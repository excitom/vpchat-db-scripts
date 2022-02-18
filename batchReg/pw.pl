#!/usr/local/bin/perl
#
# Tom Lang 3/98
#
	$G_isql_exe = '/t/t/s/sybase/bin/isql -Uvpusr -Pvpusr1 -SSYBASE';
	$G_statdir = "/tmp/";
	$tempsql = $G_statdir . ".temp.sql.$$";

	$ENV{'SYBASE'} ||= '/t/t/s/sybase';

	for ($i = 10; $i < 300; $i++) {
		open (SQL_IN, ">$tempsql") || die "Can't write to $tempsql : $!\n";
		$cmd = qq|select userID from users where nickName = "xcit_ctest$i"\ngo\n|;
		print $cmd;
		print SQL_IN $cmd;
		close SQL_IN;
		print  "$G_isql_exe -i $tempsql \n";
		open (SQL_OUT, "$G_isql_exe -i $tempsql |") || die "Can't read from $G_isql_exe -i $tempsql : $!\n";

		while (<SQL_OUT>) {
			last if (/---/);
		}
		$userID = <SQL_OUT>;
		chop $userID;
		$userID =~ s/\s+//g;
		close SQL_OUT;
		open (SQL_IN, ">$tempsql") || die "Can't write to $tempsql : $!\n";
		$cmd = qq|update registration set password="abcdef" where userID=$userID\ngo\n|;
		print $cmd;
		print SQL_IN $cmd;
		close SQL_IN;
		print  "$G_isql_exe -i $tempsql \n";
		open (SQL_OUT, "$G_isql_exe -i $tempsql |") || die "Can't read from $G_isql_exe -i $tempsql : $!\n";

		while (<SQL_OUT>) {
			print;
		}
		close SQL_OUT;
   	}

	unlink($tempsql);
