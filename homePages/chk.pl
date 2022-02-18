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
while (<STDIN>) {
	chomp;

	print SQL_IN <<SQL;
select 'XX',users.userID, nickName from users,registration,userAccounts
where nickName='$_'
and users.userID=registration.userID
and registration.accountID=userAccounts.accountID
and accountStatus = 2
go
SQL
}
	close SQL_IN;

	open (SQL_OUT, "$G_isql_exe -i $tempsql |") || die "Can't read from $G_isql_exe -i $tempsql : $!\n";

	while (<SQL_OUT>) {
		next unless(/XX/);
		chomp;
		($junk, $userID, $URL) = split;
		print "$userID $URL\n";
		$url{$userID} = $URL;
	}
foreach $userID (keys %url) {
	$name = $url{$userID};
	open (SQL_IN, ">$tempsql") || die "Can't write to $tempsql : $!\n";
	print SQL_IN "exec vpplaces..addHomePage $userID, 10, 2048, \"$name\"\ngo\n";
	#print SQL_IN "exec vpplaces..delHomePage $userID\ngo\n";
	close SQL_IN;
	open (SQL_OUT, "$G_isql_exe -i $tempsql |") || die "Can't read from $G_isql_exe -i $tempsql : $!\n";
	while (<SQL_OUT>) {
		print;
	}
}
unlink($tempsql);
