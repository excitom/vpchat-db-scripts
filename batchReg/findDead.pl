#!/usr/local/bin/perl
#
# Tom Lang 4/98
#
	$G_isql_exe = '/t/t/s/sybase/bin/isql -Uvpusr -Pvpusr1 -SSYBASE';
	$G_statdir = "/tmp/";
	$tempsql = $G_statdir . ".temp.sql.$$";

	$ENV{'SYBASE'} ||= '/t/t/s/sybase';

	open (SQL_IN, ">$tempsql") || die "Can't write to $tempsql : $!\n";
	print SQL_IN qq|select registration.userID,nickName,registrationDate,lastSignOnDate from registration,users where registration.userID=users.userID and lastSignOnDate is NULL\n|;
	print SQL_IN "go\n";
	close SQL_IN;

	print  "$G_isql_exe -i $tempsql \n";
	open (SQL_OUT, "$G_isql_exe -i $tempsql |") || die "Can't read from $G_isql_exe -i $tempsql : $!\n";

	while (<SQL_OUT>) {
		print;
	}
	close SQL_OUT;
	unlink($tempsql);
