#!/usr/bin/perl

open (TBLS, "<master.tbls") || die "can't read master.tbls";
@tbls = <TBLS>;
close TBLS;

$dbUser = 'sa';
$dbPw = 'UBIQUE';
$logDir = '/logs/backup/master';

foreach $tbl (@tbls) {
	next if ($tbl =~ /^#/);
	print "Dumping $tbl";
	chomp $tbl;
	$tbl =~ s/	.*$//;	# remove identify flags (only needed for bcp in)
 	`bcp master.dbo.$tbl out $logDir/$tbl -c -U$dbUser -SSYBASE -P$dbPw`;
}
