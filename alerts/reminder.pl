#!/usr/bin/perl
#
# Find private alert lists that have pending requests to join,
# and send a reminder to the account owner.
#
# Tom Lang 2/2004

use Date::Manip;
use DBI;
use DBD::Sybase;


require "/web/reg/configKeys.pl";

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

}

##################
#
# Subroutine: Send email message 
#
require "/u/vplaces/scripts/cannedMessages/pendingJoin.pl";
sub sendMail
{
  my $aid = shift @_;
  my $email = shift @_;
  my $pending = shift @_;
  my $from = $G_config{'helpdeskEmail'};
  my $cannedMsg = &pendingJoin( $from, $email, $aid, $pending );

  if (open(MAIL, "| /usr/lib/sendmail -oi -oem -f $from -t")) {
    print MAIL $cannedMsg;
    print MAIL $G_configHtml{'signature'};
    close MAIL;
  }
  else {
    die ("Problem: Cannot send mail");
  }
}

###############
#
# START HERE
#

$d = &ParseDate('today');
($now, $date, $sqlDate, $logDate) = &UnixDate( $d, '%Y%m%d %H:%M:%S', '%b %m, %Y', '%m/%d/%Y 00:00:00', '%Y%m%d');

$logFile = "/logs/reminder.log.$logDate";
open (LOG, ">>$logFile") || die "Can't append log file $logFile : $!";
print LOG "$now\tStarting reminder processing\n";

$G_dbh = DBI->connect ( 'dbi:Sybase:', 'audset', 'audset1' );
$sql =<<SQL;
SELECT u.accountID,COUNT(p.notifyID) AS pending, email
FROM vpusers..userAccounts u, vpusers..services s, pendingListSubscrs p
WHERE s.type=1
AND s.accountID=u.accountID
AND s.itemID=p.notifyID
GROUP BY u.accountID
SQL

$sth = $G_dbh->prepare($sql);
die 'Prepare failed' unless (defined($sth));
$sth->execute;
do {
  while (@row = $sth->fetchrow() ) {
    $accountID = shift @row;
    $pending{$accountID} = shift @row;
    $email{$accountID} = shift @row;
  }
} while($sth->{syb_more_results});
$sth->finish;

foreach $accountID (keys %pending) {
  print LOG "Acct: $accountID\tPending: $pending{$accountID}\tEmail: $email{$accountID}\n";
  &sendMail( $accountID, $email{$accountID}, $pending{$accountID} );
}
 
$date = &ParseDate('today');
$now = &UnixDate($date, '%Y%m%d %H:%M:%S');
print LOG "$now\tcompleted\n";
close LOG;
