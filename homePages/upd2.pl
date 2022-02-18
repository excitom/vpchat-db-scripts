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
select 'XX',registration.userID,URL from registration,vpplaces..homePages
where accountID in
(select accountID from userAccounts where accountStatus !=0 and accountStatus != 2)
and registration.userID=vpplaces..homePages.userID
and deleted=0
go
SQL
	close SQL_IN;

	open (SQL_OUT, "$G_isql_exe -i $tempsql |") || die "Can't read from $G_isql_exe -i $tempsql : $!\n";

	while (<SQL_OUT>) {
		next unless(/XX/);
		chomp;
		($junk, $userID) = split;
		print "$userID\n";
		$URL = <SQL_OUT>;
		chomp $URL;
		$URL =~ s/^\s+//;
		$URL =~ s/\s+$//;
		$urls{$userID} = $URL;
	}
open (SQL_IN, ">$tempsql") || die "Can't write to $tempsql : $!\n";
foreach $u (keys %urls) {
	print SQL_IN <<SQL;
exec vpplaces..updateHomePage $u, 'L', 1, "$urls{$u}"
go
SQL
}
close SQL_IN;

open (SQL_OUT, "$G_isql_exe -i $tempsql |") || die "Can't read from $G_isql_exe -i $tempsql : $!\n";

while (<SQL_OUT>) {
	print;
}
unlink($tempsql);
