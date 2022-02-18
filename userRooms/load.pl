#!/usr/local/bin/perl
$dbName = 'vpplaces';
$dbPw = 'vpplaces';

$cats{'Game Rooms'} = 9;
$cats{'Paint Shops'} = 10;
$cats{'General'} = 11;

$G_isql_exe = "/u/vplaces/s/sybase/bin/isql -U$dbName -P$dbPw -SSYBASE";
$G_statdir = "/tmp/";
$tempsql = $G_statdir . ".temp.sql.$$";
$ENV{'SYBASE'} ||= '/u/vplaces/s/sybase';

while (<STDIN>) {
	next if (/adult/);
	chomp;
	($aid,$n,$e,$u,$t,$cap,$cat) = split(/\|/);
	$u =~ s/\/$//;
	$pc = $cats{$cat};
	open (SQL_IN, ">$tempsql") || die "Can't write to $tempsql : $!\n";
	print qq|exec addUserPlace $aid,"$u",2112,"$t",$cap,0,$pc,1\ngo\n|;
	print SQL_IN qq|exec addUserPlace $aid,"$u",2112,"$t",$cap,0,$pc,1\ngo\n|;
	close SQL_IN;

	open (SQL_OUT, "$G_isql_exe -i $tempsql |") || die "Can't read from $G_isql_exe -i $tempsql : $!\n";

	while (<SQL_OUT>) {
		print;
	}
	close SQL_OUT;
}
unlink($tempsql);
