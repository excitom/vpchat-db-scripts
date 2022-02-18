#!/usr/bin/perl
$ctr = 1;
while (<STDIN>) {
	chomp;
	($aid, $time, $comment) = split(/\t/, $_, 3);
	$comment =~ s/\t/ /g;
	print <<SQL;
addActivityLogById $aid, "$time", "$comment"
SQL
	$ctr++;
	if ($ctr > 100) {
		print "GO\n";
		$ctr = 1;
	}
}
print "GO\n";
