#!/usr/local/bin/perl
#
# separate chat users from PAL users among mode 2 registrations,
# using nickname heuristic
#
# Tom Lang 8/98
#
while (<STDIN>) {
	last if (/-----/);
}
while (<STDIN>) {
	last unless (/-----/);
}
$nickname = $_;
chop $nickname;
while (1) {
	$nickname =~ s/\s+//g;
	$email = <STDIN>;
	$email =~ s/\s+//g;
	$x = $email;
	$x =~ s/(.*)@/$1/;
	print "$nickname\t$email\n" unless ($x =~ /^$nickname/);
	$nickname = <STDIN>;
	chop $nickname;
	last if ($nickname eq "");
}

