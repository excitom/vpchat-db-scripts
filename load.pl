#!/usr/local/bin/perl
#
#
if ($#ARGV == -1) {
	$dbName = 'vpusr';
	$dbPw = 'vpusr1';
} else {
	$dbName = $ARGV[0];
	$dbPw = $ARGV[1];
}

$G_isql_exe = "/u/vplaces/s/sybase/bin/isql -U$dbName -P$dbPw -SSYBASE";
$G_statdir = "/tmp/";
$tempsql = $G_statdir . ".temp.sql.$$";
$ENV{'SYBASE'} ||= '/u/vplaces/s/sybase';


while (<STDIN>) {
	chomp;
	$name = $_;
	open (SQL_IN, ">$tempsql") || die "Can't write to $tempsql : $!\n";
	print SQL_IN <<SQL;
select "X",userAccounts.accountID, users.userID, accountStatus
from users,registration,userAccounts
where users.userID=registration.userID
and registration.accountID=userAccounts.accountID
and nickName="$name"
go
SQL
	close SQL_IN;

	print  "$G_isql_exe -i $tempsql \n";

	open (SQL_OUT, "$G_isql_exe -i $tempsql |") || die "Can't read from $G_isql_exe -i $tempsql : $!\n";

	while (<SQL_OUT>) {
		if (/0 rows/) {
			print <<SQL;
DELETE $name
SQL
			next;
		}
		if (/X/) {
			print $name;
			print;
		}
	}
	close SQL_OUT;
}
unlink($tempsql);
