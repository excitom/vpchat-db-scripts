#!/usr/local/bin/perl
#
# Execute an arbitrary sequence of SQL commands and return the results
# to stdout.
#
# Tom Lang 3/98
#
if ($#ARGV == -1) {
	$dbName = 'vpusr';
	$dbPw = 'vpusr1';
} else {
	$dbName = $ARGV[0];
	$dbPw = $ARGV[1];
}

$G_isql_exe = "/u/vplaces/s/sybase/bin/isql -w 600 -U$dbName -P$dbPw -SSYBASE";
$G_statdir = "/tmp/";
$tempsql = $G_statdir . ".temp.sql.$$";
$ENV{'SYBASE'} ||= '/u/vplaces/s/sybase';

open (SQL_IN, ">$tempsql") || die "Can't write to $tempsql : $!\n";

#
# stdin should contain a sequence of SQL commands
#
while (<STDIN>) {
	chomp;
	s/  *//g;
	print "deleteUser '$_'\n";
	print SQL_IN "deleteUser '$_'\ngo\n";
		close SQL_IN;

		open (SQL_OUT, "$G_isql_exe -i $tempsql |") || die "Can't read from $G_isql_exe -i $tempsql : $!\n";

		while (<SQL_OUT>) {
			print;
		}
		close SQL_OUT;
	open (SQL_IN, ">$tempsql") || die "Can't write to $tempsql : $!\n";
}
unlink($tempsql);
