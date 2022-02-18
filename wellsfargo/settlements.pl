#!/usr/bin/perl
#
# Periodically process the Wells Fargo settlements log.
#
# Tom Lang 3/2002
#
#use Date::Manip;
use DBI;
use DBD::Sybase;
use LWP::UserAgent;
use Crypt::SSLeay;

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

##################
#
# Write action to account-specific log file
# - input is account ID
#
sub writeSubscrLog {
	die "programming error" unless ($#_ == 1);
	my $accountID = shift @_;
	die "programming error" if ($accountID eq "");
	my $msg = shift @_;
	chomp $msg;

	&addActivityLogById( $accountID, $msg );

	#$msg .= "\n" unless ($msg =~ /\n$/);
	#my $logFile = "/logs/accounts/" . $accountID;
	#my $new = (-f "$logFile") ? 0 : 1;
	#open (SLOG, ">>$logFile");
	#my $now = scalar localtime;
	#print SLOG "$now\t$msg";
	#close SLOG;
	#chmod 0666, "$logFile" if ($new);

	#$logFile = "/logs/accountIDs/" . $accountID;
	#if (-f $logFile) {
		#$msg = "$accountID\t$msg";
		#open (ULOG, ">>$logFile");
		#print ULOG "$now\t$msg";
		#close ULOG;
	#}

	&writeAcctLog( $msg );
}

##################
#
# Write action to user-specific log file
# - input is account owner name
# - also writes to the summary log
#
sub writeLog {
	die "programming error" unless ($#_ == 1);
	my $aid = shift @_;
	my $msg = shift @_;
	$msg =~ s/"/'/g;
	chomp $msg;

	&addActivityLogById( $aid, $msg );

	#$msg .= "\n";
	#my $logFile = "/logs/accountIDs/" . $aid;
	#my $new = (-f "$logFile") ? 0 : 1;
	#open (ULOG, ">>$logFile");
	#my $now = scalar localtime;
	#$msg = "$aid\t$msg";
	#print ULOG "$now\t$msg";
	#close ULOG;
	#chmod 0666, "$logFile" if ($new);
	#my $acctLog = "/logs/accountIDs/" . $aid;
	#unless (-f $acctLog) {
		#link $logFile, $acctLog;
		#chmod 0666, "$acctLog";
	#}

	&writeAcctLog( $msg );
}

##################
#
# Write action to account activity log file
# - this log is a summary of all account activity
#
sub writeAcctLog {

### disabled, since logging to the DB now
return;
###
	my $msg = $_[0];
	$msg .= "\n" unless ($msg =~ /\n$/);
	open (ALOG, ">>/logs/account_usage.log");
	my $now = scalar localtime;
	print ALOG "$now\t$msg";
	close ALOG;
}
1;

##################
#
# Write action to the database log
#
sub addActivityLogById {
	my $aid = shift @_;
	my $msg = shift @_;
	$msg =~ s/"/'/g;
	my $sql = qq!EXEC addActivityLogById $aid, "$msg"!;
###DEBUG
open (DBG, ">>/logs/wfdebug.log");
print DBG "============================\n$sql\n";
	my $sth = $G_dbh->prepare($sql);
	die 'Prepare failed' unless (defined($sth));
	$sth->execute;
	my ($rc, @row);
	do {
	  while (@row = $sth->fetchrow() ) {
	    if ($sth->{syb_result_type} == CS_STATUS_RESULT) {
		$rc = shift @row;
print DBG "RC $rc\n";
	    }
	  }
	} while($sth->{syb_more_results});

	$sth->finish;
close DBG;
}

##################
#
# Subroutine: Parse a settement record. Keys and values are
#	separated by an '='. Key/value pairs are separated by a ':'.
#
sub parse_rec {

   my $buffer = shift @_;
   my ($name, $value, @pairs, @values);
   undef %contents;	# global variable

   @pairs = split(/:/, $buffer);
    
   foreach $pair (@pairs) {
	($name, $value) = split(/=/, $pair);
	if (defined($contents{$name})) {
		$contents{$name} .= ",$value";
	} else {
		$contents{$name} = $value;
	}
   }
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

    $email = $G_config{'devEmail'} if ($G_config{'testServer'});
    my $cannedMsg = &newAccount($from, $fromName, $email, $accountID, $name, $pswd, $hold, $freeTrial);

    $queuedMail = 1;	# global flag
    my $flgs = ($G_config{'testServer'}) ? '-t' : "-odq -f $from -t";
    if ( open( MAIL, "| /usr/lib/sendmail $flgs > /dev/null" ) ) {
	print MAIL $cannedMsg;
	print MAIL $G_configHtml{'signature'};
	close( MAIL );
##DEBUG
open( MAIL, qq!| /usr/lib/sendmail -f $from $G_config{'devEmail'} > /dev/null! );
print MAIL $cannedMsg;
print MAIL $G_configHtml{'signature'};
print MAIL "\noriginally to $email\n";
close( MAIL );
open( MAIL, qq!| /usr/lib/sendmail -f $from $G_config{'supportEmail'} > /dev/null! );
print MAIL $cannedMsg;
print MAIL $G_configHtml{'signature'};
print MAIL "\noriginally to $email\n";
close( MAIL );
   }
   else { die "CAN'T SEND MAIL"; }
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
    my $payment = shift @_;
    my $accountID = shift @_;
    my $from = $G_config{'billingEmail'};
    my $fromName  = "VPchat Customer Service";
    $payment = sprintf("%6.2f", $payment);
    $payment =~ s/^\s+//;
    my $newBal = '';
    my $cannedMsg = &pmtReceipt($from, $fromName, $email, $accountID, $payment, $reason, $newBal);   

    $queuedMail = 1;	# global flag
    my $flgs = ($G_config{'testServer'}) ? '-t' : "-odq -f $from -t";
    if ( open( MAIL, "| /usr/lib/sendmail $flgs > /dev/null" ) ) {
	print MAIL $cannedMsg;
	close( MAIL );
   }
   else { die "CAN'T SEND MAIL"; }
##DEBUG
open( MAIL, qq!| /usr/lib/sendmail -f $from $G_config{'devEmail'} > /dev/null! );
print MAIL "$cannedMsg\nOriginally to $email";
close( MAIL );
open( MAIL, qq!| /usr/lib/sendmail -f $from $G_config{'supportEmail'} > /dev/null! );
print MAIL $cannedMsg;
print MAIL $G_configHtml{'signature'};
print MAIL "\noriginally to $email\n";
close( MAIL );
##DEBUG

}


sub log {
  open (SETTLEMENTLOG, ">>$logFile") || die "Can't append to $logFile : $!";
  print SETTLEMENTLOG $_[0];
  close SETTLEMENTLOG;
}

######################
#
# Subroutine: post settlement transaction to the bank
#

%AVScodes = (
	0 => "AVS: no data",
	1 => "AVS: no match",
	2 => "AVS: address match only",
	3 => "AVS: zip match only",
	4 => "AVS: OK match",
	9 => "AVS: Electronic check"
);

#
# Return 0 for failure, 1 for success
#
sub postSettlement {
	#
	# This is the "API user" defined in the Wells Fargo eStore
	#
	my $user = "vplaces";
	my $pw   = "P83H6IJ";

	#
	# Sanity checks
	#
	unless (defined($contents{'IOC_merchant_shopper_id'})) {
		&log("- missing accountID ");
		open(MAILX, "| /usr/bin/mailx -s 'Settlement Problem' $G_config{'devEmail'}");
		print MAILX "Missing accountID\n";
		close MAILX;
		return 0;
	}
	my $accountID    = $contents{'IOC_merchant_shopper_id'};

	unless (defined($contents{'IOC_authorization_amount'}) &&
	        defined($contents{'IOC_order_total_amount'}))
	{
		&log("- missing amount ");
		open(MAILX, "| /usr/bin/mailx -s 'Settlement Problem' $G_config{'devEmail'}");
		print MAILX "Missing amount\n";
		close MAILX;
		return 0;
	}
	my $amount       = $contents{'IOC_order_total_amount'};
	my $authAmt      = $contents{'IOC_authorization_amount'};

	if ($amount != $authAmt) {
		&log("- amount mismatch, $amount != $authAmt ");
		open(MAILX, "| /usr/bin/mailx -s 'Settlement Problem' $G_config{'devEmail'}");
		print MAILX "Amount mismatch, $amount != $authAmt\n";
		close MAILX;
		return 0;
	}

	#
	# Check AVS results
	#
	unless (defined($contents{'IOC_AVS_result'}) &&
		defined($AVScodes{$contents{'IOC_AVS_result'}}))
	{
		&log("- missing/bogus AVS results ");
		open(MAILX, "| /usr/bin/mailx -s 'Settlement Problem' $G_config{'devEmail'}");
		print MAILX "Missing/bogus AVS results\n";
		close MAILX;
		return 0;
	}
	my $AVSresult = $contents{'IOC_AVS_result'};
	my $amsg = $AVScodes{$AVSresult};
	&log("- $amsg ");
	
	if (($AVSresult == 1) ||
	    ($AVSresult == 2) ||
	    ($AVSresult == 3))
	{
		open(MAILX, "| /usr/bin/mailx -s 'AVS Warning' $G_config{'devEmail'}");
		print MAILX "AVS WARNING $amsg\n";
		print MAILX "Account $accountID\n";
		close MAILX;
	}

	#
	# If the preceeding sanity checks passed, the rest of the
	# fields are going to be OK ...
	#
	my $handshake    = $contents{'IOC_merchant_order_id'};
	my $shopperID    = $contents{'IOC_shopper_id'};
	my $orderID      = $contents{'IOC_order_id'};
	my $approvalCode = $contents{'IOC_authorization_code'};

	#
	# Build the query string for the POST
	#
	my $query = "IOC_Handshake_ID=$handshake";
	$query .= "&IOC_Merchant_ID=vpchat";
	$query .= "&IOC_User_Name=$user";
	$query .= "&IOC_Password=$pw";
	$query .= "&IOC_order_number=$orderID";
	$query .= "&IOC_indicator=S";
	$query .= "&IOC_settlement_amount=$amount";
	$query .= "&IOC_order_total_amount=$amount";
	$query .= "&IOC_authorization_code=$approvalCode";
	$query .= "&IOC_email_flag=No";
	$query .= "&IOC_close_flag=Yes";

	#
	# If test server, just log the query string
	#
	if ($G_config{'testServer'}) {
		open(DEBUGLOG, ">>/logs/settlements/debug.log");
		my $now = scalar localtime;
		print DEBUGLOG "$now\t$query\n";
		close DEBUGLOG;
	  	&log("- settlement OK - order $orderID ");
		return 1;
	}

	#
	# submit the POST
	#
	$ua = new LWP::UserAgent;
	$ua->protocols_allowed( [ 'http', 'https'] ); 
	$req = new HTTP::Request 'POST','https://cart.wellsfargoestore.com/settlement.mart';
	$req->content_type('application/x-www-form-urlencoded');
	$req->content($query);
	$res = $ua->request($req);

	if ($res->is_success) {
	  &log("- settlement OK - order $orderID ");
	  return 1;
	}
        open (D, ">>/logs/settlements/debug");
	print D $res->content;
	print D $res->error_as_HTML;
	close D;

	&log("- settlement FAIL - order $orderID acct $accountID ");
	open(MAILX, "| /usr/bin/mailx -s 'SETTLEMENT PROBLEM' $G_config{'devEmail'}");
	print MAILX "Post Settlement failure - $accountID - $orderID\n";
	print MAILX $res->content;
	print MAILX $res->error_as_HTML;
	close MAILX;
	return 0;
}

######################
#
# Subroutine: process subscription payments
#
sub handlePayment {

	my $comment      = $contents{'IOC_merchant_order_id'};
	my $shopperID    = $contents{'IOC_shopper_id'};
	my $orderID      = $contents{'IOC_order_id'};
	my $accountID    = $contents{'IOC_merchant_shopper_id'};
	my $amount       = $contents{'IOC_order_total_amount'};
	my $approvalCode = $contents{'IOC_authorization_code'};
	my $AVSresult    = $contents{'IOC_AVS_result'};

	&writeSubscrLog($accountID, "Wells Fargo order ID: $orderID processed");

	$date = scalar localtime;
	my @d = split(/\s+/, $date);
	$date = join(' ', $d[1], $d[2], $d[4], $d[3]);

	#
	# Find the credit card or bank account from which
	# this payment came.
	#
	my $pmtType = ($AVSresult == 9) ? 3 : 2;
	$sql = "SELECT ccID FROM subscriptions";
	$sql .= " WHERE accountID = $accountID";
	$sql .= " AND type = $pmtType";
	my $sth = $G_dbh->prepare($sql);
	die 'Prepare failed' unless (defined($sth));
	$sth->execute;
	my $ccID = -1;
	do {
	  while (@row = $sth->fetchrow() ) {
	    if ($sth->{syb_result_type} == CS_ROW_RESULT) {
		$ccID = shift @row;
	    }
	  }
	} while($sth->{syb_more_results});

	$sth->finish;
	undef $sql;
	if ($ccID == -1) {
	  &log(" - WARNING: no ccID");
	}

	#
	# Apply the payment to the account
	#
	my $hold = ($AVSresult == 9) ? 1 : 0;
	my $freeTrial = ($comment =~ /-T$/) ? 1 : 0;

	my $sql = "EXEC addPaymentCC $accountID, $amount,";
	$sql .= $G_dbh->quote($AVSresult) . ',';
	$sql .= $G_dbh->quote($shopperID) . ',';
	$sql .= $G_dbh->quote($orderID) . ',';
	$sql .= $G_dbh->quote($approvalCode) . ',';
	$sql .= $G_dbh->quote($comment) . ',';
	$sql .= "$hold, $freeTrial, $pmtType, $ccID";
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
		$pmtStat = ($rc < 100) ? 'applied' : 'HELD';
		&log("- $accountID - pmt of $amount $pmtStat - rc $rc ");
	}

	#
	# acct was New - send password
	#
	if (($rc == 1)   ||	# new
	    ($rc == 101) ||	# new - echeck pmt held
	    ($rc == 102))	# new - free trial
	{
		my $amtMsg = sprintf "%8.2f", $amount;
		$amtMsg =~ s/^\s+//;
		&writeSubscrLog($accountID, "pmt of \$ $amtMsg $pmtStat\n");
		my $sql = "SELECT nickName,password,userAccounts.email ";
		$sql .= "FROM userAccounts,registration,users ";
		$sql .= "WHERE  users.userID=$accountID ";
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
  &log("-- ERROR no email for $accountID ");
  return;
}
if ($nickName eq "") {
  &log("-- ERROR no nickName for $accountID ");
  return;
}
if ($password eq "") {
  &log("-- ERROR no password for $accountID ");
  return;
}
#### debug
		my $hold = ($rc == 101) ? 1 : 0;
		my $ft   = ($rc == 102) ? 1 : 0;
		&sendPw ($hold, $email, $accountID, $nickName, $password, $ft);
		&log('- account was NEW, password sent ');
		&writeLog($accountID, "password sent to $email by settlement process\n");
	}

	#
	# acct was OK, Pending, or Overdue
	# - also handle pmt that was insufficient to clear the balance
	#
	elsif ( ($rc == 0) ||	# OK
		($rc == 2) ||	# was pending
		($rc == 3) ||	# was expired
		($rc == 100) ||	# payment on hold
		($rc == 103) ||	# payment on hold, was expired
		($rc == 10000))	# still has non-zero balance
	{
		my $sql = "SELECT nickName,userAccounts.email ";
		$sql .= "FROM userAccounts,users ";
		$sql .= "WHERE  userAccounts.accountID = $accountID ";
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
		  &log("-- ERROR no data for $accountID ");
		  return;
		}
#### debug
if ($email eq "") {
  &log("-- ERROR no email for $accountID");
  return;
}
if ($nickName eq "") {
  &log("-- ERROR no nickName for $accountID");
  return;
}
#### debug
		if ($rc == 3) {
		  &sendMail ("overdue", $email, $amount, $accountID);
		  &writeLog($accountID, "thankyou and overdue-clear notice sent to $email by settlement process\n");
		}
		elsif($rc == 10000) {
		  &sendMail ("insufficient", $email, $amount, $accountID);
		  &writeLog($accountID, "insufficient payment notice sent to $email by settlement process\n");
		}
		elsif ($rc == 2) {
		  &sendMail ("renewal", $email, $amount, $accountID);
		  &writeLog($accountID, "thankyou and subscription renewal notice sent to $email by settlement process\n");
		}
		elsif ($rc == 100) {
		  &sendMail ("pending", $email, $amount, $accountID);
		  &writeLog($accountID, "thankyou sent to $email by settlement process\n");
		}
		elsif ($rc == 103) {
		  &sendMail ("held", $email, $amount, $accountID);
		  &writeLog($accountID, "thankyou and subscription renewal notice sent to $email by settlement process\n");
		}
		else {
		  &sendMail ("std", $email, $amount, $accountID);
		  &writeLog($accountID, "thankyou sent to $email by settlement process\n");
		}
		&log("- $accountID - thankyou sent to $email");
	}
	#
	# error when applying payment
	#
	else {
		open(MAILX, "| /usr/bin/mailx -s 'Settlement Problem' $G_config{'devEmail'}");
		my $emsg = $rc;
		if ($rc == 20001) {
			$emsg = "unknown account";
		}
		elsif ($rc == 20002) {
			$emsg = "duplicate payment";
		}
		elsif ($rc == 20003) {
			$emsg = "closed or suspended account";
		}
		elsif ($rc == 20004) {
			$emsg = " payment from bad credit list";
		}
		print MAILX "addPayment error: $emsg\naccount: $accountID\namount: $amount\n";
		close MAILX;
		&log("- $accountID - addPayment error: $emsg ");
	}
}

######################
#
# START HERE
#

$logDir = "/logs/settlements";

$incoming = $logDir . "/incoming.log";

$logFile  = $logDir . "/process.log";

unless ( -f $incoming ) {
	$n = scalar localtime;
	#&log("$n\tno settlement activity to process\n");
	exit;
}

$ENV{'SYBASE'} ||= '/u/vplaces/s/sybase';
$G_dbh = DBI->connect ( 'dbi:Sybase:', 'vpusr', 'vpusr1' );

&getConfigKeys;
$queuedMail = 0;	# global flag

@now = localtime(time);
$now[4]++;
$now[5] += 1900;
$suffix = sprintf(".%4.4d%2.2d%2.2d.%2.2d.%2.2d.%2.2d", $now[5], $now[4], $now[3], $now[2], $now[1], $now[0]);

$processed = $logDir . "/processed" . $suffix;
rename $incoming, $processed;

#
# Process incoming settlement records
#
open(SETTLEMENTS, "<$processed") || die "Can't read $processed : $!";
while (<SETTLEMENTS>) {
	my $savedRec = $_;
	chomp;
	($timeStamp, $rec) = split(/\t/, $_);
	&parse_rec($rec);

	#
	# Handle only completed transactions
	#
	$when = scalar localtime;
	if ($contents{'Ecom_transaction_complete'} eq "TRUE") {
		&log("$when ");
		unless(defined($contents{'IOC_response_code'})) {
			&log("MISSING RESPONSE CODE\n");
			open(MAILX, "| /usr/bin/mailx -s 'Settlement Problem' $G_config{'devEmail'}");
			print MAILX "Missing response code\n";
			close MAILX;
			next;
		}
		my $rc = $contents{'IOC_response_code'};
		if (($rc == -1)  && ($contents{'IOC_authorization_code'} eq 'FAITH')) {
			&log("FAITH approval\n");
			open(MAILX, "| /usr/bin/mailx -s 'FAITH approval from Wells Fargo' $G_config{'devEmail'}");
			print MAILX "FAITH approval = acct $contents{'IOC_merchant_shopper_id'}\n";
			close MAILX;
		}
		elsif ($contents{'IOC_response_code'} != 0) {
			&log("UNEXPECTED RESPONSE CODE\n");
			open(MAILX, "| /usr/bin/mailx -s 'Settlement Problem' $G_config{'devEmail'}");
			print MAILX "Unexpected response code $rc\n";
			close MAILX;
			next;
		}

		#
		# If this is an electronic check, processing is done
		# in two phases. First time through we log a payment (which
		# is marked 'hold'). Second time through, which happens 
		# after the check has cleared, we post a settlement to 
		# Wells Fargo.
		#
		my $AVSresult = $contents{'IOC_AVS_result'};
		my $invoice = $contents{'IOC_merchant_order_id'};
		if ($AVSresult == 9) {
			my $cleared = ($contents{'Hold'} eq 'Cleared') ? 1 : 0;
			if ($cleared) {
				&postSettlement;
			} else {
				&handlePayment;
			}
		}

		#
		# If this is a free trial, it is handled in two phases 
		# similar to an eCheck. The first time through we get
		# an approval code. The second time through, which happens
		# at the end of the free trial, we post a settlement.
		#
		elsif ($invoice =~ /-T$/) {
			my $cleared = ($contents{'Hold'} eq 'Cleared') ? 1 : 0;
			if ($cleared) {
				&postSettlement;
			} else {
				&handlePayment;
			}
		}

		#
		# Credit card payments are processed immediately
		#
		else {
			if (&postSettlement) {
				&handlePayment;
			}
		}
		&log("\n");
	}

	#
	# Some kind of error record - make a note of it
	#
	else {
		&log("$when - invalid or missing completion code - $contents{'Ecom_transaction_complete'}\n");
	}
}
close SETTLEMENTS;

#
# Process queued mail
# 
if ($queuedMail) {
	$n = scalar localtime;
	&log("$n\trunning mail queue\n");
	`/usr/lib/sendmail -q`;
	$n = scalar localtime;
	&log("$n\tmail queue complete\n");
}
