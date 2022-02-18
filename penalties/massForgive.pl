#!/usr/local/bin/perl
#
# Clean out old junk
#
# Tom Lang 6/2001
#

$G_isql_exe = '/u/vplaces/s/sybase/bin/isql -Uvpusr -Pvpusr1 -SSYBASE';
$G_statdir = "/tmp/";
$tempsql = $G_statdir . ".temp.sql.$$";
$ENV{'SYBASE'} ||= '/u/vplaces/s/sybase';

if ($#ARGV == -1) {
	print "You forgot to give the date\n";
	exit;
}

open (SQL_IN, ">$tempsql") || die "Can't write to $tempsql : $!\n";

print SQL_IN "select penaltyID from penalties where forgiven = 0 and issuedOn < '" . $ARGV[0] . "'\ngo\n";
close SQL_IN;

print  "$G_isql_exe -i $tempsql \n";

open (SQL_OUT, "$G_isql_exe -i $tempsql |") || die "Can't read from $G_isql_exe -i $tempsql : $!\n";

while (<SQL_OUT>) {
	last if (/^\s*\d+\s*$/);
}
chomp;
push(@penalties, $_);
while (<SQL_OUT>) {
	last if (/rows affected/);
	last if (/^\s*$/);
	chomp;
	push(@penalties, $_);
}
close SQL_OUT;
open (SQL_IN, ">$tempsql") || die "Can't write to $tempsql : $!\n";

if ($#penalties <= 0) {
	print "No penalties to forgive since $ARGV[0]\n";
	exit;
}
foreach $penalty (@penalties) {
	print "Forgiving $penalty\n";
	print SQL_IN "forgivePenalty $penalty\ngo\n";
}
close SQL_IN;

print  "$G_isql_exe -i $tempsql \n";

open (SQL_OUT, "$G_isql_exe -i $tempsql |") || die "Can't read from $G_isql_exe -i $tempsql : $!\n";

while (<SQL_OUT>) {
	print;
}
close SQL_OUT;
unlink($tempsql);
