#!/usr/local/bin/perl
#
# Copy penalties from mode 2 to mode 3 users
#
# Tom Lang 6/98
#
$G_isql_exe = '/u/vplaces/s/sybase/bin/isql -Uvpusr -Pvpusr1 -SSYBASE';
$G_statdir = "/tmp/";
$tempsql = $G_statdir . ".temp.sql.$$";

$ENV{'SYBASE'} ||= '/u/vplaces/s/sybase';

$sql_cmd = qq|select nickName,"+",penaltyType,"+",expiresOn,"+",issuedOn,"+",issuedBy,"+",forgiven,"+",penaltyID,"+",comment from penalties,users\n|;
$sql_cmd .= qq|where users.userID = penalties.userID\n|;
$sql_cmd .= qq|go\n|;

open (SQL_IN, ">$tempsql") || die "Can't write to $tempsql : $!\n";
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
	$penaltyType =~ s/\s+//g;
	$expiresOn =~ s/\s+//;
	$_ = <SQL_OUT>;
	chop;
	($issuedOn, $issuedBy, $forgiven, $penaltyID) = split(/\+/);
	$issuedBy =~ s/\s+//g;
	$issuedOn =~ s/\s+//;
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
	$userID =~ s/\s+//g;
	$nickName =~ s/\s+//g;
	$issuer{$userID} = $nickName;
}

$penalty{0} = "Kick";
$penalty{1} = "Gag";
$penalty{2} = "Ban Av.";
$duration = 60*24*365/2;

open (SQL_IN, ">$tempsql") || die "Can't write to $tempsql : $!\n";
foreach $id (keys %nickName) {
	print SQL_IN <<CMD;
penalize "$nickName",3,"$penalty{$penaltyType{$id}}",$duration,"$issuer{$issuedBy{$id}}",2,"$comment{$id}"
go
CMD
}
close SQL_IN;

open (SQL_OUT, "$G_isql_exe -i $tempsql |") || die "Can't read from $G_isql_exe -i $tempsql : $!\n";

while (<SQL_OUT>) {
	print;
}
unlink($tempsql);
