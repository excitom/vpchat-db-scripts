#!/usr/bin/perl

$tempfile = "/logs/acctChanges/tombo.file.$$";
##############
#Gets active PayPal subs by looking at account log files for matching create/cancel emtries
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
#############
sub setPPautoRenew {

my $aid = shift @_;
my $autoRenew = 0;

$dbName = 'vpusr';
$dbPw = 'vpusr1';

$G_isql_exe = "/u/vplaces/s/sybase/bin/isql -U$dbName -P$dbPw -SSYBASE";
$G_statdir = "/tmp/";
$tempsql = $G_statdir . ".temp.sql.$$";
$ENV{'SYBASE'} ||= '/u/vplaces/s/sybase';

open (SQL_IN, ">$tempsql") || die "Can't write to $tempsql : $!\n";
print SQL_IN <<SQL;
SELECT autoRenew, 'X', comment
FROM subscriptions
WHERE accountID=$aid AND type=1
GO
SQL
close SQL_IN;
open (SQL_OUT, "$G_isql_exe -i $tempsql |") || die "Can't read from $G_isql_exe -i $tempsql : $!\n";

$count = 0;
while (<SQL_OUT>) {
   if (/X/) {
	chomp;
	($autoRenew, $type) = split(/X/);
        if($autoRenew == 1){
            return;
        }
        $comment = <SQL_OUT>;
        chomp($comment);
        $comment =~ s/\s+/ /g;
        $comment =~ s/^\s+//;
        $count++;
   }
}
close SQL_OUT;

if($count == 1){
  print("$aid $comment");
open (SQL_IN, ">$tempsql") || die "Can't write to $tempsql : $!\n";
print SQL_IN <<SQL;
update subscriptions
set autoRenew=1
where comment="$comment"
GO
SQL
close SQL_IN;
open (SQL_OUT, "$G_isql_exe -i $tempsql |") || die "Can't read from $G_isql_exe -i $tempsql : $!\n";

while (<SQL_OUT>) {
   print "result: $_";
}
}elsif($count > 1){
  print("Problem $aid $comment\n");
}
}
##############
sub autoRenewFix {
    my $path = shift @_;

opendir (PENDING, $path) || die "Can't open $path: $!";
@files = grep !/^\./, readdir PENDING;
closedir PENDING;

if ($#files == -1) {
  print "No files to process ...\n";
} else {
  $total = $#files+1;

  @files = sort {(-M "$path$b") <=> (-M "$path$a")} @files;

  foreach $file (@files) {
    next unless ($file =~ /^\d+$/);
    my $my_path = $path;
    $my_path .= $file;
    my $num_subs = &getActiveSubs($my_path);
    #if they have an active subsciption
    if($num_subs > 0){
#       print "active PayPal sub = $file\n";
       $res = setPPautoRenew($file);
    }
  }
}
}
##########
#
#START
#
 print "auto renew fix\n\n";
 &autoRenewFix("/logs/accounts/");
 print "\n\n";

