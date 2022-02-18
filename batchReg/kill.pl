#!/usr/local/bin/perl
#
# Tom Lang 3/98
#
$G_isql_exe = '/t/t/s/sybase/bin/isql -Uvpusr -Pvpusr1 -SSYBASE';
$G_statdir = "/tmp/";
$tempsql = $G_statdir . ".temp.sql.$$";

$ENV{'SYBASE'} ||= '/t/t/s/sybase';
open (SQL_IN, ">$tempsql") || die "Can't write to $tempsql : $!\n";
$i=1;
while (<STDIN>) {
	next unless (/^\s*\d/);
	@line = split;
	$name = $line[1];
	print "Deleting - $name\n";

	print SQL_IN qq|deleteUser "$name"\n|;
	print SQL_IN "go\n";
	if ($i++ % 100 == 0) {
		close SQL_IN;

		print  "$G_isql_exe -i $tempsql \n";
		open (SQL_OUT, "$G_isql_exe -i $tempsql |") || die "Can't read from $G_isql_exe -i $tempsql : $!\n";

		while (<SQL_OUT>) {
			print;
		}
		close SQL_OUT;
		open (SQL_IN, ">$tempsql") || die "Can't write to $tempsql : $!\n";
	}
}
unlink($tempsql);
