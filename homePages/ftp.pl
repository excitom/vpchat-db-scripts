#!/usr/local/bin/perl
	$dbName = 'vpusr';
	$dbPw = 'vpusr1';

$G_isql_exe = "/u/vplaces/s/sybase/bin/isql -U$dbName -P$dbPw -SSYBASE";
$G_statdir = "/tmp/";
$tempsql = $G_statdir . ".temp.sql.$$";
$ENV{'SYBASE'} ||= '/u/vplaces/s/sybase';

	open (SQL_IN, ">$tempsql") || die "Can't write to $tempsql : $!\n";
	print SQL_IN <<SQL;
SELECT 'XX',users.userID,nickName,password FROM registration,users
WHERE users.userID IN
(SELECT userID FROM vpplaces..homePages WHERE deleted = 0)
AND users.userID=registration.userID
GO
SQL
	close SQL_IN;

	open (SQL_OUT, "$G_isql_exe -i $tempsql |") || die "Can't read from $G_isql_exe -i $tempsql : $!\n";

	while (<SQL_OUT>) {
		next unless(/XX/);
		chomp;
		($junk, $userID, $nickName, $password) = split;
		$nickNames{$userID} = $nickName;
		$passwords{$userID} = $password;
	}
close SQL_OUT;
unlink($tempsql);

$maxSpace = 10*1024;
foreach $u (keys %nickNames) {
	my $pwEntry = join(':', $nickNames{$u}, $passwords{$u}, $u, 60001, $nickNames{$u}, "/export/home/members/$nickNames{$u}", "/bin/false", "$maxSpace" );
print "$pwEntry\n";
  `/usr/local/sbin/ncftpd_passwd -f /usr/local/etc/ncftpd/passwd.db -c -u \"$pwEntry\"`;
}
