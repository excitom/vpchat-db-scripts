#!/usr/local/bin/perl
#
# Tom Lang 5/2001
#
sub usage {
	die <<USAGE;

usage: new.pl "server name"

USAGE
}
sub getPasswd {
	my $x = rand $#words;
	my $y = int((rand 99) * 100) % 100;
	$y = "0$y" if ($y < 10);
	return "$words[$x]$y";
}

#################
#
# START HERE
#

srand(time ^ $$ ^ unpack "%32L*", `ps -aef | /usr/local/bin/gzip`);
$dictFile = "/usr/share/lib/dict/words";
open (DICT, "<$dictFile") || die "Can't open $dictFile : $!";
while (<DICT>) {
	next unless (/^[a-z]+$/);        # skip contractions, numbers
	next unless (length($_) == 5 || length($_) == 6);
	chop;
	push(@words, $_);
}

$G_isql_exe = '//u/vplaces/s/sybase/bin/isql -Uvpusr -Pvpusr1 -SSYBASE';
$G_statdir = "/tmp/";
$tempsql = $G_statdir . ".temp.sql.$$";

if ($#ARGV != 0) {
	&usage;
} 

$ENV{'SYBASE'} ||= '/u/vplaces/s/sybase';

$nickName = $ARGV[0];
$email = "vp-resmon_" . $nickName;
$nickName = "xx-resmon_" . $nickName;
$password = &getPasswd;

$sql_cmd = qq|registerNewUser "$nickName", "$email", "$password"\n|;
$sql_cmd .= "go\n";
$sql_cmd .= qq|update users set nickName="$email" where nickName="$nickName"\n|;
$sql_cmd .= "go\n";
$sql_cmd .= qq|addPrivilege "$email",2,273\n|;
$sql_cmd .= "go\n";

open (SQL_IN, ">$tempsql") || die "Can't write to $tempsql : $!\n";
print SQL_IN $sql_cmd;
close SQL_IN;
open (SQL_OUT, "$G_isql_exe -i $tempsql |") || die "Can't read from $G_isql_exe -i $tempsql : $!\n";

print "Diagnostic info:\n\n";
while (<SQL_OUT>) {
	print;
}
close SQL_OUT;
unlink($tempsql);

print "\nName: $email Password: $password\n\n";
