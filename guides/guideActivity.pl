#!/usr/bin/perl
#
# Snoop on what the guides are doing.
#
# The vplaces log is searched for all records associated with a chat
# name that begins with "guide-"  or "mc-" (case insensitive).
#
# Tom Lang 12/1998
#
use Date::Manip;

if ($#ARGV == -1) {
  $date = &ParseDate('yesterday');
} else {
  $date = &ParseDate($ARGV[0]);
}
($Y,$m,$d) = &UnixDate($date, '%Y', '%m', '%d');
$y = $Y - 1900;
$date = $m . $d . $y;
$Pdate = "$Y-$m-$d";
$G_dateDir = "$Y/$m";

$host = `hostname`;
chomp $host;
if ($host eq 'anne') {
  $srvr = 'vpchat';
  $pre1 = 'guide-';
  $pre2 = 'mc-';
} else {
  $srvr = 'vpadult';
  $pre1 = 'guide_';
  $pre2 = 'mc_';
}

$G_logDir = "/u/vplaces/VPCOM/VPPLACES/";
$G_logFile = $G_logDir . "vplaces.log." . $date;
$G_htmlName = "activity.log." . $date . ".html";
$G_htmlFile = "/web/cmgmt/html/guides/$srvr/" . $G_htmlName;

open (HTML, ">$G_htmlFile") || die "Can't create $G_htmlFile : $!";

print HTML <<HDR;
<html>
<head>
<title>Chat Guide Log for $Pdate</title>
<META http-equiv=Content-Type content="text/html; charset=windows-1252">
<LINK href="/layout.css" type=text/css rel=stylesheet>
</head>
<body bgcolor=white>
<h3>Chat Guide Log for $Pdate<br><font color=#990000>$srvr</font> Community</h3>
<p>Click here for activity sorted by <a href=#guide>guide name</a>
<table border=0>
<tr>
<th align=center>Guide Name</th>
<th align=center>Action</th>
<th align=center>Time</th>
<th align=center>On Duty</th>
<th align=center>IP address</th>
</tr>
<tr>
HDR

$on = 0;
open (GREP, "<$G_logFile") || die "Can't open $G_logFile : $!";
while (<GREP>) {
	if (/"$pre1[^(]+\(local\)"/i || /"$pre2[^(]+\(local\)"/i) {
		next if (/resmon/);	# skip the lag monitors
		@words = split;
		if ($words[2] eq "enter" || $words[2] eq "exit") {

			$words[3] =~ /"([^"]+)\(local\)"/;
			$guide = $1;
			print HTML "<td>$guide</td>\n";

			print HTML "<td>$words[2]</td>\n";

			$words[1] =~ /^([^\]]+)\]/;
			$time = $1;
			$time =~ s/\]//;
			print HTML "<td>$time</td>\n";

			if ($words[2] eq "enter") {
				 $on++;
			} else {
				$on--;
				$on = 0 if ($on < 0);
			}
			print HTML "<td align=center>$on</td>\n";

			$ip = ($#words < 4) ? "-" : $words[4];
			print HTML "<td>$ip</td>\n";
			print HTML "</tr>\n";
		} elsif ($words[2] eq "navigate") {
			$words[3] =~ /"([^"]+)\(local\)"/;
			$guide = $1;
			$hn = $guide;
			$hn =~ tr/[A-Z]/[a-z]/;
			$guides{$hn} = $guide;
			eval (push(@$hn, $_));
		}
	}
}
close GREP;
print HTML "</table>\n";
print HTML "<hr><h3><a name=guide>Rooms Visited</a></h3>\n";
print HTML "<ul>\n";

foreach $hn (sort keys %guides) {
	print HTML "<li><a href=#$hn>$hn</a>\n";
}
print HTML "</ul>\n";
foreach $hn (sort keys %guides) {
	print HTML "<h3><a name=$hn>$hn</a></h3>\n";
	print HTML "<table border=0>\n";
	print HTML "<tr><th>Time</th><th>Room</th></tr>\n";
	eval {
		foreach $nav (@$hn) {
			@words = split(/\s+/, $nav, 5);
			$words[1] =~ /^([^\]]+)\]/;
			$time = $1;
			$time =~ s/\]//;
			print HTML "<tr><td>$time</td>\n";
			print HTML "<td>$words[4]</td></tr>\n";
		}
	print HTML "</table>\n";
	};
}
print HTML "</body></html>\n";
close HTML;
