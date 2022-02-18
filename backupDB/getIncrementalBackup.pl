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
	die "Need to specify a dump file name\n";
} else {
	$file = $ARGV[0];
}

$ENV{'SYBASE'} ||= '/u/vplaces/s/sybase';
$backupDir = $ENV{'SYBASE'} . '/db/backup';

$date = scalar localtime;
print "$date\n";
$start = time;
`/bin/rcp $master:$file $file`;
@s = stat $file;
$delta = time - $start;
$db = $file;
$db =~ s/.*\/(.*)\..*$/$1/;
print "$this retrieved $db incremental backup file from $master ($s[7] bytes) in $delta seconds\n";
