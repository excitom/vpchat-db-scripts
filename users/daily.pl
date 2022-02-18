#!/usr/bin/perl
#
# Tom Lang 1/2002

$m = $ARGV[0];
$d = $ARGV[1];
$y = $ARGV[2];
$yr = 100+$y;
$date = sprintf("%2.2d%2.2d%3.3d", $m,$d,$yr);
open (LOG, "/u/vplaces/VPCOM/VPPLACES/vplaces.log.$date");
while (<LOG>) {
	next unless(/ enter /);
	$sessions++;
	/ "([^"]+)" /;
	$name = $1;
	$name =~ /([^(]+)\(([^)]+)\)/;
	$n = $1;
	$t = $2;
	if ($t eq "local") {
		$users{$n}++;
		$registered{$n}++;
	} else {
		$n =~ s/guest\d+/guest/;
		$users{$n}++;
		$guest{$n}++;
	}
}
close LOG;
foreach $i (keys %users) {
	$users++;
}
foreach $i (keys %registered) {
	$registered++;
}
foreach $i (keys %guest) {
	$guest++;
}

$yr = $y+2000;
$date = sprintf("%4.4d%2.2d%2.2D", $yr,$m,$d);
open (LOG, "/u/vplaces/VPCOM/VPPLACES/snapshot.log.$date");
$max = 0;
while(<LOG>) {
	@fields = split;
	$c = $fields[3];
	($junk, $num) = split(/:/, $c);
	die unless ($junk eq "C");
	$max = $num if ($num > $max);
}
close LOG;

open (OUT, ">/u/vplaces/scripts/users/data/$date");
print OUT <<HTML;
<table border=2>
<tr><th colspan=2>$date</th></tr>
<tr><td>Peak online</td><th align=right>$max</th></tr>
<tr><td>Sessions</td><th align=right>$sessions</th></tr>
<tr><td>Registered</td><th align=right>$registered</th></tr>
<tr><td>Guest</td><th align=right>$guest</th></tr>
<tr><th align=left>Unique users</th><th align=right>$users</th></tr>
</table>
HTML
close OUT;

$date = sprintf("%4.4d%2.2d", $yr, $m);
open (HTML, ">/excite/chattool/html/stats/$date.html");
print HTML <<HTML;
<html>
<head>
<title>Summary for $date</title>
</head>
<body bgcolor=#ffffff>
<font face=arial,helvetica>
<h3>Summary for $date</h3>
HTML

opendir (DATA, "/u/vplaces/scripts/users/data");
@files = grep !/^\./, readdir DATA;
closedir DATA;
foreach $f (@files) {
	if ($f =~ /^$date/) {
		open (F, "/u/vplaces/scripts/users/data/$f");
		while (<F>) {
			print HTML;
		}
		close F;
	}
}
print HTML <<HTML;
</body>
</html>
HTML
close HTML;
