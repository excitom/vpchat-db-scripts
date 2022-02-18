#!/usr/bin/perl
#
# Periodically process settlements for the Authorize.Net Payment Gateway
#
# Tom Lang 11/2003 modified 1/2008 for Authorize.Net
#
#use Date::Manip;
use DBI;
use DBD::Sybase;

BEGIN {
  $ENV{'LD_LIBRARY_PATH=/export/home/u/vplaces/VPCOM/VPWEB.CMGMT/vpweb.2.1.5.2-solaris/sybase/lib:/export/home/u/vplaces/VPCOM/V.CMGMTPWEB/vpweb.2.1.5.2-solaris/perl_lib'};
}

sub log {
  open (SETTLEMENTLOG, ">>$logFile") || die "Can't append to $logFile : $!";
  print SETTLEMENTLOG $_[0];
  close SETTLEMENTLOG;
}

#####################################################
#
# Subroutine: get configuration keys from the database
#
sub getConfigKeys {
  undef %G_config;
  
  my $sth = $G_dbh->prepare("EXEC getServerConfig");
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

#####################################################
#
# Subroutine: get settlement records from the database
#
sub getSettlements {

  my $readOnly = 0;	# set to 1 for debug
  my $rc = 0;
  
  my $sth = $G_dbh->prepare("EXEC getSettlements $readOnly");
  die 'Prepare failed' unless (defined($sth));
  $sth->execute;
  my (@row);
  do {
    while (@row = $sth->fetchrow() ) {
      if ($sth->{syb_result_type} == CS_ROW_RESULT) {
        my $settlementID             = shift  @row;
        $invoice{$settlementID}      = shift @row;
        $orderID{$settlementID}      = shift @row;
        $pmtType{$settlementID}      = shift @row;
        $ccID{$settlementID}         = shift @row;
        $accountID{$settlementID}    = shift @row;
        $amount{$settlementID}       = shift @row;
        $AVS_result{$settlementID}   = shift @row;
        $approvalCode{$settlementID} = shift @row;
      }
      elsif ($sth->{syb_result_type} == CS_STATUS_RESULT) {
        $rc = shift @row;	# expect '20000' if no rows to process
      }
    }
  } while($sth->{syb_more_results});
  $sth->finish;

  if ($rc != 0) {
    die "Database error $rc" if ($rc != 20000);
  }

  return (scalar keys %orderID);
}

##################
#
# Write action to the database log
#
sub writeLog {
	my $aid = shift @_;
	my $msg = shift @_;
	chomp $msg;
	$msg =~ s/"/'/g;
	my $sql = qq!EXEC addActivityLogById $aid, "$msg"!;
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

##################
#
# Subroutine: Send password email
#
require "/u/vplaces/scripts/cannedMessages/newAccount.pl";

sub sendPw
{
    my $hold      = shift @_;
    my $email     = shift @_;
    my $accountID = shift @_;
    my $name      = shift @_;
    my $pswd      = shift @_;
    my $freeTrial = shift @_;
    my $from      = $G_config{'billingEmail'};
    my $fromName  = "VPchat Customer Service";

    my $cannedMsg = &newAccount($from, $fromName, $email, $accountID, $name, $pswd, $hold, $freeTrial);

    if ($G_config{'testServer'}) {
      $smFlg = '-Ac -odq';
    }
    else {
      $smFlg = '-odq';
    }
    $queuedMail = 1;	# global flag
    open( MAIL, "| /usr/lib/sendmail $smFlg -f $from -t > /dev/null");
    print MAIL $cannedMsg;
    print MAIL $G_configHtml{'signature'};
    close( MAIL );
##DEBUG
open( MAIL, qq!| /usr/lib/sendmail -f $from $G_config{'devEmail'} > /dev/null! );
print MAIL $cannedMsg;
print MAIL $G_configHtml{'signature'};
print MAIL "\noriginally to $email\n";
close( MAIL );
#open( MAIL, qq!| /usr/lib/sendmail -f $from jules\@vpchat.com > /dev/null! );
#print MAIL $cannedMsg;
#print MAIL $G_configHtml{'signature'};
#print MAIL "\noriginally to $email\n";
#close( MAIL );
##DEBUG
}

##################
#
# Subroutine: Send thank-you email
#
require "/u/vplaces/scripts/cannedMessages/pmtReceipt.pl";

sub sendMail
{
    my $reason = shift @_;
    my $email = shift @_;
    my $amount = shift @_;
    my $accountID = shift @_;
    my $from = $G_config{'billingEmail'};
    my $fromName  = "VPchat Customer Service";
    my $newBal = 0;
    $amount = sprintf("%6.2f", $amount);
    $amount =~ s/^\s+//;

    my $cannedMsg = &pmtReceipt($from, $fromName, $email, $accountID, $amount, $reason, $newBal);

    if ($G_config{'testServer'}) {
      $smFlg = '-Ac -odq';
    }
    else {
      $smFlg = '-odq';
    }
    $queuedMail = 1;	# global flag
    open( MAIL, "| /usr/lib/sendmail $smFlg -f $from -t > /dev/null");
    print MAIL $cannedMsg;
    print MAIL $G_configHtml{'signature'};
    close( MAIL );
##DEBUG
open( MAIL, qq!| /usr/lib/sendmail -f $from $G_config{'devEmail'} > /dev/null! );
print MAIL "$cannedMsg\nOriginally to $email";
close( MAIL );
open( MAIL, qq!| /usr/lib/sendmail -f $from $G_config{'billingEmail'} > /dev/null! );
print MAIL $cannedMsg;
print MAIL $G_configHtml{'signature'};
print MAIL "\noriginally to $email\n";
close( MAIL );
##DEBUG
}


######################
#
# Subroutine: process settled payments
#
sub doSettlement {

	my $sid = shift @_;

	&writeLog($accountID{$sid}, "AuthorizeNet transaction ID: $sid - $orderID{$sid} processed");

	#
	# Apply the payment to the account
	#
	#my $hold = (($AVS_result{$sid}+0) == 9) ? 1 : 0;
	my $hold = (($pmtType{$sid}+0) == 3) ? 1 : 0;
	my $freeTrial = ($invoice{$sid} =~ /-T$/) ? 1 : 0;

	#
	# Historical note:
	# With the original Wells Fargo eStore interface, the orderID
	# was a monotonically increasing integer and the shopper ID was
	# a long (mostly useless) character string. With the WFGPG, the
	# orderID is now a 20 digit numeric string. To cleanly retrofit
	# this into the table, the settlementID is used as the orderID
	# (since it is a monotonically increasing integer) and the orderID
	# goes in the shopperID field.
	#
	# Version 3 - Authorize.Net
	# The Transaction ID is like the orderID.

	my $avs = (($pmtType{$sid} == 3) && ($AVS_result{$sid} eq 'Pass')) ? 9 : $AVS_result{$sid};	# for backward compatibility
	my $sql = "EXEC addPaymentCC $accountID{$sid}, $amount{$sid}, ";
	$sql .= $G_dbh->quote($avs) . ',';
	$sql .= $G_dbh->quote($orderID{$sid}) . ',';
	$sql .= $G_dbh->quote($sid) . ',';
	$sql .= $G_dbh->quote($approvalCode{$sid}) . ',';
	$sql .= $G_dbh->quote($invoice{$sid}) . ',';
	$sql .= "$hold, $freeTrial, $pmtType{$sid}, $ccID{$sid}";
	$sth = $G_dbh->prepare($sql);
	die 'Prepare failed' unless (defined($sth));
	$sth->execute;
	my $rc = -1;
	do {
	  while (@row = $sth->fetchrow() ) {
	    if ($sth->{syb_result_type} == CS_STATUS_RESULT) {
		$rc = shift @row;
	    }
	  }
	} while($sth->{syb_more_results});

	$sth->finish;

	my ($email, $nickName, $password, $pmtStat);

	if ($rc < 20000) {
		$pmtStat = (($rc < 100) || ($rc == 10000)) ? 'applied' : 'HELD';
		&log("- $accountID{$sid} - pmt of $amount{$sid} $pmtStat - rc $rc ");
		my $amtMsg = sprintf "%8.2f", $amount{$sid};
		$amtMsg =~ s/^\s+//;
		&writeLog($accountID{$sid}, "pmt of \$ $amtMsg $pmtStat\n");
	}

	#
	# acct was New - send password
	#
	if (($rc == 1)   ||	# new
	    ($rc == 101) ||	# new - echeck pmt held
	    ($rc == 102))	# new - free trial
	{
		my $sql = "SELECT nickName,password,userAccounts.email ";
		$sql .= "FROM userAccounts,registration,users ";
		$sql .= "WHERE  users.userID=$accountID{$sid} ";
		$sql .= "AND    users.userID=registration.accountID ";
		$sql .= "AND userAccounts.accountID = registration.userID";
		my $sth = $G_dbh->prepare($sql);
  		die 'Prepare failed' unless (defined($sth));
  		$sth->execute;
		my (@row);
		my $ok = 0;
		do {
		  while (@row = $sth->fetchrow() ) {
	    	    next unless($sth->{syb_result_type} == CS_ROW_RESULT);
		    $nickName = shift @row;
		    $password = shift @row;
		    $email    = shift @row;
		    $ok = 1;
		  }
		} while($sth->{syb_more_results});
		$sth->finish;
		unless($ok) {
		  &log("-- ERROR no data for $accountID ");
		  return;
		}
#### debug
if ($email eq "") {
  &log("-- ERROR no email for $accountID{$sid} ");
  return;
}
if ($nickName eq "") {
  &log("-- ERROR no nickName for $accountID{$sid} ");
  return;
}
if ($password eq "") {
  &log("-- ERROR no password for $accountID{$sid} ");
  return;
}
#### debug
		my $hold = ($rc == 101) ? 1 : 0;
		my $ft   = ($rc == 102) ? 1 : 0;
		&sendPw ($hold, $email, $accountID{$sid}, $nickName, $password, $ft);
		&log('- account was NEW, password sent ');
		&writeLog($accountID{$sid}, "password sent to $email by settlement process\n");
	}

	#
	# acct was OK, Pending, or Overdue
	# - also handle pmt that was insufficient to clear the balance
	#
	elsif ( ($rc == 0) ||	# OK
		($rc == 2) ||	# was pending
		($rc == 3) ||	# was overdue
		($rc == 100) ||	# payment on hold
		($rc == 10000))	# still has non-zero balance
	{
		my $sql = "SELECT nickName,userAccounts.email ";
		$sql .= "FROM userAccounts,users ";
		$sql .= "WHERE  userAccounts.accountID = $accountID{$sid} ";
		$sql .= "AND    users.userID=userAccounts.ownerID";
		my $sth = $G_dbh->prepare($sql);
  		die 'Prepare failed' unless (defined($sth));
  		$sth->execute;
		my (@row);
		my $ok = 0;
		do {
		  while (@row = $sth->fetchrow() ) {
	    	    next unless($sth->{syb_result_type} == CS_ROW_RESULT);
		    $nickName = shift @row;
		    $email    = shift @row;
		    $ok = 1;
		  }
		} while($sth->{syb_more_results});
		$sth->finish;
		unless($ok) {
		  &log("-- ERROR no data for $accountID{$sid} ");
		  return;
		}
#### debug
if ($email eq "") {
  &log("-- ERROR no email for $accountID{$sid}");
  return;
}
if ($nickName eq "") {
  &log("-- ERROR no nickName for $accountID{$sid}");
  return;
}
#### debug
		if ($rc == 3) {
		  &sendMail ("overdue", $email, $amount{$sid}, $accountID{$sid});
		  &writeLog($accountID{$sid}, "thankyou and overdue-clear notice sent to $email by settlement process\n");
		}
		elsif($rc == 10000) {
		  &sendMail ("insufficient", $email, $amount{$sid}, $accountID{$sid});
		  &writeLog($accountID{$sid}, "insufficient payment notice sent to $email by settlement process\n");
		}
		elsif ($rc == 2) {
		  &sendMail ("renewal", $email, $amount{$sid}, $accountID{$sid});
		  &writeLog($accountID{$sid}, "thankyou and subscription renewal notice sent to $email by settlement process\n");
		}
		elsif ($rc == 100) {
		  &sendMail ("held", $email, $amount{$sid}, $accountID{$sid});
		  &writeLog($accountID{$sid}, "thankyou and subscription renewal notice sent to $email by settlement process\n");
		}
		else {
		  &sendMail ("std", $email, $amount{$sid}, $accountID{$sid});
		  &writeLog($accountID{$sid}, "thankyou sent to $email by settlement process\n");
		}
		&log("- $accountID{$sid} - thankyou sent to $email");
	}
	#
	# error when applying payment
	#
	else {
		open(MAILX, "| /usr/bin/mailx -s 'Settlement Problem' $G_config{'devEmail'} $G_config{'billingEmail'}");
		my $emsg = "Error code: $rc";
		if ($rc == 20001) {
			$emsg = "Error: unknown account";
		}
		elsif ($rc == 20002) {
			$emsg = "Error: duplicate payment";
		}
		elsif ($rc == 20003) {
			$emsg = "Error: closed or suspended account";
		}
		elsif ($rc == 20004) {
			$emsg = "Error: attempt to use bad credit";
		}
		elsif ($rc == 20005) {
			$emsg = "Error: card/acct not found";
		}
		elsif ($rc == 103) {
			$emsg = "Note: echeck payment on expired account, check to see if it should be set pending";
		}
		print MAILX <<MSG;
Add Payment $emsg
Account:  $accountID{$sid}
Amount:   $amount{$sid}
Order ID: $orderID{$sid}
Invoice:  $invoice{$sid}
MSG
		close MAILX;
		&log("- $accountID{$sid} - addPayment error: $emsg ");
	}

        #
        # Send customer's payment message, if any
	#
	$pmtMsg = "/logs/pmtMsgs/" .  $invoice{$sid};
        if (($email ne '') && ($invoice{$sid} ne '') && (-f $pmtMsg)) {
    		open( MAIL, "| /usr/lib/sendmail -oi -oem -f $email -t > /dev/null");
		open(MSG, "<$pmtMsg");
		while (<MSG>) {
			print MAIL;
		}
		close MSG;
		close MAIL;

		unlink $pmtMsg;
	}
}

######################
#
# START HERE
#

$logDir = "/logs/settlements";
$logFile  = $logDir . "/AuthorizeNet.log";

$ENV{'SYBASE'} ||= '/u/vplaces/s/sybase';
$G_dbh = DBI->connect ( 'dbi:Sybase:', 'vpusr', 'vpusr1' );

$queuedMail = 0;	# global flag

#
# See if there are any settlements to process
#
%invoice = ();%orderID = (); %ccID = (); %pmtType = ();
%accountID = (); %amount = (); %AVS_result = (); %approvalCode = ();

$settlementCount = &getSettlements;

if ($settlementCount == 0) {
  exit;
}
&getConfigKeys;

#
# Create log file
#
@now = localtime(time);
$now[4]++;
$now[5] += 1900;
$suffix = sprintf(".%4.4d%2.2d%2.2d.%2.2d.%2.2d.%2.2d", $now[5], $now[4], $now[3], $now[2], $now[1], $now[0]);

#$processed = $logDir . "/processed" . $suffix;
#open(LOG, ">$processed") || die "Can't create $processed : $!";

#
# Process incoming settlement records
#
foreach $settlementID (keys %orderID) {
  &doSettlement($settlementID);
}

#
# Process queued mail
# 
if ($queuedMail && (! $G_config{'testServer'})) {
	$n = scalar localtime;
	&log("$n\trunning mail queue\n");
	`/usr/lib/sendmail -q`;
	$n = scalar localtime;
	&log("$n\tmail queue complete\n");
}
