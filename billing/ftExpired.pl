#!/usr/bin/perl
#
# Find free trial subscriptions that have expired, and are not
# cancelled. 
# - Clear the held payment in our DB (which converts the acct to "regular")
# - Settle the transaction at Wells Fargo, so we get our money
#
# Tom Lang 11/2002

use Date::Manip;
use DBI;
use DBD::Sybase;

BEGIN {
  $ENV{'SYBASE'} ||= '/u/vplaces/s/sybase';
  $G_dbh = DBI->connect ( 'dbi:Sybase:', 'vpusr', 'vpusr1' );
}

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

	&addActivityLogById( $aid, $msg );

}

##################
#
# Write action to the database log
#
sub addActivityLogById {
	my $aid = shift @_;
	my $msg = shift @_;
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
# Subroutine: Send email message for completion of the free trial
#
sub notifyCompleted
{
    my $aid = shift @_;
    my $email = shift @_;
    my $from = $G_config{'billingEmail'};
    my $FromW = "Halsoft Customer Support";

        if ( open( MAIL, "| /usr/lib/sendmail -odq -f $from -t > /dev/null" ) ) {
                print MAIL <<MAILMSG;
From: $from ($FromW)
To: $email
Reply-To: $from
Subject: Your Free Trial subscription completed today

Thank you!

Your Free Trial subscription to Halsoft VP chat completed today, and
was converted to a regular account.

Thanks for trying our service, and we're glad you were satisfied.

If you have questions or comments you can reply to this email. To see
information about your account, you can use $G_config{'regURL'}/VP/account

Please include your account ID (which is $aid) in any email you send to us,
to assist us in finding your account information.

  -- The Halsoft Team

MAILMSG
		close( MAIL );
	}
	else {
		warn "Can't send email\n";
	}

	my (%to, $to);
	#$to{$G_config{'supportEmail'}} = 1;
	$to{$G_config{'billingEmail'}} = 1;
	$to{$G_config{'devEmail'}} = 1;
	$to = join(' ', (keys %to));
        if ( open( MAIL, "| /usr/bin/mailx -s \"completed free trial - $aid\" $to" )) {
                print MAIL <<MAILMSG;
Free Trial completion
Account $aid
Email $email

This is FYI, no action is required.
MAILMSG
		close( MAIL );
	}
	else {
		warn "Can't send email\n";
	}
}

###############
#
# START HERE
#
&getConfigKeys;
 

$d = &ParseDate('today');
$logDate = &UnixDate($d, '%Y%m%d');

$logFile = "/logs/billing/ftExpired.log.$logDate";
open (LOG, ">>$logFile") || die "Can't append log file $logFile : $!";
$now = scalar localtime;
print LOG "$now\tStarting expire processing\n";

#
# Find free trials that have expired
#
$clearNow   = 1;
$skipUnused = 1;
$count      = 0;
$settlementLog = '/logs/settlements/incoming.log';

if (-f $settlementLog) {
  die "Can't append to $settlementLog" unless (-w $settlementLog);
}

my $sth = $G_dbh->prepare("EXEC ftExpired $clearNow, $skipUnused");
die 'Prepare failed' unless (defined($sth));
$sth->execute;
do {
  while (@row = $sth->fetchrow() ) {
    if ($sth->{syb_result_type} == CS_ROW_RESULT) {
	my $flag = shift @row;
	if ($flag eq 'S1') {
		$aid       = shift @row;
		$wfid      = shift @row;
		$shopperID = shift @row;
		die 'programming error' unless($aid =~ /^\d+$/);
	}
	elsif ($flag eq 'S2') {
		$amount       = shift @row;
		$approvalCode = shift @row;
		$avs          = shift @row;
		$paymentDate  = shift @row;
		die 'programming error' unless(($amount+0) > 0);
	}
	elsif ($flag eq 'S3') {
		$email = shift @row;
	}
	elsif ($flag eq 'S4') {
		$invoice = shift @row;
		die "Programming error - missing invoice" if ($invoice eq '');

		#
		# Create settlement record
		#
		undef @rec;
		push(@rec, "Ecom_transaction_complete=TRUE");
		push(@rec, "IOC_buyer_type=I");
		push(@rec, "IOC_AVS_result=$avs");
		push(@rec, "IOC_response_code=0");
		push(@rec, "IOC_merchant_order_shipto_same_as_billto=1");
		push(@rec, "IOC_merchant_order_transaction_type=CC");
		push(@rec, "m=vpchat");
		push(@rec, "IOC_order_id=$wfid");
		push(@rec, "IOC_shopper_id=$shopperID");
		push(@rec, "IOC_merchant_shopper_id=$aid");
		push(@rec, "IOC_order_total_amount=$amount");
		push(@rec, "IOC_authorization_amount=$amount");
		push(@rec, "IOC_merchant_order_id=$invoice");
		push(@rec, "IOC_authorization_code=$approvalCode");
		push(@rec, "Hold=Cleared");
		$rec = join(':', @rec);
		$now = scalar localtime;
		open (SETTLEMENTS, ">>$settlementLog") || die "Can't append to $settlementLog : $!";
		print SETTLEMENTS "$now\t$rec\n";
		close SETTLEMENTS;
		chmod 0666, $settlementLog;
		print LOG "$aid\t$paymentDate\n";
		&writeLog($aid, "free trial completed");
		&notifyCompleted( $aid, $email );
		$count++;
	}
    }
  }
} while($sth->{syb_more_results});
$sth->finish;


#
# Send out email notices
#
if ($count) {
	$now = scalar localtime;
	print LOG "$now\tSending email\n";

	`/usr/lib/sendmail -q`;
	$now = scalar localtime;
	print LOG "$now\tcompleted\n";
}
else {
	print LOG "No accounts processed\n";
}
