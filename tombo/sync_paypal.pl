
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
my $paypalFile = "paypalJan2002.txt"; 
#my $paypalFile = "paypalFeb2002.txt"; 

open(PAYPAL, $paypalFile) || die "couldn't open file: $paypalFIle\n";

$i = 0;
$found_count = 0;
$not_found_count = 0;
$found = 0;
while(<PAYPAL>){
   chomp;
   s/\"//g; #pitch quotes
   ($Date, $Time, $Name, $Type, $Status, $Subject, $Gross, $Fee, $Net, $Note, $FromEmailAddress, $ToEmailAddress, $TransactionID, $PaymentType, $CounterpartyStatus, $ShippingAddress, $AddressStatus,  $ItemTitle, $ItemID, $ShippingAmount, $InsuranceAmount, $SalesTax, $AuctionHouse, $ItemURL, $ClosingDate, $ReferenceTxnID, $InvoiceNumber, $SubscriptionNumber, $CustomNumber) = split(/\t/);

#   if(($Type eq "Subscription Payment Received")||
#      ($Type eq "Web Accept Payment Received")){
    if($Type eq "Subscription Payment Received"){
      print "CustomNumber = $CustomNumber TransactionID = $TransactionID\n";
      $found = 0;
#      print "SubscriptionNumber = $SubscriptionNumber \n";
#      print "Gross = $Gross Name = $Name \n";
#      print "Type = $Type \n";

open (SQL_IN, ">$tempsql") || die "Can't write to $tempsql : $!\n";
print SQL_IN <<SQL;
SELECT paymentDate, 'X', amount, comment FROM payments WHERE accountID=$CustomNumber
GO
SQL
close SQL_IN;
open (SQL_OUT, "$G_isql_exe -i $tempsql |") || die "Can't read from $G_isql_exe -i $tempsql : $!\n";
while (<SQL_OUT>) {
	if (/X/) {
           chomp;
           ($dbDate, $amount) = split(/X/);
           $line = <SQL_OUT>;
           chomp $line;
           if($line =~ /$TransactionID/){
             print "Found one: $TransactionID, $CustomNumber\n";
             $found = 1;
             print "date: $dbDate, amount = $amount\n";
             print"Comment:$line\n"; 
           }
        }
}
close(SQL_OUT);

   if($found == 1){
     $found_count++;
   }else{
     if($CustomNumber eq ""){
       print "Not Found NULL $TransactionID $Date\n";
     }else{
       print "Not Found $CustomNumber $TransactionID $Date\n";
     }
     $not_found_count++;
   }
   $i++;
}
}
print "found = $found_count, not found = $not_found_count, records = $i\n";
