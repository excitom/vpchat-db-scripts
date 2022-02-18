#!/usr/bin/perl
while (<STDIN>) {
	chomp;
	$aid = $_;
	open (LOG, "</logs/accountIDs/$aid");
	while (<LOG>) {
		next unless(/2003	/);
		next unless(/^\w+\s+Mar /);
		@f = split(/\t/);
		next if ($#f > 3);
		if ($#f == 3) {
			next unless(/by settlement/ || /by IPN/);
			s/\t\d+\t/\t/;
		}
		if ($#f == 2) {
			next unless(/Wells Fargo/);
			s/\t\d+\t/\t/;
		}
		print "$aid\t";
		print;
	}
	close LOG;
}
