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
$ctr = 200;
$i = 1;
$G_isql_exe = "/u/vplaces/s/sybase/bin/isql -w 300 -U$dbName -P$dbPw -SSYBASE";
$G_statdir = "/tmp/";
$tempsql = $G_statdir . ".temp.sql.$$";
$ENV{'SYBASE'} ||= '/u/vplaces/s/sybase';

open (SQL_IN, ">$tempsql") || die "Can't write to $tempsql : $!\n";

while (<STDIN>) {
	next if (/^GO/);

        print;
        print SQL_IN;
	$i++;
	if ($i > $ctr) {
		$i = 1;
        	print SQL_IN "GO\n";
                close SQL_IN;

                open (SQL_OUT, "$G_isql_exe -i $tempsql |") || die "Can't read from $G_isql_exe -i $tempsql : $!\n";

                while (<SQL_OUT>) {
                        print;
                }
                close SQL_OUT;
                open (SQL_IN, ">$tempsql") || die "Can't write to $tempsql : $!\n";

        }
}
print SQL_IN "GO\n";
close SQL_IN;
open (SQL_OUT, "$G_isql_exe -i $tempsql |") || die "Can't read from $G_isql_exe -i $tempsql : $!\n";
while (<SQL_OUT>) {
   print;
}
close SQL_OUT;
unlink($tempsql);
