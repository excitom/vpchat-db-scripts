#!/usr/bin/perl
#
# Copy important log files to backup server
#
# Tom Lang 1/2002
#

$now = scalar localtime;
print "Starting log file backup - $now\n";
open (LIST, "</u/vplaces/scripts/backup/list.txt") || die "Can't find list to backup: $!";
while (<LIST>) {
	next if (/^#/);
	chomp;
	push(@list, $_);
}
close LIST;

#
# Determine which host this is, and which host has the slave DB
#
@dbHosts = ('anne', 'amy');
$s{$dbHosts[0]} = $dbHosts[1];
$s{$dbHosts[1]} = $dbHosts[0];
$this = `hostname`;
chomp $this;
$this =~ s/\..*$//;
$slave = $s{$this};
die "Can't figure out which hosts to use- master: $this - slave: $slave" if ($slave eq "" || $this eq "");

foreach $src (@list) {
	$dest = $src;
	$dest =~ s!/[^/]+$!!;
	`/usr/local/bin/rsync -auv $src $slave:$dest`;
}

$now = scalar localtime;
print "backup complete - $now\n";
