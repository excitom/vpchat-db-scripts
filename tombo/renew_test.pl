#!/usr/bin/perl
use Date::Manip;


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
# Find PayPal auto-renew subscriptions that expire today
#
open (SQL_IN, ">$tempsql") || die "Can't write to $tempsql : $!\n";
print SQL_IN <<SQL;
SELECT 'X',accountID,autoRenew,unitCost,discount,billingCycle,email
FROM subscriberAccounts
WHERE renewalDate <= "$sqlDate"
AND type = 1
AND accountType >0
AND accountStatus=0
GO
SQL
close SQL_IN;

open (SQL_OUT, "$G_isql_exe -i $tempsql |") || die "Can't read from $G_isql_exe -i $tempsql : $!\n";

print "PayPal subscriptions that should renew today: $sqlDate\n";
while (<SQL_OUT>) {
	if (/^\s*X/) {
		chomp;
		($junk, $accountID, $autoRenew, $uc, $disc) = split;
		$accts{$accountID} += $autoRenew;
		$bc = <SQL_OUT>;
		chomp $bc;
		$email = <SQL_OUT>;
		chomp $email;
		$email =~ s/\s+//g;
		$cost = $uc * $bc;
		$cost -= ($cost * $disc);
		$cost{$accountID} = $cost;
		$email{$accountID} = $email;
	}
}
close SQL_OUT;

open (SQL_IN, ">$tempsql") || die "Can't write to $tempsql : $!\n";

$setPending = 1;
$setOverdue = 0;
foreach $accountID (sort keys %accts) {
	$a = $accts{$accountID};
	if ($a == 0) {
		print "$accountID EXPIRED today\n";
		print SQL_IN <<SQL;
#expireAccount $accountID, $setOverdue
#GO
SQL
#		&notifyExpired($accountID, $email{$accountID}, $cost{$accountID}, 1);
	}
	elsif($a == 1) {
		print "$accountID should renew today\n";
		print SQL_IN <<SQL;
#expireAccount $accountID, $setPending
#GO
SQL
	}
	else {
		print "Warning - multiple active subscriptions for $accountID\n";
		print SQL_IN <<SQL;
#expireAccount $accountID, $setPending
#GO
SQL
	}
}
close SQL_IN;

open (SQL_OUT, "$G_isql_exe -i $tempsql |") || die "Can't read from $G_isql_exe -i $tempsql : $!\n";

while(<SQL_OUT>) {
}
close SQL_OUT;

#
# Find non-PayPal subscriptions that expire today
#
open (SQL_IN, ">$tempsql") || die "Can't write to $tempsql : $!\n";
print SQL_IN <<SQL;
SELECT 'X',userAccounts.accountID,unitCost,discount,billingCycle,email,subscription
FROM userAccounts, accountBalance
WHERE renewalDate <= "$sqlDate"
AND accountType >0
AND accountStatus=0
AND userAccounts.accountID = accountBalance.accountID
AND NOT EXISTS (
 SELECT autoRenew
 FROM subscriptions
 WHERE subscriptions.accountID = userAccounts.accountID
)
GO
SQL
close SQL_IN;

open (SQL_OUT, "$G_isql_exe -i $tempsql |") || die "Can't read from $G_isql_exe -i $tempsql : $!\n";

print "Non-PayPal subscriptions that expire today\n";
undef %email;
while (<SQL_OUT>) {
	if (/^\s*X/) {
		chomp;
		($junk, $accountID, $uc, $disc, $bc) = split;
		$email = <SQL_OUT>;
		chomp $email;
		$email =~ s/\s+//g;
		$cost = $uc * $bc;
		$cost -= ($cost * $disc);
		$cost{$accountID} = $cost;
		$email{$accountID} = $email;
		$bal = <SQL_OUT>;
		chomp $bal;
		$balance{$accountID} = $bal;
	}
}
close SQL_OUT;

open (SQL_IN, ">$tempsql") || die "Can't write to $tempsql : $!\n";

foreach $accountID (sort keys %email) {
  if ($balance{$accountID} < 0) {
	$b = 0 - $balance{$accountID};
	#
	# Apply outstanding credit
	#
	if ($cost{$accountID} <= $b) {
		$b -= $cost{$accountID};
		print SQL_IN <<SQL;
#expireAccount $accountID
#GO
SQL
		print "$accountID credit applied, paid in full\n";
#		&notifyPaid($accountID, $email{$accountID}, $cost{$accountID}, $b);
	}
	else {
		$c = $cost{$accountID} - $balance;
		print SQL_IN <<SQL;
#expireAccount $accountID, $setOverdue
#GO
SQL
		print "$accountID credit applied, balance remains\n";
#		&notifyExpired2($accountID, $email{$accountID}, $c, $b, $c-$b);
	}
   }
   else {
	#
	# Account has expired
	#
	print SQL_IN <<SQL;
#expireAccount $accountID, $setOverdue
#GO
SQL
	print "$accountID EXPIRED today\n";
#	&notifyExpired($accountID, $email{$accountID}, $cost{$accountID}+$balance{$accountID}, 0);
   }
}
close SQL_IN;

open (SQL_OUT, "$G_isql_exe -i $tempsql |") || die "Can't read from $G_isql_exe -i $tempsql : $!\n";

while(<SQL_OUT>) {
	print;
}
close SQL_OUT;

unlink($tempsql);

#`/usr/lib/sendmail -q`;
$date = &ParseDate('today');
$now = &UnixDate($date, '%Y%m%d %H:%M:%S');
print "$now\tcompleted\n";
