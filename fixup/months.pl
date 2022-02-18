#!/usr/local/bin/perl
	$dbName = 'vpusr';
	$dbPw = 'vpusr1';
$G_isql_exe = "/u/vplaces/s/sybase/bin/isql -w 300 -U$dbName -P$dbPw -SSYBASE";
$G_statdir = "/tmp/";
$tempsql = '/tmp/sql.txt';
$ENV{'SYBASE'} ||= '/u/vplaces/s/sybase';

open (SQL_IN, ">$tempsql") || die "Can't write to $tempsql : $!\n";

while (<STDIN>) {
	chomp;
	print SQL_IN <<SQL;
EXEC months $_
GO
SQL
}
close SQL_IN;
