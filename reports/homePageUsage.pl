#!/usr/bin/perl
#
# Monitor usage of homePages
#
# Tom Lang 6/2002
#
$dbName = 'vpplaces';
$dbPw = 'vpplaces';

$G_isql_exe = "/u/vplaces/s/sybase/bin/isql -U$dbName -P$dbPw -SSYBASE";
$G_statdir = "/tmp/";
$tempsql = $G_statdir . ".temp.sql.$$";
$ENV{'SYBASE'} ||= '/u/vplaces/s/sybase';

#
# Find bytes transferred by home page
#
open (SQL_IN, ">$tempsql") || die "Can't write to $tempsql : $!\n";
print SQL_IN <<SQL;
SELECT 'VP', locked, deleted, megsTransferred, bytesTransferred, URL 
FROM homePages
ORDER BY megsTransferred DESC, bytesTransferred DESC
GO
SQL
close SQL_IN;

open (SQL_OUT, "$G_isql_exe -i $tempsql |") || die "Can't read from $G_isql_exe -i $tempsql : $!\n";

#
# Show the top 100
#
print "The Top 100 web pages, by bytes transferred:\n\n";
print "U=unlocked, L=locked\nA=active, D=deleted\n";
$count = 1;
while (<SQL_OUT>) {
	next unless (/VP/);
	chomp;
	my ($junk, $locked, $deleted, $megs, $bytes) = split;
	my $url = <SQL_OUT>;
	$url =~ s/^\s+//;
	$url =~ s/\s+$//;
	my $l = ($locked) ? 'L' : 'U';
	my $d = ($deleted) ? 'D' : 'A';
	if ($megs >= 10) {
		1 while ($megs =~ s/(\d+)(\d\d\d)/$1,$2/);
		printf "%3.0d. %s %s\t%12s Megs\t%s\n", $count, $l, $d, $megs, $url;
	}
	elsif ($megs >= 1) {
		$megs = ($megs * 1024 * 1024) + $bytes;
		1 while ($megs =~ s/(\d+)(\d\d\d)/$1,$2/);
		printf "%3.0d. %s %s\t%12s Bytes\t%s\n", $count, $l, $d, $megs, $url;
	}
	else {
		1 while ($bytes =~ s/(\d+)(\d\d\d)/$1,$2/);
		printf "%3.0d. %s %s\t%12s bytes\t%s\n", $count, $l, $d, $bytes, $url;
	}
	last if ($count++ > 99);
}
close SQL_OUT;

#
# Find web hits by home page
#
open (SQL_IN, ">$tempsql") || die "Can't write to $tempsql : $!\n";
print SQL_IN <<SQL;
SELECT 'VP', locked, deleted, webHits, URL 
FROM homePages
ORDER BY webHits DESC
GO
SQL
close SQL_IN;

open (SQL_OUT, "$G_isql_exe -i $tempsql |") || die "Can't read from $G_isql_exe -i $tempsql : $!\n";

#
# Show the top 100
#
print "The Top 100 web pages, by Web Hits:\n\n";
print "U=unlocked, L=locked\nA=active, D=deleted\n";
$count = 1;
while (<SQL_OUT>) {
	next unless (/VP/);
	chomp;
	my ($junk, $locked, $deleted, $hits) = split;
	my $url = <SQL_OUT>;
	$url =~ s/^\s+//;
	$url =~ s/\s+$//;
	my $l = ($locked) ? 'L' : 'U';
	my $d = ($deleted) ? 'D' : 'A';
	1 while ($hits =~ s/(\d+)(\d\d\d)/$1,$2/);
	printf "%3.0d. %s %s\t%12s Hits\t%s\n", $count, $l, $d, $hits, $url;
	last if ($count++ > 99);
}
close SQL_OUT;

#
# Find page views by home page
#
open (SQL_IN, ">$tempsql") || die "Can't write to $tempsql : $!\n";
print SQL_IN <<SQL;
SELECT 'VP', locked, deleted, pageViews, URL 
FROM homePages
ORDER BY pageViews DESC
GO
SQL
close SQL_IN;

open (SQL_OUT, "$G_isql_exe -i $tempsql |") || die "Can't read from $G_isql_exe -i $tempsql : $!\n";

#
# Show the top 100
#
print "The Top 100 web pages, by Page Views:\n\n";
print "U=unlocked, L=locked\nA=active, D=deleted\n";
$count = 1;
while (<SQL_OUT>) {
	next unless (/VP/);
	chomp;
	my ($junk, $locked, $deleted, $pvs) = split;
	my $url = <SQL_OUT>;
	$url =~ s/^\s+//;
	$url =~ s/\s+$//;
	my $l = ($locked) ? 'L' : 'U';
	my $d = ($deleted) ? 'D' : 'A';
	1 while ($pvs =~ s/(\d+)(\d\d\d)/$1,$2/);
	printf "%3.0d. %s %s\t%12s PVs\t%s\n", $count, $l, $d, $pvs, $url;
	last if ($count++ > 99);
}
close SQL_OUT;
unlink($tempsql);
