#!/usr/bin/perl
#
# Periodically process the VPUSERS log and update the 
# database with recent user sign-in activity.
#
# Tom Lang 8/2003
#
use DBI;
use DBD::Sybase;
require "/web/reg/configKeys.pl";

BEGIN {
  $ENV{'SYBASE'} ||= '/u/vplaces/s/sybase';
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
if ($G_config{'VPUSERSserver'} eq $G_config{'thisHost'}) {
  #$doSecFile = 1;
  $doSecFile = 0;
  $G_dbh = DBI->connect ( 'dbi:Sybase:', 'vpusr', 'vpusr1' );
}
elsif ($G_config{'VPUSERSadultServer'} eq $G_config{'thisHost'}) {
  $doSecFile = 0;
  $G_dbh = DBI->connect ( 'dbi:Sybase:server=SYBASE2', 'vpusr', 'vpusr1' );
}
else {
  die "$0 should run on $G_config{'VPUSERSserver'} or $G_config{'VPUSERSadultServer'}, not $G_config{'thisHost'}\n";
}

@now = localtime(time);
$now[4]++;
$now[5] += 1900;
$suffix = sprintf("%4.4d%2.2d%2.2d", $now[5], $now[4], $now[3]);

$priLogFile = $ENV{'HOME'} . "/VPCOM/VPUSERS/vpusers.log." . $suffix;
$secLogFile = $ENV{'HOME'} . "/VPCOM/VPAUX/vpaux.log." . $suffix;
$traceFile = $ENV{'HOME'} . "/VPCOM/VPUSERS/signInTrace.log";
if (! -f $priLogFile) {
	die "$0 can't find $priLogFile\n";
}

$pidFile = "$ENV{'HOME'}/scripts/users/updateSignOnDate.pid";
if (-f $pidFile) {
	open(PID, "<$pidFile");
	$pid = <PID>;
	chomp $pid;
	close PID;

	$found = (-e "/proc/$pid");
	die "$0 - looks like it's already running\n" if ($found);
}
die "Can't find $priLogFile" if (! -f $priLogFile);

close(STDERR);
$| = 1;
open(STDERR, ">>$traceFile") || die;
close(STDIN);
close(STDOUT);
exit if (fork);
exit if (fork);

open (PID, ">$pidFile");
$pid = $$;
print PID "$pid\n";
close PID;

print STDERR "Processing log file $priLogFile\n";
open (PRILOG, "<$priLogFile") || die "Can't open $priLogFile: $!";
if ($doSecFile && (! $G_config{'testServer'})) {
  print STDERR "Processing log file $secLogFile\n";
  open (SECLOG, "<$secLogFile") || die "Can't open $secLogFile: $!";
}

while(1) {
	%signIns = ();
	while (<PRILOG>) {
		next unless(/Successful/);
		/\[([^\]]+).*<([^>]+)>/;
		$when = $1;
		$who = $2;
		$who =~ tr/[A-Z]/[a-z]/;
		$who =~ s/\s+//g;
		$who =~ s/\@buddy//;
		$signIns{$who} = $when;
	}
	if ($doSecFile) {
	  while (<SECLOG>) {
		next unless(/ OK$/);
		/^(\d+):([^ ]+)[^<]*<([^>]+)>/;
		$yr = substr($1,0,4);
		$mon = substr($1,4,2);
		$day = substr($1,6,2);
		$when = "$mon/$day/$yr $2";
		$who = $3;
		$who =~ tr/[A-Z]/[a-z]/;
		$who =~ s/\s+//g;
		$who =~ s/\@buddy//;
		$signIns{$who} = $when;
	  }
	}
	&updateDatabase;
	$now = scalar localtime;

	close STDERR;
	sleep(2*60);
	open(STDERR, ">>$traceFile") || die;

	@now = localtime(time);
	$now[4]++;
	$now[5] += 1900;
	$newSuffix = sprintf("%4.4d%2.2d%2.2d", $now[5], $now[4], $now[3]);
	if ($newSuffix ne $suffix) {
		$suffix = $newSuffix;
		close PRILOG;
		$priLogFile = $ENV{'HOME'} . "/VPCOM/VPUSERS/vpusers.log." . $suffix;
		print STDERR "Processing log file $priLogFile\n";
		while (! open (PRILOG, "<$priLogFile")) {
			$timeStamp = sprintf("%2.2d:%2.2d:%2.2d", $now[2], $now[1], $now[0]);
			print STDERR "$timeStamp Can't open $priLogFile: $! - retrying\n";
			sleep(60*60);
		}
		if ($doSecFile) {
		  close SECLOG;
		  $secLogFile = $ENV{'HOME'} . "/VPCOM/VPAUX/vpaux.log." . $suffix;
		  print STDERR "Processing log file $secLogFile\n";
		  if (! open (SECLOG, "<$secLogFile")) {
			print STDERR "Can't open $secLogFile: $!\n";
		  }
		}
	}
}
