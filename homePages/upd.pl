#!/usr/local/bin/perl
#
# Execute an arbitrary sequence of SQL commands and return the results
# to stdout.
#
# Tom Lang 3/98
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

	open (SQL_IN, ">$tempsql") || die "Can't write to $tempsql : $!\n";
	print SQL_IN <<SQL;
select 'XX',registration.userID from registration,vpplaces..homePages
where accountID=0
and registration.userID=vpplaces..homePages.userID
go
SQL
	close SQL_IN;

	open (SQL_OUT, "$G_isql_exe -i $tempsql |") || die "Can't read from $G_isql_exe -i $tempsql : $!\n";

	while (<SQL_OUT>) {
		next unless(/XX/);
		chomp;
		($junk, $userID, $URL) = split;
		print "$userID\n";
		push (@uids, $userID);
	}
open (SQL_IN, ">$tempsql") || die "Can't write to $tempsql : $!\n";
foreach $u (@uids) {
	print SQL_IN <<SQL;
exec vpplaces..delHomePage $u
go
SQL
}
close SQL_IN;

open (SQL_OUT, "$G_isql_exe -i $tempsql |") || die "Can't read from $G_isql_exe -i $tempsql : $!\n";

while (<SQL_OUT>) {
	print;
}
unlink($tempsql);
