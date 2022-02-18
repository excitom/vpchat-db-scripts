#!/usr/bin/perl
use Date::Manip;

$tempfile = "/logs/acctChanges/tombo.file.$$";

sub sendErrorEmail
{
    my $aid = shift @_;
    my $email = "payments\@halsoft.com";
    my $FromW = "Virtual Places";

        if ( open( MAIL, "| /usr/lib/sendmail -odq -f \"vplaces\@halsoft.com\" -F \"$FromW\" $email > /dev/null" ) ) {
                print MAIL <<MAILMSG;
To: $email
Reply-To: payments\@halsoft.com
Subject: Change Subscription Difference

Balance difference detected for account: $aid

http://reg.vpchat.com/VP/changeSub?aid=$aid

Check it out...

MAILMSG
		close( MAIL );
	}
}



sub sendLinkEmail
{
    my $email = shift @_;
    my $aid = shift @_;
    my $FromW = "Virtual Places";

        if ( open( MAIL, "| /usr/lib/sendmail -f \"vplaces\@halsoft.com\" -F \"$FromW\" $email > /dev/null" ) ) {
                print MAIL <<MAILMSG;
To: $email
Reply-To: payments\@halsoft.com
Subject: HalSoft Account

Hello,

Our records indicate that there is a balance due on your account ($aid) and that you requested an upgrade but did not complete the transaction with PayPal. To complete the transaction click the link below, review the changes and click the Make Changes button which takes you to PayPal and sign up for your new subscription. After you have added your new subscription with PayPal we will cancel your existing subscription for you.

http://reg.vpchat.com/VP/changeSub?aid=$aid

If you do not wish to change your subscription or you believe we have made an error, please reply to this email.

Thanks for being our customer!

- The HalSoft Team
http://www.halsoft.com

MAILMSG
		close( MAIL );
	}
}

sub acctChangesUpdate{

   my $path = shift @_;

   if(!(-f $path)){
      return(0);
   }

   #return if file is less than 1 day old
   my $file_time = (stat($path))[9];
   $file_time = (time - $file_time) / (3600 * 24);
   $file_time = sprintf "%3.0f", $file_time;
   #print "file $file_time days old $path\n";
   if($file_time < 2){
      print "file less 1 day old $path\n";
      return(0);
   }
   
   open(ACCT,$path) || die "cannot open $path for reading";
   open (TMP_FILE, ">$tempfile") || die "Can't write to $tempfile : $!\n";

   my $file_ok = 1;

   @line = `/web/cmgmt/html/VP/cmgmt/halsoft/diff.pl \"$renewalDate\"`;
   $daysRemaining = $line[0];
   chomp $daysRemaining;

   my $weeksRemaining;
   #sheez where's the C trunc function when ya need it?
   if(($daysRemaining % 7) > 0){
      my $temp_daysRemaining = $daysRemaining + (7 - ($daysRemaining % 7));
      $weeksRemaining = ($temp_daysRemaining / 7);
   }else{
      $weeksRemaining = ($daysRemaining / 7);
   }
    
   my $use_get = 0; #use get method (currently) only for Hotmail

   while (<ACCT>) {
      chomp;
      #make sure the balance is the same
      if(/hotmail.com/i) {
         $use_get = 1;
      }elsif(/form method=post/){
         if($use_get){
            print $_;
            print "\n";
            $_ = "<form method=get action=\"https://www.paypal.com/cgi-bin/webscr\">";
            print $_;
            print "\n";
         }
      }elsif(/type=submit onClick/){ #Javascript call caused error
         print $_;
         print "\n";
         $_ = "<input type=submit value=\"Make Changes\">";
         print $_;
         print "\n";
      }elsif(/difference for these changes is/) {
         $acctBalance = sprintf("%6.2f", $balance);
         if(/$acctBalance/){
           $rd = &ParseDate($renewalDate);
           print "$aid, $email, $daysRemaining, $renewalDate, \$$balance\n";
           &sendLinkEmail($email,$aid);
#           &sendLinkEmail("tombo\@jump.net",$aid);
         }else{
           #our balance and link balance are different
           print "Darn: $aid, \$ $acctBalance, $_\n";
           #email someone who can fix this:
           &sendErrorEmail($aid);
           $file_ok = 0;
           last;
         }
      }elsif(/input type=hidden name=p1/){
         print $_;
         print "\n";
         if($daysRemaining <= 90){
            $_ = "<input type=hidden name=p1 value=\"" . $daysRemaining . "\">";
         }else{
            $_ = "<input type=hidden name=p1 value=\"" . $weeksRemaining . "\">";
         }
         print $_;
         print "\n";
      }elsif(/input type=hidden name=t1/){
         print $_;
         print "\n";
         if($daysRemaining <= 90){
            $_ = "<input type=hidden name=t1 value=\"D\">";
         }else{
            $_ = "<input type=hidden name=t1 value=\"W\">";
         }
         print $_;
         print "\n";
      }elsif(/Days remaining in your subscription/){
         print $_;
         print "\n";
         $_ = "<p>Days remaining in your subscription: " . $daysRemaining;
         print $_;
         print "\n";
      }elsif(/first [0-9]+/){
         print $_;
         print "\n";
         if($daysRemaining <= 90){
            $_ = "first " . $daysRemaining . " days</i>.";
         }else{
            $_ = "first " . $weeksRemaining . " weeks</i>.";
         }
         print $_;
         print "\n";
      }
      $_ = $_ . "\n";
      print TMP_FILE;
   }
   close(ACCT);
   close(TMP_FILE);

   if($file_ok){
      #overwrite file with temp file
      rename($tempfile, $path) || die "Can't rename $tempfile to $path";
   }else{
      unlink($tempfile);
   }
   return $file_ok;
}


sub getActiveSubs{

    my $path = shift @_;

    #print "Path: $path\n";
    open(ACCT,$path) || die "cannot open $path for reading";
    my $i = 0;
    my @lines;
    my $created = 0;
    my $cancelled = 0;
    while (<ACCT>) {
      chomp;
      ($left, $right) = split(/ID:/); #pitch everything up to sub
      $_ = $right;
      #see if line is already in the array
      my $found = 0;
      my $k = $#lines;
      while ($k >= 0){
        if($_ eq $lines[$k--]){
           $found = 1;
        }
      }
      #if not already there insert it and count it
      if($found == 0){
         $lines[$i] = $_;
         if($lines[$i] =~ /created/){
           $created++;
         }
         if($lines[$i] =~ /cancelled/){
           $cancelled++;
         }
         $i++;
      }
    }
    close(ACCT);

    return($created - $cancelled);
}


$dbName = 'vpusr';
$dbPw = 'vpusr1';

$G_isql_exe = "/u/vplaces/s/sybase/bin/isql -U$dbName -P$dbPw -SSYBASE";
$G_statdir = "/tmp/";
$tempsql = $G_statdir . ".temp.sql.$$";
$ENV{'SYBASE'} ||= '/u/vplaces/s/sybase';


open (SQL_IN, ">$tempsql") || die "Can't write to $tempsql : $!\n";
print SQL_IN <<SQL;
SELECT userAccounts.accountID,'X',creationDate,'X',renewalDate,accountStatus, 'X', accountType, 'X', paymentStatus, 'X', subscription, email
FROM userAccounts,accountBalance
WHERE userAccounts.accountID=accountBalance.accountID
ORDER BY userAccounts.accountID
GO
SQL
close SQL_IN;
open (SQL_OUT, "$G_isql_exe -i $tempsql |") || die "Can't read from $G_isql_exe -i $tempsql : $!\n";

$i=1;
$badSubCount = 0;
while (<SQL_OUT>) {
	if (/X/) {
		chomp;
#print "Line: $_ \n";
		($aid, $creationDate, $renewalDate) = split(/X/);

#print " $aid $creationDate, $renewalDate " . "\n";
		$line = <SQL_OUT>;
		chomp $line;
#print "Line: $line \n";
		($accountStatus, $accountType, $paymentStatus, $balance) = split(/X/,$line);
#print "$accountStatus $accountType $paymentStatus $balance" . "\n";
		$line = <SQL_OUT>;
		chomp $line;
                $email = $line;
                $email =~ s/\s+//g;
#print "Email: $email \n";
#last;
		$aid+=0;
		$amount+=0;
		$accountStatus+=0;
		$accountType+=0;
		$balance+= 0;
		#not smart enough to make this part of the query, I tried
		if(($accountStatus==0)&&($accountType > 0)&&($accountType < 4)){
                   if($balance > 0){
                        #if there is a subscription log file
			if(-f "/logs/accounts/$aid") {
                            my $num_subs = &getActiveSubs("/logs/accounts/$aid");
                            #if they have an active subsciption
                            if($num_subs > 0){
                              $badSubCount++;
                              my $end = &acctChangesUpdate("/logs/acctChanges/$aid");
                              #bail after first valid one til production
				if($end){
					#last;
				}
                            }
			}
                    }
		}
	}
}
close SQL_OUT;
unlink($tempsql);
`/usr/lib/sendmail -q`;
print "Non-compliant subscription changes:$badSubCount \n";
