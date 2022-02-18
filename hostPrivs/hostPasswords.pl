#!/usr/local/bin/perl
#
# Tom Lang 9/98
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

$_ = <SQL_OUT>;		# skip headers
$_ = <SQL_OUT>;
while (<SQL_OUT>) {
	last if (/^\s*$/);
	($nickName, $mode, $priv) = split;
	push(@nickNames, $nickName);
}
close SQL_OUT;
foreach $nickName (@nickNames) {
	$sql_cmd = qq|select password from registration,users where nickName="$nickName" and users.userID = registration.userID\ngo\n|;
	open (SQL_IN, ">$tempsql") || die "Can't write to $tempsql : $!\n";
	print SQL_IN $sql_cmd;
	close SQL_IN;

	open (SQL_OUT, "$G_isql_exe -i $tempsql |") || die "Can't read from $G_isql_exe -i $tempsql : $!\n";
	while (<SQL_OUT>) {
		print "$nickName: $_";
	}
	close SQL_OUT;
}
unlink($tempsql);
