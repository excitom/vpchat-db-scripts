#!/usr/local/bin/perl
#
# Tom Lang 6/98
#
$G_isql_exe = '/u/vplaces/s/sybase/bin/isql -Uvpusr -Pvpusr1 -SSYBASE';
$G_statdir = "/tmp/";
$tempsql = $G_statdir . ".temp.sql.$$";

$ENV{'SYBASE'} ||= '/u/vplaces/s/sybase';

$sql_cmd = qq|select nickName,"+",warningID,"+",issuedOn,"+",issuedBy,"+",content from warnings,users\n|;
$sql_cmd .= qq|where users.userID = warnings.userID\n|;
$sql_cmd .= qq|go\n|;

open (SQL_IN, ">$tempsql") || die "Can't write to $tempsql : $!\n";
print SQL_IN $sql_cmd;
close SQL_IN;

open (SQL_OUT, "$G_isql_exe -i $tempsql |") || die "Can't read from $G_isql_exe -i $tempsql : $!\n";

for ($i = 1; $i <=4; $i++) {
	$_ = <SQL_OUT>;		# skip headers
}
while (<SQL_OUT>) {
	last if (/rows affected/);
	chop;
	($nickName, $warningID, $issuedOn, $issuedBy) = split(/\+/);
	$nickName =~ s/\s+//g;
	$warningID += 0;
	$issuedBy =~ s/\s+//g;
	$issuedOn =~ s/\s+//;
	$content = <SQL_OUT>;
	chop $content;
	$content =~ s/\s+$//;
	$nickName{$warningID} = $nickName;
	$issuedOn{$warningID} = $issuedOn;
	$issuedBy{$warningID} = $issuedBy;
	$content{$warningID} = $content;
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
Issued By: $issuer{$issuedBy{$id}}
Content:   $content{$id}
X

}
unlink($tempsql);
