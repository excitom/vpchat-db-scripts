#!/usr/bin/perl
$dbName = 'vpusr';
$dbPw = 'vpusr1';

$G_isql_exe = "/u/vplaces/s/sybase/bin/isql -U$dbName -P$dbPw -SSYBASE";
$G_statdir = "/tmp/";
$tempsql = $G_statdir . ".temp.sql.$$";
$ENV{'SYBASE'} ||= '/u/vplaces/s/sybase';


opendir(DIR, "/logs/accounts");
@files = grep(!/^\./, readdir(DIR));
closedir(DIR);

foreach $accountID (@files) {
	open (SQL_IN, ">$tempsql") || die "Can't write to $tempsql : $!\n";
	print SQL_IN <<SQL;
SELECT 'X',accountID,email
FROM userAccounts
WHERE accountID=$accountID
GO
SQL
	close SQL_IN;
	open (SQL_OUT, "$G_isql_exe -i $tempsql |") || die "Can't read from $G_isql_exe -i $tempsql : $!\n";

	while (<SQL_OUT>) {
		if (/X/) {
			chomp;
			($junk, $aid) = split;
			$email = <SQL_OUT>;
			chomp $email;
			$email =~ s/^\s+//;
			$email =~ s/\s+$//;
			last;
		}
	}
	close SQL_OUT;
	if ($aid != $accountID) {
		print "$accountID - no account\n";
	}
	open (SQL_IN, ">$tempsql") || die "Can't write to $tempsql : $!\n";
	print SQL_IN <<SQL;
getLastPayment $accountID
GO
SQL
	close SQL_IN;
	open (SQL_OUT, "$G_isql_exe -i $tempsql |") || die "Can't read from $G_isql_exe -i $tempsql : $!\n";

	$lastPayment = "none";
	while (<SQL_OUT>) {
		if (/----/) {
			$lastPayment = <SQL_OUT>;
			chomp $lastPayment;
			$lastPayment =~ s/^\s+//;
			$lastPayment =~ s/\s+$//;
			last;
		}
	}
	close SQL_OUT;
	print "$accountID\t$lastPayment\t$email\n";
}

unlink($tempsql);
