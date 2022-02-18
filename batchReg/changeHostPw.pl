#!/usr/local/bin/perl
#
# Tom Lang 9/98
#
sub getPasswd {
	my $x = rand $#words;
	my $y = int((rand 99) * 100) % 100;
	$y = "0$y" if ($y < 10);
	return "$words[$x]$y";
}

srand(time ^ $$ ^ unpack "%32L*", `ps -aef | /usr/local/bin/gzip`);
$dictFile = "/usr/share/lib/dict/words";
open (DICT, "<$dictFile") || die "Can't open $dictFile : $!";
while (<DICT>) {
	next unless (/^[a-z]+$/);        # skip contractions, numbers
	next unless (length($_) == 5 || length($_) == 6);
	chop;
	push(@words, $_);
}

$G_isql_exe = '/t/t/s/sybase/bin/isql -Uvpusr -Pvpusr1 -SSYBASE';
$G_statdir = "/tmp/";
$tempsql = $G_statdir . ".temp.sql.$$";
$ENV{'SYBASE'} ||= '/t/t/s/sybase';

$name = $ARGV[0];
open (H, "<$name") || die "Can't read $name: $!";
while (<H>) {
	$chomp;
	s/\s+$//;
	$host = $_;
	$pw = &getPasswd;
	open (SQL_IN, ">$tempsql") || die "Can't write to $tempsql : $!\n";
	$cmd = qq|update registration set password="$pw" where userID=(select userID from users where nickName="$host")\ngo\n|;
	print "#$host $pw\n";
	print SQL_IN $cmd;
	print SQL_IN "go\n";
	close SQL_IN;

	print  "$G_isql_exe -i $tempsql \n";
	open (SQL_OUT, "$G_isql_exe -i $tempsql |") || die "Can't read from $G_isql_exe -i $tempsql : $!\n";

	while (<SQL_OUT>) {
		print STDERR;
	}
	close SQL_OUT;
}
unlink($tempsql);
