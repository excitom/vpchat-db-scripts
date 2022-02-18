#!/usr/local/bin/perl
#
# Tom Lang 3/98
#
$G_isql_exe = '/u/vplaces/s/sybase/bin/isql -Uvpusr -Pvpusr1 -SSYBASE';
$G_statdir = "/tmp/";
$tempsql = $G_statdir . ".temp.sql.$$";

$ENV{'SYBASE'} ||= '/u/vplaces/s/sybase';

while (<STDIN>) {
	chop;
	$name = $_;
	$sql_cmd = qq|penalize \"$name\",2,\"Kick\",260000,\"vpmanager\",2,"keep happy hour crowd in vpadult\",0,-6\ngo\n|;

	open (SQL_IN, ">$tempsql") || die "Can't write to $tempsql : $!\n";
	print SQL_IN $sql_cmd;
	close SQL_IN;

	open (SQL_OUT, "$G_isql_exe -i $tempsql |") || die "Can't read from $G_isql_exe -i $tempsql : $!\n";

	while (<SQL_OUT>) {
		print;
	}
	chop;
	close SQL_OUT;
}
unlink($tempsql);
