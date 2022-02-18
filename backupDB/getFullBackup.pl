#!/usr/local/bin/perl
#
# Tom Lang 7/1999
#
@dbHosts = ('anne', 'angela');
$m{$dbHosts[0]} = $dbHosts[1];
$m{$dbHosts[1]} = $dbHosts[0];
$this = `hostname`;
chomp $this;
$this =~ s/\..*$//;
$master = $m{$this};
die "Can't figure out which host to use" if ($master eq "");

if ($#ARGV == -1) {
	@dbs = ('audset', 'vpplaces', 'vpusers');
} else {
  while ($#ARGV > -1) {
	push(@dbs, pop);
  }
}

$ENV{'SYBASE'} ||= '/u/vplaces/s/sybase';
$backupDir = $ENV{'SYBASE'} . '/db/backup';

$date = scalar localtime;
print "$date\n";
foreach $db (@dbs) {
	$start = time;
	$file0 = $backupDir . "/" . $db . ".full.backupSet.0";
	$file1 = $backupDir . "/" . $db . ".full.backupSet.1";
	$file2 = $backupDir . "/" . $db . ".full.backupSet.2";
	#
	# rotate old backups
	#
	if (-f $file1) {
		rename $file1, $file2;
	}
	if (-f $file0) {
		rename $file0, $file1;
	}

	#
	# get the newest full backup
	#
	`/bin/rcp $master:$file0 $file0`;
	$s = (-s $file0);
	unless(defined($s)) {
		"ERROR: $this was unable to retrieve $file\n";
	} else {
		$delta = time - $start;
		print "$this retrieved $db full backup file from $master ($s bytes) in $delta seconds\n";
	}
}
