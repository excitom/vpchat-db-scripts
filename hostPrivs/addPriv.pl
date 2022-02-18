#!/usr/local/bin/perl
#
# Tom Lang 6/98
#
sub usage {
	die <<USAGE;

usage: addPrivs.pl < host_name_list

Pipe a list of one or more host names to standard input.

USAGE
}

$G_isql_exe = '//u/vplaces/s/sybase/bin/isql -Uvpusr -Pvpusr1 -SSYBASE';
$G_statdir = "/tmp/";
$tempsql = $G_statdir . ".temp.sql.$$";

$privs{'Hosting'} = 273;
$privs{'CommunityMgmt'} = 502;
$privs{'CrowdControl'} = 272;
$privs{'AuditoriumSetup'} = 501;
$privs{'Supervisor'} = 400;

$modes{'VP'} = 2;
$modes{'URS'} = 3;

if ($#ARGV != 1) {
	&usage;
} 
&usage unless (exists $privs{$ARGV[0]});
&usage unless (exists $modes{$ARGV[1]});

$priv = $privs{$ARGV[0]};
$mode = $modes{$ARGV[1]};

$ENV{'SYBASE'} ||= '/u/vplaces/s/sybase';

while (<STDIN>) {
	chop;
	($name, $junk) = split;
print "$name\n";
	$sql_cmd = qq|addPrivilege "$name",$mode,$priv\n|;
	$sql_cmd .= "go\n";
	open (SQL_IN, ">$tempsql") || die "Can't write to $tempsql : $!\n";
	print SQL_IN $sql_cmd;
	close SQL_IN;
	open (SQL_OUT, "$G_isql_exe -i $tempsql |") || die "Can't read from $G_isql_exe -i $tempsql : $!\n";

	while (<SQL_OUT>) {
		print;
	}
	close SQL_OUT;
}
unlink($tempsql);
