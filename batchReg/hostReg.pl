#!/usr/local/bin/perl
#
# Tom Lang 9/2000
#
$G_isql_exe = '/u/vplaces/s/sybase/bin/isql -Uvpusr -Pvpusr1 -SSYBASE';
$G_statdir = "/tmp/";
$tempsql = $G_statdir . ".temp.sql.$$";
$ENV{'SYBASE'} ||= '/u/vplaces/s/sybase';

open (LIST, ">>pal.list") || die "Can't append to pal.list : $!";

open (SQL_IN, ">$tempsql") || die "Can't write to $tempsql : $!\n";
srand(time ^ $$ ^ unpack "%32L*", `ps -aef | /usr/local/bin/gzip`);
while (<STDIN>) {
	chomp;
	($name, $password) = split;
	$email = "$name\@host";

	print qq|$name	$email	$password\n|;
	print LIST qq|$name	$email	$password\n|;
	#
	print SQL_IN qq|registerNewUser "$name","$email","$password"\n|;
	print SQL_IN "go\n";
}
print SQL_IN "checkpoint\ngo\n";
close SQL_IN;

print  "$G_isql_exe -i $tempsql \n";
open (SQL_OUT, "$G_isql_exe -i $tempsql |") || die "Can't read from $G_isql_exe -i $tempsql : $!\n";

while (<SQL_OUT>) {
	print;
}
close SQL_OUT;
close LIST;
unlink($tempsql);
