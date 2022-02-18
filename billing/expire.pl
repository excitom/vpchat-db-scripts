#!/usr/bin/perl
#
# Find subscriptions that have expired
# - If PayPal, and autoRenew expected, then set status to Pending. Payment
#   should arrive soon and IPN will set status back to OK.
# - Else set status to Overdue
#   -- If PayPal, send note saying subscription cancelled
#   -- Else send note saying payment is overdue
#
# Tom Lang 3/2002

use Date::Manip;
use DBI;
use DBD::Sybase;

##################
#
# Write action to account-specific log file
# - input is account ID
#
sub writeLog {
	die "programming error" unless ($#_ == 1);
	my $accountID = shift @_;
	die "programming error" if ($accountID eq "");
	my $msg = shift @_;
	chomp $msg;

	&addActivityLogById( $accountID, $msg );

	#$msg .= "\n" unless ($msg =~ /\n$/);
	#my $logFile = "/logs/accountIDs/" . $accountID;
	#my $new = (-f "$logFile") ? 0 : 1;
	#open (SLOG, ">>$logFile");
	#my $now = scalar localtime;
	#print SLOG "$now\t$msg";
	#close SLOG;
	#chmod 0666, "$logFile" if ($new);
}

##################
#
# Write action to the database log
#
sub addActivityLogById {
	my $aid = shift @_;
	my $msg = shift @_;
	$msg =~ s/"/'/g;
	my $sql = qq!EXEC vpusers..addActivityLogById $aid, "$msg"!;
	my $sth = $G_dbh->prepare($sql);
	die 'Prepare failed' unless (defined($sth));
	$sth->execute;
	my ($rc, @row);
	do {
	  while (@row = $sth->fetchrow() ) {
	    if ($sth->{syb_result_type} == CS_STATUS_RESULT) {
		$rc = shift @row;
	    }
	  }
	} while($sth->{syb_more_results});

	$sth->finish;
}

#####################################################
#
# Subroutine: get configuration keys from the database
#
sub getConfigKeys {
  undef %G_config;
  
  my $sth = $G_dbh->prepare("EXEC vpusers..getServerConfig");
  die 'Prepare failed' unless (defined($sth));
  $sth->execute;
  my (@row);
  do {
    while (@row = $sth->fetchrow() ) {
      my $key = shift @row;
      $G_config{$key} = shift @row;
    }
  } while($sth->{syb_more_results});
  $sth->finish;
  die "database error - missing config keys" unless((scalar keys %G_config) > 0);
  my $host = `hostname`;
  chomp $host;
  $G_config{'thisHost'} = $host;
}

##################
#
# Subroutine: Send email message for expired account
#
require "/u/vplaces/scripts/cannedMessages/expiredNoSub.pl";
sub notifyExpired
{
    my $aid = shift @_;
    my $email = shift @_;
    my $amt = shift @_;
    $amt = sprintf("%6.2f", $amt);
    $amt =~ s/^\s+//;
    my $from = $G_config{'billingEmail'};
    my $fromName = "VPchat customer service";
    my (@p) = split(/\\n/, $G_config{'poBox'});
    my $poBox = join("\n", @p);

    my $cannedMsg = &expiredNoSub($from, $fromName, $email, $aid, $amt, $poBox);

   if ( open( MAIL, qq!| /usr/lib/sendmail -odq -f $from -t > /dev/null! ) ) {
     print MAIL $cannedMsg;
     print MAIL $G_configHtml{'signature'};
     close( MAIL );
##DEBUG
open( MAIL, qq!| /usr/lib/sendmail -odq -f $from $G_config{'devEmail'} > /dev/null! );
print MAIL $cannedMsg;
print MAIL $G_configHtml{'signature'};
print MAIL "\noriginally to $email\n";
close( MAIL );
   }
   else {
     warn "Can't send email\n";
   }
}
require "/u/vplaces/scripts/cannedMessages/insufficientCredit.pl";
sub notifyExpired2
{
   my $aid = shift @_;
   my $email = shift @_;
   my $amt = shift @_;
   my $bal = shift @_;
   my $diff = shift @_;
   $amt = sprintf("%6.2f", $amt);
   $amt =~ s/^\s+//;
   $bal = sprintf("%6.2f", $bal);
   $bal =~ s/^\s+//;
   $diff = sprintf("%6.2f", $diff);
   $diff =~ s/^\s+//;
   my (@p) = split(/\\n/, $G_config{'poBox'});
   my $poBox = join("\n", @p);
   my $from = $G_config{'billingEmail'};
   my $fromName = "VPchat customer service";

   my $cannedMsg = &insufficientCredit($from, $fromName, $email, $aid, $amt, $diff, $bal, $poBox);

   if ( open( MAIL, qq!| /usr/lib/sendmail -odq -f $from -t > /dev/null! ) ) {
     print MAIL $cannedMsg;
     print MAIL $G_configHtml{'signature'};
     close( MAIL );
##DEBUG
open( MAIL, qq!| /usr/lib/sendmail -odq -f $from $G_config{'devEmail'} > /dev/null! );
print MAIL $cannedMsg;
print MAIL $G_configHtml{'signature'};
print MAIL "\noriginally to $email\n";
close( MAIL );
   }
   else {
     warn "Can't send email\n";
   }
}
sub notifyPaid
{

####### Disabled this notification - Tom - 8/1/2002
return;
#######
    my $aid = shift @_;
    my $email = shift @_;
    my $amt = shift @_;
    my $bal = shift @_;
    $amt = sprintf("%6.2f", $amt);
    $amt =~ s/^\s+//;
    $bal = sprintf("%6.2f", $bal);
    $bal =~ s/^\s+//;
    my $from = "billing\@halsoft.com";
    my $FromW = "HalSoft Customer Service";

        if ( open( MAIL, "| /usr/lib/sendmail -odq -f $from -t > /dev/null" ) ) {
                print MAIL <<MAILMSG;
From: $from ($FromW)
To: $email
Reply-To: $from
Subject: Your account renewed today

Your HalSoft VP chat account was due to expire today (account ID $aid).
However we applied your credit balance to the \$ $amt cost and you
have \$ $bal credit remaining.

Thank you for your business.

  -- The HalSoft Team

MAILMSG
		close( MAIL );
	}
	else {
		warn "Can't send email\n";
	}
}

###############
#
# Subroutine: round off floating point decimal dust. it's not really 
#	a true round, actually it's a trunc, but what the hell.
#
sub round {
	my $n = shift @_;
	$n = int($n*100)/100;
	return $n;
}

###############
#
# START HERE
#

if ($#ARGV == -1) {
  $d = &ParseDate('today');
  $yd = &ParseDate('yesterday');
} else {
  $d = &ParseDate($ARGV[0]);
  $yd = &DateCalc($ARGV[0],'- 1 day');
}
($now, $date, $sqlDate, $logDate) = &UnixDate( $d, '%Y%m%d %H:%M:%S', '%b %m, %Y', '%m/%d/%Y 00:00:00', '%Y%m%d');
$yesterday = &UnixDate($yd, '%m/%d/%Y 00:00:00');

$logFile = "/logs/billing/expire.log.$logDate";
open (LOG, ">>$logFile") || die "Can't append log file $logFile : $!";
print LOG "$now\tStarting expire processing\n";

#
# Set up to access the database
#
$G_dbh = DBI->connect ( 'dbi:Sybase:', 'vpusr', 'vpusr1' );
&getConfigKeys;
 
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
SELECT 'X',accountID,autoRenew,unitCost,discount,billingCycle,subscription,email
FROM subscriberAccounts
WHERE renewalDate <= "$sqlDate"
AND   renewalDate >= "$yesterday"
AND accountType >0
AND accountStatus=0
GO
SQL
close SQL_IN;

open (SQL_OUT, "$G_isql_exe -i $tempsql |") || die "Can't read from $G_isql_exe -i $tempsql : $!\n";

print LOG "PayPal subscriptions that should renew today\n";
while (<SQL_OUT>) {
	if (/^\s*X/) {
		chomp;
		($junk, $accountID, $autoRenew, $uc, $disc) = split;
		$accts{$accountID} += $autoRenew;
		$_ = <SQL_OUT>;
		chomp;
		($bc,$subscription) = split;
		$email = <SQL_OUT>;
		chomp $email;
		$email =~ s/\s+//g;
		$cost = $uc * $bc;
		$cost -= ($cost * $disc);
		$cost{$accountID} = &round($cost);
		$balance{$accountID} = &round($subscription);
		$email{$accountID} = $email;
	}
}
close SQL_OUT;

open (SQL_IN, ">$tempsql") || die "Can't write to $tempsql : $!\n";

$setPending = 1;
$setOverdue = 0;
foreach $accountID (sort keys %accts) {
	#
	# An account may have one or more subscriptions records.
	# See if any of them are active.
	#
	$a = $accts{$accountID};
	if ($a == 0) {
	   #
	   # No active (auto-renew) subscription,
	   # check for credit balance.
	   #
  	   if ($balance{$accountID} < 0) {
	     $b = 0 - $balance{$accountID};
	     #
	     # Apply outstanding credit
	     #
	     if ($cost{$accountID} <= $b) {
		$b -= $cost{$accountID};
		print SQL_IN <<SQL;
expireAccount $accountID
GO
SQL
		print LOG "$accountID credit applied, paid in full\n";
		&notifyPaid($accountID, $email{$accountID}, $cost{$accountID}, $b);
		&writeLog($accountID, "credit applied, set to OK, acct renewed by daily account processing, email sent");
	     }
	     else {
		$c = $cost{$accountID};
		print SQL_IN <<SQL;
expireAccount $accountID, $setOverdue
GO
SQL
		print LOG "$accountID credit applied, balance remains\n";
		&notifyExpired2($accountID, $email{$accountID}, $c, $b, $c-$b);
		&writeLog($accountID, "set to OVERDUE since insufficient credit by daily account processing, email sent");
	     }
   	   }
   	   else {
		print LOG "$accountID EXPIRED today\n";
		print SQL_IN <<SQL;
expireAccount $accountID, $setOverdue
GO
SQL
		&notifyExpired($accountID, $email{$accountID}, $cost{$accountID});
		&writeLog($accountID, "EXPIRED by daily account processing, email sent");
	   }
	}
	#
	# The account has an active (auto-renew) subscription
	#
	elsif($a == 1) {
		print LOG "$accountID should renew today\n";
		&writeLog($accountID, "set to PENDING auto-renew by daily account processing");
		print SQL_IN <<SQL;
expireAccount $accountID, $setPending
GO
SQL
	}
	else {
		print LOG "Warning - multiple active subscriptions for $accountID\n";
		print SQL_IN <<SQL;
expireAccount $accountID, $setPending
GO
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
AND   renewalDate >= "$yesterday"
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

print LOG "Check payer subscriptions that expire today\n";
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
		$cost{$accountID} = &round($cost);
		$email{$accountID} = $email;
		$bal = <SQL_OUT>;
		chomp $bal;
		$balance{$accountID} = &round($bal);
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
expireAccount $accountID
GO
SQL
		print LOG "$accountID credit applied, paid in full\n";
		&notifyPaid($accountID, $email{$accountID}, $cost{$accountID}, $b);
		&writeLog($accountID, "credit applied, set to OK, acct renewed by daily account processing, email sent");
	}
	else {
		$c = $cost{$accountID};
		print SQL_IN <<SQL;
expireAccount $accountID, $setOverdue
GO
SQL
		print LOG "$accountID credit applied, balance remains\n";
		&notifyExpired2($accountID, $email{$accountID}, $c, $b, $c-$b);
		&writeLog($accountID, "set to OVERDUE since insufficient credit by daily account processing, email sent");
	}
   }
   else {
	#
	# Account has expired
	#
	print SQL_IN <<SQL;
expireAccount $accountID, $setOverdue
GO
SQL
	print LOG "$accountID became OVERDUE today\n";
	&writeLog($accountID, "set to OVERDUE by daily account processing, email sent");
	&notifyExpired($accountID, $email{$accountID}, $cost{$accountID}+$balance{$accountID});
   }
}
close SQL_IN;

open (SQL_OUT, "$G_isql_exe -i $tempsql |") || die "Can't read from $G_isql_exe -i $tempsql : $!\n";

while(<SQL_OUT>) {
}
close SQL_OUT;

unlink($tempsql);

`/usr/lib/sendmail -q`;
$date = &ParseDate('today');
$now = &UnixDate($date, '%Y%m%d %H:%M:%S');
print LOG "$now\tcompleted\n";
