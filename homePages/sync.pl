#!/usr/bin/perl
#
# synchronize the password database with NcFTPd and find dead
# member pages
#
# Tom Lang 2/2002
#
$dbName = 'vpusr';
$dbPw = 'vpusr1';

$G_isql_exe = "/u/vplaces/s/sybase/bin/isql -U$dbName -P$dbPw -SSYBASE";
$G_statdir = "/tmp/";
$tempsql = $G_statdir . ".temp.sql.$$";
$ENV{'SYBASE'} ||= '/u/vplaces/s/sybase';


while (<STDIN>) {
	chomp;
	$name = $_;
	open (SQL_IN, ">$tempsql") || die "Can't write to $tempsql : $!\n";
	print SQL_IN <<SQL;
SELECT 'X',accountStatus,users.userID,password
FROM users,registration,userAccounts
WHERE nickName = "$name"
AND users.userID=registration.userID
AND userAccounts.accountID=registration.accountID
AND deleteDate IS NULL
GO
SQL
	close SQL_IN;
	open (SQL_OUT, "$G_isql_exe -i $tempsql |") || die "Can't read from $G_isql_exe -i $tempsql : $!\n";

	$userID = -1;
	while (<SQL_OUT>) {
		if (/X/) {
			chomp;
			($junk, $accountStatus,$userID, $password) = split;
		}
	}
	close SQL_OUT;
	if ($userID == -1) {
		print "$name DELETED\n";
	} else {
	   if (($accountStatus != 0) && ($accountStatus != 2)) {
		print "$name CLOSED/SUSPENDED\n";
	   } else {
  		my $pwEntry = join(':', $name, $password, $userID, 60001, $name, "/export/home/members/$name", "/bin/false");
  		`/usr/local/bin/ssh nobody\@nala "/usr/local/bin/ncftpd_passwd -f /usr/local/etc/ncftpd/passwd.db -c -a \"$pwEntry\""`;
		print "$name $userID UPDATED FTP\n";
	   }
	}
	
}

unlink($tempsql);
