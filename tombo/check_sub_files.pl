
#!/usr/bin/perl
use Date::Manip;


###############
#
# START HERE
#

$dbName = 'vpusr';
$dbPw = 'vpusr1';

$G_isql_exe = "/u/vplaces/s/sybase/bin/isql -U$dbName -P$dbPw -SSYBASE";
$G_statdir = "/tmp/";
$tempsql = $G_statdir . ".temp.sql.$$";
$ENV{'SYBASE'} ||= '/u/vplaces/s/sybase';

#my $paypalFile = "paypal2001.txt"; 
#my $paypalFile = "paypalJan2002.txt"; 
#my $paypalFile = "paypalFeb2002.txt"; 

my $paypalFile = "paypalMar1-24.txt";

open(PAYPAL, $paypalFile) || die "couldn't open file: $paypalFIle\n";

$i = 0;
$found_count = 0;
$not_found_count = 0;
$found = 0;
while(<PAYPAL>){
   chomp;
   s/\"//g; #pitch quotes
   ($Date, $Time, $Name, $Type, $Status, $Subject, $Gross, $Fee, $Net, $Note, $FromEmailAddress, $ToEmailAddress, $TransactionID, $PaymentType, $CounterpartyStatus, $ShippingAddress, $AddressStatus,  $ItemTitle, $ItemID, $ShippingAmount, $InsuranceAmount, $SalesTax, $AuctionHouse, $ItemURL, $ClosingDate, $ReferenceTxnID, $InvoiceNumber, $SubscriptionNumber, $CustomNumber) = split(/\t/);

   if(($Type eq "Subscription Payment Received")||
      ($Type eq "Web Accept Payment Received")){
#      print "CustomNumber = $CustomNumber TransactionID = $TransactionID\n";
#      if(!( -f "/logs/accounts/$CustomNumber")){
#         print "Missing file: $CustomNumber  $SubscriptionNumber $Date $Time\n";
#         $i++;
#      }
   }else{
      print "$Type \n";
   }
}
#print "Found $i missing files\n";
