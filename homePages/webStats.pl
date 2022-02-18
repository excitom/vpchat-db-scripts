#!/usr/bin/perl
###########################################################
#
# Update the homePages table in the database, 
# increment usage stats for user home pages.
#
# Tom Lang 6/2002
#
$dbName = 'vpplaces';
$dbPw = 'vpplaces';
$dbSrvr = 'SYBASE-ANNE';
$G_isql_exe = "/u/vplaces/s/sybase/bin/isql -U$dbName -P$dbPw -S$dbSrvr";
$G_statdir = "/tmp/";
$tempsql = $G_statdir . ".temp.sql.$$";
$ENV{'SYBASE'} ||= '/u/vplaces/s/sybase';

if ($#ARGV == 0) {
  $dir = $ARGV[0];
}
else {
  $dir = "/logs/shortTerm";
}
opendir(STATS, $dir);
@statFiles = grep( /^access.members/, readdir(STATS));
closedir(STATS);
$files = $#statFiles;	# total files - 1, since the last one is still 
			# being written to by the web server.

foreach $file (sort @statFiles) {
	last if ($files-- == 0);
	##print "$file\n";
	open(LOG, "<$dir/$file") || die "Can't read $dir/$file : $!";
	while (<LOG>) {
		m!"GET /([A-Za-z0-9_.-]+)[ /?]!;
		my $n = $1;
		next if (($n =~ /^index\./) || ($n eq '') || ($n eq 'icons'));
		next if (($n eq 'VP') || ($n eq "robots.txt") || ($n eq "favicon.ico"));
		next if (($n eq 'img') || ($n eq "server-status"));
		next if (($n eq 'server-info') || ($n eq "server-status"));
		next if ($n eq 'throttle-status');
		next if ($n eq 'style.css');
		next if ($n eq 'md5.js');
		$n =~ tr/[A-Z]/[a-z]/;
    		my @f = split;
		next if ($f[8] >= 400);		# skip errors
		$hits{$n}++;
		$bytes{$n} += ($f[9]+0);
		if (($f[6] =~ /\/$/) || ($f[6] =~ /\.html*/)) {
			$pageviews{$n}++;
		}
	}
	close LOG;
	unlink "$dir/$file";
}

open (SQL_IN, ">$tempsql") || die "Can't write to $tempsql : $!\n";
$i = 1;
foreach $n (keys %hits) {
	#print "$n $hits{$n} $pageviews{$n} $bytes{$n}\n";
	$h = $hits{$n}+0;
	$p = $pageviews{$n}+0;
	$b = $bytes{$n}+0;
	$pg{$i} = $n;
	print SQL_IN <<SQL;
exec updateHomePageStats "$n", $h, $p, $b
SQL
	if ($i++ %10 == 0) {
		print SQL_IN "GO\n";
	}
}
print SQL_IN "GO\n";
close SQL_IN;
open (SQL_OUT, "$G_isql_exe -i $tempsql |") || die "Can't read from $G_isql_exe -i $tempsql : $!\n";
$i = 0;
while (<SQL_OUT>) {
  $i++;
  if (/return status = 20001/) {
	print "problem with updating home page stats for acct $pg{$i}\n";
  }
}
unlink($tempsql);
