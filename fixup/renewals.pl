#!/usr/local/bin/perl
	$dbName = 'vpusr';
	$dbPw = 'vpusr1';
$G_isql_exe = "/u/vplaces/s/sybase/bin/isql -w 300 -U$dbName -P$dbPw -SSYBASE";
$G_statdir = "/tmp/";
$tempsql = '/tmp/sql.txt';
$ENV{'SYBASE'} ||= '/u/vplaces/s/sybase';

open (SQL_IN, ">$tempsql") || die "Can't write to $tempsql : $!\n";

$ctr = 0;
while (<STDIN>) {
	chomp;
	my ($accountID, $renewals) = split;
	#$renewals--;
	if ($renewals > 0) {
		print SQL_IN <<SQL;
UPDATE renewals SET renewals = $renewals WHERE accountID=$accountID
SQL
		print SQL_IN "GO\n" if ($ctr %10 == 0);
		$ctr++;
	}
}
close SQL_IN;
