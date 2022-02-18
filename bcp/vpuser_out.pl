#!/usr/bin/perl

open (TBLS, "<vpuser.tbls") || die "can't read vpuser.tbls";
@tbls = <TBLS>;
close TBLS;

$dbUser = 'sa';
$dbPw = 'UBIQUE';
$logDir = '/logs/backup';

foreach $tbl (@tbls) {
	next if ($tbl =~ /^#/);
	print "Dumping $tbl";
	chomp $tbl;
	$tbl =~ s/	.*$//;	# remove identify flags (only needed for bcp in)
 	`bcp vpusers.dbo.$tbl out $logDir/$tbl -c -U$dbUser -SSYBASE -P$dbPw`;
}
