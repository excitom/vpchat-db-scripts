#!/usr/bin/perl
#
# Post a transaction to the Wells Fargo payment gateway,
# capture the returned HTML and pass it through to standard output.
#
# This is intended to be called from inside CGI or WebSQL .hts page.
# Why not do it directly in the page? Two reasons:
# - WebSQL's embedded Perl interpreter is too down-level to support LWP and SSLeay
# - We want to obfuscate the form variables so they don't show up in the 
#   web page, for security reasons.
#
# Tom Lang 10/2002
#

use LWP::UserAgent;
use Crypt::SSLeay;

######################
#
# The getCreditInfo stored procedure returns many key/value pairs.
# These keys and values are used to build the HTML form elements for
# the transaction that is posted to Wells Fargo.
#
# This hash defines the relation between the key names and the form elements.
#
# The CC keys are associated with credit cards, and the EC keys with eChecks.
# Some fields overlap, for example both credit cards and eChecks have a 
# country code. Other fields, such as credit card number or bank routing code,
# are unique to the type.
#

%fieldCodes = (
  'CC' => 'IOC_order_transaction_type',
  'EC' => 'IOC_order_transaction_type',
  'CC00' => 'Ecom_billto_online_email',
  'EC00' => 'Ecom_billto_online_email',
  'CC01' => 'Ecom_billto_postal_city',
  'EC01' => 'Ecom_billto_postal_city',
  'CC02' => 'Ecom_billto_postal_countrycode',
  'EC02' => 'Ecom_billto_postal_countrycode',
  'CC03' => 'Ecom_billto_postal_name_first',
  'EC03' => 'Ecom_billto_postal_name_first',
  'CC04' => 'Ecom_billto_postal_name_last',
  'EC04' => 'Ecom_billto_postal_name_last',
  'CC05' => 'Ecom_billto_postal_postalcode',
  'EC05' => 'Ecom_billto_postal_postalcode',
  'CC06' => 'Ecom_billto_postal_stateprov',
  'EC06' => 'Ecom_billto_postal_stateprov',
  'CC07' => 'Ecom_billto_postal_street_line1',
  'EC07' => 'Ecom_billto_postal_street_line1',
  'CC08' => 'Ecom_billto_telecom_phone_number',
  'EC08' => 'Ecom_billto_telecom_phone_number',
  'CC09' => 'IOC_buyer_type',
  'EC09' => 'IOC_buyer_type',
  'CC10' => 'Ecom_payment_card_name',
  'CC11' => 'Ecom_payment_card_expdate_month',
  'CC12' => 'Ecom_payment_card_expdate_year',
  'CC13' => 'Ecom_payment_card_number',
  'CC14' => 'Ecom_payment_card_verification',
  'CC15' => 'IOC_CVV_indicator',
  'EC10' => 'IOC_business_name',
  'EC11' => 'IOC_DDA_acct_name',
  'EC12' => 'IOC_DDA_acct_number',
  'EC13' => 'IOC_DDA_bankname',
  'EC14' => 'IOC_DDA_DLnumber',
  'EC15' => 'IOC_DDA_DLstate',
  'EC16' => 'IOC_DDA_DOB',
  'EC17' => 'IOC_DDA_routing',
  'EC18' => 'IOC_DDA_SSN',
  'EC19' => 'IOC_DDA_taxID',
  'EC20' => 'IOC_DDA_acct_type',
  'EC21' => 'IOC_id_option'
);

%fields = ();	# results from the SQL query

######################
#
# Subroutine: Get credit card or eCheck info from the database.
#	Results are loaded into the %fields hash.
#
sub getInfo {
  my $ccID = shift @_;
  my $type = shift @_;

  my $isql_exe = "/u/vplaces/s/sybase/bin/isql -Uvpusr -Pvpusr1 -SSYBASE -w 300";
  my $tempsql = "/tmp/.temp.sql.$$";
  $ENV{'SYBASE'} ||= '/u/vplaces/s/sybase';

  my $sql = "EXEC getCreditInfoByID ";
  $sql .= "$ccID, $type\nGO\n";

  open (SQL_IN, ">$tempsql") || die "Can't write to $tempsql : $!\n";
  print SQL_IN $sql;
  close SQL_IN;

  open (SQL_OUT, "$isql_exe -i $tempsql |") || die "Can't read from $isql_exe -i $tempsql : $!\n";

  my $status = 0;
  while (<SQL_OUT>) {
    if (/return status\s+=\s+(\d+)/) {
      $status = $1;
      next;
    }
    next unless (/^\s+[EC]C/);
    chomp;
    s/^\s+//;
    s/\s+$//;
    my ($key, $value) = split(/\s+/, $_, 2);
    $value = '' if ($value =~ /NULL/);
    if (length($key) == 2) {
      $fields{$key} = $key;
    } else {
      $fields{$key} = $value;
    }
  }
  my $ok = 1;
  if ($status != 0) {
    print <<HTML;
FAIL
<h4>Database error - $status</h4>
HTML
    $ok = 0;
  }
  
  unlink($tempsql);
  return $ok;
}

######################
#
# Subroutine: post the payment transaction to the bank
#
sub doTransaction {
  my $query = shift @_;

  #
  # determine the URL to use
  #
  my $url = 'https://cart.wellsfargoestore.com/payment.mart';
  if ($debug) {
    if ($debug == 2) {
      $query =~ s/IOC_order_total_amount=//;  # deliberately make a parameter invalid
    }
    elsif ($debug == 3) {
      $query =~ s/Ecom_payment_card_number=\d/Ecom_payment_card_number=/;
      $query =~ s/IOC_DDA_acct_number=\d/IOC_DDA_acct_number=/;
    }
    else {
      my $host = `hostname`;
      chomp $host;
      $url = "https://$host/VP/test.cgi";
    }
  }
  #
  # submit the POST
  #
  my $ua = new LWP::UserAgent;
  $ua->protocols_allowed( [ 'http', 'https'] ); 

  my $hdrs = new HTTP::Headers;
  $hdrs->referrer("https://chattool.vpchat.com/VP/pay");

  my $req = new HTTP::Request 'POST', $url, $hdrs;
  $req->content_type('application/x-www-form-urlencoded');
  $req->content($query);

  my $res = $ua->request($req);

  #
  # 'success' is unexpected. all results should be returned
  # as a 'relocate' error 302
  #
  if ($res->is_success) {
      print "FAIL\n";
      print $res->content;
  }
  else {
    if ($res->code == 302) {
      my (@lines) = split(/\n/, $res->as_string);
      my ($line);
      my $prob = 1;
      foreach $line (@lines) {
        if ($line =~ /^Location: (.*)$/) {
  	  &parseResults($1);
  	  $prob = 0;
        }
      }
      if ($prob) {
        print "FAIL\n";
        print $res->content;
      }
    }
    else {
      print "FAIL\n";
      print $res->content;	# unexpected error
    }
  }
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
  my ($url, $qs) = split( /\?/, shift @_ );
  my $success = ($url =~ /\/VP\/finish/) ? 1 : 0;
  my @pairs = split(/&/, $qs);
  my ($name, $value, $pair, $msg);
  foreach $pair (@pairs) {
    ($name, $value) = split(/=/, $pair);
    $contents{$name} = &decode($value);
  }

  if ($success) {
    print "SUCCESS\n";
    &writeSettlementLog( &decode( join( ':', @pairs) ) );
    $msg = "payment of $contents{'IOC_order_total_amount'} submitted, $contents{'IOC_merchant_order_id'}";
  }
  else {
    print "FAIL\n";
    $msg = "payment attempt FAILED, '}";
    if ($contents{'IOC_reject_description'} ne '') {
      print "<br>$contents{'IOC_reject_description'}\n";
      $msg .= " $contents{'IOC_reject_description'}";
    }
    if ($contents{'IOC_missing_fields'} ne '') {
      print "<br>Missing information: $contents{'IOC_missing_fields'}\n";
      $msg .= " Missing information: $contents{'IOC_missing_fields'}";
    }
    if ($contents{'IOC_invalid_fields'} ne '') {
      print "<br>$contents{'IOC_invalid_fields'}\n";
      $msg .= " $contents{'IOC_invalid_fields'}";
    }
  }
  &writeLogByID( $contents{'IOC_merchant_shopper_id'}, $msg );
}

##################
#
# Write action to account-specific log file
# - input is account ID
#
sub writeLogByID {
	die "programming error" unless ($#_ == 1);
	my $accountID = shift @_;
	die "programming error" if ($accountID eq "");
	my $msg = shift @_;
	chomp $msg;

	&addAcctHistoryByID( $accountID, $msg );

	$msg .= "\n";
	my $msg = shift @_;
	$msg .= "\n" unless ($msg =~ /\n$/);
	$logFile = "/logs/accountIDs/" . $accountID;
	open(ULOG, "| /bin/rsh anne \"cat >> $logFile\" ") || die "Can't rsh : $!";
	my $now = scalar localtime;
	print ULOG "$now\t$accountID\t$msg";
	close ULOG;
}

##################
#
# Write action to the database log
#
sub addAcctHistoryByID {
	my $aid = shift @_;
	my $msg = shift @_;
	my $ip  = $ENV{'REMOTE_ADDR'};
	my $sql = qq!EXEC vpusers..addAcctHistoryByID $aid, "$msg", "$ip"!;
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
# Subroutine: Decode URL encoding
#
sub decode {
  my $value = $_[0];
  $value =~ tr/+/ /;
  $value =~ s/%([a-fA-F0-9][a-fA-F0-9])/pack("C", hex($1))/eg;
  return $value;
}

################
#
# Subroutine: Write a record to the transaction settlement log.
#
#	All the settlement processing is done on the main DB
#	server. If for some reason we can't append to the log
#	on that server, we save the transaction locally for
#	later recovery.
#
sub writeSettlementLog {
  my $trans = shift @_;
  my $now = scalar localtime;
  my $logFile = "/logs/settlements/incoming.log";
  my $dbServer = 'anne';

  unless (open(TRANS, "| /bin/rsh $dbServer \"cat >>$logFile\""))
  {
    open(TRANS, ">>$logFile");
  }
  print TRANS $now . "\t" . $trans . "\n";
  close TRANS;
}

######################
#
# START HERE
#

$debug = 0;
if (($#ARGV > -1) && ($ARGV[0] eq '-d')) {
  shift @ARGV;
  $debug = shift @ARGV;
}

if ($#ARGV == -1) {
  print <<HTML;
FAIL
<h4>Programming error - wrong number of transaction parameters</h4>
HTML

 exit;
}

#
# method 1 - query string passed in
#
if ($ARGV[0] eq '-q') {
  shift @ARGV;
  if ($#ARGV != 0) {
    print <<HTML;
FAIL
<h4>Programming error - wrong number of transaction parameters</h4>
HTML

   exit;
  }
  &doTransaction( $ARGV[0] );
}

#
# method 2 = get stuff from the database to build the query string
#
else {
  if ($#ARGV != 4) {
    print <<HTML;
FAIL
<h4>Programming error - wrong number of transaction parameters</h4>
HTML

   exit;
  }

  $accountID = shift @ARGV;
  $ccID = shift @ARGV;
  $type = shift @ARGV;
  $amt = shift @ARGV;
  $invoice = shift @ARGV;

  if (&getInfo( $ccID, $type )) {

    #
    # Build the query string for the POST
    #
    my (@fields, $f);
    foreach $f (keys %fields) {
      push (@fields, join( '=', $fieldCodes{$f}, $fields{$f} ));
    }
    my $query = join( '&', @fields );
    $query .= "&IOC_order_tax_amount=0";
    $query .= "&IOC_order_ship_amount=0";
    $query .= "&IOC_shipto_same_as_billto=1";
    $query .= "&IOC_merchant_id=vpchat";
    $query .= "&IOC_merchant_order_id=$invoice";
    $query .= "&IOC_merchant_shopper_id=$accountID";
    $query .= "&IOC_order_total_amount=$amt";

    &doTransaction( $query );
  }
}
