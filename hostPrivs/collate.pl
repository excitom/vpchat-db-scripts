#!/usr/local/bin/perl
print "Name of the file containing userID | host name \n";
$hosts = <>;
chop $hosts;
print "File containing mode 2 registrations in userID | name |mode format\n";
$mode2 = <>;
chop $mode2;
print "Output file\n";
$out = <>;
chop $out;
open (H, "<$hosts") || die "Can't read $hosts : $!";
open (M, "<$mode2") || die "Can't read $mode2 : $!";
open (O, ">$out") || die "Can't write $out : $!";

while (<M>) {
	chop;
	($userID, $name, $mode) = split;
	$names{$userID} = $name;
}
close M;
while (<H>) {
	chop;
	($userID, $name) = split;
	delete $names{$userID};
}
open (M, "<$mode2") || die "Can't read $mode2 : $!";
while (<M>) {
	($userID, $name, $mode) = split;
	print O if ($names{$userID} eq $name);
}
