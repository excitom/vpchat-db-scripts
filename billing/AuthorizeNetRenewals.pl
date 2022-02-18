#!/usr/bin/perl
#
# Submit charges to the Authorize.Net gateway,
# attempting to renew subscriptions.
#
# This program depends on a previous step - running the 'expire' program
# to find accounts that are ready for renewal.
#
# The expire step builds a log file of account IDs for which we should attempt
# an automatic renewal transaction - either credit card or echeck.
#
# The log file contains accountIDs and the amount we should try to charge
# for each. Note that this is not necessarily the same as the subscription
# renewal cost, since the account may have credit (for example, from referral
# bonus or overpayment). The expire stage figures all this out.
#
# Tom Lang 1/2008

use Date::Manip;
use LWP::UserAgent;
use Crypt::SSLeay;
use DBD::Sybase;
use DBI qw(:sql_types);
use Digest::MD5 qw(md5_hex);
require "/u/vplaces/scripts/billing/creditlib.pl";
require "/u/vplaces/scripts/billing/purchaseResponse.pl";
require "/web/reg/config.inc";

BEGIN {
  $ENV{'SYBASE'} ||= '/u/vplaces/s/sybase';
}

sub md5 {
  my $data = shift @_;
  return md5_hex($data);
}

##################
#
# Subroutine: Encode a string for use in a URL
#
sub encode {
	my $s = $_[0];
	chomp;
	my (@line, $line, $c);
	@line = split(//, $s);
	foreach $c (@line) {
		if ($c =~ /\w/) {
			$line .= $c;
		} else {
		   #if ($c eq ' ') {
			#$line .= '+';
		   #} else {
			$line .= "%" . unpack('H*', $c);
		   #}
		}
	}
	return $line;
}

######################
#
# Subroutine: Get credit card or eCheck info from the database.
#	Results are loaded into the %fields hash.
#
#
sub getInfo {
  my $aid = shift @_;
  my $sql = "EXEC vpusers..getCreditInfoByAcctID_p $aid, 1, 1";
  my $sth = $G_dbh->prepare($sql);
  die 'Prepare failed' unless (defined($sth));
  $sth->execute;
  my $row = $sth->fetchrow_hashref;
  %G_fields = %$row;
  $sth->finish;

  return (($G_fields{'x_method'} eq "CC") || ($G_fields{'x_method'} eq "ECHECK")) ? 1 : 0;
}

######################
#
# Subroutine: post the payment transaction to the bank
#
sub doTransaction {

  my $accountID = shift @_;
  $trans{'accountID'} = $accountID;
  $trans{'amount'} = shift @_;
  $trans{'amount'} = sprintf("%6.2f", $trans{'amount'});
  $trans{'email'} = $fields{'EmailAddr'};

  #
  # Get timestamp information
  #
  $trans{'now'} = time;
  my (@d) = localtime($trans{'now'});
  $trans{'mon'}  = $d[4]+1;
  $trans{'day'}  = $d[3]+0;
  $trans{'year'} = $d[5]+1900;
  $trans{'hr'}   = $d[2]+0;
  $trans{'min'}  = $d[1]+0;
  $trans{'sec'}  = $d[0]+0;
  $trans{'ip'}   = $G_ip;
  &createInvoiceNumber($G_ip);

  my $i = join('', split(/\./, $G_ip));
  $trans{'uuid'} = sprintf "%8.8x-%4.4x-%4.4x-%4.4x-%6.6x%6.6x", $trans{'now'}, 0,0,0, $i, $trans{'accountID'};

  #
  # Build the query string for the POST
  #
  my @fields = ();
  push(@fields, "x_version=3.1");
  push(@fields, "x_delim_data=TRUE");
  push(@fields, "x_delim_char=" . $G_authnet_delim);
  push(@fields, "x_relay_response=FALSE");
  push(@fields, "x_login=" . $G_authnet_login);
  push(@fields, "x_tran_key=" . $G_authnet_trans_key);
  push(@fields, "x_amount=" . $trans{'amount'});
  push(@fields, "x_type=AUTH_CAPTURE");
  push(@fields, "x_email_customer=FALSE");
  push(@fields, "x_method=" . $G_fields{'x_method'});

  if ($trans{'debug'} > 0) {
    push(@fields, "x_test_request=TRUE");
  }

  if ($G_fields{'x_method'} eq "CC") {
    push(@fields, "x_card_num=" . $G_fields{'x_card_num'});

    $expdate = sprintf("%2.2d%4.4d", $G_fields{'expdate_month'}, $G_fields{'expdate_year'});
    push(@fields, "x_exp_date=$expdate");
  }
  else {
    push(@fields, "x_bank_aba_code="  . $G_fields{'x_bank_aba_code'});
    push(@fields, "x_bank_acct_num="  . $G_fields{'x_bank_acct_num'});
    push(@fields, "x_bank_acct_type=" . $G_fields{'x_bank_acct_type'});
    push(@fields, "x_bank_name="      . &encode($G_fields{'x_bank_name'}));
    push(@fields, "x_bank_acct_name=" . &encode($G_fields{'x_bank_acct_name'}));
    push(@fields, "x_type=WEB");
  }
  push(@fields, "x_first_name=" . &encode($G_fields{'x_first_name'}));
  push(@fields, "x_last_name="  . &encode($G_fields{'x_last_name'}));
  push(@fields, "x_address="    . &encode($G_fields{'x_address'}));
  push(@fields, "x_city="       . &encode($G_fields{'x_city'}));
  push(@fields, "x_state="      . &encode($G_fields{'x_state'}));
  push(@fields, "x_zip="        . &encode($G_fields{'x_zip'}));
  push(@fields, "x_country="    . &encode($G_fields{'x_country'}));
  push(@fields, "x_phone="      . &encode($G_fields{'x_phone'}));
  push(@fields, "x_email="      . &encode($G_fields{'x_email'}));

  push(@fields, "x_cust_id=$accountID");

  # there's an x_invoice_num field but it is only 20 chars
  push(@fields, "x_description=" . $trans{'invoice'});

  # extra wells fargo fields

  push(@fields, "x_customer_ip=" . $trans{'ip'});
  push(@fields, "x_customer_organization_type=" . $G_fields{'x_customer_organization_type'});
  if ($G_fields{'x_method'} eq "ECHECK") {
    push(@fields, "x_drivers_license_num=" . &encode($G_fields{'x_drivers_license_num'}));
    push(@fields, "x_drivers_license_state=" . &encode($G_fields{'x_drivers_license_state'}));
    push(@fields, "x_drivers_license_dob=" . &fmtDOB($G_fields{'x_drivers_license_dob'}));
  }

  $query = join("&", @fields);

  #
  # submit the POST
  #
  $G_req->content($query);

  my $res = $G_ua->request($G_req);

  my $result = &parsePurchaseResponse($res->content);

  #
  # Did the transaction work?
  #
  if ($RESPONSE{'ResponseCode'} == 1) {
    &doSettlement;
  }
  else {
    &doFailed($accountID);
  }

  #
  # Warn the billing department on suspicious results

  if (($RESPONSE{'ResponseCode'} == 3) ||
      (($RESPONSE{'ResponseCode'} == 2) && 
       ($RESPONSE{'ResponseReasonCode'} == 4)))
  {
    my $to = $G_config{'devEmail'};
    open(LOG, "| /usr/bin/mailx -s 'Authorize.Net Error' $to") || die "Can't send mail: $!";
      print LOG <<ERROR;
When:\t$now
Server: $G_config{'thisHost'}
Account ID: $accountID
ERROR
    my ($k);
    foreach $k (sort keys %RESPONSE) {
      print LOG "$k:\t$RESPONSE{$k}\n";
    }
    close LOG;
      
  }
}

######################
#
# Subroutine: create settlement record
#
sub doSettlement {
  my $invoice = shift @_;
  my $sql = "EXEC vpusers..addSettlement '";
  $sql .= $trans{'invoice'};
  $sql .= "', '";
  $sql .= $RESPONSE{'TransactionID'};
  $sql .= "', '";
  $sql .= $RESPONSE{'AVSresult'};
  $sql .= "', '";
  $sql .= $RESPONSE{'ApprovalCode'};
  $sql .= "'";
  my $sth = $G_dbh->prepare($sql);
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

  if ($rc == 20000) {
    print LOG "Duplicate transaction - $invoice\n";
  }
  elsif ($rc != 0) {
    die "Settlement database error: $rc";
  }
}

######################
#
# Subroutine: report error message
#
sub doFailed {
  my $aid = shift @_;

  #
  # Set failed payment status for the account
  #
  my $sql = "EXEC vpusers..updatePaymentStatus $aid, 2";
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
  print "$sql returned unexpected result: $rc" if ($rc);

  my $now = scalar localtime;
  open(MAIL, "| /usr/bin/mailx -s 'renewal processing failure' $G_config{'devEmail'}");
  print MAIL <<ERROR;
When:\t$now
Account ID: $aid
ERROR
  my ($k);
  foreach $k (sort keys %RESPONSE) {
    next if ($RESPONSE{$k} =~ /</);
    print MAIL "$k:\t$RESPONSE{$k}\n";
  }
  close MAIL;
  print LOG "Renewal failed, account $aid\n";
  &writeLog($aid, "Subscription renewal failed, Reason: $RESPONSE{'ResponseReasonText'}, OrderId: $RESPONSE{'OrderId'}");
}

##################
#
# Write action to the database log
#
sub writeLog {
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
  
  my $sql = "EXEC vpusers..getServerConfig";
  my $sth = $G_dbh->prepare($sql);
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
# Subroutine: Send email message for payment failure
#
require "/u/vplaces/scripts/cannedMessages/autoRenewFailed.pl";
sub notifyFailed
{
  my $aid = shift @_;
  my $email = $trans{'email'};
  my $from = $G_config{'billingEmail'};
  my $fromName = "VPchat customer service";

  my $cannedMsg = &autoRenewFailed($from, $fromName, $email, $aid);

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

##################
#
# Subroutine: Create invoice number
#
sub createInvoiceNumber {
  die "Missing IP" if ($#_ == -1);
  my $ip = shift @_;

  $trans{'invoice'} = sprintf("%4.4d%2.2d%2.2d-%2.2d%2.2d%2.2d-%d-R", $trans{'year'}, $trans{'mon'}, $trans{'day'}, $trans{'hr'}, $trans{'min'}, $trans{'sec'}, $trans{'accountID'});

  my $sql =<<SQL;
EXEC addTransaction $trans{'accountID'}, $trans{'ccID'}, $trans{'type'},
$trans{'amount'}, '$trans{"invoice"}', '$ip'
SQL

  my $sth = $G_dbh->prepare($sql);
  $sth->execute();
}

###############
#
# START HERE
#
if ($#ARGV == -1) {
  $d = &ParseDate('today');
} else {
  $d = &ParseDate($ARGV[0]);
}
$logDate = &UnixDate( $d, '%Y%m%d');
#$logDate = 'TEST';

#
# The outgoing IP is used when creating transaction records.
# Since we use 'NAT' when going out to the Internet, the IP
# the outside sees is not the IP of this machine.
#
$addr = scalar gethostbyname('reg.vpchat.com');
$G_ip = join('.', unpack( 'C4', $addr));

#
# Prepare to write to the daily log file
#
$logFile = "/logs/billing/renewal.log.$logDate";
if (-f $logFile) {
  die "Renewal processing cancelled since it looks like it has already been run today.";
}
open (LOG, ">>$logFile") || die "Can't append log file $logFile : $!";
$now = scalar localtime;
print LOG "$now\tStarting renewal processing\n";

#
# Prepare to read the list of pending transations
#
$inFile = "/logs/billing/renewal.pending.$logDate";
open (IN, "<$inFile") || die "Can't read input file $inFile : $!";

#
# Set up to access the database
#
$G_dbh = DBI->connect ( 'dbi:Sybase:', $G_dbuser, $G_dbpass );
&getConfigKeys;

#
# Set up user agent for communicating with the processing gateway
#
$G_url = "https://secure.authorize.net/gateway/transact.dll";
$G_ua = new LWP::UserAgent;
$G_ua->protocols_allowed( [ 'http', 'https'] ); 
$G_ua->timeout(30);

$G_hdrs = new HTTP::Headers;

$G_req = new HTTP::Request 'POST', $G_url, $G_hdrs;
$G_req->content_type('text/html');
 
#
# Find credit card or eCheck info for each account
#

%fields   = ();		# credit card info for this transaction
%trans    = ();		# other details about this transaction
%RESPONSE = ();		# global variable

while(<IN>) {
  chomp;
  my ($accountID, $amt) = split;

  my $sql = "SELECT subscription FROM accountBalance WHERE accountID=$accountID";
  my $sth = $G_dbh->prepare($sql);
  $sth->execute();
  my ($balance, @row);
  do {
    while (@row = $sth->fetchrow() ) {
      if ($sth->{syb_result_type} == CS_ROW_RESULT) {
         $balance = shift @row;
      }
    }
  } while($sth->{syb_more_results});
  $sth->finish;
  if ($balance != $amt) {
    print LOG "Balance due $balance expected $amt, account $accountID - skipped\n";
    next;
  }

  my $r = &getInfo($accountID);
  die "Renewal processing problem" if ($r == 0);

  $trans{'ccID'} = $G_fields{'ccID'};
  if($G_fields{'x_method'} eq 'CC') {
    $trans{'type'} = 2;
    print LOG "CC transaction, account $accountID, amount $amt\n";
    &doTransaction($accountID, $amt);
  }
  else {
    #
    # due to the potential for costly problems inherent with
    # checks, don't do any of these automatically ...
    #
    print LOG "EC transaction, account $accountID - skipped\n";
  }
  undef %fields;
  undef %trans;
  undef %RESPONSE;
}
close IN;
$now = scalar localtime;
print LOG "$now\tCompleted renewal processing\n";
close LOG;
