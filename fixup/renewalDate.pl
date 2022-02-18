#!/usr/bin/perl
use Date::Manip;
$dbName = 'vpusr';
$dbPw = 'vpusr1';

$G_isql_exe = "/u/vplaces/s/sybase/bin/isql -U$dbName -P$dbPw -SSYBASE";
$G_statdir = "/tmp/";
$tempsql = $G_statdir . ".temp.sql.$$";
$ENV{'SYBASE'} ||= '/u/vplaces/s/sybase';


open (SQL_IN, ">$tempsql") || die "Can't write to $tempsql : $!\n";
print SQL_IN <<SQL;
SELECT accountID,'X',renewalDate, 'X',creationDate,'X',billingCycle
FROM userAccounts
WHERE accountStatus=1 AND accountType >0 AND accountType < 4
GO
SQL
close SQL_IN;
open (SQL_OUT, "$G_isql_exe -i $tempsql |") || die "Can't read from $G_isql_exe -i $tempsql : $!\n";

$i=1;
while (<SQL_OUT>) {
	if (/X/) {
		chomp;
		($aid, $renewalDate, $creationDate) = split(/X/);
		$billingCycle = <SQL_OUT>;
		chomp $billingCycle;
		$aid+=0;
		$billingCycle+=0;
print "$aid, $creationDate, $renewalDate, $billingCycle\n";
		$d1 = &ParseDate($creationDate);
		$d2 = &ParseDate($renewalDate);
		$diff = &DateCalc($d1, $d2);
		print "$diff\n";
last if ($i++ > 200);
	}
}
close SQL_OUT;
unlink($tempsql);
