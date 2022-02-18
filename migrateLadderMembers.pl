#!/usr/local/bin/perl
#
# Tom Lang 6/06
#
	$dbName = 'audset';
	$dbPw = 'audset1';

die "Usage: migrateLadderMembers.pl [fromID] [toID]\n" unless ($#ARGV == 1);

$fromID = $ARGV[0];
$toID = $ARGV[1];

$G_isql_exe = "/u/vplaces/s/sybase/bin/isql -w 600 -U$dbName -P$dbPw -SSYBASE";
$G_statdir = "/tmp/";
$tempsql = $G_statdir . "temp.sql.$$";
$ENV{'SYBASE'} ||= '/u/vplaces/s/sybase';

open (SQL_IN, ">$tempsql") || die "Can't write to $tempsql : $!\n";

while (<STDIN>) {
	chomp;
	@member = split();
	print "UserID $member[0] email $member[1]\n";
	print;
	print SQL_IN <<SQL;
EXEC leaveGameLadder $fromID, $member[0]
GO
EXEC  joinGameLadder $toID, $member[0], '$member[1]'
GO
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
