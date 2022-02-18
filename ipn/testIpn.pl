#!/usr/bin/perl
#
# Periodically process the PayPal IPN log
# IPN = Instant Payment Notification
#
# Tom Lang 12/2001
#

##################
#
# Write action to account-specific log file
# - input is account ID
#
sub writeSubscrLog {
return;
	die "programming error" unless ($#_ == 1);
	my $accountID = shift @_;
	die "programming error" if ($accountID eq "");
	my $msg = shift @_;
	$msg .= "\n" unless ($msg =~ /\n$/);
	my $logFile = "/logs/accounts/" . $accountID;
	my $new = (-f "$logFile") ? 0 : 1;
	open (SLOG, ">>$logFile");
	my $now = scalar localtime;
	print SLOG "$now\t$msg";
	close SLOG;
	chmod 0666, "$logFile" if ($new);

	$logFile = "/logs/accountIDs/" . $accountID;
	if (-f $logFile) {
		$msg = "$accountID\t$msg";
		open (ULOG, ">>$logFile");
		print ULOG "$now\t$msg";
		close ULOG;
	}
}

##################
#
# Write action to user-specific log file
# - input is account owner name
# - also writes to the summary log
#
sub writeLog {
return;
	die "programming error" unless ($#_ == 2);
	my $user = shift @_;
	die "programming error" if ($user eq "");
	$user =~ tr/[A-Z]/[a-z]/;
	my $aid = shift @_;
	my $msg = shift @_;
	$msg .= "\n" unless ($msg =~ /\n$/);
	my $logFile = "/logs/users/" . $user;
	my $new = (-f "$logFile") ? 0 : 1;
	open (ULOG, ">>$logFile");
	my $now = scalar localtime;
	$msg = "$user\t$aid\t$msg";
	print ULOG "$now\t$msg";
	close ULOG;
	chmod 0666, "$logFile" if ($new);
	my $acctLog = "/logs/accountIDs/" . $aid;
	unless (-f $acctLog) {
		link $logFile, $acctLog;
		chmod 0666, "$acctLog";
	}

	&writeAcctLog( $msg );
}

##################
#
# Write action to account activity log file
# - this log is a summary of all account activity
#
sub writeAcctLog {
return;
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
sub sendInfoReq
{
return;
    my $cmd = shift @_;
    my $email = shift @_;
    my $amount = shift @_;
    my $name = "";
    my $pswd;
    if ($#_ > -1) {
	$name = shift @_;
	$pswd = shift @_;
    }
    my $FromW = "Virtual Places";

    $queuedMail = 1;	# global flag
    if ( open( MAIL, "| /usr/lib/sendmail -odq -f \"vplaces\@halsoft.com\" -F \"$FromW\" $email > /dev/null" ) ) {
                print MAIL <<MAILMSG;
To: $email
Subject: Thanks for your payment

Thank you!

We received your payment of \$ $amount.
MAILMSG

		if ($cmd eq "unknown") {
			print MAIL <<MAILMSG;

However, we can't find your email address in our system. Perhaps you
used a different address when you registered at HalSoft? Please tell
us your chat name or account number, so that we may correctly credit
your payment.
MAILMSG
		}
		elsif ($cmd eq "dup") {
			print MAIL <<MAILMSG;

However, your email address is associated with more than one
account. Please tell us which chat name or account number should
be given credit for this payment.
MAILMSG
		}
                print MAIL <<MAILMSG;

-- The HalSoft Team


MAILMSG
		close( MAIL );
	}
}

##################
#
# Subroutine: Send thank-you email
#
sub sendMail
{
return;
    my $cmd = shift @_;
    my $email = shift @_;
    my $amount = shift @_;
    my $accountID = shift @_;
    my $name = "";
    my $pswd;
    if ($#_ > -1) {
	$name = shift @_;
	$pswd = shift @_;
    }
    my $FromW = "Virtual Places";

    $queuedMail = 1;	# global flag
    if ( open( MAIL, "| /usr/lib/sendmail -odq -f \"vplaces\@halsoft.com\" -F \"$FromW\" $email > /dev/null" ) ) {
	print MAIL <<MAILMSG;
To: $email
Subject: Thanks for your payment
Reply-to: billing\@halsoft.com

Thank you!

We received your payment of \$ $amount for account # $accountID.
MAILMSG

	#
	# NEW account
	#
	if ($cmd eq "new") {
		print MAIL <<MAILMSG;

You are now registered to the HalSoft VP Chat community.

User name: $name
Password : $pswd

Here are some tips regarding your password:

1. Be careful to distinguish between 1 (one) and l (lower case L), 0 (zero) and O (uppercase o) when you enter your password.
2. For your convenience, you can change your password by clicking Change Password on the Sign In page.
3. Keep your information in a secure place to prevent unauthorized access to your account.
MAILMSG
	}

	#
	# OVERDUE account
	#
	elsif ($cmd eq "overdue") {
		print MAIL <<MAILMSG;

Your account had been suspended for overdue payment, but it's
reactivated now. Your password was not changed.

MAILMSG
	}

	#
	# payment was insufficient to clear the balance
	#
	elsif ($cmd eq "insufficient") {
		print MAIL <<MAILMSG;

Your payment was not sufficent to clear the balanace due on your
account. If you feel this is an error, please contact us at
billing\@halsoft.com

MAILMSG
	}
        print MAIL <<MAILMSG;

-- The HalSoft Team


MAILMSG
	close( MAIL );
   }
}

sub log {
  open (IPNLOG, ">>$logFile") || die "Can't append to $logFile : $!";
  print IPNLOG $_[0];
  close IPNLOG;
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
	my $txn = $contents{'txn_id'};
	my $total;

	#
	# Use the email to find account ID and balance due
	#
	open (SQL_IN, ">$tempsql") || die "Can't write to $tempsql : $!\n";
	print SQL_IN <<SQL;
SELECT 'X',userAccounts.accountID, subscription
FROM   userAccounts,accountBalance
WHERE  email="$email"
AND    userAccounts.accountID=accountBalance.accountID
GO
SQL
	close SQL_IN;

	open (SQL_OUT, "$G_isql_exe -i $tempsql |") || die "Can't read from $G_isql_exe-i $tempsql : $!\n";
	
	$accountID = $total = 0;
	my $counter = 0;
	while (<SQL_OUT>) {
		if (/X/) {
			chomp;
			($junk, $accountID, $total) = split;
			$counter++;
		}
	}
	close SQL_OUT;

	#
	# Problem - couldn't find an account for this email
	#
	unless ($accountID) {
		open(MAILX, "| /usr/bin/mailx -s 'IPN PROBLEM' tlang\@halsoft.com");
		print MAILX "$email not found\n";
		close MAILX;
		&sendInfoReq("unknown", $email, $amount);
		&log('- email not found, mail sent');
		return;
	}

	#
	# Warning - multiple accounts for this email
	#
	if ($counter > 1) {
		open(MAILX, "| /usr/bin/mailx -s 'IPN PROBLEM' tlang\@halsoft.com");
		print MAILX "$email has $counter accounts\n";
		close MAILX;
		&sendInfoReq("dup", $email, $amount);
		&log('- email has multiple accts, mail sent');
		return;
	}

	#
	# Warning - didn't pay enough
	#
	if ($amount != $total) {
		open(MAILX, "| /usr/bin/mailx -s 'IPN PROBLEM' tlang\@halsoft.com");
		print MAILX "$email - $accountID - Paid $amount but owed $total\n";
		close MAILX;
	}

	#
	# Apply the payment to the account
	#
	open (SQL_IN, ">$tempsql") || die "Can't write to $tempsql : $!\n";
	print SQL_IN "addPaymentIPN $accountID, $amount, \"Transaction ID: $txn\"\ngo\n";
	close SQL_IN;

	open (SQL_OUT, "$G_isql_exe -i $tempsql |") || die "Can't read from $G_isql_exe-i $tempsql : $!\n";
	&handleAddPayment($accountID, $amount);
}

######################
#
# Subroutine: process subscription payments
#
sub handleSubscrPayment {

	my ($date,$sec,$accountID) = split(/-/, $contents{'invoice'});
	my $amount = $contents{'payment_gross'};
	my $txn = $contents{'txn_id'};

	#
	# Apply the payment to the account
	#
	open (SQL_IN, ">$tempsql") || die "Can't write to $tempsql : $!\n";
	print SQL_IN "addPaymentIPN $accountID, $amount,\"Transaction ID: $txn\"\nGO\n";
	close SQL_IN;
	open (SQL_OUT, "$G_isql_exe -i $tempsql |") || die "Can't read from $G_isql_exe -i $tempsql : $!\n";

	&handleAddPayment($accountID, $amount);
}

######################
#
# Subroutine: handle return codes from addPayment
#
sub handleAddPayment {
	my $accountID = shift @_;
	my $amount = shift @_;
	my ($rc, $email, $nickName, $password, $junk);

	#
	# Get the stored procedure return code
	#
	while (<SQL_OUT>) {
	   if (/return status\s+=\s+(\d+)\s*\)/ ) {
		close SQL_OUT;
		$rc = $1;

		#
		# acct was New - send password
		#
		if ($rc == 1) {
			open (SQL_IN, ">$tempsql") || die "Can't write to $tempsql : $!\n";
			print SQL_IN <<SQL;
SELECT 'X',nickName,password,userAccounts.email
FROM userAccounts,registration,users
WHERE  users.userID=$accountID
AND    users.userID=registration.accountID
AND userAccounts.accountID = registration.userID
GO
SQL
			close SQL_IN;
			open (SQL_OUT, "$G_isql_exe -i $tempsql |") || die "Can't read from $G_isql_exe -i $tempsql : $!\n";

			while (<SQL_OUT>) {
			   if (/X/) {
				chomp;
				($junk, $nickName, $password) = split;
				$nickName =~ s/\s+//g;
				$password =~ s/\s+//g;
				$email = <SQL_OUT>;
				chomp $email;
				$email =~ s/\s+//g;
			   	last;
			   }
			}
			close SQL_OUT;
die "NO EMAIL" if ($email eq "");
die "NO NICKNAME" if ($nickName eq "");
die "NO PASSOWRD" if ($password eq "");
			&sendMail ("new", $email, $amount, $accountID, $nickName, $password);
			&log('- account was NEW, thanks and password sent');
			&writeLog($nickName, $accountID, "password and thanks sent to $email by IPN process\n");
		}
		#
		# acct was OK, Pending, or Overdue
		# - also handle pmt that was insufficient to clear the balance
		#
		elsif ( ($rc == 0) ||	# OK
			($rc == 2) ||	# was pending
			($rc == 3) ||	# was overdue
			($rc == 10000))	# still has non-zero balance
		{
			open (SQL_IN, ">$tempsql") || die "Can't write to $tempsql : $!\n";
			print SQL_IN <<SQL;
SELECT 'X',nickName,userAccounts.email
FROM userAccounts,users
WHERE  userAccounts.accountID = $accountID
AND    users.userID=userAccounts.ownerID
GO
SQL
			close SQL_IN;
			open (SQL_OUT, "$G_isql_exe -i $tempsql |") || die "Can't read from $G_isql_exe -i $tempsql : $!\n";

			while (<SQL_OUT>) {
			   if (/X/) {
				chomp;
				($junk, $nickName) = split;
				$nickName =~ s/\s+//g;
				$email = <SQL_OUT>;
				chomp $email;
				$email =~ s/\s+//g;
			   	last;
			   }
			}
			close SQL_OUT;
			die "NO EMAIL" if ($email eq "");
			die "NO NICKNAME" if ($nickName eq "");
			if ($rc == 3) {
			  &sendMail ("overdue", $email, $amount, $accountID);
			  &writeLog($nickName, $accountID, "thankyou and overdue-clear notice sent to $email by IPN process\n");
			}
			elsif($rc == 10000) {
			  &sendMail ("insufficient", $email, $amount, $accountID);
			  &writeLog($nickName, $accountID, "insufficient payment notice sent to $email by IPN process\n");
			} else {
			  &sendMail ("std", $email, $amount, $accountID);
			  &writeLog($nickName, $accountID, "thankyou sent to $email by IPN process\n");
			}
			&log('- thankyou sent to $email');
		}

		#
		# error when applying payment
		#
		else {
			open(MAILX, "| /usr/bin/mailx -s 'IPN PROBLEM' tlang\@halsoft.com");
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
			print MAILX "subscr_payment, addPayment error: $emsg\naccount: $accountID\namount: $amount\n";
			close MAILX;
			&log("- account $accountID - addPayment error: $emsg, account $accountID");
		}
		last;
	   }
	}
	close SQL_OUT;
}

######################
#
# START HERE
#

$queuedMail = 0;	# global flag

$logDir = "/logs/ipn";

#$incoming = $logDir . "/incoming.log";
$incoming = "/tmp/x";

#$logFile  = $logDir . "/process.log";
$logFile  = "process.log";

unless ( -f $incoming ) {
	$n = scalar localtime;
	#&log("$n\tno IPN activity to process\n");
	exit;
}

@now = localtime(time);
$now[4]++;
$now[5] += 1900;
$suffix = sprintf(".%4.4d%2.2d%2.2d.%2.2d.%2.2d.%2.2d", $now[5], $now[4], $now[3], $now[2], $now[1], $now[0]);

$processed = $incoming;
#$processed = $logDir . "/processed" . $suffix;
#rename $incoming, $processed;

#
# Prepare to use the isql program for DB access
#
$G_isql_exe = "/u/vplaces/s/sybase/bin/isql -Uvpusr -Pvpusr1 -SSYBASE";
$G_statdir = "/tmp/";
$tempsql = $G_statdir . ".temp.sql.$$";
$ENV{'SYBASE'} ||= '/u/vplaces/s/sybase';

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
			($date,$sec,$accountID) = split(/-/, $contents{'invoice'});
			&log(" - new subscription $accountID");
			&writeSubscrLog($accountID, "Subscription ID: $contents{'subscr_id'} created");
		}

		#
		# Subscriber cancel
		#
		elsif ($contents{'txn_type'} eq "subscr_cancel") {
			$subscr = $contents{'subscr_id'};
			opendir (ACCTS, "/logs/accounts");
			@files = grep !/^\./, readdir ACCTS;
			closedir ACCTS;
			my $accountID = 0;
			foreach $file (@files) {
			   open (FILE, "/logs/accounts/$file");
			   while (<FILE>) {
				chomp;
				next unless (/Subscription ID:/);
				next unless (/$subscr/);
				$accountID = $file;
				last;
			   }
			}
			if ($accountID == 0) {
				&log(" - subscription $subscr cancelled, but can't find account ID");
			}
			else {
				&log(" - subscription $subscr cancelled, account ID $accountID");
				&writeSubscrLog($accountID, "Subscription ID: $subscr cancelled");
			}
		}
		&log("\n");
	}

	#
	# Some kind of error record - make a note of it
	#
	else {
		&log("$when - $status - $parms\n");
	}
}

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

unlink($tempsql);
