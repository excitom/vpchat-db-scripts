#!/usr/bin/perl
#
# Check for changes in user home page directories, and recalculate
# space usage. 
#
# This is intended to run periodically from crontab. 
#
# Tom Lang 8/2002
#
use DBI;
use DBD::Sybase;

BEGIN () {
  $ENV{'SYBASE'} ||= '/u/vplaces/s/sybase';
  $dbName = 'sa';
  $dbPw = 'UBIQUE';
  $dbSrvr = 'SYBASE-ANNE';
  $G_dbh = DBI->connect ( "dbi:Sybase:server=$dbSrvr", $dbName, $dbPw );
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

  my @now = localtime(time);
  $G_config{'curYear'} = $now[5]+1900;
}

#################
#
# Subroutine: Update the database
sub updateDB {
	my $url = shift @_;
	my $bytes = shift @_;
	my $sql =<<SQL;
EXEC vpplaces..updateHomePageBytes "$url", $bytes
SQL
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
	print "$sql expected 0 got $rc\n" if ($rc != 0);
	$sth->finish;

        if ($rc == 20001) {		# home page is deleted
	  my $saveDir = $G_config{'deletedMembersRoot'};
	  my $docRoot = $G_config{'membersRoot'};
	  $dir = $docRoot . "/" . $url;
	  `mv -- $dir $saveDir`;
	  print "Deleted directory $dir since home page deleted\n";
	}
}

#################
#
# START HERE
#
&getConfigKeys;

die "This script should run on $G_config{'membersNFS'} not $G_config{'thisHost'}" unless($G_config{'membersNFS'} eq $G_config{'thisHost'});

$lockFile = '/tmp/updateSpaceUsage.lock';
$homePageDir = $G_config{'membersRoot'};
$timeStamp = $homePageDir . '/VP/time.stamp';
$tmpStamp = $timeStamp . '.tmp';
$start = time;
if (-f $lockFile) {
	$thisTime = localtime($start);
	die "Lock file found at $thisTime\n";
}
`touch $lockFile`;

`touch $tmpStamp`;
if (-f $timeStamp) {
	@dirs = `cd $homePageDir;find . -newer $timeStamp -type d -print`;
} else {
	@dirs = `cd $homePageDir;find . -type d -print`;
}
rename $tmpStamp,$timeStamp;

foreach $dir (@dirs) {
	chomp $dir;
	$dir =~ /\.\/([^\/]+\/*)/;
	$d = $1;
	$d =~ s/\/$//;
	$changed{$d} = 1;
}

#
# Anything to do?
#
$pages = scalar keys %changed;
if ($pages) {

  $ctr = 0;
  my (@dirs) = ();
  foreach $dir (keys %changed) {
	$ctr++;
	###print "$ctr of $pages ";
	next if ($dir =~ /^\s*$/);
	next if ($dir eq 'VP');
	next if ($dir eq 'img');
	next if ($dir =~ /^index/);
	$docRoot = $homePageDir . "/" . $dir;
	next unless (-d "$docRoot");
	@s = `du -sk $docRoot`;
	($su, $junk) = split(/\s+/, $s[0]);
	$su *= 1024;
	push(@dirs, "$dir -- $su");
	&updateDB( $dir, $su);
  }

  if ($ctr) {
    $secs = time - $start;
    if ($secs > 60) {
      print "\nupdateSpaceUsage: $ctr pages processed in $secs seconds\n";
      print join("\n", @dirs);
    }
  }
}

unlink $lockFile;
