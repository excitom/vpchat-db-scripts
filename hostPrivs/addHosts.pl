#!/usr/local/bin/perl
#
# Tom Lang 5/1999
#
sub usage {
	die <<USAGE;

usage: addHosts.pl < host_name_list

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

$modes{'VP'} = 2;
$modes{'URS'} = 3;

if ($#ARGV != -1) {
	&usage;
} 

$ENV{'SYBASE'} ||= '/u/vplaces/s/sybase';

$mode = $modes{'VP'};
$priv = $privs{'Hosting'};

while (<STDIN>) {
	chop;
	#($nickName, $email, $password) = split;
	($nickName, $password) = split;
	$email = "$nickName\@host";
	print "Adding $nickName\n";
	$sql_cmd = qq|registerNewUser "$nickName", "$email", "$password"\n|;
	$sql_cmd .= "go\n";
	$sql_cmd .= qq|addPrivilege "$nickName",$mode,$priv\n|;
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
