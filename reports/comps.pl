#!/usr/bin/perl
#
# Show comp accounts and names
#
# Tom Lang 3/2002

require "/web/reg/html/VP/accountVars.pl";

$dbName = 'vpusr';
$dbPw = 'vpusr1';

$G_isql_exe = "/u/vplaces/s/sybase/bin/isql -U$dbName -P$dbPw -SSYBASE";
$G_statdir = "/tmp/";
$tempsql = $G_statdir . ".temp.sql.$$";
$ENV{'SYBASE'} ||= '/u/vplaces/s/sybase';

open (SQL_IN, ">$tempsql") || die "Can't write to $tempsql : $!\n";

print SQL_IN <<SQL;
SELECT 'X',userAccounts.accountID,nickName,accountStatus,userAccounts.email,
lastSignOnDate
FROM users,registration,userAccounts
WHERE accountType=0
AND users.userID=registration.userID
AND registration.accountID=userAccounts.accountID
AND userAccounts.accountID > 1
ORDER BY userAccounts.accountID
GO
SQL

close SQL_IN;

open (SQL_OUT, "$G_isql_exe -i $tempsql |") || die "Can't read from $G_isql_exe -i $tempsql : $!\n";

$a = 0;
$now = scalar localtime;
print "Report run $now\n";
while (<SQL_OUT>) {
	next unless (/X/);
	chomp;
	($junk, $aid, $name, $st) = split;
	$status = $accountStatus{$st};
	$email = <SQL_OUT>;
	chomp $email;
	$email =~ s/\s+//g;
	$lastUse = <SQL_OUT>;
	chomp $lastUse;
	$lastUse = "Never used" if ($lastUse =~ "NULL");
	if ($aid != $a) {
		print "===========================================================\n";
		print "Account ID: $aid\n";
		print "     Email: $email\n";
		print "    Status: $status\n";
		$a = $aid;
	}
	print "      Name: $name	$lastUse\n";
}
close SQL_OUT;
unlink($tempsql);
