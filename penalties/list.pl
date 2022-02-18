#!/usr/local/bin/perl
#
# Tom Lang 10/98
#
use Date::Manip;

###################
#
# Subroutine: cleanup and exit
#
sub CLEANUP {
   `rm -f $G_tmpsql`;
   exit;
}

###################
#
# START HERE
#

$SIG{'INT'} = \&CLEANUP;
$SIG{'HUP'} = \&CLEANUP;
$SIG{'QUIT'} = \&CLEANUP;
$SIG{'PIPE'} = \&CLEANUP;
$SIG{'ALRM'} = \&CLEANUP;

$today = substr ( ParseDate('today'), 0, 8);

$SYBASE = '/u/vplaces/s/sybase';
$G_isql_exe = $SYBASE . '/bin/isql -Uvpusr -Pvpusr1 -SSYBASE';
$G_statdir = "/tmp/";
$G_tmpsql = $G_statdir . ".temp.sql.$$";
$outFile = $G_statdir . "penalties." . $today;

$ENV{'SYBASE'} ||= $SYBASE;

$showPenalties = 1;
$showWarnings = 0;
$showExpired = 1;
$dummy = "X";
$sql_cmd = "showPenalties $showPenalties,$showWarnings,$showExpired,$dummy\ngo\n";
open (SQL_IN, ">$G_tmpsql") || die "Can't write to $G_tmpsql : $!\n";
print SQL_IN $sql_cmd;
close SQL_IN;

open (SQL_OUT, "$G_isql_exe -i $G_tmpsql |") || die "Can't read from $G_isql_exe -i $G_tmpsql : $!\n";

open (OUT, ">$outFile") || die "Can't create $outFile : $!";

while (<SQL_OUT>) {
	last if (/--------/);
}
while (<SQL_OUT>) {
	last unless (/--------/);
}
$_ = <SQL_OUT>;
while (<SQL_OUT>) {
	chomp;
	($id,$name,$mode,$penalty) = split;
	$_ = <SQL_OUT>;
	chomp;
	@x = split;
	$exp = pop @x;
	$hm = pop @x;
	$host = pop @x;
	$date = join("\t",@x);
	$d = &ParseDate($date);
	$date = &DateCalc($d, "-6 hours");
	print OUT join("\t",$date,$host,$name,$penalty,$exp) . "\n";
}

print "OUTPUT is in $G_tmpsql\n";
