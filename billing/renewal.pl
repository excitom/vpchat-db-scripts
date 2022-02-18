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
# Read SQL output to extract credit card or eCheck info
#
sub getCcInfo {
  my $sth = shift @_;
  my ($t,$v);
  do {
    while (($t, $v) = $sth->fetchrow() ) {
      if (($t eq 'EC') || ($t eq 'CC')) {
        $fields{'IOC_merchant_order_transaction_type'} = $t;
      }
      elsif ($t =~ /[EC]C00/) {
        $fields{'Ecom_billto_online_email'} = $v;
      }
      elsif ($t =~ /[EC]C01/) {
        $fields{'Ecom_billto_postal_city'} = $v;
      }
      elsif ($t =~ /[EC]C02/) {
        $fields{'Ecom_billto_postal_countrycode'} = $v;
      }
      elsif ($t =~ /[EC]C03/) {
        $fields{'Ecom_billto_postal_name_first'} = $v;
      }
      elsif ($t =~ /[EC]C04/) {
        $fields{'Ecom_billto_postal_name_last'} = $v;
      }
      elsif ($t =~ /[EC]C05/) {
        $fields{'Ecom_billto_postal_postalcode'} = $v;
      }
      elsif ($t =~ /[EC]C06/) {
        $fields{'Ecom_billto_postal_stateprov'} = $v;
      }
      elsif ($t =~ /[EC]C07/) {
        $fields{'Ecom_billto_postal_street_line1'} = $v;
      }
      elsif ($t =~ /[EC]C08/) {
        $fields{'Ecom_billto_telecom_phone_number'} = $v;
      }
      elsif ($t eq 'CC09') {
        $fields{'IOC_buyer_type'} = $v;
      }
      elsif ($t eq 'EC09') {
        ($fields{'IOC_buyer_type'},
         $fields{'IOC_DDA_acct_type'},
         $fields{'IOC_id_option'}) = split(/\s+/, $v);
      }
      elsif ($t eq 'CC10') {
        $fields{'Ecom_payment_card_name'} = $v;
      }
      elsif ($t eq 'CC11') {
        $fields{'Ecom_payment_card_expdate_month'} = $v;
      }
      elsif ($t eq 'CC12') {
        $fields{'Ecom_payment_card_expdate_year'} = $v;
      }
      elsif ($t eq 'CC13') {
        $fields{'Ecom_payment_card_number'} = $v;
      }
      elsif ($t eq 'CC14') {
        $fields{'Ecom_payment_card_verification'} = $v;
      }
      elsif ($t eq 'CC15') {
        $fields{'IOC_CVV_indicator'} = $v;
      }
      elsif ($t eq 'EC10') {
        $fields{'IOC_business_name'} = $v;
      }
      elsif ($t eq 'EC11') {
        $fields{'IOC_DDA_acct_name'} = $v;
      }
      elsif ($t eq 'EC12') {
        $fields{'IOC_DDA_acct_number'} = $v;
      }
      elsif ($t eq 'EC13') {
        $fields{'IOC_DDA_bankname'} = $v;
      }
      elsif ($t eq 'EC14') {
        $fields{'IOC_DDA_DLnumber'} = $v;
      }
      elsif ($t eq 'EC15') {
        $fields{'IOC_DDA_DLstate'} = $v;
      }
      elsif ($t eq 'EC16') {
        $fields{'IOC_DDA_DOB'} = $v;
      }
      elsif ($t eq 'EC17') {
        $fields{'IOC_DDA_routing'} = $v;
      }
      elsif ($t eq 'EC18') {
        $fields{'IOC_DDA_SSN'} = $v;
      }
      elsif ($t eq 'EC19') {
        $fields{'IOC_DDA_taxID'} = $v;
      }
    }
  } while($sth->{syb_more_results});
}

##################
#
# Subroutine: Decode URL encoding
#
sub decode {
  my $value = $_[0];
  $value =~ tr/+/ /;
  $value =~ s/%([a-fA-F0-9][a-fA-F0-9])/pack("C", hex($1))/eg;
  return $value;
}

##################
#
# Subroutine: Send email message for payment failure
#
require "/u/vplaces/scripts/cannedMessages/autoRenewFailed.pl";
sub notifyFailed
{
    my $aid = shift @_;
    my $email = shift @_;
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
# Subroutine: build the POST request for the payment gateway
#
# AccountID and amount are passed in explicitly. The %fields hash has
# previously been filled in with the rest of the information needed.
#
sub doPost {
	my $accountID    = shift @_;
	my $amount       = shift @_;
	my $invoice = &createInvoiceNumber($accountID);

	#
	# Build the query string for the POST
	#
	my $query = "IOC_order_total_amount=$amount";
	$query .= "&IOC_order_tax_amount=0";
	$query .= "&IOC_order_ship_amount=0";
	$query .= "&IOC_Merchant_id=vpchat";
	$query .= "&IOC_merchant_order_id=$invoice";
	$query .= "&IOC_merchant_shopper_id=$accountID";
	$query .= "&IOC_buyer_type=I";
	$query .= "&IOC_shipto_same_as_billto=1";
	$query .= "&Ecom_billto_online_email=$fields{'Ecom_billto_online_email'}";
	$query .= "&Ecom_billto_postal_name_first=$fields{'Ecom_billto_postal_name_first'}";
	$query .= "&Ecom_billto_postal_name_last=$fields{'Ecom_billto_postal_name_last'}";
	$query .= "&Ecom_billto_postal_street_line1=$fields{'Ecom_billto_postal_street_line1'}";
	$query .= "&Ecom_billto_postal_city=$fields{'Ecom_billto_postal_city'}";
	$query .= "&Ecom_billto_postal_stateprov=$fields{'Ecom_billto_postal_stateprov'}";
	$query .= "&Ecom_billto_postal_countrycode=$fields{'Ecom_billto_postal_countrycode'}";
	$query .= "&Ecom_billto_postal_postalcode=$fields{'Ecom_billto_postal_postalcode'}";
	$query .= "&Ecom_billto_telecom_phone_number=$fields{'Ecom_billto_telecom_phone_number'}";
	$query .= "&IOC_merchant_order_transaction_type=$fields{'IOC_merchant_order_transaction_type'}";
	if ($fields{'IOC_merchant_order_transaction_type'} eq 'EC') {
	  $query .= "&IOC_DDA_acct_name=$fields{'IOC_DDA_acct_name'}";
	  $query .= "&IOC_DDA_acct_number=$fields{'IOC_DDA_acct_number'}";
	  $query .= "&IOC_DDA_acct_type=$fields{'IOC_DDA_acct_type'}";
	  $query .= "&IOC_DDA_bankname=$fields{'IOC_DDA_bankname'}";
	  $query .= "&IOC_DDA_routing=$fields{'IOC_DDA_routing'}";
	  $query .= "&IOC_id_option='D'";
	  $query .= "&IOC_DDA_DLnumber=$fields{'IOC_DDA_DLnumber'}";
	  $query .= "&IOC_DDA_DLstate=$fields{'IOC_DDA_DLstate'}";
	  $query .= "&IOC_DDA_DOB=$fields{'IOC_DDA_DOB'}";
	  $query .= "&IOC_DDA_SSN=''";
	  $query .= "&IOC_DDA_taxID=''";
	} else {
	  $query .= "&Ecom_payment_card_name=$fields{'Ecom_payment_card_name'}";
	  $query .= "&Ecom_payment_card_name=$fields{'Ecom_payment_card_name'}";
	  $query .= "&Ecom_payment_card_number=$fields{'Ecom_payment_card_number'}";
	  $query .= "&Ecom_payment_card_expdate_month=$fields{'Ecom_payment_card_expdate_month'}";
	  $query .= "&Ecom_payment_card_expdate_year=$fields{'Ecom_payment_card_expdate_year'}";
	  $query .= "&Ecom_payment_card_verification=$fields{'Ecom_payment_card_verification'}";
	  $query .= "&IOC_CVV_indicator=$fields{'IOC_CVV_indicator'}";
	}

	#
	# submit the POST
	#
	my $ua = new LWP::UserAgent;
	$ua->protocols_allowed( [ 'http', 'https'] ); 
	my $hdrs = new HTTP::Headers;
	$hdrs->referrer("https://reg.vpchat.com/VP/pay");
	my $url = 'https://cart.wellsfargoestore.com/payment.mart';
	my $req = new HTTP::Request 'POST', $url, $hdrs;
	$req->content_type('application/x-www-form-urlencoded');
	$req->content($query);
	my $res = $ua->request($req);

	#
	# 'success' is unexpected ... instead we should get a 
	# failure with redirect (HTTP error 302), since the interface
	# is set up for use by a web browser, and the user is redirected
	# to either a success or a retry web page.
	#
	if (!($res->is_success)) {
	  if ($res->code == 302) {
	    my (@lines) = split(/\n/, $res->as_string);
	    my ($line);
	    foreach $line (@lines) {
	      if ($line =~ /^Location: (.*)$/) {
	        &parseResults($accountID, $1);
		return;
	      }
	    }
	  }
	}
	print LOG "Transaction problem, acct $accountID\n";
	print LOG $res->content;
	open(MAILX, "| /usr/bin/mailx -s 'Transaction Problem' $G_config{'devEmail'}");
	print MAILX "Transaction problem:\n";
	print MAILX $res->content;
	print MAILX $res->error_as_HTML;
	close MAILX;
	&writeLog( $accountID, "transaction problem - payment not submitted" );
}

######################
#
# Subroutine: Parse the results from the transaction post.
#
#	If this seems convoluted, it's because we're 
#	retaining compatibility with web pages that post
#	directly and get redirected back to a results web page.
#	The results come back in a query string. The string is
#	appended to a transaction log for further processing (e.g.
#	settling the transaction). We could do that immediately
#	here, but it already works the other way and it would
#	make this code even slower.
#
sub parseResults {
  my $accountID  = shift @_;
  my ($url, $qs) = split( /\?/, shift @_ );
  my $success    = ($url =~ /\/VP\/finish/) ? 1 : 0;
  my @pairs      = split(/&/, $qs);

  my ($name, $value, $pair);
  my $msg = '';
  foreach $pair (@pairs) {
    ($name, $value) = split(/=/, $pair);
    $contents{$name} = &decode($value);
  }

  ###
  ### Payment succeeded
  ###
  my $logMsg = '';
  if ($success) {

    #
    # The following is ESSENTIAL for the completion of the 
    # transaction. Otherwise it will be left hanging open
    # and we don't get our money.
    #
    &writeSettlementLog( &decode( join( ':', @pairs) ) );

    my $msg = "renewal payment submitted: \$$contents{'IOC_order_total_amount'}, WF # $contents{'IOC_order_id'}";
    &writeLog( $accountID, $msg );	# database log for this account
    print LOG "$accountID, $msg\n";	# text file log for this program
  }

  ###
  ### Payment failed
  ###
  else {
    my $msg = "renewal pmt failure: $contents{'IOC_reject_description'} $contents{'IOC_missing_fields'} $contents{'IOC_invalid_fields'}, invoice $contents{'IOC_merchant_order_id'}";

    &writeLog( $accountID, $msg );	# database log for this account
    print LOG "$accountID, $msg\n";	# text file log for this program

    my $sql = "EXEC updatePaymentStatus $accountID, 2";
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

    $sql = "SELECT email FROM userAccounts WHERE accountID=$accountID";
    $sth = $G_dbh->prepare($sql);
    die 'Prepare failed' unless (defined($sth));
    $sth->execute;
    my $email = '';
    do {
      while (@row = $sth->fetchrow() ) {
        if ($sth->{syb_result_type} == CS_ROW_RESULT) {
            $email = shift @row;
        }
      }
    } while($sth->{syb_more_results});
    $sth->finish;
    print "$sql didn't find email\n" if ($email eq '');

    &notifyFailed ($accountID, $email );
    &writeLog( $accountID, "notice sent to $email" );
  }
}

######################
#
# Subroutine: Write to the transaction settlement log
#	This log is processed once per minute by a cron job.
#
sub writeSettlementLog {
  my $trans   = shift @_;
  my $logFile = "/logs/settlements/incoming.log";

  my $now = scalar localtime;

  open(TRANS, ">> $logFile") || die "can't write to $logFile : $!";
  print TRANS $now . "\t" . $trans . "\n";
  close TRANS;
}

##################
#
# Subroutine: Create invoice number
#
sub createInvoiceNumber {
  my $accountID = $_[0];
  my @d = localtime(time);
  my $y = $d[5]+1900;
  my $m = $d[4]+1;
  return (sprintf("%4.4d%2.2d%2.2d-%2.2d%2.2d%2.2d-%d-R", $y, $m, $d[3], $d[2], $d[1], $d[0], $accountID));
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
# Find credit card or eCheck info for each account
#
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

	$sth = $G_dbh->prepare("EXEC getCreditInfoByAcctID $accountID , 1");
	$sth->execute();
	undef %fields;
	&getCcInfo($sth);
	if ($fields{'IOC_merchant_order_transaction_type'} eq 'CC') {
		print LOG "CC transaction, account $accountID, amount $amt\n";
		&doPost($accountID, $amt);
	}
	else {
		#
		# due to the potential for costly problems inherent with
		# checks, don't do any of these automatically ...
		#
		print LOG "EC transaction, account $accountID - skipped\n";
	}
}
close IN;
$now = scalar localtime;
print LOG "$now\tCompleted renewal processing\n";
close LOG;
