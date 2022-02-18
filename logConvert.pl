#!/usr/bin/perl


######################
#
# START HERE
#

$ctr = 1;
while (<STDIN>) {
	chomp;
	(@fields) = split(/\t/);
	$date = shift @fields;
	(@df) = split(/\s+/, $date);
	$date = join(' ', $df[1], $df[2], $df[4], $df[3]);
	next if ($date =~ /^\s*$/);
	$x = shift @fields;
	$who = '';
	if ($x =~ /^\d+\.\d+\.\d+\.\d+$/) {
		$ip = $x;
		$name = shift @fields;
		next if ($name eq '');
		$msg = join(' ', @fields);
		$msg =~ s/- processed by (\w+)//;
		$who = $1;
		if ($who ne '') {
			$msg =~ s/ by (\w+)//;
			$who = $1;
		}
		else {
			$who =~ s/Comment from ([^:]*): //;
			$who = $1;
		}
		if ($name =~ /^\d+$/) {
			$aid = $name;
		}
		else {
			$aid = 0;
		}
		$msg =~ s/^update\s+(\d+)//;
		$a = $1+0;
		if ($a) {
			$aid = $a;
		}
		$msg =~ s/^payment\s+(\d+)//;
		$a = $1+0;
		if ($a) {
			$msg = "payment $msg";
			$aid = $a;
		}
		$msg =~ s/^thankyou sent\s+(\d+)//;
		$a = $1+0;
		if ($a) {
			$msg = "thankyou sent $msg";
			$aid = $a;
		}
	}
	else {
		$ip = '';
		if ($x eq 'login') {
			$name = shift @fields;
			$name = shift @fields if ($name eq '');
			$y = shift @fields;
			$msg = ($y) ? "$name acct owner $x" : "$name user $x";
			$aid = shift @fields;
		}
		elsif ($x eq 'update') {
			$fields[0] =~ s/^(\d+) //;
			$aid = $1 + 0;
			$msg = $x . ' ' . join(' ', @fields);
		}
		elsif ($x eq 'new acct') {
			$msg = $x . ' ' . shift @fields;
			$aid = shift @fields;
		}
		elsif ($x eq 'CMGMT login') {
			$name = shift @fields;
			$msg = $x . ' privs: ' . shift @fields;
			$aid = 0;
		}
		elsif ($x =~ /^\d+$/) {
			$aid = $x;
			$msg = join(' ', @fields);
		}
		elsif ($x =~ /registered by/) {
			$x =~ s/ by (\w+)//;
			$who = $1;
			$msg = $x;
			$aid = 1;
		}
		elsif ($fields[0] =~ /^\d+$/) {
			$aid = shift @fields;
			$msg = $x . ' ' . join(' ', @fields);
		}
		elsif ($fields[0] =~ /^password sent/) {
			$name = $x;
			$msg = join(' ', @fields);
		}
		elsif ($x eq '') {
			next;
		}
		elsif ($x =~ /^INVALID attempt/) {
			next;
		}
		elsif ($x =~ /^Regular subscription -/) {
			$x =~ s/ - ([^ ]+) -//;
			$name = $1;
			$msg = $x . ' ' . join(' ', @fields);
		}
		elsif ($x =~ /^Free Trial subscription -/) {
			$x =~ s/ - ([^ ]+) -//;
			$name = $1;
			$msg = $x . ' ' . join(' ', @fields);
		}
		elsif ($x =~ /^This is a test/) {
			next;
		}
		elsif ($x =~ /^Wells Fargo/) {
			next;
		}
		elsif ($x =~ /^pmt of/) {
			next;
		}
		else {
			die ">>$x<<>>$fields[0]<<$_";
		}
		if ($msg =~ / by (\w+)/) {
			$msg =~ s/ by (\w+)//;
			$who = $1;
		}
	}
	$msg =~ s/"/'/g;
	$msg =~ s/to account//;
	$msg =~ s/\s+$//;
	$ip =~ s/\s+$//;
	$name =~ s/\s+$//;
	$who =~ s/\s+$//;
	$aid += 0;
	if ($aid) {
		$sql = qq!EXEC vpusers..addHistID $aid, "$msg", "$ip", "$who", "$date"!;
	}
	else {
		die $_ if ($name eq '');
		$sql = qq!EXEC vpusers..addHist "$name", "$msg", "$ip", "$who", "$date"!;
	}
	print "$sql\n";
	$ctr++;
	if ($ctr > 100) {
		print "GO\n";
		$ctr = 1;
	}
}
print "GO\n" unless($ctr == 1);
