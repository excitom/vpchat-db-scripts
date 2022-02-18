#!/usr/local/bin/perl
#
# Add categories in batch mode
#
# Tom Lang 7/1999
#
$G_isql_exe = '/u/vplaces/s/sybase/bin/isql -Uvpplaces -Pvpplaces -SSYBASE';
$G_tmpdir = "/tmp/";
$tempsql = $G_tmpdir . ".temp.sql.$$";
$ENV{'SYBASE'} ||= '/u/vplaces/s/sybase';
$category = "";
#
# Loop through input
#
while (<STDIN>) {
	chop;
	next if (/^\s*$/);
	print "Processing $category\n";
	open (SQL_IN, ">$tempsql") || die "Can't write to $tempsql : $!\n";
	print SQL_IN qq|select category from categories where description='$category'\n|;
	print SQL_IN "go\n";
	close SQL_IN;
	open (SQL_OUT, "$G_isql_exe -i $tempsql |") || die "Can't read from $G_isql_exe -i $tempsql : $!\n";
	$found = 0;
	while (<SQL_OUT>) {
		if (/---/) {
			$found=1;
			last;
		}
	}
}
unlink $tempsql;
