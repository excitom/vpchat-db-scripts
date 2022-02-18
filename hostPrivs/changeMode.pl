#!/usr/local/bin/perl
#
# Tom Lang 7/98
#
# Change mode of registered users from 2(local) to 3(URS)

$G_isql_exe = '/t/t/s/sybase/bin/isql -Uvpusr -Pvpusr1 -SSYBASE';
$G_statdir = "/tmp/";
$tempsql = $G_statdir . ".temp.sql.$$";

$ENV{'SYBASE'} ||= '/t/t/s/sybase';

open (HOSTS, "<hostPrivs") || die "Can't open hostPrivs: $!";
while (<HOSTS>) {
	last if (/---/);
}
while (<HOSTS>) {
	chop;
	($userID, $nickName) = split;
	$hosts{$userID} = $nickName;
}
close HOSTS;
open (M3, "<mode3") || die "Can't open mode3: $!";
while (<M3>) {
	last if (/---/);
}
while (<M3>) {
	chop;
	($userID, $nickName) = split;
	$mode3{$nickName} = $userID;
}
close M3;
open(USERS, "<userIDs") || die "Can't open userIDs : $!";
$batch = 0;
while (<USERS>) {
	chop;
	($userID, $name) = split;
	if (defined($hosts{$userID})) {
		print "Skipping host $name\n";
		next;
	}
	if (defined($mode3{$name})) {
		print "Skipping dual mode $name\n";
		next;
	}
	print "Changing mode for $name\n";
	$sql_cmd = qq|update users set registrationMode=3 where nickName="$name"\ngo\n|;

	unless($batch) {
		open (SQL_IN, ">$tempsql") || die "Can't write to $tempsql : $!\n";
	}
	print SQL_IN $sql_cmd;
	if ($batch++ > 49) {
		close SQL_IN;
		open (SQL_OUT, "$G_isql_exe -i $tempsql |") || die "Can't read from $G_isql_exe -i $tempsql : $!\n";

		while (<SQL_OUT>) {
			print;
		}
		close SQL_OUT;
		$batch = 0;
	}
}
close SQL_IN;
open (SQL_OUT, "$G_isql_exe -i $tempsql |") || die "Can't read from $G_isql_exe -i $tempsql : $!\n";

while (<SQL_OUT>) {
	print;
}
		close SQL_OUT;
unlink($tempsql);
