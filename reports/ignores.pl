#!/usr/bin/perl
###########################################################
#
# Process "ignore" messages posted to the web server.
# The web server writes copies of the log for this purpose.
# The copies are 5 minute chunks. This script processes
# the "ignore" posts in all chunk files it finds except
# the newest, which is being actively written to by the web
# server.
#
# Tom Lang 10/2002
#

use Date::Manip;
use DBI;
use DBD::Sybase;

$ENV{'SYBASE'} ||= '/u/vplaces/s/sybase';

#
# open report log file
#
$d = &DateCalc('now','- 5 minutes');
$logDate = &UnixDate( $d, '%Y%m%d' );
$logFile = "/logs/ignore.log.$logDate";
open (LOG, ">>$logFile") || die "Can't append log file $logFile : $!";
$now = scalar localtime;
print LOG "Starting ignore processing at $now\n";

#
# Find the log file chunk(s), if any
#
$dir = "/logs/shortTerm";
opendir(STATS, $dir);
@statFiles = grep( /^access.reg/, readdir(STATS));
closedir(STATS);
$files = $#statFiles;	# total files - 1, since the last one is still 
			# being written to by the web server.

#
# Process the report lines, making a hash of ignorer:ignoree
# pairs with counter. Also make a hash keyed by ignoree.
# The former is for creating log records -
#	Ignorer ignored Ignoree N times
# The latter is for updating the database per ignoree.
#
$count = 0;
foreach $file (sort @statFiles) {
	last if ($files-- == 0);
	#print "$file\n";
	open(WEBLOG, "<$dir/$file") || die "Can't read $dir/$file : $!";
	while (<WEBLOG>) {
		next unless (/GET \/VP\/report.html/);
		/\?user=([^&]+)&ignored=([^ ]+)/;
		$ignorer = $1;
		$ignoree = $2;
		$ignorer =~ tr/[A-Z]/[a-z]/;
		$ignoree =~ tr/[A-Z]/[a-z]/;
		$ignorer =~ s/%\d\d//g;		# take out query-string encoded stuff
		$ignoree =~ s/%\d\d//g;		# like space characters (%20)
		$key = $ignorer . ":" . $ignoree;
		$ignores{$key}++;
		$ignored{$ignoree}++;
		$count++;
	}
	close WEBLOG;
	unlink "$dir/$file";	# delete chunk file after processing
}
if ($count == 0) {
	print LOG "No activity to process ...\n";
	close LOG;
	exit;
}

print LOG "Updating the database ...\n";
$G_dbh = DBI->connect ( 'dbi:Sybase:', 'vpusr', 'vpusr1' );

#
# process activity by ignoree
#
foreach $who (keys %ignored) {
	if ($who eq "") {
		print LOG "Warning: missing user name, ignored\n";
		next;
	}
	print LOG "$ignored{$who}\t$who\n";
	$sql = qq!UPDATE users SET ignores=ignores+$ignored{$who} WHERE nickName="$who"!;
	$sth = $G_dbh->prepare($sql);
	die 'Prepare failed' unless (defined($sth));
	$sth->execute;
	do {
	  while (@row = $sth->fetchrow() ) {
	    if ($sth->{syb_result_type} == CS_STATUS_RESULT) {
		$rc = shift @row;
	    }
	  }
	} while($sth->{syb_more_results});
	$sth->finish;
	print "$sql returned $rc\n" if ($rc);

}

#
# process activity by ignorer
#
foreach $k (keys %ignores) {
	($ignorer, $ignoree) = split(/:/, $k);
	$times = ($ignores{$k} > 1) ? "times" : "time";
	print LOG "$ignorer ignored $ignoree $ignores{$k} $times\n";
} 

$now = scalar localtime;
print LOG "Processing completed at $now\n";
