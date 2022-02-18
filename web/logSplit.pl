#!/usr/bin/perl
#
# Split members.vpchat.com log file by member name
#
# Tom Lang 2/2002
#
use FileCache;
use Date::Manip;

if ($#ARGV == -1) {
	$d = &ParseDate('yesterday');
} else {
	$d = &ParseDate($ARGV[0]);
}
($date, $month) = &UnixDate( $d, '%Y%m%d', '%Y%m' );
$logFile = "/logs/archive/access.members." . $date . ".gz";
print "Processing $logFile -- $month\n";
open (LOG, "gunzip -c $logFile |") || die "Can't read $logFile : $!";

$dir = "/logs/web/";

while (<LOG>) {
	m!"GET /([A-Za-z0-9_.-]+)[ /][^"]+" (\d+) ([0-9-]+)!;
	next unless (($2 >= 200) && ($2 < 400));
	$who = $1;
	$who =~ tr/[A-Z]/[a-z]/;
	$out = $dir . $month . "." . $who . ".tmp";
	cacheout $out;
	print $out $_;
}
close LOG;

chdir $dir;
opendir (DIR, $dir) || die "Can't read $dir : $!";
@files = grep /\.tmp/, readdir DIR;
closedir DIR;

foreach $file (@files) {
	$log = $file;
	$log =~ s/\.tmp/.log/;
	`cat $file >> $log`;
	unlink $file;
}
