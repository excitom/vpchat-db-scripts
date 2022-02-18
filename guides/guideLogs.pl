#!/usr/bin/perl
#
# Build nice web page containing chat guide logs
#
# Tom Lang 6/98

use Date::Manip;

#################
#
# Subroutine: process months days in a month
#
sub doMonth {
	my $yr = shift @_;
	my $month = shift @_;
	my $srvr = shift @_;

	open (MONTH, ">$yr/$month/index.html") || die "Can't make $yr/$month/index.html: $!";
	print MONTH <<X;
<html>
<head>
<title>
HalSoft Chat Guide Logs for $monthNames[$month], $yr
</title>
<META http-equiv=Content-Type content="text/html; charset=windows-1252">
<LINK href="/layout.css" type=text/css rel=stylesheet>
</head>
<body bgcolor=white>
<h3><font color=#990000>$srvr</font> Chat Guide Logs for $monthNames[$month], $yr</h3>
<ul>
X

	opendir THIS, "$G_srcDir/$yr/$month" || die "Can't read $G_srcDir/$yr/$month: $!";
	my @days = grep /^activity.log.\d+.html$/, readdir THIS;
	close THIS;

	my $day;
	my $dayName;
	my (%days, %files, @name, $y, $Y, $m, $d);
	foreach $day (@days) {
		@name = split('\.', $day);
		$m = substr($name[2],0,2);
		$d = substr($name[2],2,2);
		$y = substr($name[2],4,length($name[2]-4));
		$Y = $y + 1900;
		$date = $m . $d . $y;
		$G_dateDir = "$Y/$m";
		$dayName = $Y . "-" . $m . "-" . $d;
		$days{"$y$m$d"} = $dayName;
		$files{"$y$m$d"} = $day;
	}
	foreach $day (sort keys %days) {
		print MONTH qq!<li><a href="$files{$day}">$days{$day}</a>\n!;
	}

	print MONTH <<Y;
</ul>
</body>
</html>
Y
	close MONTH;
}

#################
#
# Subroutine: process months in a year
#
sub doYear {
	my $yr = shift @_;
	my $srvr = shift @_;

	open (YEAR, ">$yr/index.html") || die "Can't make $yr/index.html: $!";
	print YEAR <<X;
<html>
<head>
<title>
HalSoft Chat Guide Logs for $yr
</title>
<META http-equiv=Content-Type content="text/html; charset=windows-1252">
<LINK href="/layout.css" type=text/css rel=stylesheet>
</head>
<body bgcolor=white>
<h3><font color=#990000>$srvr</font> Chat Guide Logs for $yr</h3>
<ul>
X

	my ($m,$month);
	for ($m = 1; $m < 13; $m++) {
		$month = sprintf("%2.2d", $m);
		next unless(-d "$G_srcDir/$yr/$month");
		print YEAR qq!<li><a href="$month/index.html">$monthNames[$month]</a>\n!;
		&doMonth( $yr, $month, $srvr );
	}

	print YEAR <<Y;
</ul>
</body>
</html>
Y
	close YEAR;
}

####################
#
# START HERE
#

$host = `hostname`;
chomp $host;
if ($host eq 'anne') {
  $srvr = 'vpchat';
} else {
  $srvr = 'vpadult';
}

@monthNames = ( "-", "January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December");

$G_srcDir = "/web/cmgmt/html/guides/$srvr";
chdir $G_srcDir;

$G_htmlDir = "/web/cmgmt/html/guides/$srvr";

opendir THIS, $G_srcDir || die "Can't read $G_srcDir: $!";
@logFiles = grep /^activity.log.\d+.html$/, readdir THIS;
close THIS;

foreach $logFile (@logFiles) {
	@name = split('\.', $logFile);
	$m = substr($name[2],0,2);
	$d = substr($name[2],2,2);
	$y = substr($name[2],4,length($name[2]-4));
	$Y = $y + 1900;
	$date = $m . $d . $y;

	`mkdir $Y` unless (-d $Y);
	`mkdir "$Y/$m"` unless (-d "$Y/$m");
	`mv $logFile $Y/$m/$logFile`;
}
open (HTML, ">index.html") || die "Can't make index.html: $!";
print HTML <<X;
<html>
<head>
<title>
HalSoft Chat Guide Logs
</title>
<META http-equiv=Content-Type content="text/html; charset=windows-1252">
<LINK href="/layout.css" type=text/css rel=stylesheet>
</head>
<body bgcolor=white>
<h3>Chat Guide Logs for the <font color=#990000>$srvr</font> Community</h3>
<ul>
X

opendir THIS, $G_srcDir || die "Can't read $G_srcDir: $!";
@yrs = grep /^\d+\d+\d+\d+$/, readdir THIS;
close THIS;

foreach $yr (@yrs) {
	print HTML qq!<li><a href="$yr/index.html">$yr</a>\n!;
	&doYear( $yr, $srvr );
}

print HTML <<Y;
</ul>
</body>
</html>
Y
close HTML;
