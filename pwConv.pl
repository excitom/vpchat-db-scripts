#!/usr/local/bin/perl
while (<STDIN>) {
	chomp;
	($uid, $nickName, $password, $maxSpace) = split;
	$maxSpace *= 1024;
	$pwEntry = join(':', $nickName, $password, $uid, 60001, $nickName,"/export/home/members/$nickName", "/bin/false", "$maxSpace" );
	print "$pwEntry\n";
}
