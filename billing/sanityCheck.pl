#!/usr/bin/perl
# Tom Lang 6/2003

use Date::Manip;
use DBI;
use DBD::Sybase;
use LWP::UserAgent;
use Crypt::SSLeay;

#####################################################
#
# Subroutine: get configuration keys from the database
#
sub getConfigKeys {
  undef %G_config;
  
  my $sth = $G_dbh->prepare("EXEC vpusers..getServerConfig");
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

###############
#
# START HERE
#

if ($#ARGV == -1) {
  $d = &ParseDate('today');
  $yd = &ParseDate('yesterday');
} else {
  $d = &ParseDate($ARGV[0]);
  $yd = &DateCalc($ARGV[0],'- 1 day');
}
($now, $date, $sqlDate, $logDate) = &UnixDate( $d, '%Y%m%d %H:%M:%S', '%b %m, %Y', '%m/%d/%Y 00:00:00', '%Y%m%d');
$yesterday = &UnixDate($yd, '%m/%d/%Y 00:00:00');

#
# Set up to access the database
#

$ENV{'SYBASE'} ||= '/u/vplaces/s/sybase';
$G_dbh = DBI->connect ( 'dbi:Sybase:', 'vpusr', 'vpusr1' );
&getConfigKeys;

$sql =<<SQL;
SELECT accountID,autoRenew,type
FROM subscriberAccounts
WHERE renewalDate <= "$sqlDate"
AND   renewalDate >= "$yesterday"
AND accountType >0
AND accountStatus=0
SQL

$sth = $G_dbh->prepare($sql);
die 'Prepare failed' unless (defined($sth));
$sth->execute;
do {
  while (@row = $sth->fetchrow() ) {
    if ($sth->{syb_result_type} == CS_ROW_RESULT) {
	$accountID    = shift @row;
	$autoRenew    = shift @row;
	$type         = shift @row;
	$accts{$accountID} = $type;
    }
  }
} while($sth->{syb_more_results});

$sth->finish;

$sql =<<SQL;
SELECT accountID,autoRenew,type
FROM subscriberAccounts
WHERE renewalDate <= "$sqlDate"
AND accountType >0
AND accountStatus=0
SQL

$sth = $G_dbh->prepare($sql);
die 'Prepare failed' unless (defined($sth));
$sth->execute;
do {
  while (@row = $sth->fetchrow() ) {
    if ($sth->{syb_result_type} == CS_ROW_RESULT) {
	$accountID    = shift @row;
	$autoRenew    = shift @row;
	$type         = shift @row;
	unless($accts{$accountID} == $type) {
		print "Sanity check needed: $accountID $type $autoRenew\n";
	}
    }
  }
} while($sth->{syb_more_results});

$sth->finish;
