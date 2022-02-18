#!/usr/local/bin/perl
$dbName = 'vpusr';
$dbPw = 'vpusr1';

$G_isql_exe = "/u/vplaces/s/sybase/bin/isql -U$dbName -P$dbPw -SSYBASE";
$G_statdir = "/tmp/";
$tempsql = $G_statdir . ".temp.sql.$$";
$ENV{'SYBASE'} ||= '/u/vplaces/s/sybase';

while (<STDIN>) {
	next if (/adult/);
	$line = $_;
	chomp;
	($aid,$n,$e,$u,$t,$cap,$cat) = split(/\|/);
	open (SQL_IN, ">$tempsql") || die "Can't write to $tempsql : $!\n";
	print SQL_IN qq|select 'XXXXX',accountID from userAccounts where accountID=$aid and accountStatus=0\ngo\n|;
	close SQL_IN;

	open (SQL_OUT, "$G_isql_exe -i $tempsql |") || die "Can't read from $G_isql_exe -i $tempsql : $!\n";

	$found = 0;
	while (<SQL_OUT>) {
		$found = 1 if (/XXXXX/);
	}
	close SQL_OUT;
	print $line if ($found);
}
unlink($tempsql);
