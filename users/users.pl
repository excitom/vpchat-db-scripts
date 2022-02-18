#!/usr/local/bin/perl -w
#
# show peak chat and PAL users, and minutes of usage
#
# Tom Lang 2/98
#

use Date::Manip;
use Getopt::Long;
use vars qw(
$OPT_date
$G_exportdir
);

(
$OPT_date,
$G_exportdir
) = (''x2);

####################
#
# START HERE
#

$input_date = ($#ARGV == 0) ? $ARGV[0] : "yesterday";
$G_isql_exe = '/u/vplaces/s/sybase/bin/isql -SSYBASE -Uvpplaces -Pvpplaces';
$G_statdir = '/u/vplaces/scripts/users/';
$G_exportdir = '/logs/users/';
$G_statsFile = $G_exportdir . "users.txt";

if ($input_date eq "yesterday") {
	#
	# clean out old HTML files
	#
	$oldDate = &ParseDate('last week');
	$old = &UnixDate($oldDate, '%Q');
	$outfn = join('', $G_exportdir, $old, ".users.html");
	unlink $outfn if (-f $outfn);
}

@hours = (
"12am","1am","2am","3am","4am","5am","6am","7am","8am","9am","10am","11am",
"12pm","1pm","2pm","3pm","4pm","5pm","6pm","7pm","8pm","9pm","10pm","11pm"
);

$TZ = `date "+%Z"`;
$offset = ($TZ =~ "DT") ? 7 : 8;	# offset from GMT
$OPT_date = &ParseDate("$input_date $offset:00:00");
($G_date, $out) = &UnixDate($OPT_date, '%F', '%Q');
$G_start = &UnixDate($OPT_date, '%d %b %Y %H:%M');
$G_end = &UnixDate(DateCalc($OPT_date, "+23 hours"), '%d %b %Y %H:%M');

$tempsql = $G_statdir . ".temp.sql.$$";
$ENV{'SYBASE'} ||= '/t/t/s/sybase';

$sql_cmd = qq|getHourlyAvgStatistics "$G_start", "$G_end"\ngo\n|;
open (SQL_IN, ">$tempsql") || die "Can't write to $tempsql : $!\n";
print SQL_IN $sql_cmd;
close(SQL_IN);

open (SQL_OUT, "$G_isql_exe -i $tempsql |") || die "Can't read from $G_isql_exe -i $tempsql : $!\n";
@lines = <SQL_OUT>;
close SQL_OUT;

$h = 0;
$avgCombinedMax = $avgChatMax = $avgPALMax = 0;
$avgCombinedMin = $avgChatMin = $avgPALMin = 99999999;
for ($i = 0; $i <= $#lines; ) {
	$_ = $lines[$i++];
	next unless (/^\s*\d/);
	chomp;
	@data = split;
	$avgCombined[$h] = $data[4] + 0;
	$avgChat[$h] = $data[5] + 0;
	$_ = $lines[$i++];
	chomp;
	$avgPAL[$h] = $_ + 0;
	if ($avgCombined[$h] > $avgCombinedMax) {
		$avgCombinedMax = $avgCombined[$h];
		$avgCombinedMaxH = $h;
	}
	if ($avgCombined[$h] < $avgCombinedMin) {
		$avgCombinedMin = $avgCombined[$h];
		$avgCombinedMinH = $h;
	}
	if ($avgChat[$h] > $avgChatMax) {
		$avgChatMax = $avgChat[$h];
		$avgChatMaxH = $h;
	}
	if ($avgChat[$h] < $avgChatMin) {
		$avgChatMin = $avgChat[$h];
		$avgChatMinH = $h;
	}
	if ($avgPAL[$h] > $avgPALMax) {
		$avgPALMax = $avgPAL[$h];
		$avgPALMaxH = $h;
	}
	if ($avgPAL[$h] < $avgPALMin) {
		$avgPALMin = $avgPAL[$h];
		$avgPALMinH = $h;
	}
	$h++;
}

$sql_cmd = qq|getHourlyMaxStatistics "$G_start", "$G_end"\ngo\n|;
$tempsql = $G_statdir . ".temp.sql.$$";

$ENV{'SYBASE'} ||= '/t/t/s/sybase';

open (SQL_IN, ">$tempsql") || die "Can't write to $tempsql : $!\n";
print SQL_IN $sql_cmd;
close(SQL_IN);

open (SQL_OUT, "$G_isql_exe -i $tempsql |") || die "Can't read from $G_isql_exe -i $tempsql : $!\n";
@lines = <SQL_OUT>;
close SQL_OUT;

$h = 0;
$maxCombinedMax = $maxChatMax = $maxPALMax = 0;
$maxCombinedMin = $maxChatMin = $maxPALMin = 99999999;
for ($i = 0; $i <= $#lines; ) {
	$_ = $lines[$i++];
	next unless (/^\s*\d/);
	chomp;
	@data = split;
	$maxCombined[$h] = $data[4] + 0;
	$maxChat[$h] = $data[5] + 0;
	$_ = $lines[$i++];
	chomp;
	$maxPAL[$h] = $_ + 0;
	if ($maxCombined[$h] > $maxCombinedMax) {
		$maxCombinedMax = $maxCombined[$h];
		$maxCombinedMaxH = $h;
	}
	if ($maxCombined[$h] < $maxCombinedMin) {
		$maxCombinedMin = $maxCombined[$h];
		$maxCombinedMinH = $h;
	}
	if ($maxChat[$h] > $maxChatMax) {
		$maxChatMax = $maxChat[$h];
		$maxChatMaxH = $h;
	}
	if ($maxChat[$h] < $maxChatMin) {
		$maxChatMin = $maxChat[$h];
		$maxChatMinH = $h;
	}
	if ($maxPAL[$h] > $maxPALMax) {
		$maxPALMax = $maxPAL[$h];
		$maxPALMaxH = $h;
	}
	if ($maxPAL[$h] < $maxPALMin) {
		$maxPALMin = $maxPAL[$h];
		$maxPALMinH = $h;
	}
	$h++;
}

$sql_cmd = qq|getHourlyMinStatistics "$G_start", "$G_end"\ngo\n|;
$tempsql = $G_statdir . ".temp.sql.$$";

$ENV{'SYBASE'} ||= '/t/t/s/sybase';

open (SQL_IN, ">$tempsql") || die "Can't write to $tempsql : $!\n";
print SQL_IN $sql_cmd;
close(SQL_IN);

open (SQL_OUT, "$G_isql_exe -i $tempsql |") || die "Can't read from $G_isql_exe -i $tempsql : $!\n";
@lines = <SQL_OUT>;
close SQL_OUT;

$h = 0;
$minCombinedMax = $minChatMax = $minPALMax = 0;
$minCombinedMin = $minChatMin = $minPALMin = 99999999;
for ($i = 0; $i <= $#lines; ) {
	$_ = $lines[$i++];
	next unless (/^\s*\d/);
	chomp;
	@data = split;
	$minCombined[$h] = $data[4] + 0;
	$minChat[$h] = $data[5] + 0;
	$_ = $lines[$i++];
	chomp;
	$minPAL[$h] = $_ + 0;
	if ($minCombined[$h] > $minCombinedMax) {
		$minCombinedMax = $minCombined[$h];
		$minCombinedMaxH = $h;
	}
	if ($minCombined[$h] < $minCombinedMin) {
		$minCombinedMin = $minCombined[$h];
		$minCombinedMinH = $h;
	}
	if ($minChat[$h] > $minChatMax) {
		$minChatMax = $minChat[$h];
		$minChatMaxH = $h;
	}
	if ($minChat[$h] < $minChatMin) {
		$minChatMin = $minChat[$h];
		$minChatMinH = $h;
	}
	if ($minPAL[$h] > $minPALMax) {
		$minPALMax = $minPAL[$h];
		$minPALMaxH = $h;
	}
	if ($minPAL[$h] < $minPALMin) {
		$minPALMin = $minPAL[$h];
		$minPALMinH = $h;
	}
	$h++;
}
$outfn = join('', $G_exportdir, $out, ".users.html");
$a = "#ffcccc";
$b = "#ccffcc";
$c = "#ccccff";
$hi = "#66ff66";
$lo = "#ff6666";

open (HTML, ">$outfn") || die "Can't write to $outfn : $!";
print HTML <<AVGTBL;
<html>
<head>
<title>PAL/Chat Usage by Hour</title>
</head>
<body bgcolor="#ffffff">
<h1>
PAL/Chat Usage by Hour
</h1>
<hr size=5>
<center><font size=-1>[ <a href="index.html">Daily Index</a> ] </font></center>
<hr>
<h3>$G_date $TZ</h3>
<p>
<table border=3>
<tr>
 <td rowspan=2>&nbsp;</td><th bgcolor=$a colspan=2>Combined</th><th bgcolor=$b colspan=2>Chat</th><th bgcolor=$c colspan=2>PAL</th>
</tr>
<tr>
 <th bgcolor=$a>Users</th><th bgcolor=$a>Hour</th><th bgcolor=$b>Users</th><th bgcolor=$b>Hour</th><th bgcolor=$c>Users</th><th bgcolor=$c>Hour</th>
</tr>
<tr>
 <th>Daily Minimum</th>
 <td bgcolor=$a align=right>$minCombinedMin</td>
 <td bgcolor=$a align=right>$hours[$minCombinedMinH]</td>
 <td bgcolor=$b align=right>$minChatMin</td>
 <td bgcolor=$b align=right>$hours[$minChatMinH]</td>
 <td bgcolor=$c align=right>$minPALMin</td>
 <td bgcolor=$c align=right>$hours[$minPALMinH]</td>
</tr>
<tr>
 <th>Daily Maximum</th>
 <td bgcolor=$a align=right>$maxCombinedMax</td>
 <td bgcolor=$a align=right>$hours[$maxCombinedMaxH]</td>
 <td bgcolor=$b align=right>$maxChatMax</td> 
 <td bgcolor=$b align=right>$hours[$maxChatMaxH]</td>
 <td bgcolor=$c align=right>$maxPALMax</td>
 <td bgcolor=$c align=right>$hours[$maxPALMaxH]</td>
</tr>
</table>
<table border=3>
<tr>
 <th colspan=10>Chat/PAL Users</th>
</tr>
<tr>
 <th align=center>&nbsp;</th>
 <th align=center colspan=3>Min Hourly Statistics</th>
 <th align=center colspan=3>Average Hourly Statistics</th>
 <th align=center colspan=3>Max Hourly Statistics</th>
</tr>
<tr>
 <th align=center>Hour</th>
 <th bgcolor=$a align=center>Combined</th>
 <th bgcolor=$b align=center>Chat</th>
 <th bgcolor=$c align=center>PAL</th>
 <th bgcolor=$a align=center>Combined</th>
 <th bgcolor=$b align=center>Chat</th>
 <th bgcolor=$c align=center>PAL</th>
 <th bgcolor=$a align=center>Combined</th>
 <th bgcolor=$b align=center>Chat</th>
 <th bgcolor=$c align=center>PAL</th>
</tr>
AVGTBL
for ( $h = 0; $h < 24; $h++ ){

	print HTML " <tr>\n <td align=right>$hours[$h]</td>\n";

	$bg = ($minCombinedMaxH == $h) ? $hi : $a;
	$bg = ($minCombinedMinH == $h) ? $lo : $bg;
	print HTML " <td align=right bgcolor=$bg>$minCombined[$h]</td>";
	$bg = ($minChatMaxH == $h) ? $hi : $b;
	$bg = ($minChatMinH == $h) ? $lo : $bg;
	print HTML " <td align=right bgcolor=$bg>$minChat[$h]</td>";
 	$bg = ($minPALMaxH == $h) ? $hi : $c;
	$bg = ($minPALMinH == $h) ? $lo : $bg;
	print HTML " <td align=right bgcolor=$bg>$minPAL[$h]</td>\n";

	$bg = ($avgCombinedMaxH == $h) ? $hi : $a;
	$bg = ($avgCombinedMinH == $h) ? $lo : $bg;
	print HTML " <td align=right bgcolor=$bg>$avgCombined[$h]</td>";
	$bg = ($avgChatMaxH == $h) ? $hi : $b;
	$bg = ($avgChatMinH == $h) ? $lo : $bg;
	print HTML " <td align=right bgcolor=$bg>$avgChat[$h]</td>";
 	$bg = ($avgPALMaxH == $h) ? $hi : $c;
	$bg = ($avgPALMinH == $h) ? $lo : $bg;
	print HTML " <td align=right bgcolor=$bg>$avgPAL[$h]</td>\n";

	$bg = ($maxCombinedMaxH == $h) ? $hi : $a;
	$bg = ($maxCombinedMinH == $h) ? $lo : $bg;
	print HTML " <td align=right bgcolor=$bg>$maxCombined[$h]</td>";
	$bg = ($maxChatMaxH == $h) ? $hi : $b;
	$bg = ($maxChatMinH == $h) ? $lo : $bg;
	print HTML " <td align=right bgcolor=$bg>$maxChat[$h]</td>";
 	$bg = ($maxPALMaxH == $h) ? $hi : $c;
	$bg = ($maxPALMinH == $h) ? $lo : $bg;
	print HTML " <td align=right bgcolor=$bg>$maxPAL[$h]</td>\n";

	print HTML "</tr>\n";
}
print HTML <<FTR;
</table>
</font>
</body>
</html>
FTR

unlink $tempsql;

#
# Append to .txt file (for easy Excel import)
# Note: We read and re-write, rather than simply append so that
# if this script is run more than once on the same day, only a single
# line per day is added to the file.
#
open (TXT, "<$G_statsFile");
while (<TXT>) {
	next if (/^#/);
	chop;
	($date, $mc, $mp) = split(/\t/, $_);
	$max_c{$date} = $mc;
	$max_p{$date} = $mp;
}
close TXT;
$max_c{$out} = $maxChatMax;	# add today's info
$max_p{$out} = $maxPALMax;

open (TXT, ">$G_statsFile") || die "Can't write $G_statsFile : $!";

print TXT <<HDR;
# Chat/PAL stats format
# - tab separated columns
# - columns contain:
#  -- date
#  -- peak chat users
#  -- peak PAL users
HDR

foreach $date (sort reverse keys %max_c) {
	print TXT join("\t", $date, $max_c{$date}, $max_p{$date}) . "\n";
}

close TXT;
exit 0;
