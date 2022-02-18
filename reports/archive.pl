#!/usr/bin/perl
#
# Zip up log files at the end of the month
#
# Tom Lang 2/2002

use Date::Manip;

#
# Default - run on the first day of the month, so 'yesterday' is in the
# month to be processed.
#
if ($#ARGV == -1) {
	$d = &ParseDate('yesterday');
} else {
	$d = &ParseDate($ARGV[0]);
}
($pre, $last, $day) = &UnixDate( $d, '%Y%m', '%Y%m%d', '%d' );
$logDir = "/logs";
$archive = "/logs/archive";
`mkdir $archive` unless (-d $archive);
die "No $archive" unless (-d $archive);

@servers = ('chat','adult','reg','cmgmt','members','secure', 'download','ladders','helpdesk');
foreach $server (@servers) {
	if ( -f "$logDir/access.$server.$last") {
		for ($i = 1; $i <= $day; $i++) {
			$dd = sprintf("%2.2d", $i);
			print "Processing access.$server.$pre$dd\n";
			`gzip $logDir/access.$server.$pre$dd; mv $logDir/access.$server.$pre$dd.gz $archive`;
			unlink "$logDir/errors.$server.$pre$dd"if (-f "$logDir/errors.$server.$pre$dd");
		}
	}
}
chdir $logDir;
$mask = "ignore.log.$pre" . '*';
@ignLogs = `ls -1 $mask`;
foreach $file (@ignLogs) {
	chomp $file;
	print "Processing $logDir/$file\n";
	`gzip $file; mv $file.gz $archive`;
}
