#!/usr/local/bin/perl
#
# Update stored procedures.
#
# Tom Lang 4/1999
#

$G_sybase = '/u/vplaces/s/sybase';
$G_isql_exe = $G_sybase . '/bin/isql -Usa -Ppassword -SSYBASE';
$G_statdir = "/tmp/";
$tempsql = $G_statdir . ".temp.sql.$$";

$ENV{'SYBASE'} ||= $G_sybase;

#
# go to stored procedure directory
#
$G_stpDir = '/u/vplaces/VPCOM/VPDB/vpdb.2.1.4.1-all/vpplaces/sql/stp';
chdir $G_stpDir;
opendir (STP, $G_stpDir) || die "Can't read $G_stpDir";
@stp = grep(/\.stp$/, readdir(STP));
closedir (STP);

foreach $stp (@stp) {
	print "*** $stp\n";
	$s = $stp;
	$s =~ s/\.stp$//;
	open (SQL_IN, ">$tempsql") || die "Can't write to $tempsql : $!\n";
	print SQL_IN <<DROP;
use vpplaces
go
drop procedure $s
go
DROP
	close SQL_IN;

	open (SQL_OUT, "$G_isql_exe -i $tempsql |") || die "Can't read from $G_isql_exe -i $tempsql : $!\n";

	while (<SQL_OUT>) {
		print;
	}
	close SQL_OUT;

	open (SQL_IN, ">$tempsql") || die "Can't write to $tempsql : $!\n";
	open (STP_IN, "<$stp") || die "Can't read $stp : $!\n";
	print SQL_IN "use vpplaces\ngo\n";
	while (<STP_IN>) {
		print SQL_IN;
	}
	close SQL_IN;
	close STP_IN;

	open (SQL_OUT, "$G_isql_exe -i $tempsql |") || die "Can't read from $G_isql_exe -i $tempsql : $!\n";

	while (<SQL_OUT>) {
		print;
	}
	close SQL_OUT;
}
unlink($tempsql);
