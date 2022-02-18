#!/usr/bin/perl
#
# Tom Lang 1/2002

use Date::Manip;
require "/web/reg/html/VP/accountVars.pl";
require "/web/reg/configKeys.pl";

#
# Subroutine: get total chat minutes yesterday
#
sub readStatFile {
  my $file = shift @_;
  my $srvr = shift @_;
  open(STATS, qq!/bin/rsh $srvr tail -1 $file |!);
  $_ = <STATS>;
  close STATS;
  my @f = split;
  my $f;
  my $minutes = 0;
  foreach $f (@f) {
    my ($key, $val) = split(/:/,$f);
    $minutes += $val if ($key eq "Usage");
  }
  return $minutes;
}
sub getChatMinutesPerServer {
  my $srvr = shift @_;
  my $date = shift @_;
  my $statDir = "/u/vplaces/VPCOM/VPSTATS";
  my $file = "stat.log.$date";
  my $minutes = 0;
  $minutes += &readStatFile( "$statDir/$file", $srvr );
  my (@save);
  @save = `rsh $srvr "ls -d $statDir/$saveDir\* 2>/dev/null"`;
  my $dir;
  foreach $dir (@save) {
    chomp $dir;
    $minutes += &readStatFile( "$dir/$file", $srvr );
  }
print "MINUTES $srvr = $minutes\n";
  return $minutes;
}
sub getChatMinutes {
  my $date = shift @_;
  $minutes1 = getChatMinutesPerServer($G_config{'VPSTATSserver'}, $date);
  #$minutes2 = getChatMinutesPerServer($G_config{'VPSTATSadultServer'}, $date);
  $minutes2 = 0;
}

#
# Subroutine: get max users yesterday
#
sub getMaxUsers {
  my $date = shift @_;
  open(STATS, qq!/bin/rsh $G_config{'VPPLACESserver'} "cat /u/vplaces/VPCOM/VPPLACES/snapshot.log.$date" |!);
  my $max = 0;
  while(<STATS>) {
    my (@f) = split(/\t/);
    my ($junk, $m) = split(/:/, $f[2]);
    die "Programming error" unless($junk eq 'C');
    $max = $m if ($m > $max);
  }
  close STATS;
  $maxUsers1 = $max;
  #$max = 0;
  #open(STATS, qq!/bin/rsh $G_config{'VPPLACESadultServer'} "cat /u/vplaces/VPCOM/VPPLACES/snapshot.log.$date" |!);
  #while(<STATS>) {
    #my (@f) = split(/\t/);
    #my ($junk, $m) = split(/:/, $f[2]);
    #die "Programming error" unless($junk eq 'C');
    #$max = $m if ($m > $max);
  #}
  #close STATS;
  #$maxUsers2 = $max;
$maxUsers2 = 0;
}

#
# Subroutine: get sessions and unique users yesteray
#
sub getSessions {
  my $date = shift @_;
  $sessions1 = 0;
  $uniqueUsers = 0;
  $file = qq!/bin/rsh $G_config{'VPPLACESserver'} "cat /u/vplaces/VPCOM/VPPLACES/vplaces.log.$date" |!;
  open (LOG, $file) || die "Can't read $file : !";
  while (<LOG>) {
    next unless(/ enter /);
    $sessions1++;
    / "([^"]+)" /;
    my $name = $1;
    $name =~ /([^(]+)\(([^)]+)\)/;
    my $n = $1;
    my $t = $2;
    if ($t eq "local") {
      $users{$n}++;
      $registered{$n}++;
    } else {
      $n =~ s/guest\d+/guest/;
      $users{$n}++;
      $guest{$n}++;
    }
  }
  close LOG;

  $sessions2 = 0;
  #$file = qq!/bin/rsh $G_config{'VPPLACESadultServer'} "cat /u/vplaces/VPCOM/VPPLACES/vplaces.log.$date" |!;
  #open (LOG, $file) || die "Can't read $file : !";
  #while (<LOG>) {
    #next unless(/ enter /);
    #$sessions2++;
    #/ "([^"]+)" /;
    #my $name = $1;
    #$name =~ /([^(]+)\(([^)]+)\)/;
    #my $n = $1;
    #my $t = $2;
    #if ($t eq "local") {
      #$users{$n}++;
      #$registered{$n}++;
    #} else {
      #$n =~ s/guest\d+/guest/;
      #$users{$n}++;
      #$guest{$n}++;
    #}
  #}
  #close LOG;

  foreach $i (keys %users) {
        $uniqueUsers++;
  }
}

#######################
#
# Subroutine: Get account statistics
#
sub getAccountInfo {

  my $dbName = 'vpusr';
  my $dbPw = 'vpusr1';
  my $isql_exe = "/u/vplaces/s/sybase/bin/isql -U$dbName -P$dbPw -SSYBASE";

  open (SQL_IN, ">$tempsql") || die "Can't write to $tempsql : $!\n";
  print SQL_IN <<SQL;
SELECT 'T-50', COUNT(accountID)
FROM userAccounts
WHERE accountStatus = 0 AND accountType > 0
AND paymentStatus = 0
SELECT 'T-56',COUNT(accountID)
FROM userAccounts
WHERE accountStatus = 1
AND accountType > 0
SELECT 'T-51',COUNT(accountID)
FROM userAccounts
WHERE accountStatus = 2
AND accountType > 0
SELECT 'T-54',COUNT(accountID)
FROM userAccounts
WHERE accountStatus = 3
AND accountType > 0
SELECT 'T-53',COUNT(accountID)
FROM userAccounts
WHERE accountStatus = 4
AND accountType > 0
SELECT 'T-55',COUNT(accountID)
FROM userAccounts
WHERE accountStatus = 5
AND accountType > 0
SELECT 'T-52',COUNT(accountID)
FROM userAccounts
WHERE accountStatus = 0
AND accountType > 0
AND paymentStatus > 0
SELECT 'T-42',COUNT(accountID)
FROM subscriptions
WHERE autoRenew=1
SELECT 'T-80',CONVERT(INT, SUM(unitCost - (unitCost * discount)))
FROM userAccounts
WHERE (accountStatus = 0 OR accountStatus = 2)
AND accountType > 0
SELECT 'T-81',CONVERT(INT, SUM(unitCost - (unitCost * discount)))
FROM userAccounts
WHERE accountStatus = 0
AND paymentStatus = 0
AND accountType > 0
SELECT 'T-60',COUNT(accountID)
FROM userAccounts
WHERE accountType = 0
AND (accountStatus = 0 OR accountStatus=2)
SELECT 'T-61',COUNT(accountID)
FROM userAccounts
WHERE accountType = 1
AND (accountStatus = 0 OR accountStatus=2)
SELECT 'T-62',COUNT(accountID)
FROM userAccounts
WHERE accountType = 2
AND (accountStatus = 0 OR accountStatus=2)
SELECT 'T-63',COUNT(accountID)
FROM userAccounts
WHERE accountType = 3
AND (accountStatus = 0 OR accountStatus=2)
SELECT 'T-64',COUNT(accountID)
FROM userAccounts
WHERE accountType = 4
AND (accountStatus = 0 OR accountStatus=2)
SELECT 'T-70',COUNT(accountID)
FROM userAccounts
WHERE billingCycle = 1
AND (accountStatus = 0 OR accountStatus=2)
SELECT 'T-71',COUNT(accountID)
FROM userAccounts
WHERE billingCycle = 3
AND (accountStatus = 0 OR accountStatus=2)
SELECT 'T-72',COUNT(accountID)
FROM userAccounts
WHERE billingCycle = 6
AND (accountStatus = 0 OR accountStatus=2)
SELECT 'T-73',COUNT(accountID)
FROM userAccounts
WHERE billingCycle = 12
AND (accountStatus = 0 OR accountStatus=2)
SELECT 'T-40', COUNT(URL)
FROM vpplaces..homePages
WHERE deleted = 0
AND locked=0
GO
SQL

  close SQL_IN;

  open (SQL_OUT, "$isql_exe -i $tempsql |") || die "Can't read from $isql_exe -i $tempsql : $!\n";

  while (<SQL_OUT>) {
	chomp;
	if (/T-/) {
		my ($t, $v) = split;
		$t =~ s/T-//;
		$type{$t} = $v;
	}
  }
  close SQL_OUT;

  open (SQL_IN, ">$tempsql") || die "Can't write to $tempsql : $!\n";
  print SQL_IN <<SQL;
getMemberDir 0,1
GO
SQL

  close SQL_IN;

  open (SQL_OUT, "$isql_exe -i $tempsql |") || die "Can't read from $isql_exe -i $tempsql : $!\n";

  my @lines = <SQL_OUT>;
  close SQL_OUT;
  while ($#lines > -1) {
	$_ = shift @lines;
	last if (/----/);
  }
  my $more = 2;		# expect two data lines
  my ($withProfile, $withoutProfile);
  while ($#lines > -1) {
	$_ = shift @lines;
	my ($t, $v) = split;
	if ($t == 1) {		# prefix 0 -> members with profile
	  $withProfile = $v;
	  $more--;
	}
	if ($t == 0) {		# prefix 1 -> members without profile
	  $withoutProfile = $v;
	  $more--;
	}
	last unless($more);
  }
  $type{41} = $withProfile;
  $type{43} = $withoutProfile + $withProfile;

}

#######################
#
# Subroutine: Write 'yesterday' dat file for web page stats
#
sub writeDatFile {
  my $minutes = $minutes1 + $minutes2;
  my $maxUsers = $maxUsers1 + $maxUsers2;
  my $sessions = $sessions1 + $sessions2;
  my $datFile = "/u/vplaces/scripts/memberDir/yesterday.dat";
  open (DAT, ">$datFile") || die "Can't write to $datFile : $!";
  print DAT <<DAT;
\$minutes=$minutes;
\$maxUsers=$maxUsers;
\$sessions=$sessions;
\$uniqueUsers=$uniqueUsers;
DAT

  close DAT;
  ##`rcp $datFile anne:$datFile`;
}

#######################
#
# START HERE
#

if ($#ARGV == -1) {
  $yd = 1;
  $d = &ParseDate('yesterday');
} else {
  $yd = 0;
  $d = &ParseDate($ARGV[0]);
}
($processDate, $saveDir, $sqlDate) = &UnixDate( $d, '%Y%m%d', 'save%y%h%d_', '%m/%d/%Y 12:00AM');
print "$processDate\n" if ($yd == 0);	## confirm date in interactive mode

$dbName = 'vpplaces';
$dbPw = 'vpplaces';

$G_isql_exe = "/u/vplaces/s/sybase/bin/isql -U$dbName -P$dbPw -SSYBASE";
$G_statdir = "/tmp/";
$tempsql = $G_statdir . ".temp.sql.$$";
$ENV{'SYBASE'} ||= '/u/vplaces/s/sybase';


&getChatMinutes($processDate);

&getMaxUsers($processDate);

$pd = &UnixDate( $d, '%m%d1%y');

&getSessions($pd);

&writeDatFile if ($yd);

#
# Data keys
#
# 1 = peak online (family)
# 2 = peak online (adult)
# 11 = sessions (family)
# 12 = sessions (adult)
# 21 = unique users 
# 31 = chat minutes (family)
# 32 = chat minutes (adult)
# 
# 40 = home pages
# 41 = member profiles
# 42 = auto-renewing subscriptions
# 43 = active users
# 
# 50 = paid accounts
# 51 = pending
# 52 = awaiting payment
# 53 = suspended
# 54 = closed
# 55 = overdue
# 56 = new
# 
# 60 = complimentary
# 61 = basic
# 62 = family
# 63 = sybil
# 64 = group
# 
# 70 = 1 month
# 71 = 3 month
# 72 = 6 month
# 73 = 12 month
#
# 80 = monthly revenue
# 81 = monthly paid revenue

if ($yd) {
  &getAccountInfo;
}

open (SQL_IN, ">$tempsql") || die "Can't write to $tempsql : $!\n";
print SQL_IN <<SQL;
INSERT dailyTotals (time, type, value)
  VALUES ("$sqlDate", 1, $maxUsers1)
INSERT dailyTotals (time, type, value)
  VALUES ("$sqlDate", 2, $maxUsers2)
INSERT dailyTotals (time, type, value)
  VALUES ("$sqlDate", 11, $sessions1)
INSERT dailyTotals (time, type, value)
  VALUES ("$sqlDate", 12, $sessions2)
INSERT dailyTotals (time, type, value)
  VALUES ("$sqlDate", 21, $uniqueUsers)
INSERT dailyTotals (time, type, value)
  VALUES ("$sqlDate", 31, $minutes1)
INSERT dailyTotals (time, type, value)
  VALUES ("$sqlDate", 32, $minutes2)
SQL

if ($yd) {
  foreach $k ( keys %type) {
    print SQL_IN <<SQL;
INSERT dailyTotals (time, type, value)
  VALUES ("$sqlDate", $k, $type{$k})
SQL
  }
}

print SQL_IN "GO\n";

close SQL_IN;

open (SQL_OUT, "$G_isql_exe -i $tempsql |") || die "Can't read from $G_isql_exe -i $tempsql : $!\n";

@lines = <SQL_OUT>;
close SQL_OUT;

unlink($tempsql);
