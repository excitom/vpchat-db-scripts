#!/usr/local/bin/perl
#
# Tom Lang 6/98
#
$G_isql_exe = '/t/t/s/sybase/bin/isql -Uvpusr -Pvpusr1 -SSYBASE';
$G_statdir = "/tmp/";
$tempsql = $G_statdir . ".temp.sql.$$";

$ENV{'SYBASE'} ||= '/t/t/s/sybase';

$sql_cmd = qq|showPrivileges Hosting\ngo\n|;

open (SQL_IN, ">$tempsql") || die "Can't write to $tempsql : $!\n";
print SQL_IN $sql_cmd;
close SQL_IN;

open (SQL_OUT, "$G_isql_exe -i $tempsql |") || die "Can't read from $G_isql_exe -i $tempsql : $!\n";

while (<SQL_OUT>) {
	print;
}
close SQL_OUT;
unlink($tempsql);
