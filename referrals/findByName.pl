#!/usr/bin/perl
#
# Find people who were listed as a referrer, but by name rather
# than account ID.

# Tom Lang 1/2002
#
$dbName = 'vpusr';
$dbPw = 'vpusr1';
$G_isql_exe = "/u/vplaces/s/sybase/bin/isql -U$dbName -P$dbPw -SSYBASE";
$G_statdir = "/tmp/";
$tempsql = $G_statdir . ".temp.sql.$$";
$ENV{'SYBASE'} ||= '/u/vplaces/s/sybase';

open (SQL_IN, ">$tempsql") || die "Can't write to $tempsql : $!\n";

print SQL_IN <<SQL;
SELECT accountID,referredBy FROM userAccounts
WHERE referredByID=0
AND referredBy IS NOT NULL
AND referredBy != ''
GROUP BY referredBy
GO
SQL

close SQL_IN;

open (SQL_OUT, "$G_isql_exe -i $tempsql |") || die "Can't read from $G_isql_exe -i $tempsql : $!\n";

while (<SQL_OUT>) {
	last if (/---/);
}
$_ = <SQL_OUT>;		# skip second ----- line

while (<SQL_OUT>) {
	last if (/^\s*$/);
	chomp;
	s/\s+//g;
	$accountID = $_;
	$referredBy = <SQL_OUT>;
	chomp $referredBy;
	$referredBy =~ s/\s+//g;
	$referredBy =~ tr/[A-Z]/[a-z]/;
	$account{$accountID} = $referredBy;
}

close SQL_OUT;

open (SQL_IN, ">$tempsql") || die "Can't write to $tempsql : $!\n";
foreach $accountID (keys %account) {
	print SQL_IN <<SQL;
SELECT 'X',$accountID, userID FROM users WHERE nickName = "$account{$accountID}"
GO
SQL

}
close SQL_IN;

open (SQL_OUT, "$G_isql_exe -i $tempsql |") || die "Can't read from $G_isql_exe -i $tempsql : $!\n";

while (<SQL_OUT>) {
	next unless (/X/);
	chomp;
	($junk,$aid,$uid) = split;
	$referred{$aid} = $uid;
}
close SQL_OUT;

open (SQL_IN, ">$tempsql") || die "Can't write to $tempsql : $!\n";
foreach $aid (keys %referred) {
	print SQL_IN <<SQL;
UPDATE userAccounts SET referredByID = $referred{$aid}
WHERE accountID = $aid
AND referredByID = 0
GO
SQL
}
close SQL_IN;

open (SQL_OUT, "$G_isql_exe -i $tempsql |") || die "Can't read from $G_isql_exe -i $tempsql : $!\n";

while (<SQL_OUT>) {
	print;
}
close SQL_OUT;

unlink($tempsql);
