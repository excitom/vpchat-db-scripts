#!/usr/local/bin/perl
#
# Tom Lang 3/98
#
$G_isql_exe = '/u/vplaces/s/sybase/bin/isql -Uvpusr -Pvpusr1 -SSYBASE';
$G_statdir = "/tmp/";
$tempsql = $G_statdir . ".temp.sql.$$";
$ENV{'SYBASE'} ||= '/u/vplaces/s/sybase';

$dictFile = "/usr/share/lib/dict/words";
open (DICT, "<$dictFile") || die "Can't open $dictFile : $!";
while (<DICT>) {
	next unless (/^[a-z]+/);        # skip contractions, numbers
	next unless (length($_) == 5 || length($_) == 6);
	chop;
	push(@words, $_);
}

open (LIST, ">>host.list") || die "Can't append to host.list : $!";

open (SQL_IN, ">$tempsql") || die "Can't write to $tempsql : $!\n";
srand(time ^ $$ ^ unpack "%32L*", `ps -aef | /usr/local/bin/gzip`);
while (<STDIN>) {
	chomp;
	$name = $_;
	$email = $name . "\@boards";
	#$name = "host-" . $name unless($name =~ /^host-/);
	#$name = substr($name,0,20) if (length($name) > 20);

	$x = rand $#words;
	$y = int((rand 99) * 100) % 100;
	$y = "0$y" if ($y < 10);
	$password = $words[$x] . $y;

	print qq|$name	$email	$password\n|;
	print LIST qq|$name	$email	$password\n|;
	print SQL_IN qq|registerNewUser "$name","$email","$password"\n|;
	print SQL_IN "go\n";
}
close SQL_IN;

print  "$G_isql_exe -i $tempsql \n";
open (SQL_OUT, "$G_isql_exe -i $tempsql |") || die "Can't read from $G_isql_exe -i $tempsql : $!\n";

while (<SQL_OUT>) {
	print;
}
close SQL_OUT;
close LIST;
unlink($tempsql);
