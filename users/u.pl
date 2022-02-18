#!/usr/bin/perl
#
# Periodically process the VPUSERS log and update the 
# database with recent user sign-in activity.
#
# Tom Lang 8/2003
#
use DBI;
use DBD::Sybase;

BEGIN {
  $ENV{'SYBASE'} ||= '/u/vplaces/s/sybase';
  $G_dbh = DBI->connect ( 'dbi:Sybase:', 'vpusr', 'vpusr1' );
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


##################
#
# Subroutine: Update the database
#
sub updateDatabase {
	my ($who, $when);
	my $count = 0;
	foreach $who (keys %signIns) {
	  $when = $signIns{$who};
	  my $sql = "EXEC vpusers..updateSignOnDate '$who', '$when'";
	  my $sth = $G_dbh->prepare($sql);
	  die 'Prepare failed' unless (defined($sth));
	  $sth->execute;
	  my (@row);
	  do {
	    while (@row = $sth->fetchrow() ) {
	      my $key = shift @row;
	    }
	  } while($sth->{syb_more_results});
	  $sth->finish;
	  $count++;
	}
	my $now = scalar localtime;
	print STDERR "$now processed $count\n";
}

######################
#
# START HERE
#
&getConfigKeys;
if ($G_config{'VPUSERSserver'} ne $G_config{'thisHost'}) {
	die "$0 should run on $G_config{'VPUSERSserver'} not $G_config{'thisHost'}\n";
}

$suffix = $ARGV[0];

$famLogFile = $ENV{'HOME'} . "/VPCOM/VPUSERS/vpusers.log." . $suffix;
$adultLogFile = $ENV{'HOME'} . "/VPCOM/VPAUX/vpaux.log." . $suffix;
if (! -f $famLogFile) {
	die "$0 can't find $famLogFile\n";
}

print STDERR "Processing log file $famLogFile\n";
open (FAMLOG, "<$famLogFile") || die "Can't open $famLogFile: $!";
open (ADULTLOG, "<$adultLogFile") || die "Can't open $adultLogFile: $!";

	%signIns = ();
	while (<FAMLOG>) {
		next unless(/Successful/);
		/\[([^\]]+).*<([^>]+)>/;
		$when = $1;
		$who = $2;
		$who =~ tr/[A-Z]/[a-z]/;
		$who =~ s/\s+//g;
		$signIns{$who} = $when;
	}
	while (<ADULTLOG>) {
		next unless(/ OK$/);
		/^(\d+):([^ ]+)[^<]*<([^>]+)>/;
		$yr = substr($1,0,4);
		$mon = substr($1,4,2);
		$day = substr($1,6,2);
		$when = "$mon/$day/$yr $2";
		$who = $3;
		$who =~ tr/[A-Z]/[a-z]/;
		$who =~ s/\s+//g;
		$signIns{$who} = $when;
	}
	&updateDatabase;
