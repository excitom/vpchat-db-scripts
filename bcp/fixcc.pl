#!/usr/bin/perl
while(<STDIN>) {
	chomp;
	@f = split(/\t/);
	$x = $f[5];
	$f[5] = $f[6];
	$f[6] = $x;
	$rec = join("\t", @f);
	print "$rec\n";
}
