#!/usr/bin/perl
#
# Find credit card/e check subscriptions that have expired
# - If auto-renew, record that a transaction should be attempted (this
#    is handled in a separate step)
# - Else send note saying payment is overdue
#
# Tom Lang 4/2002

use Date::Manip;
use DBI;
use DBD::Sybase;
use LWP::UserAgent;
use Crypt::SSLeay;

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
	print "$sql returned $rc\n" if ($rc);

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
    my $FromW = "Halsoft Customer Service";

        if ( open( MAIL, "| /usr/lib/sendmail -odq -f $from -t > /dev/null" ) ) {
                print MAIL <<MAILMSG;
From: $from ($FromW)
To: $email
Reply-To: $from
Subject: Your account renewed today

Your Halsoft VP chat account was due to expire today (account ID $aid).
However we applied your credit balance to the \$ $amt cost and you
have \$ $bal credit remaining.

Thank you for your business.

  -- The Halsoft Team

MAILMSG
		close( MAIL );
	}
	else {
		warn "Can't send email\n";
	}
}

###############
#
# Subroutine: round off floating point decimal dust. 
#
sub round {
	my $n = sprintf "%8.2f", shift @_;
	return $n+0;
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

$ENV{'SYBASE'} ||= '/u/vplaces/s/sybase';
$G_dbh = DBI->connect ( 'dbi:Sybase:', 'vpusr', 'vpusr1' );
&getConfigKeys;

#
# Find credit card auto-renew subscriptions that expire today
#
$sql =<<SQL;
SELECT accountID,autoRenew,unitCost,discount,billingCycle,subscription,referral,email
FROM subscriberAccounts
WHERE renewalDate <= "$sqlDate"
AND   renewalDate >= "$yesterday"
AND type > 1
AND accountType >0
AND accountStatus=0
SQL

$sth = $G_dbh->prepare($sql);
die 'Prepare failed' unless (defined($sth));
$sth->execute;
do {
  while (@row = $sth->fetchrow() ) {
    if ($sth->{syb_result_type} == CS_ROW_RESULT) {
	$accountID    = shift @row;
	$autoRenew    = shift @row;
	$uc           = shift @row;
	$disc         = shift @row;
	$bc           = shift @row;
	$subscription = shift @row;
	$referral     = shift @row;
	$email        = shift @row;
	$accts{$accountID} += $autoRenew;
	$cost = $uc * $bc;
	$cost -= ($cost * $disc);
	$cost{$accountID} = &round($cost);
	$balance{$accountID} = &round($subscription);
	$referralBalance{$accountID} = &round($referral);
	$email{$accountID} = $email;
    }
  }
} while($sth->{syb_more_results});

$sth->finish;

print LOG "Credit card/eCheck subscriptions that should renew today\n";

$setWaiting = 1;
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
		my $sql =<<SQL;
EXEC expireAccount $accountID
SQL
		my $sth = $G_dbh->prepare($sql);
		die 'Prepare failed' unless (defined($sth));
		$sth->execute;
		do {
		  while (@row = $sth->fetchrow() ) {
		    if ($sth->{syb_result_type} == CS_STATUS_RESULT) {
			$rc = shift @row;
		    }
		  }
		} while($sth->{syb_more_results});
		print "$sql expected 1 got $rc, $accountID\n" if ($rc != 1);
		$sth->finish;

		print LOG "$accountID credit applied, paid in full\n";
		&notifyPaid($accountID, $email{$accountID}, $cost{$accountID}, $b);
		&writeLog($accountID, "credit applied, set to OK, acct renewed by daily account processing, email sent");
	     }
	     #
	     # See if the referral balance will help
	     #
	     elsif ($cost{$accountID} <= ($b + $referralBalance{$accountID})) {
		$need = $cost{$accountID} - $b;
		$b = 0;

		my $sql =<<SQL;
EXEC transferBonusToSubscr $accountID, $need
SQL
		my $sth = $G_dbh->prepare($sql);
		die 'Prepare failed' unless (defined($sth));
		$sth->execute;
		do {
		  while (@row = $sth->fetchrow() ) {
		    if ($sth->{syb_result_type} == CS_STATUS_RESULT) {
			$rc = shift @row;
		    }
		  }
		} while($sth->{syb_more_results});
		print "$sql returned $rc\n" if ($rc);
		$sth->finish;

		$sql =<<SQL;
EXEC expireAccount $accountID
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
		print "$sql expected 0 got $rc, $accountID\n" if ($rc != 0);
		$sth->finish;

		print LOG "$accountID credit applied, $need referral applied, paid in full\n";
		&notifyPaid($accountID, $email{$accountID}, $cost{$accountID}, $b);
		&writeLog($accountID, "credit applied (including $need from referrals), set to OK, acct renewed by daily account processing, email sent");
	     }
	     #
	     # Not enough credit
	     #
	     else {
		$c = $cost{$accountID};

		#
		# Drain referral balance, if any
		#
		if ($referralBalance{$accountID} > 0) {
		  $b += $referralBalance{$accountID};

		  my $sql =<<SQL;
EXEC transferBonusToSubscr $accountID, $referralBalance{$accountID}
SQL
		  my $sth = $G_dbh->prepare($sql);
		  die 'Prepare failed' unless (defined($sth));
		  $sth->execute;
		  do {
		    while (@row = $sth->fetchrow() ) {
		      if ($sth->{syb_result_type} == CS_STATUS_RESULT) {
			  $rc = shift @row;
		      }
		    }
		  } while($sth->{syb_more_results});
		  print "$sql returned $rc\n" if ($rc);
		  $sth->finish;
		}

		my $sql =<<SQL;
EXEC expireAccount $accountID, $setOverdue
SQL
		my $sth = $G_dbh->prepare($sql);
		die 'Prepare failed' unless (defined($sth));
		$sth->execute;
		do {
		  while (@row = $sth->fetchrow() ) {
		    if ($sth->{syb_result_type} == CS_STATUS_RESULT) {
			$rc = shift @row;
		    }
		  }
		} while($sth->{syb_more_results});
		print "$sql expected 1 got $rc, $accountID\n" if ($rc != 1);
		$sth->finish;

		print LOG "$accountID credit applied, balance remains\n";
		&notifyExpired2($accountID, $email{$accountID}, $c, $b, $c-$b);
		&writeLog($accountID, "set to OVERDUE since insufficient credit by daily account processing, email sent");
	     }
   	   }
	   #
	   # No available balance, check for referral balance 
	   #
	   elsif ($cost{$accountID} <= $referralBalance{$accountID}) {
		$need = $cost{$accountID};
		$b = 0;

		my $sql =<<SQL;
EXEC transferBonusToSubscr $accountID, $need
SQL
		my $sth = $G_dbh->prepare($sql);
		die 'Prepare failed' unless (defined($sth));
		$sth->execute;
		do {
		  while (@row = $sth->fetchrow() ) {
		    if ($sth->{syb_result_type} == CS_STATUS_RESULT) {
			$rc = shift @row;
		    }
		  }
		} while($sth->{syb_more_results});
		print "$sql returned $rc\n" if ($rc);
		$sth->finish;
		$sql =<<SQL;
EXEC expireAccount $accountID
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
		print "$sql expected 0 got $rc, $accountID\n" if ($rc != 0);
		$sth->finish;

		print LOG "$accountID applied $need from referral, paid in full\n";
		&notifyPaid($accountID, $email{$accountID}, $cost{$accountID}, $b);
		&writeLog($accountID, "applied $need from referrals, set to OK, acct renewed by daily account processing, email sent");
	   }
	   #
	   # No available subscription balance
	   #
   	   else {
		print LOG "$accountID EXPIRED today\n";

		#
		# Drain referral balance, if any
		#
		if ($referralBalance{$accountID} > 0) {
		  $b += $referralBalance{$accountID};

		  my $sql =<<SQL;
EXEC transferBonusToSubscr $accountID, $referralBalance{$accountID}
SQL
		  my $sth = $G_dbh->prepare($sql);
		  die 'Prepare failed' unless (defined($sth));
		  $sth->execute;
		  do {
		    while (@row = $sth->fetchrow() ) {
		      if ($sth->{syb_result_type} == CS_STATUS_RESULT) {
			  $rc = shift @row;
		      }
		    }
		  } while($sth->{syb_more_results});
		  print "$sql returned $rc\n" if ($rc);
		  $sth->finish;
		}

		my $sql =<<SQL;
EXEC expireAccount $accountID, $setOverdue
SQL
		my $sth = $G_dbh->prepare($sql);
		die 'Prepare failed' unless (defined($sth));
		$sth->execute;
		do {
		  while (@row = $sth->fetchrow() ) {
		    if ($sth->{syb_result_type} == CS_STATUS_RESULT) {
			$rc = shift @row;
		    }
		  }
		} while($sth->{syb_more_results});
		print "$sql expected 1 got $rc, $accountID\n" if ($rc != 1);
		$sth->finish;

		&notifyExpired($accountID, $email{$accountID}, $cost{$accountID});
		&writeLog($accountID, "EXPIRED by daily account processing, email sent");
	   }
	}
	#
	# The account has an active (auto-renew) subscription
	#
	elsif($a > 0) {
	   if ($a > 1) {
		print LOG "Warning - multiple active subscriptions for $accountID\n";
	   }
	   #
	   # Check for credit balance.
	   #
  	   if ($balance{$accountID} < 0) {
	     $b = 0 - $balance{$accountID};
	     #
	     # Apply outstanding credit
	     #
	     if ($cost{$accountID} <= $b) {
		$b -= $cost{$accountID};

		my $sql =<<SQL;
EXEC expireAccount $accountID
SQL
		my $sth = $G_dbh->prepare($sql);
		die 'Prepare failed' unless (defined($sth));
		$sth->execute;
		do {
		  while (@row = $sth->fetchrow() ) {
		    if ($sth->{syb_result_type} == CS_STATUS_RESULT) {
			$rc = shift @row;
		    }
		  }
		} while($sth->{syb_more_results});
		print "$sql expected 0 got $rc, $accountID\n" if ($rc != 0);
		$sth->finish;

		print LOG "$accountID credit applied, paid in full\n";
		&notifyPaid($accountID, $email{$accountID}, $cost{$accountID}, $b);
		&writeLog($accountID, "credit applied, set to OK, acct renewed by daily account processing, email sent");
	     }
	     #
	     # See if the referral balance will help
	     #
	     elsif ($cost{$accountID} <= ($b + $referralBalance{$accountID})) {
		$need = $cost{$accountID} - $b;
		$b = 0;

		my $sql =<<SQL;
EXEC transferBonusToSubscr $accountID, $need
SQL
		my $sth = $G_dbh->prepare($sql);
		die 'Prepare failed' unless (defined($sth));
		$sth->execute;
		do {
		  while (@row = $sth->fetchrow() ) {
		    if ($sth->{syb_result_type} == CS_STATUS_RESULT) {
			$rc = shift @row;
		    }
		  }
		} while($sth->{syb_more_results});
		print "$sql returned $rc\n" if ($rc);
		$sth->finish;
		$sql =<<SQL;
EXEC expireAccount $accountID
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
		print "$sql expected 0 got $rc, $accountID\n" if ($rc != 0);
		$sth->finish;

		print LOG "$accountID credit applied, $need referral applied, paid in full\n";
		&notifyPaid($accountID, $email{$accountID}, $cost{$accountID}, $b);
		&writeLog($accountID, "credit applied (including $need from referrals), set to OK, acct renewed by daily account processing, email sent");
	     }
	     #
	     # Not enough credit
	     #
	     else {
		$c = $cost{$accountID};

		#
		# Drain referral balance, if any
		#
		if ($referralBalance{$accountID} > 0) {
		  $b += $referralBalance{$accountID};

		  my $sql =<<SQL;
EXEC transferBonusToSubscr $accountID, $referralBalance{$accountID}
SQL
		  my $sth = $G_dbh->prepare($sql);
		  die 'Prepare failed' unless (defined($sth));
		  $sth->execute;
		  do {
		    while (@row = $sth->fetchrow() ) {
		      if ($sth->{syb_result_type} == CS_STATUS_RESULT) {
			  $rc = shift @row;
		      }
		    }
		  } while($sth->{syb_more_results});
		  print "$sql returned $rc\n" if ($rc);
		  $sth->finish;
		}

		my $sql =<<SQL;
EXEC expireAccount $accountID, $setWaiting
SQL
		my $sth = $G_dbh->prepare($sql);
		die 'Prepare failed' unless (defined($sth));
		$sth->execute;
		do {
		  while (@row = $sth->fetchrow() ) {
		    if ($sth->{syb_result_type} == CS_STATUS_RESULT) {
			$rc = shift @row;
		    }
		  }
		} while($sth->{syb_more_results});
		print "$sql expected 1 got $rc, $accountID\n" if ($rc != 1);
		$sth->finish;

		print LOG "$accountID credit applied, balance remains, requires a transaction\n";
		&writeLog($accountID, "due for renewal, credit applied but balance remains, requires a transaction");
		$pendingTransactions{$accountID} = $c-$b;
	     }
   	   }
	   #
	   # No available balance, check for referral balance 
	   #
	   elsif ($cost{$accountID} <= $referralBalance{$accountID}) {
		$need = $cost{$accountID};
		$b = 0;

		my $sql =<<SQL;
EXEC transferBonusToSubscr $accountID, $need
SQL
		my $sth = $G_dbh->prepare($sql);
		die 'Prepare failed' unless (defined($sth));
		$sth->execute;
		do {
		  while (@row = $sth->fetchrow() ) {
		    if ($sth->{syb_result_type} == CS_STATUS_RESULT) {
			$rc = shift @row;
		    }
		  }
		} while($sth->{syb_more_results});
		print "$sql returned $rc\n" if ($rc);
		$sth->finish;
		$sql =<<SQL;
EXEC expireAccount $accountID
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
		print "$sql expected 0 got $rc, $accountID\n" if ($rc != 0);
		$sth->finish;

		print LOG "$accountID applied $need from referral, paid in full\n";
		&notifyPaid($accountID, $email{$accountID}, $cost{$accountID}, $b);
		&writeLog($accountID, "applied $need from referrals, set to OK, acct renewed by daily account processing, email sent");
	   }
	   #
	   # No available subscription balance
	   #
   	   else {
		print LOG "$accountID due for renewal, requires a transaction\n";

		#
		# Drain referral balance, if any
		#
		if ($referralBalance{$accountID} > 0) {
		  $b += $referralBalance{$accountID};

		  my $sql =<<SQL;
EXEC transferBonusToSubscr $accountID, $referralBalance{$accountID}
SQL
		  my $sth = $G_dbh->prepare($sql);
		  die 'Prepare failed' unless (defined($sth));
		  $sth->execute;
		  do {
		    while (@row = $sth->fetchrow() ) {
		      if ($sth->{syb_result_type} == CS_STATUS_RESULT) {
			  $rc = shift @row;
		      }
		    }
		  } while($sth->{syb_more_results});
		  print "$sql returned $rc\n" if ($rc);
		  $sth->finish;
		}

		my $sql =<<SQL;
EXEC expireAccount $accountID, $setWaiting
SQL
		my $sth = $G_dbh->prepare($sql);
		die 'Prepare failed' unless (defined($sth));
		$sth->execute;
		do {
		  while (@row = $sth->fetchrow() ) {
		    if ($sth->{syb_result_type} == CS_STATUS_RESULT) {
			$rc = shift @row;
		    }
		  }
		} while($sth->{syb_more_results});
		print "$sql expected 1 got $rc, $accountID\n" if ($rc != 1);
		$sth->finish;

		&writeLog($accountID, "due for renewal, requires a transaction");
		$pendingTransactions{$accountID} = $cost{$accountID};
	   }
	}
}

#
# Write out a log of pending transactions, with accountID and amount
#
$date = &ParseDate('today');
$now = &UnixDate($date, '%Y%m%d %H:%M:%S');
print LOG "$now\tCreating renewal transaction log\n";

$logFile = "/logs/billing/renewal.pending.$logDate";
open (RENEW, ">>$logFile") || die "Can't append log file $logFile : $!";
foreach $aid (keys %pendingTransactions) {
	print RENEW "$aid\t$pendingTransactions{$aid}\n";
}
close RENEW;

#
# Send out email notices
#
$date = &ParseDate('today');
$now = &UnixDate($date, '%Y%m%d %H:%M:%S');
print LOG "$now\tSending renewal email\n";

`/usr/lib/sendmail -q`;
$date = &ParseDate('today');
$now = &UnixDate($date, '%Y%m%d %H:%M:%S');
print LOG "$now\tcompleted\n";
