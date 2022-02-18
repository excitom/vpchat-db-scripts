#!/usr/local/bin/perl
if ($#ARGV == -1) {
	$dbName = 'audset';
	$dbPw = 'audset1';
} else {
	$dbName = $ARGV[0];
	$dbPw = $ARGV[1];
}

$G_isql_exe = "/u/vplaces/s/sybase/bin/isql -w 600 -U$dbName -P$dbPw -SSYBASE";
$G_statdir = "/tmp/";
$tempsql = $G_statdir . ".temp.sql.$$";
$ENV{'SYBASE'} ||= '/u/vplaces/s/sybase';

open (SQL_IN, ">$tempsql") || die "Can't write to $tempsql : $!\n";

while (<STDIN>) {
	chomp;
	($aid, $ownerID, $nid, $oldOwnerID) = split;
	print SQL_IN <<SQL;
update notifyAccessList set userID = $ownerID
where notifyID = $nid
and accountID = $aid
and userID = $oldOwnerID
go
SQL
}
close SQL_IN;

print  "$G_isql_exe -i $tempsql \n";

open (SQL_OUT, "$G_isql_exe -i $tempsql |") || die "Can't read from $G_isql_exe -i $tempsql : $!\n";

while (<SQL_OUT>) {
	print;
}
close SQL_OUT;
unlink($tempsql);
