#!/usr/bin/perl
#
# Submit charges to the Wells Fargo gateway, attempting to renew subscriptions.
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
# Tom Lang 3/2003

use Date::Manip;
use LWP::UserAgent;
use Crypt::SSLeay;
use DBD::Sybase;
use DBI qw(:sql_types);
require "/u/vplaces/scripts/billing/creditlib.pl";
require "/u/vplaces/scripts/billing/purchaseResponse.pl";
require "/u/vplaces/scripts/billing/ccXml.pl";

######################
#
# The getCreditInfo stored procedure returns many key/value pairs.
# These keys and values are used to build the XML for the
# transaction that is posted to Wells Fargo.
#
# This hash defines the relation between the key names and the XML elements.
#
# The CC keys are associated with credit cards, and the EC keys with eChecks.
# Some fields overlap, for example both credit cards and eChecks have a 
# country code. Other fields, such as credit card number or bank routing code,
# are unique to the type.
#

%fieldCodes = (
  'CC' => 'CCPurchase',
  'EC' => 'ECheckPurchase',
  'CC00' => 'EmailAddr',
  'EC00' => 'EmailAddr',
  'CC01' => 'City',
  'EC01' => 'City',
  'CC02' => 'Country',
  'EC02' => 'Country',
  'CC03' => 'FirstName',
  'EC03' => 'FirstName',
  'CC04' => 'LastName',
  'EC04' => 'LastName',
  'CC05' => 'PostalCode',
  'EC05' => 'PostalCode',
  'CC06' => 'StateProv',
  'EC06' => 'StateProv',
  'CC07' => 'Addr1',
  'EC07' => 'Addr1',
  'CC08' => 'Phone',
  'EC08' => 'Phone',
  'CC09' => 'BuyerType',
  'EC09' => 'BuyerType',
  'CC10' => 'CardholderName',
  'CC11' => 'Month',
  'CC12' => 'Year',
  'CC13' => 'CcAcctId',
  'CC14' => 'CVV2Code',
  'CC15' => 'CVV2PresentInd',
  'EC10' => 'IOC_business_name',
  'EC11' => 'BankAccountName',
  'EC12' => 'EcAcctId',
  'EC13' => 'BankName',
  'EC14' => 'DmvNum',
  'EC15' => 'DmvStateProv',
  'EC16' => 'DmvDOB',
  'EC17' => 'BankId',
  'EC18' => 'IOC_DDA_SSN',
  'EC19' => 'IOC_DDA_taxID',
  'EC20' => 'AcctType',
  'EC21' => 'IOC_id_option'
);

######################
#
# Subroutine: Get credit card or eCheck info from the database.
#	Results are loaded into the %fields hash.
#
#
sub getInfo {
  my $aid = shift @_;
  my $sql = "EXEC getCreditInfoByAcctID $aid, 1";
  my $sth = $G_dbh->prepare($sql);
  die 'Prepare failed' unless (defined($sth));
  $sth->execute;
  my (@row);
  do {
    while (@row = $sth->fetchrow() ) {
	my $key = shift @row;
	if (length($key) == 2) {
	  $fields{$fieldCodes{$key}} = $key;
	  $trans{'ccID'} = shift @row;
          $trans{'type'} = ($key eq 'CC') ? 2 : 3;
	} else {
	  $fields{$fieldCodes{$key}} = shift @row;
	}
    }
  } while($sth->{syb_more_results});
  $sth->finish;

  return ((scalar keys %fields) > 0) ? 1 : 0;
}

######################
#
# Subroutine: Generate XML for an echeck transaction
#
sub do_EcXml {

  #
  # Create a unique ID for the XML request
  #
  my $i = join('', split(/\./, $G_ip));
  $trans{'uuid'} = sprintf "%8.8x-%4.4x-%4.4x-%4.4x-%6.6x%6.6x", $trans{'now'}, 0,0,0, $i, $trans{'accountID'};

  die ("EC not supported");
  #&doEcXml;

}

######################
#
# Subroutine: debug dump
#
sub dumpXml {

  open (DUMP, ">>/logs/xmlDump.log");
  my $t = scalar localtime;
  print DUMP <<XML;
-------------------------------------------------------------
$t

$G_buffer
XML
  close DUMP;
}

######################
#
# Subroutine: post the payment transaction to the bank
#
sub doTransaction {

  my $accountID = shift @_;
  $trans{'accountID'} = $accountID;
  $trans{'amount'} = shift @_;
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

  #
  # Create the XML
  #
  $G_buffer = '';
  if ($trans{'type'} == 2) {
    &doCcXml;
  }
  else {
    &do_EcXml;
  }

  &dumpXml;

  #
  # submit the POST
  #
  $G_req->content($G_buffer);

  my $res = $G_ua->request($G_req);

  my $result = &parsePurchaseResponse($res->content);

  #
  # A transaction can work, or return an error. 
  # If it works, then the decision code must be checked to see if it 
  # was accepted. Even if it was 'accepted' there could still be a problem.
  #
  # Ain't this API wonderful?
  #

  #
  # Did the transaction work?
  #
  if ($result == 0) {

    #
    # Was it accepted? 
    #
    if ($RESPONSE{'DecisionCode'} eq 'Pass') {

      #
      # Did it really, really, really work?
      #
      if ($RESPONSE{'AuthResult'} == 0) {
        &doSettlement($invoice);
        print LOG "Subscription renewed, account $accountID\n";
        &writeLog($accountID, "Subscription renewed");
      }
      else {
        &doFailed($accountID);
      }
    }
    #
    # Failed authorization?
    #
    elsif ($RESPONSE{'DecisionCode'} eq 'Failed') {
      &notifyFailed($accountID);	# tell the customer
      &doFailed($accountID);		# tell billing
    }

    #
    # Transaction authorized but warning issued?
    #
    elsif ($RESPONSE{'DecisionCode'} eq 'WarningInReview') {

      #
      # Did it seem to work?
      #
      if ($RESPONSE{'AuthResult'} == 0) {
        &doSettlement($invoice);
      }

      #
      # Warn the billing department
      #
      &doFailed($accountID);
    }
    #
    # Some non-failure, yet non-success, result
    #
    else {
      &doFailed($accountID);
    }
  }

  #
  # Transaction error - probably invalid user data but maybe not
  #
  else {
    if ($RESPONSE{'StatusCode'} == 300) {
      &doFailed($accountID);
    }
    #
    # User input data errors
    #
    elsif (($RESPONSE{'ErrorCode'} == 2) ||
           ($RESPONSE{'ErrorCode'} == 4) ||
           ($RESPONSE{'ErrorCode'} == 6) ||
           ($RESPONSE{'ErrorCode'} == 7) ||
           ($RESPONSE{'ErrorCode'} == 19))
    {
      &doFailed($accountID);
    }
    #
    # Duplicate transactions
    #
    elsif (($RESPONSE{'ErrorCode'} == 11) ||
           ($RESPONSE{'ErrorCode'} == 12))
    {
      &doFailed($accountID);
    }
    #
    # Miscellaneous weirdness with the system
    #
    else {
      &doFailed($accountID);
    }
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
  $sql .= $RESPONSE{'OrderId'};
  $sql .= "', '";
  $sql .= $RESPONSE{'AvsResponse'};
  $sql .= "', '";
  $sql .= $RESPONSE{'AuthCode'};
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
  my $sql = "EXEC updatePaymentStatus $aid, 2";
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
  &writeLog($aid, "Subscription renewal failed, Reason: $RESPONSE{'Reason'}, OrderId: $RESPONSE{'OrderId'}");
}

##################
#
# Write action to the database log
#
sub writeLog {
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
exec addTransaction $trans{'accountID'}, $trans{'ccID'}, $trans{'type'},
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
$G_dbh = DBI->connect ( 'dbi:Sybase:', 'vpusr', 'vpusr1' );
&getConfigKeys;

#
# Set up user agent for communicating with the processing gateway
#
if ($G_config{'testServer'}) {
  $G_url = "https://wfgateway-test.wellsfargo.com/xml";
}
else {
  $G_url = "https://wfgateway.wellsfargo.com/xml";
}
$G_ua = new LWP::UserAgent;
$G_ua->protocols_allowed( [ 'http', 'https'] ); 

$G_hdrs = new HTTP::Headers;
#
# This should be hard-coded, it is the value that Wells Fargo expects.
#
#$G_hdrs->referrer("https://reg.vpchat.com/VP/pay");

$G_req = new HTTP::Request 'POST', $G_url, $G_hdrs;
$G_req->content_type('text/xml');
 
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

  &getInfo($accountID);

  if ($trans{'type'} == 2) {
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
