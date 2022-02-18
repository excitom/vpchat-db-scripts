#!/usr/bin/perl
#
# Find referrals grouped by account owner
#
# Tom Lang 1/2001
#
$dbName = 'vpusr';
$dbPw = 'vpusr1';

$G_isql_exe = "/u/vplaces/s/sybase/bin/isql -U$dbName -P$dbPw -SSYBASE";
$G_statdir = "/tmp/";
$tempsql = $G_statdir . ".temp.sql.$$";
$ENV{'SYBASE'} ||= '/u/vplaces/s/sybase';

#
# find all referrals, accumulate totals by referrer's account ID
#
open (SQL_IN, ">$tempsql") || die "Can't write to $tempsql : $!\n";
print SQL_IN <<SQL;
SELECT 'X', referredByID, COUNT(referredByID)
FROM referrals
WHERE type = 0
AND accountID IN
(SELECT accountID FROM userAccounts WHERE accountStatus = 0)
GROUP BY referredByID
GO
SQL

close SQL_IN;

open (SQL_OUT, "$G_isql_exe -i $tempsql |") || die "Can't read from $G_isql_exe -i $tempsql : $!\n";

while (<SQL_OUT>) {
	next unless (/X/);
	($junk, $aid, $count) = split;
	$refers{$aid} = $count;
}
close SQL_OUT;

#
# find account status for each of the referrers
#
open (SQL_IN, ">$tempsql") || die "Can't write to $tempsql : $!\n";

foreach $aid (keys %refers) {
	print SQL_IN <<SQL;
SELECT 'X',$aid, accountStatus, enrolledReferrer, email FROM userAccounts
WHERE accountID = $aid
GO
SQL

}
close SQL_IN;

open (SQL_OUT, "$G_isql_exe -i $tempsql |") || die "Can't read from $G_isql_exe -i $tempsql : $!\n";

#
# create categorized lists
# - accounts eligible for bonus, and amount per account
# - accounts ineligible for bonus, and amount per account
# - accounts not enrolled for bonus, and amount per account
#

while (<SQL_OUT>) {
	next unless (/X/);
	chomp;
	($junk, $aid, $status, $enrolled) = split;
	$email = <SQL_OUT>;
	chomp $email;
	$email =~ s/\s+//g;
	if ($enrolled && ($status == 0)) {
		$ok{$aid} = $refers{$aid};
	}
	elsif ($status != 0) {
		$ineligible{$aid} = $refers{$aid};
		$status{$aid} = $status;
	}
	else {
		$notEnrolled{$aid} = $refers{$aid};
	}
	$email{$aid} = $email;
}
close SQL_IN;

#
# done with the SQL temp file
#
unlink($tempsql);

#
# create file containing the list of accounts to be credited 
# with bonus money, and also print a summary of activity
#
open (LIST, ">/tmp/referralList") || die "Can't create /tmp/referralList : $!";

print "Referrals to pay:\n";
foreach $aid (sort {$ok{$b} <=> $ok{$a}} keys %ok) {
	print "$ok{$aid} $aid $email{$aid}\n";
	$amount[0] += $ok{$aid};
	$total[0]++;

	#
	# format is:
	# account ID, referrals, bonus amount, email
	# since $1/referral, columns 2 & 3 are the same, but may not
	# always be that way ...
	#
	print LIST "$aid\t$ok{$aid}\t$ok{$aid}\t$email{$aid}\n";
}
print "\nIneligible Referrals:\n";
$reason{1} = 'NEW';
$reason{2} = 'PENDING';
$reason{3} = 'CLOSED';
$reason{4} = 'SUSPENDED';
foreach $aid (sort {$ineligible{$b} <=> $ineligible{$a}} keys %ineligible) {
	print "$ineligible{$aid} $aid $reason{$status{$aid}} $email{$aid}\n";
	$amount[1] += $ineligible{$aid};
	$total[1]++;
}
print "\nUn-enrolled Referrals:\n";
foreach $aid (sort {$notEnrolled{$b} <=> $notEnrolled{$a}} keys %notEnrolled) {
	print "$notEnrolled{$aid} $aid $email{$aid}\n";
	$amount[2] += $notEnrolled{$aid};
	$total[2]++;
}
$a1 = sprintf("\$ %6.2f", $amount[0]);
$a2 = sprintf("\$ %6.2f", $amount[1]);
$a3 = sprintf("\$ %6.2f", $amount[2]);
$t1 = sprintf(" %7.1d", $total[0]);
$t2 = sprintf(" %7.1d", $total[1]);
$t3 = sprintf(" %7.1d", $total[2]);

print <<OUT;

Referrals to pay:	$t1
Amount:			$a1

Ineligible referrals:	$t2
Amount:			$a2

Un-enrolled referrals:	$t3
Amount:			$a3
OUT

close LIST;

### end
