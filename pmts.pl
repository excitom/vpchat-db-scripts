#!/usr/local/bin/perl
#

sub writeSql {
	open (SQL_IN, ">$tempsql") || die "Can't write to $tempsql : $!\n";

	foreach $p (keys %balance) {
		print "insert runningBalance (paymentID, balance) values($p,$balance{$p})\n";
		print SQL_IN "insert runningBalance (paymentID, balance) values($p,$balance{$p})\n";
	}
	print SQL_IN "GO\n";
	close SQL_IN;

	print  "$G_isql_exe -i $tempsql \n";

	open (SQL_OUT, "$G_isql_exe -i $tempsql |") || die "Can't read from $G_isql_exe -i $tempsql : $!\n";

	while (<SQL_OUT>) {
		print;
	}
	close SQL_OUT;
}

############
# 
# START HERE
#

$dbName = 'vpusr';
$dbPw = 'vpusr1';

$G_isql_exe = "/u/vplaces/s/sybase/bin/isql -U$dbName -P$dbPw -SSYBASE";
$G_statdir = "/tmp/";
$tempsql = $G_statdir . ".temp.sql.$$";
$ENV{'SYBASE'} ||= '/u/vplaces/s/sybase';

open (BAL, "<bal") || die;
while (<BAL>) {
	chomp;
	($aid, $bal) = split;
	$bal{$aid} = 0 - $bal;
}
close BAL;
$a = 0;
print "BAL	AMT	AID\n";
open (PMTS, "<pmts") || die;
while (<PMTS>) {
	chomp;
	($aid, $pid, $amt) = split;
	if ($a == 0) {
		$a = $aid;
		$balance = $bal{$aid};
	}
	elsif ($aid != $a) {
		&writeSql;
		print "=====================\n";
		undef %balance;
		$a = $aid;
		$balance = $bal{$aid};
	}
	print "$balance	$amt	$aid\n";
	$balance{$pid} = $balance;
	$balance -= $amt;
}
close PMTS;
	
unlink($tempsql);
