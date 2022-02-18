#!/usr/bin/perl
#
# Apply pending account changes to user accounts that are up for renewal
#
# Tom Lang 3/2002

use Date::Manip;
require "/web/reg/html/VP/accountVars.pl";

###############
#
# START HERE
#

if ($#ARGV == -1) {
  $d = &ParseDate('today');
} else {
  $d = &ParseDate($ARGV[0]);
}
($now, $date, $sqlDate, $logDate) = &UnixDate( $d, '%Y%m%d %H:%M:%S', '%b %m, %Y', '%m/%d/%Y 00:00am', '%Y%m%d');

$logFile = "/logs/billing/expire.log.$logDate";
open (LOG, ">>$logFile") || die "Can't append log file $logFile : $!";
print LOG "$now\tStarting pending change processing\n";

#
# Set up to access the database
#
$dbName = 'vpusr';
$dbPw = 'vpusr1';
$G_isql_exe = "/u/vplaces/s/sybase/bin/isql -U$dbName -P$dbPw -SSYBASE";
$G_statdir = "/tmp/";
$tempsql = $G_statdir . ".temp.sql.$$";
$ENV{'SYBASE'} ||= '/u/vplaces/s/sybase';

#
# Find pending account changes
#
open (SQL_IN, ">$tempsql") || die "Can't write to $tempsql : $!\n";
print SQL_IN <<SQL;
SELECT 'X',userAccounts.accountID,pendingAcctChanges.billingCycle
FROM userAccounts,pendingAcctChanges
WHERE renewalDate <= "$sqlDate"
AND userAccounts.accountID = pendingAcctChanges.accountID
GO
SQL
close SQL_IN;

open (SQL_OUT, "$G_isql_exe -i $tempsql |") || die "Can't read from $G_isql_exe -i $tempsql : $!\n";

while (<SQL_OUT>) {
	if (/^\s*X/) {
		chomp;
		($junk, $accountID, $newBc) = split;
		$bc{$accountID} = $newBc;
	}
}
close SQL_OUT;

#
# Update accounts
#
open (SQL_IN, ">$tempsql") || die "Can't write to $tempsql : $!\n";

foreach $accountID (sort keys %bc) {
	$b = $revBillingCycle{$bc{$accountID}};
	$disc = $discount{$b};
	print SQL_IN <<SQL;
UPDATE userAccounts
SET billingCycle = $bc{$accountID},
    discount = $disc
WHERE accountID = $accountID
GO
DELETE FROM pendingAcctChanges
WHERE accountID = $accountID
GO
SQL
	print LOG "Account ID $accountID - bc $bc{$accountID} - disc $disc\n";

}
close SQL_IN;

open (SQL_OUT, "$G_isql_exe -i $tempsql |") || die "Can't read from $G_isql_exe -i $tempsql : $!\n";

while (<SQL_OUT>) {
	if (/return status\s+=\s+(\d+)\s*\)/ ) {
	   if ($1 != 0) {
		print LOG "Unexpected return status $1\n";
	   }
	}
}
close SQL_OUT;

unlink($tempsql);

$date = &ParseDate('today');
$now = &UnixDate($date, '%Y%m%d %H:%M:%S');
print LOG "$now\tcompleted\n";
