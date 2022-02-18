#!/usr/bin/perl
$logDir = "/logs/accountIDs";
opendir(DIR, $logDir) || die "Can't open $logDir : $!";
@accounts = grep /[0-9]+/, readdir DIR;
closedir DIR;
$dbName = 'vpusr';
$dbPw = 'vpusr1';

$G_isql_exe = "/u/vplaces/s/sybase/bin/isql -U$dbName -P$dbPw -SSYBASE";
$G_statdir = "/tmp/";
$tempsql = '/tmp/sql.txt';
$ENV{'SYBASE'} ||= '/u/vplaces/s/sybase';

chdir $logDir;
open (SQL_IN, ">$tempsql") || die "Can't write to $tempsql : $!\n";
$chunk = 0;
$files = $#accounts + 1;
$f = 1;
foreach $file (@accounts) {
	open (ACCT, "<$file") || die "Can't read $file : $!";
	while (<ACCT>) {
		$ctr++ if (/eCheck payment cleared Rejected/);
	}
	close ACCT;
	print SQL_IN <<SQL if ($ctr > 0);
UPDATE renewals SET badChecks = $ctr WHERE accountID = $file
GO
SQL
	print "$f of $files\n" if ($f % 10 == 0);
	$f++;
	$ctr = 0;
}
print SQL_IN "GO\n";
close SQL_IN;
exit;
open (SQL_OUT, "$G_isql_exe -i $tempsql |") || die "Can't read from $G_isql_exe -i $tempsql : $!\n";
while (<SQL_OUT>) {
	print;
}
close SQL_OUT;

