#!/usr/local/bin/perl
#
# Tom Lang 6/98
#
$G_isql_exe = '/t/t/s/sybase/bin/isql -Uvpusr -Pvpusr1 -SSYBASE';
$G_statdir = "/tmp/";
$tempsql = $G_statdir . ".temp.sql.$$";

$ENV{'SYBASE'} ||= '/t/t/s/sybase';

while (<STDIN>) {
	chop;
	($name, $junk) = split;
	$sql_cmd = qq|select nickName,password,email from registration,users where nickName="$name" and users.userID=registration.userID\ngo\n|;

	open (SQL_IN, ">$tempsql") || die "Can't write to $tempsql : $!\n";
	print SQL_IN $sql_cmd;
	close SQL_IN;

	open (SQL_OUT, "$G_isql_exe -i $tempsql |") || die "Can't read from $G_isql_exe -i $tempsql : $!\n";

	while (<SQL_OUT>) {
		last if (/---/);
	}
	while (<SQL_OUT>) {
		last unless (/---/);
	}
	chop;
	($nickName, $password) = split;
	chop;
	$email = <SQL_OUT>;
	$email =~ s/\s+//g;;
$email = "$name\@excite.com";
	print ">$nickName<>$password<>$email<\n";
	close SQL_OUT;

	$sql_cmd = qq|registerNewUser "$nickName","$email","$password"\n|;
	$sql_cmd .= "go\n";
	$sql_cmd .= qq|addPrivilege "$nickName",2,273|;
	$sql_cmd .= "go\n";

	open (SQL_IN, ">$tempsql") || die "Can't write to $tempsql : $!\n";
	print SQL_IN $sql_cmd;
	close SQL_IN;
	open (SQL_OUT, "$G_isql_exe -i $tempsql |") || die "Can't read from $G_isql_exe -i $tempsql : $!\n";

	while (<SQL_OUT>) {
		print;
	}
	close SQL_OUT;
}
unlink($tempsql);
