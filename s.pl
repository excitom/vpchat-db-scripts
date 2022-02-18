#!/usr/local/bin/perl
#
# Execute an arbitrary sequence of SQL commands and return the results
# to stdout.
#
# Tom Lang 3/98
#
if ($#ARGV == -1) {
	$dbName = 'vpusr';
	$dbPw = 'vpusr1';
} else {
	$dbName = $ARGV[0];
	$dbPw = $ARGV[1];
}

$G_isql_exe = "/u/vplaces/s/sybase/bin/isql -w 600 -U$dbName -P$dbPw -SSYBASE";
$G_statdir = "/tmp/";
$tempsql = "temp.sql";
$ENV{'SYBASE'} ||= '/u/vplaces/s/sybase';

open (SQL_IN, ">$tempsql") || die "Can't write to $tempsql : $!\n";

#
# stdin should contain a sequence of SQL commands
#
while (<STDIN>) {
	
	chomp;
	($aid, $comment) = split(/\t/, $_, 2);
	$subscr = $comment;
	$subscr =~ s/Subscription ID: //;
	print SQL_IN <<SQL;
update subscriptions
set comment = "$subscr"
where accountID = $aid
and type = 1
and comment = "$comment"
go
SQL
}
close SQL_IN;
