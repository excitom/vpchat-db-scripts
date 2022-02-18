#!/usr/local/bin/perl
#
# Execute an arbitrary sequence of SQL commands and return the results
# to stdout.
#
# Tom Lang 3/98
#
if ($#ARGV == -1) {
	$dbName = 'sa';
	$dbPw = 'UBIQUE';
} else {
	$dbName = $ARGV[0];
	$dbPw = $ARGV[1];
}

$G_isql_exe = "/u/vplaces/s/sybase/bin/isql -U$dbName -P$dbPw -SSYBASE";
$G_statdir = "/tmp/";
$tempsql = $G_statdir . ".temp.sql.$$";
$ENV{'SYBASE'} ||= '/u/vplaces/s/sybase';


while (<STDIN>) {
	chomp;
	$name = $_;
	open (SQL_IN, ">$tempsql") || die "Can't write to $tempsql : $!\n";
	print SQL_IN "select 'XX',userID from vpusers..users where nickName=\"$name\" \ngo\n";
	close SQL_IN;

	open (SQL_OUT, "$G_isql_exe -i $tempsql |") || die "Can't read from $G_isql_exe -i $tempsql : $!\n";

	$userID = -1;
	while (<SQL_OUT>) {
		if (/XX/) {
			chomp;
			($junk, $userID) = split;
		}
	}
	close SQL_OUT;
	if ($userID == -1) {
		print "Problem with $name\n";
		next;
	} else {
		print "$name -- $userID\n";
	}
	open (SQL_IN, ">$tempsql") || die "Can't write to $tempsql : $!\n";
	print SQL_IN "exec vpplaces..delHomePage $userID\ngo\n";
	close SQL_IN;
	open (SQL_OUT, "$G_isql_exe -i $tempsql |") || die "Can't read from $G_isql_exe -i $tempsql : $!\n";
	while (<SQL_OUT>) {
		print;
	}
	
}
unlink($tempsql);
