#!/usr/bin/perl
#
# Periodically poll for service changes, and take appropriate
# action.
#
# Tom Lang 1/04
#

use DBI;
use DBD::Sybase;

BEGIN {
  $ENV{'SYBASE'} ||= '/u/vplaces/s/sybase';
  $G_dbh = DBI->connect ( 'dbi:Sybase:', 'vpusr', 'vpusr1' );
  $G_logOpened = 0;
}

##################
#
# Write action to a log file
#
sub writeLog {
	my $msg = shift @_;
	if ($G_logOpened == 0) {
		my (@now) = localtime(time);
		$now[4]++;
		$now[5] += 1900;
		my $suffix = sprintf("%4.4d%2.2d%2.2d", $now[5], $now[4], $now[3]);
		my $logFile = "/logs/emailForwarding.$suffix";
		open(LOG, ">>$logFile") || die "Can't write to: $logFile $!";
		$G_logOpened = 1;
	}
	$msg .= "\n" unless ($msg =~ /\n$/);
	my $now = scalar localtime;
	print LOG "$now\t$msg";
}

##################
#
# Handle email forwarding updates
#
sub doEmailForwarding {
  my $sql =<<SQL;
SELECT nickName, email 
FROM users u, emailForwarding e, services s
WHERE e.locked = 0
AND   s.status = 0
AND   s.locked = 0
AND   e.serviceID = s.serviceID
AND   s.type = 3
AND   e.userID = u.userID
SQL
  
  my $sth = $G_dbh->prepare($sql);
  die 'Prepare failed' unless (defined($sth));
  $sth->execute;
  my (@row, %users);
  do {
    while (@row = $sth->fetchrow() ) {
      my $nickName = shift @row;
      $users{$nickName} = shift @row;
    }
  } while($sth->{syb_more_results});
  $sth->finish;
  my $count = scalar keys %users;
  $mailDir = "/etc/mail";
  chdir($mailDir);
  open (IN, "<virtusertable.base") || "Die can't read virtusertable.base : $!";
  open (OUT, ">virtusertable") || "Die can't write virtusertable : $!";
  my $baseCount = 0;
  my (%baseEmail);
  while (<IN>) {
    print OUT;
    $baseCount++;
    my ($e, $f) = split;
    $baseEmail{$e} = $f;
  }
  close IN;
  foreach $nickName (keys %users) {
    my $inMail = "$nickName\@vpchat.com";
    if (exists($baseEmail{$inMail})) {
      &writeLog("Duplicate forwarding: $inMail");
      next;
    }
    print OUT "$inMail\t$users{$nickName}\n";
  }
  close OUT;
  #
  # creating this file will trigger a root cron job to
  # update the sendmail dbm
  #
  open (TMP, ">/tmp/updateVirtusertable") || die "Can't write /tmp/updateVirtusertable : $!";
  close TMP;
  &writeLog( "Email forwarding updated: $baseCount base names, $count customers" );
}

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

#####################################################
#
# START HERE
#

my $sth = $G_dbh->prepare("EXEC vpusers..getEmailForwardingChanges");
die 'Prepare failed' unless (defined($sth));
$sth->execute;
my (@row);
do {
  while (@row = $sth->fetchrow() ) {
    my $accountID = shift @row;
    $aids{$accountID}++ if ($accountID > 0);
  }
} while($sth->{syb_more_results});
$sth->finish;

$count = scalar keys %aids;
if ($count > 0) {
  &getConfigKeys;
  &doEmailForwarding($accountID, $itemID{$accountID});
  &writeLog( "Items processed: $count" );
}
if ($G_logOpened) {
  close LOG;
}
