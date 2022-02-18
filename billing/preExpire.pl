#!/usr/bin/perl
#
# Find subscriptions that will expire "soon" and that will not
# auto-renew -- i.e. people we need to whom we need to send a 
# renewal notice.
#
# Tom Lang 3/2002

use Date::Manip;
use DBI;
use DBD::Sybase;
require "/web/reg/html/VP/accountVars.pl";

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
# Subroutine: Send email message to eCheck account
#
require "/u/vplaces/scripts/cannedMessages/autoRenewing.pl";
sub eCheckEmail
{
    my $aid   = shift @_;
    my $email = shift @_;
    my $cost  = shift @_;
    my $bal   = shift @_;
    my $rDate = shift @_;

    my $amt = $cost + $bal;
    if ($amt <=0 ) {
      return;
    }

    my $amount = sprintf("%7.2f", $amt);
    $amount =~ s/^\s+//;
    my $from = $G_config{'billingEmail'};
    my $fromName = "VPchat Customer Service";

    my $cannedMsg = &autoRenewing($from,$fromName,$email,$aid,$rDate,$amount);

    if ( open( MAIL, "| /usr/lib/sendmail -oi -oem -f $from -t > /dev/null" ) ) {

      print MAIL $cannedMsg;
      print MAIL $G_configHtml{'signature'};
      close( MAIL );

## DEBUG
      open( MAIL, "| /usr/lib/sendmail -oi -oem -f $from $G_config{'devEmail'} > /dev/null" );

      print MAIL $cannedMsg;
      print MAIL $G_configHtml{'signature'};
      print MAIL "\nOriginally to: $email\n";
      close( MAIL );

    }
    else {
	warn "Can't send email\n";
    }
}

##################
#
# Subroutine: Send email message 
#
require "/u/vplaces/scripts/cannedMessages/preExpire.pl";
sub notifyEmail
{
    my $aid   = shift @_;
    my $email = shift @_;
    my $cost  = shift @_;
    my $bal   = shift @_;
    my $rDate = shift @_;

    my $amt = $cost + $bal;
    my $amount = sprintf("%7.2f", $amt);
    $amount =~ s/^\s+//;
    my $subscrCost = sprintf("%7.2f", $cost);
    $subscrCost =~ s/^\s+//;
    my $cred = 0;
    my ($balance);
    if ($bal < 0) {
	$cred = 1;
	$balance = 0 - $bal;
	$balance = sprintf("%7.2f credit", $balance);
    } else {
	$balance = sprintf("%7.2f", $bal);
    }
    $balance =~ s/^\s+//;
    my $from = $G_config{'billingEmail'};
    my $fromName = "VPchat Customer Service";
    my $poBox = join("\n", split(/\\n/, $G_config{'poBox'}));

    my $cannedMsg = &preExpire( $from, $fromName, $email, $aid, $amount, $cost, $subscrCost, $balance, $poBox, $rDate, $cred );

    if ( open( MAIL, "| /usr/lib/sendmail -oi -oem -f $from -t > /dev/null" ) ) {

      print MAIL $cannedMsg;
      close( MAIL );

## DEBUG
      ##open( MAIL, "| /usr/lib/sendmail -oi -oem -f $from $G_config{'devEmail'} > /dev/null" );

      ##print MAIL $cannedMsg;
      ##print MAIL "\nOriginally to: $email\n";
      ##close( MAIL );
    }
    else {
	warn "Can't send email\n";
    }
}

###############
#
# START HERE
#

if ($#ARGV == -1) {
  $d = &DateCalc('today','+ 2 weeks');
} else {
  $d = &ParseDate($ARGV[0]);
}
($sqlDate1, $sqlDate2) = &UnixDate( $d, '%m/%d/%Y 00:00:00', '%m/%d/%Y 23:59:59' );
$d = &ParseDate('today');
($now, $logDate) = &UnixDate( $d, '%Y%m%d %H:%M:%S', '%Y%m%d');

$logFile = "/logs/billing/expire.log.$logDate";
open (LOG, ">>$logFile") || die "Can't append log file $logFile : $!";
print LOG "$now\tStarting expire-notify processing for $sqlDate1\n";

#
# Set up to access the database
#
$G_dbh = DBI->connect ( 'dbi:Sybase:', 'vpusr', 'vpusr1' );
&getConfigKeys;

#
# Find subscriptions that expire soon and don't auto-renew.
#
# Assumption: Don't bother sending mail to the accounts that had an
# auto-renew subscription but cancelled it. That action means they
# are not interested in renewing. They'll get a "you can still come
# back" note when the subscription expires.
####
#### 5/2002 -- tom -- new thinking, beg for renewals
####
#
# Note that there is a subscrptions table entry only for auto-renew
# accounts, therefore testing for NOT EXIST in the subscriptions table
# gets the non-auto-renew people.
#
# Also, not interested in Complimentary accounts nor accounts that
# are New, Pending, Closed, Suspended or Overdue.
#
# This operation is done in two passes, for accounts without and with
# pending billing cycle changes -- since this affects the amount we 
# tell them to pay.
#

$sql =<<SQL;
SELECT userAccounts.accountID,unitCost,discount,billingCycle,subscription,renewalDate,email
FROM userAccounts,accountBalance
WHERE renewalDate <= "$sqlDate2"
AND   renewalDate >= "$sqlDate1"
AND accountType >0
AND accountStatus=0
AND userAccounts.accountID = accountBalance.accountID
AND NOT EXISTS
  (SELECT * FROM subscriptions
   WHERE subscriptions.accountID = userAccounts.accountID AND autoRenew = 1)
AND NOT EXISTS
  (SELECT * FROM pendingAcctChanges
   WHERE pendingAcctChanges.accountID = userAccounts.accountID)
SQL

$sth = $G_dbh->prepare($sql);
die 'Prepare failed' unless (defined($sth));
$sth->execute;

my ($rc, @row);
print LOG "Subscriptions that need a renewal reminder\n";
do {
  while (@row = $sth->fetchrow() ) {
    if ($sth->{syb_result_type} == CS_ROW_RESULT) {
	$accountID = shift @row;
	$uc = shift @row;
	$disc = shift @row;
	$bc = shift @row;
	$bal = shift @row;
	$bal = sprintf "%6.2f", $bal;
	$cost = $uc * $bc;
	$cost -= ($cost * $disc);
	$cost = sprintf "%6.2f", $cost;
	my $d = shift @row;
	my (@f) = split(/\s+/, $d);
	$rDate = join(' ', $f[0],$f[1],$f[2]);
	$email = shift @row;
	$email =~ s/\s+//g;
	print LOG "$accountID - subscr cost $cost -- acct bal $bal -- renewal date $rDate\n";
	&notifyEmail($accountID, $email, $cost, $bal, $rDate);
	&writeLog($accountID, "sent notice of pending renewal to $email");
    }
  }
} while($sth->{syb_more_results});

$sth->finish;

#
# Do it all again, this time handling accounts with  pending changes
#
$sql =<<SQL;
SELECT userAccounts.accountID,userAccounts.unitCost,
        pendingAcctChanges.billingCycle,subscription,renewalDate,email
FROM userAccounts,accountBalance, pendingAcctChanges
WHERE renewalDate <= "$sqlDate2"
AND   renewalDate >= "$sqlDate1"
AND userAccounts.accountType >0
AND accountStatus=0
AND userAccounts.accountID = accountBalance.accountID
AND NOT EXISTS
  (SELECT * FROM subscriptions
   WHERE subscriptions.accountID = userAccounts.accountID AND autoRenew = 1)
AND pendingAcctChanges.accountID = userAccounts.accountID
SQL
$sth = $G_dbh->prepare($sql);
die 'Prepare failed' unless (defined($sth));
$sth->execute;

print LOG "Subscriptions with pending changes that need a renewal reminder\n";
do {
  while (@row = $sth->fetchrow() ) {
    if ($sth->{syb_result_type} == CS_ROW_RESULT) {
	$accountID = shift @row;
	$uc = shift @row;
	$bc = shift @row;
	$bal = shift @row;
	$cost = $uc * $bc;
	$disc = $discount{$revBillingCycle{$bc}};
	$cost -= ($cost * $disc);
	$cost = sprintf "%6.2f", $cost;
	$bal = sprintf "%6.2f", $bal;
	my $d = shift @row;
	my (@f) = split(/\s+/, $d);
	$rDate = join(' ', $f[0],$f[1],$f[2]);
	$email = shift @row;
	$email =~ s/\s+//g;
	print LOG "$accountID - subscr cost $cost -- acct bal $bal -- renewal date $rDate -- email $email\n";
	&notifyEmail($accountID, $email, $cost, $bal, $rDate);
	&writeLog($accountID, "sent email notice of pending renewal");
    }
  }
} while($sth->{syb_more_results});

$sth->finish;

#
# Now look for auto-renewal eCheck subscriptions, where the subscription
# length is longer than one month. These are relatively expensive accounts
# that renew rarely, and we don't want to surprise people with the debit.
#
$sql =<<SQL;
SELECT userAccounts.accountID,unitCost,discount,billingCycle,subscription,renewalDate,email
FROM userAccounts,accountBalance
WHERE renewalDate <= "$sqlDate2"
AND   renewalDate >= "$sqlDate1"
AND accountType >0
AND accountStatus=0
AND billingCycle > 1
AND userAccounts.accountID = accountBalance.accountID
AND EXISTS
  (SELECT * FROM subscriptions
   WHERE subscriptions.accountID = userAccounts.accountID
   AND type = 3
   AND autoRenew = 1)
SQL

$sth = $G_dbh->prepare($sql);
die 'Prepare failed' unless (defined($sth));
$sth->execute;

print LOG "Echeck subscriptions that need a renewal reminder\n";
do {
  while (@row = $sth->fetchrow() ) {
    if ($sth->{syb_result_type} == CS_ROW_RESULT) {
	$accountID = shift @row;
	$uc = shift @row;
	$disc = shift @row;
	$bc = shift @row;
	$bal = shift @row;
	$bal = sprintf "%6.2f", $bal;
	$cost = $uc * $bc;
	$disc = $discount{$revBillingCycle{$bc}};
	$cost -= ($cost * $disc);
	$cost = sprintf "%6.2f", $cost;
	my $d = shift @row;
	my (@f) = split(/\s+/, $d);
	$rDate = join(' ', $f[0],$f[1],$f[2]);
	$email = shift @row;
	$email =~ s/\s+//g;
	print LOG "$accountID - subscr cost $cost -- acct bal $bal -- renewal date $rDate\n";
	&eCheckEmail($accountID, $email, $cost, $bal, $rDate);
	&writeLog($accountID, "sent email notice of pending renewal");
    }
  }
} while($sth->{syb_more_results});

$sth->finish;

$date = &ParseDate('today');
$now = &UnixDate($date, '%Y%m%d %H:%M:%S');
print LOG "$now\tcompleted\n";
