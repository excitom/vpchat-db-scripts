#!/usr/bin/perl
#
# Periodically process the PayPal IPN log
# IPN = Instant Payment Notification
#
# Tom Lang 12/2001
#
use DBI;
use DBD::Sybase;

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
# Write action to account-specific log file
# - input is account ID
#
sub writeSubscrLog {
	die "programming error" unless ($#_ == 1);
	my $accountID = shift @_;
	die "programming error" if ($accountID eq "");
	my $msg = shift @_;
	chomp $msg;

	&addActivityLogById( $accountID, "$msg" );
}

##################
#
# Write action to user-specific log file
# - input is account owner name
# - also writes to the summary log
#
sub writeLog {
	die "programming error" unless ($#_ == 2);
	my $user = shift @_;
	## $user no longer needed
	#die "programming error" if ($user eq "");
	#$user =~ tr/[A-Z]/[a-z]/;
	my $aid = shift @_;
	my $msg = shift @_;
	chomp $msg;

	&addActivityLogById( $aid, $msg );

	my $now = scalar localtime;
	$msg = "$user\t$aid\t$msg";

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
	my $logFile = "/logs/account_usage.log";
	$msg .= "\n" unless ($msg =~ /\n$/);
	if ($G_config{'thisHost'} eq $G_config{'logFileServer'}) {
		open(ALOG, ">> $logFile") || die "Can't append : $!";
	} else {
		open(ALOG, "| /bin/rsh $G_config{'logFileServer'} \"cat >> $logFile\" ") || die "Can't rsh : $!";
	}
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

##################
#
# Add information about the paypal payer to the database
#
sub addPaypalInfo {
	return   unless(defined($contents{'payer_email'}) &&
		 defined($contents{'first_name'}) &&
		 defined($contents{'payer_status'}) &&
		 defined($contents{'last_name'}));
	my $aid = (defined($contents{'custom'})) ? $contents{'custom'} : 'NULL';
	$aid = 'NULL' if ($aid eq '');
	$contents{'payer_email'} =~ tr/[A-Z]/[a-z]/;

  	my $sql =<<SQL;
EXEC addPaypalInfo
  "$contents{'payer_email'}",
  "$contents{'first_name'}",
  "$contents{'last_name'}",
  "$contents{'payer_status'}",
  $aid,
SQL
	if (!defined($contents{'payer_id'}) || ($contents{'payer_id'} eq '')) {
		$sql .= "NULL,\n";
	} else {
		$sql .= qq!"$contents{'payer_id'}",\n!;
	}
	if (!defined($contents{'subscr_id'}) || ($contents{'subscr_id'} eq '')) {
		$sql .= "NULL\n";
	} else {
		$sql .= qq!"$contents{'subscr_id'}"\n!;
	}
  	my $sth = $G_dbh->prepare($sql);
  	die 'Prepare failed' unless (defined($sth));
  	$sth->execute;
  	my (@row);
	$contents{'ccID'} = -1;
  	do {
    	  while (@row = $sth->fetchrow() ) {
	    if ($sth->{syb_result_type} == CS_ROW_RESULT) {
	      $contents{'ccID'} = shift @row;
	    }
	    elsif ($sth->{syb_result_type} == CS_STATUS_RESULT) {
	    	my $rc = shift @row;
		if ($rc != 0) {
		  my $msg = "Unknown error from addPaypalInfo $rc, email $contents{'payer_email'}";
		  &log($msg);
		  if (defined($contents{'custom'})) {
		    &writeLog("", $contents{'custom'}, $msg);
		    $msg .= "\nAccount: $contents{'custom'}\n";
		  }
		  $msg .= "\nTXN: $contents{'txn_id'}\n" if (defined($contents{'txn_id'}));
		  $msg .= "\nType: $contents{'txn_type'}\n";
  		  my %to = ( $G_config{'billingEmail'} => 1, $G_config{'devEmail'} => 1 );
  		  my $to = join(' ', (keys %to));
		  open(MAILX, "| /usr/bin/mailx -s 'IPN PROBLEM' $to");
		  print MAILX $msg;
		  close MAILX;
		}
	    }
	  }
  	} while($sth->{syb_more_results});
  	$sth->finish;
}

##################
#
# Subroutine: Parse an IPN record, which is in URL-encoded
#		query string format.
#
sub parse_rec {

   my $buffer = shift @_;
   my ($name, $value, @pairs, @values);
   undef %contents;	# global variable

   @pairs = split(/&/, $buffer);
    
   foreach $pair (@pairs) {
	($name, $value) = split(/=/, $pair);
	$value =~ tr/+/ /;
	$value =~ s/%([a-fA-F0-9][a-fA-F0-9])/pack("C", hex($1))/eg;
	if (defined($contents{$name})) {
		$contents{$name} .= ",$value";
	} else {
		$contents{$name} = $value;
	}
   }
}

##################
#
# Subroutine: Send request for more info
#
require "/u/vplaces/scripts/cannedMessages/paypalNoEmail.pl";
sub sendInfoReq
{
    my $cmd = shift @_;
    my $email = shift @_;
    my $amount = shift @_;
    my $from = $G_config{'billingEmail'};
    my $fromName = 'VPchat Customer Service';

    $amount = sprintf "%6.2f", $amount;
    $amount =~ s/\s+//g;
    my $cannedMsg = &paypalNoEmail($from, $fromName, $email, $amount, $cmd);

    my $flgs = ($G_config{'testServer'}) ? '-t' : "-odq -f $from -t";
    if ( open( MAIL, "| /usr/lib/sendmail $flgs > /dev/null" ) ) {
     print MAIL $cannedMsg;
     print MAIL $G_configHtml{'signature'};
     close( MAIL );
     $queuedMail = 1;
##DEBUG
open( MAIL, qq!| /usr/lib/sendmail -f $from $G_config{'devEmail'} > /dev/null! );
print MAIL $cannedMsg;
print MAIL $G_configHtml{'signature'};
print MAIL "\noriginally to $email\n";
close( MAIL );
   }
   else {
     warn "Can't send email\n";
   }
}

##################
#
# Subroutine: notify about errors
#
sub errorNotify {
    open( ERRMAIL, "| /usr/bin/mailx -s 'IPN error' $G_config{'devEmail'}" );
    my $host = `hostname`;
    chomp $host;
    print ERRMAIL "check /logs/ipn/errors.log on $host\n";
    close ERRMAIL;
}

##################
#
# Subroutine: Send password email
#
require "/u/vplaces/scripts/cannedMessages/newAccount.pl";
sub sendPw
{
    my $email     = shift @_;
    my $accountID = shift @_;
    my $name      = shift @_;
    my $pswd      = shift @_;
    my $hold      = shift @_;
    my $freeTrial = 0;
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
    my $amount = shift @_;
    my $accountID = shift @_;
    my $from = $G_config{'billingEmail'};
    my $newBal = 0;
    if ($reason eq 'insufficient') {
	my $sql =<<SQL;
SELECT subscription
FROM   accountBalance
WHERE  accountID = $accountID
SQL
	$sth = $G_dbh->prepare($sql);
	die 'Prepare failed' unless (defined($sth));
	$sth->execute;
	my (@row);
	do {
	  while (@row = $sth->fetchrow() ) {
	    if ($sth->{syb_result_type} == CS_ROW_RESULT) {
	      $newBal = shift @row;
	    }
	  }
	} while($sth->{syb_more_results});
	$sth->finish;
	if ($newBal <= 0) {
	  $newBal = 0;	# shouldn't happen
	} else {
	  $newBal = sprintf "%6.2f", $newBal;
	  $newBal =~ s/\s+//g;
	  $newBal .= ' DUE';
	}
    }

    $amount = sprintf "%6.2f", $amount;
    $amount =~ s/\s+//g;
    $fromName = 'VPchat Billing';
    my $cannedMsg = &pmtReceipt($from, $fromName, $email, $accountID, $amount, $reason, $newBal);

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
   }
   else { die "CAN'T SEND MAIL"; }
}

##################
#
# Subroutine: Send email to people who cancel
#
sub sendCancelMail
{
	return;
	##### DISABLED ###
	my $accountID = shift @_;
	my $sth = $G_dbh->prepare("SELECT email FROM userAccounts WHERE accountID=$accountID");
	die 'Prepare failed' unless (defined($sth));
	$sth->execute;
	my (@row, $email);
	do {
	  while (@row = $sth->fetchrow() ) {
	    if ($sth->{syb_result_type} == CS_ROW_RESULT) {
		$email = shift @row;
	    }
	  }
	} while($sth->{syb_more_results});

	$sth->finish;

	die "PROGRAMMING ERROR" if ($email eq "");

	my $from = 'tlang@halsoft.com';
    	my $FromW = "Tom Lang";
    	my $flgs = ($G_config{'testServer'}) ? '-oi -oem' : "-odq -f $from -F \"$FromW\"";

    	$queuedMail = 1;	# global flag
    	if ( open( MAIL, "| /usr/lib/sendmail $flgs $email > /dev/null" ) ) {
	print MAIL <<MAILMSG;
To: $email
Subject: Your subscription cancelled - account $accountID
Reply-to: billing\@halsoft.com

Hi,
I'm sorry to see you are cancelling your subscription. If you are
unsatisfied with our service in any way, please let me know why so
that we may make improvements.

Thank you for checking us out, and we hope to see you chatting with
us again some time :-)

Regards,
  Tom

--
Thomas G. Lang
President, HalSoft.com, Inc.
tlang\@halsoft.com
http://www.halsoft.com
MAILMSG

	close( MAIL );
   }
   else { die "CAN'T SEND MAIL"; }
}

sub log {
  open (IPNLOG, ">>$logFile") || die "Can't append to $logFile : $!";
  print IPNLOG $_[0];
  close IPNLOG;
}

######################
#
# Subroutine: process subscription cancellation
#
sub handleCancel {
	$subscr = $contents{'subscr_id'};
	unless (defined($contents{'custom'})) {
		&log(" - subscription $subscr cancelled, but can't find account ID");
		return;
	}
	my $accountID = $contents{'custom'};
	my $sth = $G_dbh->prepare(qq!updateSubscription $accountID, 1, 0, "$subscr"!);
	die 'Prepare failed' unless (defined($sth));
	$sth->execute;
	my (@row, $rc);
	do {
	  while (@row = $sth->fetchrow() ) {
	    if ($sth->{syb_result_type} == CS_STATUS_RESULT) {
		$rc = shift @row;
	    }
	  }
	} while($sth->{syb_more_results});

	$sth->finish;

	unless ($rc == 0) {
  		my %to = ( $G_config{'billingEmail'} => 1, $G_config{'devEmail'} => 1 );
  		my $to = join(' ', (keys %to));
		open(MAILX, "| /usr/bin/mailx -s 'IPN PROBLEM' $to");
		print MAILX "return code $rc when cancelling $accountID\n";
		close MAILX;
	}
	&sendCancelMail($accountID);
	&log(" - subscription $subscr cancelled, account ID $accountID");
	&writeSubscrLog($accountID, "Subscription ID: $subscr cancelled");
}

######################
#
# Subroutine: process subscription payment failure
#
sub handleSubscrPaymentFailure {
	$subscr = $contents{'subscr_id'};
	unless (defined($contents{'custom'})) {
		&log(" - subscription payment failed, but can't find account ID");
		return;
	}
	my $accountID = $contents{'custom'};
	&log(" - subscription payment failed for $subscr, account ID $accountID");
	&writeSubscrLog($accountID, "Subscription ID: $subscr - PayPal payment failed");

	#
	# Get current payment status
	#
	my $sql =<<SQL;
SELECT paymentStatus, accountStatus
FROM   userAccounts
WHERE  accountID = $accountID
SQL
	my $sth = $G_dbh->prepare($sql);
	die 'Prepare failed' unless (defined($sth));
	$sth->execute;
	my (@row, $prevPmtStatus, $acctStatus);
	do {
	  while (@row = $sth->fetchrow() ) {
	    if ($sth->{syb_result_type} == CS_ROW_RESULT) {
		$prevPmtStatus = shift @row;
		$acctStatus = shift @row;
	    }
	  }
	} while($sth->{syb_more_results});
	$sth->finish;


	#
	# Set payment status = Failed
	#
	$sql =<<SQL;
EXEC updatePaymentStatus $accountID, 2
SQL
	$sth = $G_dbh->prepare($sql);
	die 'Prepare failed' unless (defined($sth));
	$sth->execute;
	my ($rc);
	do {
	  while (@row = $sth->fetchrow() ) {
	    if ($sth->{syb_result_type} == CS_STATUS_RESULT) {
		$rc = shift @row;
	    }
	  }
	} while($sth->{syb_more_results});
	$sth->finish;
	print "$sql returned $rc, expected 1\n" if ($rc);

	#
	# If this is a second failure, lock the account
	#
	##if (($prevPmtStatus == 2) && ($acctStatus == 2)) {
        #
	# Get tougher
	#
	if ($acctStatus == 2) {
	  $sql =<<SQL;
EXEC updateAccountStatus $accountID, 5
SQL
	  $sth = $G_dbh->prepare($sql);
	  die 'Prepare failed' unless (defined($sth));
	  $sth->execute;
	  do {
	    while (@row = $sth->fetchrow() ) {
	      if ($sth->{syb_result_type} == CS_STATUS_RESULT) {
		  $rc = shift @row;
	      }
	    }
	  } while($sth->{syb_more_results});
	  $sth->finish;
	  print "$sql returned $rc, expected 0\n" if ($rc);

	  &writeSubscrLog( $accountID, "account set to Overdue because of multiple payment failures" );
	}
}

######################
#
# Subroutine: process payment reversals
#
sub handleReversal {

	#
	# Get parameters from the transaction record
	#
	my $email = $contents{'payer_email'};
	$email =~ tr/[A-Z]/[a-z]/;
	#
	# assumptions
	# - payment_gross is negative
	# - payment_fee is positive
	# - abs(payment_gross) + payment_fee = original payment
	#
	my $amount = $contents{'payment_gross'} - $contents{'payment_fee'};
	my $txn = $contents{'txn_id'} . '-REV';

	my $counter = 0;
	my $accountID = 0;
	if (defined($contents{'custom'})) {
	  $accountID = $contents{'custom'};
	}
	else {
	  #
	  # Use the email to find account ID 
	  #
	  my $sql =<<SQL;
EXEC getAcctForPayPal "$email"
SQL
	  my $sth = $G_dbh->prepare($sql);
	  die 'Prepare failed' unless (defined($sth));
	  $sth->execute;
          my (@row);
	  do {
	    while (@row = $sth->fetchrow() ) {
	      if ($sth->{syb_result_type} == CS_ROW_RESULT) {
		$accountID = shift @row;
		$counter++;
	      }
	    }
	  } while($sth->{syb_more_results});
	}

	#
	# Problem - couldn't find an account for this email
	#
	unless ($accountID) {
  		my %to = ( $G_config{'billingEmail'} => 1, $G_config{'devEmail'} => 1 );
  		my $to = join(' ', (keys %to));
		open(MAILX, "| /usr/bin/mailx -s 'IPN PROBLEM' $to");
		print MAILX "$email not found\n";
		close MAILX;
		&sendInfoReq("unknown", $email, $amount);
		&log("- email not an account owner, mail sent to $email");
		return;
	}

	#
	# Warning - multiple accounts for this email
	#
	if ($counter > 1) {
  		my %to = ( $G_config{'billingEmail'} => 1, $G_config{'devEmail'} => 1 );
  		my $to = join(' ', (keys %to));
		open(MAILX, "| /usr/bin/mailx -s 'IPN PROBLEM' $to");
		print MAILX "$email has $counter accounts\n";
		close MAILX;
		&sendInfoReq("dup", $email, $amount);
		&log("- email has multiple accts, mail sent to $email");
		return;
	}

	#
	# Apply the reversal to the account
	#
	$sth = $G_dbh->prepare(qq!EXEC addPaymentIPN $accountID, $amount, "$txn", $contents{'ccID'}!);
	die 'Prepare failed' unless (defined($sth));
	$sth->execute;
	my ($pmtResult);
	do {
	  while (@row = $sth->fetchrow() ) {
	    if ($sth->{syb_result_type} == CS_STATUS_RESULT) {
		$pmtResult = shift @row;
	    }
	  }
	} while($sth->{syb_more_results});

	$sth->finish;
	&handleAddPayment($accountID, $amount, $pmtResult);
}

######################
#
# Subroutine: process non-subscription payments
#
sub handlePayment {

	#
	# Get parameters from the transaction record
	#
	my $email = $contents{'payer_email'};
	$email =~ tr/[A-Z]/[a-z]/;
	my $amount = $contents{'payment_gross'};
        if ($amount == 0) {
	  $amount = $contents{'settle_amount'};
	}
	$amount +=0;
	my $txn = $contents{'txn_id'};

	my $accountID = 0;
	my $counter = 0;
	if (defined($contents{'custom'})) {
	  $accountID = $contents{'custom'};
	}
	else {
	  #
	  # Use the email to find account ID 
	  #
	  my $sql =<<SQL;
EXEC getAcctForPayPal "$email"
SQL
	  my $sth = $G_dbh->prepare($sql);
	  die 'Prepare failed' unless (defined($sth));
	  $sth->execute;
	  my $total;
          my (@row);
	  do {
	    while (@row = $sth->fetchrow() ) {
	      if ($sth->{syb_result_type} == CS_ROW_RESULT) {
		$accountID = shift @row;
		$counter++;
	      }
	    }
	  } while($sth->{syb_more_results});
        }

 	if ($accountID) {
	  my $sql =<<SQL;
SELECT subscription
FROM   accountBalance
WHERE  accountID = $accountID
SQL
	  $sth = $G_dbh->prepare($sql);
	  die 'Prepare failed' unless (defined($sth));
	  $sth->execute;
	  do {
	    while (@row = $sth->fetchrow() ) {
	      if ($sth->{syb_result_type} == CS_ROW_RESULT) {
		  $total = shift @row;
	      }
	    }
	  } while($sth->{syb_more_results});

	  $sth->finish;
        }

	#
	# Problem - couldn't find an account for this email
	#
	unless ($accountID) {
  		my %to = ( $G_config{'billingEmail'} => 1, $G_config{'devEmail'} => 1 );
  		my $to = join(' ', (keys %to));
		open(MAILX, "| /usr/bin/mailx -s 'IPN PROBLEM' $to");
		print MAILX "$email not found\n";
		close MAILX;
		&sendInfoReq("unknown", $email, $amount);
		&log("- email not an account owner, mail sent to $email");
		return;
	}

	#
	# Warning - multiple accounts for this email
	#
	if ($counter > 1) {
  		my %to = ( $G_config{'billingEmail'} => 1, $G_config{'devEmail'} => 1 );
  		my $to = join(' ', (keys %to));
		open(MAILX, "| /usr/bin/mailx -s 'IPN PROBLEM' $to");
		print MAILX "$email has $counter accounts\n";
		close MAILX;
		&sendInfoReq("dup", $email, $amount);
		&log("- email has multiple accts, mail sent to $email");
		return;
	}

	#
	# Warning - foreign currency
	#
	if (($contents{'payment_status'} eq 'Pending') &&
            ($contents{'pending_reason'} eq 'multi_currency')) {
		my $mc_gross = $contents{'mc_gross'};
		my $mc_currency = $contents{'mc_currency'};
  		my %to = ( $G_config{'billingEmail'} => 1, $G_config{'devEmail'} => 1 );
  		my $to = join(' ', (keys %to));
		open(MAILX, "| /usr/bin/mailx -s 'IPN PROBLEM' $to");
		print MAILX "$email - $accountID - Sent $mc_gross $mc_currency but status is Pending, multi_currency\n";
		close MAILX;
		&log(" - $accountID - Pending multi_currency pmt $mc_gross $mc_currency ");
	}

	#
	# Warning - didn't pay enough
	#
	if ($amount != $total) {
  		my %to = ( $G_config{'billingEmail'} => 1, $G_config{'devEmail'} => 1 );
  		my $to = join(' ', (keys %to));
		open(MAILX, "| /usr/bin/mailx -s 'IPN PROBLEM' $to");
		print MAILX "$email - $accountID - Paid $amount but owed $total\n";
		close MAILX;
		&log(" - $accountID - Paid $amount but owed $total ");
	}

	#
	# See if this is an echeck 
	#
	my $echeck = 0;
	if (($contents{'payment_status'} eq 'Pending') &&
	    ($contents{'payment_type'} eq 'echeck')) {
	  $echeck = 1;
	}
	elsif (($contents{'payment_status'} eq 'Denied') ||
	       ($contents{'payment_status'} eq 'Failed')) {
	  $echeck = 3;
	}
	elsif (($contents{'payment_status'} eq 'Completed') &&
	       ($contents{'payment_type'} eq 'echeck')) {
	  $echeck = 2;
	}

	#
	# Apply the payment to the account
	# - payment amount may be zero if Pending multi-currency transaction,
	#   do not add a $0 payment.
	#
	if ($amount != 0) {
	  $sth = $G_dbh->prepare(qq!EXEC addPaymentIPN $accountID, $amount, "$txn", $contents{'ccID'}, $echeck!);
	  die 'Prepare failed' unless (defined($sth));
	  $sth->execute;
	  my ($pmtResult);
	  do {
	    while (@row = $sth->fetchrow() ) {
	      if ($sth->{syb_result_type} == CS_STATUS_RESULT) {
		  $pmtResult = shift @row;
	      }
	    }
	  } while($sth->{syb_more_results});

	  $sth->finish;
	}

	my ($date,$sec,$aid,$modifier) = split(/-/, $contents{'invoice'});
	if ($modifier eq 'C') {
		die "Programming error, $aid != $accountID" unless($aid == $accountID);
		$sth = $G_dbh->prepare(qq!UPDATE renewals SET upgrades=upgrades+1 WHERE accountID=$accountID!);
		die 'Prepare failed' unless (defined($sth));
		$sth->execute;
		my ($rc);
		do {
		  while (@row = $sth->fetchrow() ) {
		    if ($sth->{syb_result_type} == CS_STATUS_RESULT) {
			$rc = shift @row;
		    }
		  }
		} while($sth->{syb_more_results});

		$sth->finish;
	}
	&handleAddPayment($accountID, $amount, $pmtResult);
}

######################
#
# Subroutine: process new subscriptions
#
sub handleNewSubscr {
	my ($date,$sec,$accountID,$modifier) = split(/-/, $contents{'invoice'});
	my $comment = "$contents{'subscr_id'}";
	#&log(" - new subscription $accountID");
	&writeSubscrLog($accountID, "Subscription ID: $contents{'subscr_id'} created");

	#
	# Create a subscription record. The account status is also set
	# to Pending if it was New.
	#
	$date = scalar localtime;
	my @d = split(/\s+/, $date);
	$date = join(' ', $d[1], $d[2], $d[4], $d[3]);
	my $ccID = (defined($contents{'ccID'})) ? $contents{'ccID'} : 'NULL';

	$sth = $G_dbh->prepare(qq!EXEC registerNewSubscription $accountID, 1, "$comment", "$date", 1, $ccID!);
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
	if ($rc == 1) {
		&log(" - UPDATED subscription for account $accountID ");
		&writeSubscrLog($accountID, "UPDATE subscription confirmation received by IPN\n");
	}
	elsif ($rc == 0) {
		&log("- NEW subscription was received for account $accountID ");
		&writeSubscrLog($accountID, "NEW subscription confirmation received by IPN\n");
	}
	else {
		&log("- unexpected return from registerNewSubscription - $rc - account $accountID ");
	}
	if ($modifier eq 'C') {
		$sth = $G_dbh->prepare(qq!UPDATE renewals SET upgrades=upgrades+1 WHERE accountID=$accountID!);
		die 'Prepare failed' unless (defined($sth));
		$sth->execute;
		do {
		  while (@row = $sth->fetchrow() ) {
		    if ($sth->{syb_result_type} == CS_STATUS_RESULT) {
			$rc = shift @row;
		    }
		  }
		} while($sth->{syb_more_results});

		$sth->finish;
	}
}

######################
#
# Subroutine: process subscription payments
#
sub handleSubscrPayment {

	my ($date,$sec,$accountID,$modifier) = split(/-/, $contents{'invoice'});
	my $amount = $contents{'payment_gross'};
        if ($amount == 0) {
	  $amount = $contents{'settle_amount'};
	}
	my $txn = $contents{'txn_id'};

	#
	# See if this is an echeck 
	#
	my $echeck = 0;
	if (($contents{'payment_status'} eq 'Pending') &&
	    ($contents{'payment_type'} eq 'echeck')) {
	  $echeck = 1;
	}
	elsif (($contents{'payment_status'} eq 'Denied') ||
	       ($contents{'payment_status'} eq 'Failed')) {
	  $echeck = 3;
	}
	elsif (($contents{'payment_status'} eq 'Completed') &&
	       ($contents{'payment_type'} eq 'echeck')) {
	  $echeck = 2;
	}
	elsif ($contents{'payment_status'} eq 'Refunded') {
	  $amount = 0 - $amount if ($amount > 0);
	  $txn .= '-REV';
	}

	#
	# Apply the payment to the account
	#
	my $sql = qq!EXEC addPaymentIPN $accountID, $amount, "$txn", $contents{'ccID'}, $echeck!;
	my $sth = $G_dbh->prepare($sql);
	die 'Prepare failed' unless (defined($sth));
	$sth->execute;
	my ($pmtResult, @row);
	do {
	  while (@row = $sth->fetchrow() ) {
	    if ($sth->{syb_result_type} == CS_STATUS_RESULT) {
		$pmtResult = shift @row;
	    }
	  }
	} while($sth->{syb_more_results});
	$sth->finish;

	if ($modifier eq 'C') {
		$sth = $G_dbh->prepare(qq!UPDATE renewals SET upgrades=upgrades+1 WHERE accountID=$accountID!);
		die 'Prepare failed' unless (defined($sth));
		$sth->execute;
		my ($rc);
		do {
		  while (@row = $sth->fetchrow() ) {
		    if ($sth->{syb_result_type} == CS_STATUS_RESULT) {
			$rc = shift @row;
		    }
		  }
		} while($sth->{syb_more_results});

		$sth->finish;
	}
	&handleAddPayment($accountID, $amount, $pmtResult);
}

######################
#
# Subroutine: handle return codes from addPayment
#
sub handleAddPayment {
	my $accountID = shift @_;
	my $amount    = shift @_;
	my $pmtResult = shift @_;
	my ($rc, $email, $nickName, $password, $junk);

	#
	# acct was New - send password
	#
	if ($pmtResult == 1) {
		my $sql =<<SQL;
SELECT nickName,password,userAccounts.email
FROM userAccounts,registration,users
WHERE  users.userID=$accountID
AND    users.userID=registration.accountID
AND userAccounts.accountID = registration.userID
SQL
		$sth = $G_dbh->prepare($sql);
		die 'Prepare failed' unless (defined($sth));
		$sth->execute;
		my (@row);
		do {
		  while (@row = $sth->fetchrow() ) {
	  	  if ($sth->{syb_result_type} == CS_ROW_RESULT) {
			$nickName = shift @row;
			$password = shift @row;
			$email    = shift @row;
		    }
		  }
		} while($sth->{syb_more_results});

		$sth->finish;
#### debug
if ($amount == 0) {
  &log('-- PROBLEM zero amount for $accountID');
  return;
}
if ($email eq "") {
  &log('-- PROBLEM no email for $accountID');
  return;
}
if ($nickName eq "") {
  &log('-- PROBLEM no nickName for $accountID');
  return;
}
if ($password eq "") {
  &log('-- PROBLEM no password for $accountID');
  return;
}
#### debug
		&sendPw ($email, $accountID, $nickName, $password, 0);
		&log('- account was NEW, thanks and password sent');
		&writeLog($nickName, $accountID, "password and thanks sent to $email by IPN process\n");
	}
	#
	# acct was OK, Pending, or Overdue
	# - also handle pmt that was insufficient to clear the balance
	#
	elsif ( ($pmtResult == 0) ||	# OK
		($pmtResult == 2) ||	# was pending
		($pmtResult == 3) ||	# was overdue
		($pmtResult == 10000))	# still has non-zero balance
	{
		my $sql =<<SQL;
SELECT nickName,userAccounts.email
FROM userAccounts,users
WHERE  userAccounts.accountID = $accountID
AND    users.userID=userAccounts.ownerID
SQL
		$sth = $G_dbh->prepare($sql);
		die 'Prepare failed' unless (defined($sth));
		$sth->execute;
		my $paymentStatus = 0;
		my (@row);
		do {
		  while (@row = $sth->fetchrow() ) {
		    if ($sth->{syb_result_type} == CS_ROW_RESULT) {
			$nickName = shift @row;
			$email    = shift @row;
		    }
		  }
		} while($sth->{syb_more_results});
		$sth->finish;

#### debug
if ($amount == 0) {
  &log('-- PROBLEM zero amount for $accountID');
  return;
}
if ($email eq "") {
  &log('-- PROBLEM no email for $accountID');
  return;
}
if ($nickName eq "") {
  &log('-- PROBLEM no nickName for $accountID');
  return;
}
#### debug

		#
		# See if this account has an active subscription
		#
		$sql =<<SQL;
SELECT autoRenew
FROM   subscriptions
WHERE  accountID = $accountID
SQL
		$sth = $G_dbh->prepare($sql);
		die 'Prepare failed' unless (defined($sth));
		$sth->execute;
		my $autoRenew = 0;
		do {
		  while (@row = $sth->fetchrow() ) {
		    if ($sth->{syb_result_type} == CS_ROW_RESULT) {
			$autoRenew = shift @row;
		    }
		  }
		} while($sth->{syb_more_results});
		$sth->finish;


		if ($pmtResult == 3) {
		  &sendMail ("overdue", $email, $amount, $accountID);
		  &writeLog($nickName, $accountID, "thankyou and overdue-clear notice sent to $email by IPN process\n");
		}
		elsif($pmtResult == 10000) {
		  &sendMail ("insufficient", $email, $amount, $accountID);
		  &writeLog($nickName, $accountID, "insufficient payment notice sent to $email by IPN process\n");
		}
		else {
		  if ($autoRenew) {
		    &sendMail ("pprenewal", $email, $amount, $accountID);
		    &writeLog($nickName, $accountID, "renewal thankyou sent to $email by IPN process\n");
		  }
		  else {
		    &sendMail ("std", $email, $amount, $accountID);
		    &writeLog($nickName, $accountID, "thankyou sent to $email by IPN process\n");
		  }
		}
		&log("- $accountID - thankyou sent to $email");
	}

	#
	# Payment held?
	#
	elsif ( ($pmtResult == 100) ||	# held
		($pmtResult == 101) ||	# held, new account
		($pmtResult == 103))   	# held, expired account
	{
		my $sql =<<SQL;
SELECT nickName,userAccounts.email
FROM userAccounts,users
WHERE  userAccounts.accountID = $accountID
AND    users.userID=userAccounts.ownerID
SQL
		$sth = $G_dbh->prepare($sql);
		die 'Prepare failed' unless (defined($sth));
		$sth->execute;
		my (@row);
		do {
		  while (@row = $sth->fetchrow() ) {
		    if ($sth->{syb_result_type} == CS_ROW_RESULT) {
			$nickName = shift @row;
			$email    = shift @row;
		    }
		  }
		} while($sth->{syb_more_results});
		$sth->finish;

#### debug
if ($amount == 0) {
  &log('-- PROBLEM zero amount for $accountID');
  return;
}
if ($email eq "") {
  &log('-- PROBLEM no email for $accountID');
  return;
}
if ($nickName eq "") {
  &log('-- PROBLEM no nickName for $accountID');
  return;
}
#### debug
		if ($pmtResult == 100) {
		  &sendMail ("pending", $email, $amount, $accountID);
		  &writeLog($nickName, $accountID, "pending echeck notice sent to $email by IPN process\n");
		}
		elsif($pmtResult == 101) {
		  my ($pswd);
		  my $sql =<<SQL;
SELECT password
FROM registration, userAccounts
WHERE  userAccounts.accountID = $accountID
AND    registration.userID=userAccounts.ownerID
SQL
		  $sth = $G_dbh->prepare($sql);
		  die 'Prepare failed' unless (defined($sth));
		  $sth->execute;
		  my (@row);
		  do {
		    while (@row = $sth->fetchrow() ) {
		      if ($sth->{syb_result_type} == CS_ROW_RESULT) {
			$pswd = shift @row;
		      }
		    }
		  } while($sth->{syb_more_results});
		  $sth->finish;
		  &sendPw ($email, $accountID, $nickName, $pswd, 1);
		  &writeLog($nickName, $accountID, "new acct - held payment notice sent to $email by IPN process\n");
		}
		elsif ($pmtResult == 103) {
		  &sendMail ("held", $email, $amount, $accountID);
		  &writeLog($nickName, $accountID, "expired acct - held payment notice sent to $email by IPN process\n");
		}
		else {
		  die "programming error - unknown pmtResult $pmtResult";
		}
		&log("- $accountID - held payment notice sent to $email");
	}

	#
	# Echeck completed or denied ?
	#
	elsif ( ($pmtResult == 200) ||	# echeck OK
		($pmtResult == 201))   	# echeck denied
	{
		my $sql =<<SQL;
SELECT nickName,userAccounts.email
FROM userAccounts,users
WHERE  userAccounts.accountID = $accountID
AND    users.userID=userAccounts.ownerID
SQL
		$sth = $G_dbh->prepare($sql);
		die 'Prepare failed' unless (defined($sth));
		$sth->execute;
		my (@row);
		do {
		  while (@row = $sth->fetchrow() ) {
		    if ($sth->{syb_result_type} == CS_ROW_RESULT) {
			$nickName = shift @row;
			$email    = shift @row;
		    }
		  }
		} while($sth->{syb_more_results});
		$sth->finish;

#### debug
if ($amount == 0) {
  &log('-- PROBLEM zero amount for $accountID');
  return;
}
if ($email eq "") {
  &log('-- PROBLEM no email for $accountID');
  return;
}
if ($nickName eq "") {
  &log('-- PROBLEM no nickName for $accountID');
  return;
}
#### debug
		if ($pmtResult == 200) {
		  &sendMail ("cleared", $email, $amount, $accountID);
		  &writeLog($nickName, $accountID, "echeck cleared notice sent to $email by IPN process\n");
		  &log("- $accountID - echeck cleared notice sent to $email");
		}
		elsif($pmtResult == 201) {
		  &sendMail ("denied", $email, $amount, $accountID);
		  &writeLog($nickName, $accountID, "echeck denied notice sent to $email by IPN process\n");
		  &log("- $accountID - echeck denied notice sent to $email");
		}
		else {
		  die "programming error - unknown pmtResult $pmtResult";
		}
	}

	#
	# Reversal ?
	#
	elsif ($pmtResult == 300) {
  		my %to = ( $G_config{'billingEmail'} => 1, $G_config{'devEmail'} => 1 );
  		my $to = join(' ', (keys %to));
		open(MAILX, "| /usr/bin/mailx -s 'IPN PROBLEM' $to");
		print MAILX "payment reversal processed: account: $accountID\namount: $amount\n";
		close MAILX;
		&log("- account $accountID - reversal processed");
	}

	#
	# error when applying payment
	#
	else {
  		my %to = ( $G_config{'billingEmail'} => 1, $G_config{'devEmail'} => 1 );
  		my $to = join(' ', (keys %to));
		open(MAILX, "| /usr/bin/mailx -s 'IPN PROBLEM' $to");
		my $emsg = $rc;
		if ($pmtResult == 20001) {
			$emsg = "unknown account";
		}
		elsif ($pmtResult == 20002) {
			$emsg = "duplicate payment";
		}
		elsif ($pmtResult == 20003) {
			$emsg = "closed or suspended account";
		}
		elsif ($pmtResult == 20004) {
			$emsg = "attempted payment from bad credit list";
		}
		print MAILX "subscr_payment, addPayment error: $emsg\naccount: $accountID\namount: $amount\n";
		close MAILX;
		&log("- account $accountID - addPayment error: $emsg");
	}
}

######################
#
# START HERE
#

$queuedMail = 0;	# global flags
$G_error    = 0;

$logDir = "/logs/ipn";

$incoming = $logDir . "/incoming.log";
#$incoming = $logDir . "/x";

$logFile  = $logDir . "/process.log";
#$logFile  = "process.log";

unless ( -f $incoming ) {
	$n = scalar localtime;
	#&log("$n\tno IPN activity to process\n");
	exit;
}

#
# Connect to the database
#
$ENV{'SYBASE'} ||= '/u/vplaces/s/sybase';
$G_dbh = DBI->connect ( 'dbi:Sybase:', 'vpusr', 'vpusr1' );
&getConfigKeys;

@now = localtime(time);
$now[4]++;
$now[5] += 1900;
$suffix = sprintf(".%4.4d%2.2d%2.2d.%2.2d.%2.2d.%2.2d", $now[5], $now[4], $now[3], $now[2], $now[1], $now[0]);

#$processed = $incoming;
$processed = $logDir . "/processed" . $suffix;
rename $incoming, $processed;

#
# Process incoming IPN records
#
open(IPN, "<$processed") || die "Can't read $processed : $!";
while (<IPN>) {
	($when, $status, $parms) = split(/\t/, $_);

	#
	# Handle only 'verified' records
	#
	if ($status eq "VERIFIED") {
		&parse_rec($parms);
		&log("$when - $status - $contents{'txn_type'}");

		#
		# Add information about the payer to our DB
		#
		&addPaypalInfo;

		#
		# Pending or denied payment -- make sure someone notices
		#
		if (($contents{'payment_status'} eq 'Pending') ||
		    ($contents{'payment_status'} eq 'Denied')) {
			my $msg = "Pending payment HELD - ";
			if (defined($contents{'custom'})) {
			  $msg .= "$contents{'custom'} - ";
			}
			$msg .= "$contents{'payment_status'} - ";
			$msg .= "$contents{'payer_email'}\n";
  			my %to = ( $G_config{'billingEmail'} => 1, $G_config{'devEmail'} => 1 );
  			my $to = join(' ', (keys %to));
			open(MAILX, "| /usr/bin/mailx -s 'PayPal Held Payment' $to");
			print MAILX $msg;
			close MAILX;
		}

		#
		# Subscription payment
		#
		if ($contents{'txn_type'} eq "subscr_payment") {
			&handleSubscrPayment;
		}

		#
		# Money received, other than a subscription payment
		#
		elsif (($contents{'txn_type'} eq "web_accept") ||
		       ($contents{'txn_type'} eq "send_money"))
		{
			&handlePayment;
		}

		#
		# Subscriber signup
		#
		elsif ($contents{'txn_type'} eq "subscr_signup") {
			&handleNewSubscr;
		}

		#
		# Subscriber cancel
		#
		elsif ($contents{'txn_type'} eq "subscr_cancel") {
			&handleCancel;
		}

		#
		# Subscription payment failure
		#
		elsif ($contents{'txn_type'} eq "subscr_failed") {
			&handleSubscrPaymentFailure;
		}

		#
		# Payment reversal
		#
		elsif ($contents{'txn_type'} eq "reversal") {
			&handleReversal;
		}

		#
		# Subscriber end-of-term
		# ... this doesn't appear to be very useful, so just make a note
		#
		elsif ($contents{'txn_type'} eq "subscr_eot") {
			&log("$when - $status - subscr_eot $contents{'custom'}");
		}

		&log("\n");
	}

	#
	# Some kind of error record - make a note of it
	#
	else {
		&log("$when - $status - ERROR\n");
    		open ( ERRLOG, ">> /logs/ipn/errors.log" );
    		print ERRLOG $status;
    		close ERRLOG;
		$G_error = 1;
	}
}
close IPN;

#
# Process queued mail
# 
if ($queuedMail) {
  if (!$G_config{'testServer'}) {
	$n = scalar localtime;
	&log("$n\trunning mail queue\n");
	`/usr/lib/sendmail -q`;
	$n = scalar localtime;
	&log("$n\tmail queue complete\n");
  }
}
if ($G_error) {
	&errorNotify;
}
