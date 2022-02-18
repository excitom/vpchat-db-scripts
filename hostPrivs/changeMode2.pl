#!/usr/local/bin/perl
#
# Tom Lang 7/98
#
# Change mode of registered users from 2(local) to 3(URS)
print "File containing mode 2 registrations in userID | name |mode format\n";
$mode2 = <>;
chop $mode2;
print "Output file\n";
$out = <>;
chop $out;

$G_isql_exe = '/t/t/s/sybase/bin/isql -Uvpusr -Pvpusr1 -SSYBASE';
$G_statdir = "/tmp/";
$tempsql = $G_statdir . ".temp.sql.$$";

$ENV{'SYBASE'} ||= '/t/t/s/sybase';

open(USERS, "<$mode2") || die "Can't open $mode2 : $!";
$batch = 0;
while (<USERS>) {
	chop;
	($userID, $name, $mode) = split;
	print "Changing mode for $name\n";
	$sql_cmd = qq|update users set registrationMode=3 where nickName="$name"\ngo\n|;

	unless($batch) {
		open (SQL_IN, ">$tempsql") || die "Can't write to $tempsql : $!\n";
	}
	print SQL_IN $sql_cmd;
	if ($batch++ > 49) {
		close SQL_IN;
		open (SQL_OUT, "$G_isql_exe -i $tempsql |") || die "Can't read from $G_isql_exe -i $tempsql : $!\n";

		while (<SQL_OUT>) {
			print;
		}
		close SQL_OUT;
		$batch = 0;
	}
}
close SQL_IN;
open (SQL_OUT, "$G_isql_exe -i $tempsql |") || die "Can't read from $G_isql_exe -i $tempsql : $!\n";

while (<SQL_OUT>) {
	print;
}
		close SQL_OUT;
unlink($tempsql);
