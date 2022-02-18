#!/usr/bin/perl
#
# Check each days batch of credit card subscriptions that are expiring.
# If the credit card expiration date is looming, send a reminder note.
#
# Tom Lang 9/2002
#

use Date::Manip;
use DBI;
use DBD::Sybase;
require "/u/vplaces/scripts/cannedMessages/ccExpiring.pl";

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
	my $sql = qq!EXEC vpusers..addActivityLogById $aid, "$msg"!;
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

#################
#
# Subroutine: send mail
#
sub sendMail {
	my $email = shift @_;
	my $aid = shift @_;
	my $from = $G_config{'billingEmail'};
	my $fromName = "VPchat Customer Service";

	my $cannedMsg = &ccExpiring($from, $fromName, $email, $aid);

        if ( open( MAIL, "| /usr/lib/sendmail -oi -oem -f $from -t > /dev/null" ) ) {
                print MAIL $cannedMsg;
                print MAIL $G_configHtml{'signature'};

		close( MAIL );
##DEBUG
        open( MAIL, "| /usr/lib/sendmail -oi -oem -f $from $G_config{'devEmail'} > /dev/null" );
                print MAIL $cannedMsg;
                print MAIL $G_configHtml{'signature'};
		print MAIL "\nOriginally to: $email\n";

		close( MAIL );

	}
	else {
		warn "Can't send email\n";
	}
}

#################
#
# START HERE
#

$t = time + (60*60*24*30);
@d = localtime($t);
$mon = $d[4]+1;
$yr = $d[5]+1900;
$day = $d[3];

#
# Set up to access the database
#
$ENV{'SYBASE'} ||= '/u/vplaces/s/sybase';
$G_dbh = DBI->connect ( 'dbi:Sybase:', 'vpusr', 'vpusr1' );
&getConfigKeys;
 
#
# Find credit cards with looming or past expiration date
#

$sql =<<SQL;
SELECT userAccounts.accountID, Ecom_billto_online_email
FROM creditCards,subscriptions,userAccounts
WHERE type=2
AND autoRenew=1
AND subscriptions.ccID=creditCards.ccID
AND subscriptions.accountID=userAccounts.accountID
AND accountStatus = 0
AND renewalDate <= "$mon/$day/$yr 23:59:59"
AND renewalDate >= "$mon/$day/$yr 00:00:00"
AND Ecom_card_expdate_month <= $mon
AND Ecom_card_expdate_year = $yr
SQL

$sth = $G_dbh->prepare($sql);
die 'Prepare failed' unless (defined($sth));

$sth->execute;

print "Checking for credit cards with looming or past expiration\n";
my ($rc, @row);
do {
  while (@row = $sth->fetchrow() ) {
    if ($sth->{syb_result_type} == CS_ROW_RESULT) {
	$aid = shift @row;
	$email = shift @row;
	print "$aid - $email\n";
	&sendMail($email, $aid);
	&writeLog($aid, "Reminder note sent - credit card has expired and need to update their info.");
    }
  }
} while($sth->{syb_more_results});

$sth->finish;

print "Done\n";
