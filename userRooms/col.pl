#!/usr/bin/perl

open (C, "<cur");
open (R, "<requests.out");
open (L, ">list.out");
while(<C>) {
	chomp;
	$urls{$_} = 1;
}
close C;
while (<R>) {
	chomp;
	($aid,$n,$e,$u,$t,$cap,$cat) = split(/\|/);
	$u =~ s/\/$//;
print "$u\n";
	if (defined($urls{$u})) {
		print L;
		print L "\n";
	}
}
