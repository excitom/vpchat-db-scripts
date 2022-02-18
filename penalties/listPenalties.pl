#!/usr/local/bin/perl
#
# Tom Lang 6/98
#
$G_isql_exe = '/u/vplaces/s/sybase/bin/isql -Uvpusr -Pvpusr1 -SSYBASE';
$G_statdir = "/tmp/";
$tempsql = $G_statdir . ".temp.sql.$$";

$ENV{'SYBASE'} ||= '/t/t/s/sybase';

if ($#ARGV == 0) {
	$qual = "and issuedOn < '" . $ARGV[0] . "'";
	$qual .= " and expiresOn >= '" . $ARGV[0] . "'";
	$qual .= " and forgiven = 0";
} else {
	$qual = "";
}

$sql_cmd = qq|select nickName,"+",penaltyType,"+",expiresOn,"+",issuedOn,"+",issuedBy,"+",forgiven,"+",penaltyID,"+",comment from penalties,users\n|;
$sql_cmd .= qq|where users.userID = penalties.userID $qual\n|;
$sql_cmd .= qq|go\n|;

open (SQL_IN, ">$tempsql") || die "Can't write to $tempsql : $!\n";
print $sql_cmd;
print SQL_IN $sql_cmd;
close SQL_IN;

open (SQL_OUT, "$G_isql_exe -i $tempsql |") || die "Can't read from $G_isql_exe -i $tempsql : $!\n";

for ($i = 1; $i <=6; $i++) {
	$_ = <SQL_OUT>;		# skip headers
}
while (<SQL_OUT>) {
	last if (/rows affected/);
	chop;
	($nickName, $penaltyType, $expiresOn) = split(/\+/);
	$nickName =~ s/\s+//g;
	$expiresOn =~ s/\s+//;
	$_ = <SQL_OUT>;
	chop;
	($issuedOn, $issuedBy, $forgiven, $penaltyID) = split(/\+/);
	$issuedBy += 0;
	$issuedOn =~ s/\s+//;
	$penaltyID += 0;
	$comment = <SQL_OUT>;
	chop $comment;
	$comment =~ s/\s+$//;
	$nickName{$penaltyID} = $nickName;
	$penaltyType{$penaltyID} = $penaltyType;
	$expiresOn{$penaltyID} = $expiresOn;
	$issuedOn{$penaltyID} = $issuedOn;
	$issuedBy{$penaltyID} = $issuedBy;
	$forgiven{$penaltyID} = $forgiven;
	$comment{$penaltyID} = $comment;

	$issuer{$issuedBy} = $issuedBy;
}
close SQL_OUT;

$first = 1;
foreach $userID (keys %issuer) {
	next unless($userID =~ /\d+/);
	if ($first) {
		$first = 0;
		$sql_cmd = qq|select userID,nickName from users where userID=$userID\n|;
	} else {
		$sql_cmd .= "or userID=$userID\n";
	}
}
$sql_cmd .= "go\n";

open (SQL_IN, ">$tempsql") || die "Can't write to $tempsql : $!\n";
print SQL_IN $sql_cmd;
close SQL_IN;

open (SQL_OUT, "$G_isql_exe -i $tempsql |") || die "Can't read from $G_isql_exe -i $tempsql : $!\n";

while (<SQL_OUT>) {
	next unless(/^\s*\d/);
	chop;
	($userID, $nickName) = split;
	$userID += 0;
	$nickName =~ s/\s+//g;
	$issuer{$userID} = $nickName;
}

foreach $id (sort keys %nickName) {
	print <<X;
=====================
ID:        $id
Offender:  $nickName{$id}
Issued On: $issuedOn{$id}
Expired:   $expiresOn{$id}
Issued By: $issuer{$issuedBy{$id}}
Penalty:   $penaltyType{$id}
Comment:   $comment{$id}
X

}
unlink($tempsql);
