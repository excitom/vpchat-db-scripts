#!/usr/bin/perl
$exit = ($ARGV[0] eq '-x') ? 1 : 0;
$first = 1;
while (<STDIN>) {
	if ($first) {
		$first = 0;
		/^\[([^ ]+) /;
		$date = $1;
		if ($exit) {
			print "EXIT frequency on $date\n";
		} else {
			print "ENTER frequency on $date\n";
		}
	}
	if (/ enter /) {
		/ enter "[^"]+" ([^ ]+) /;
		$ip = $1;
		$ips{$ip}++;
		@octets = split(/\./, $ip);
		pop @octets;
		$ip = join('.', @octets);
		$net1{$ip}++;
		@octets = split(/\./, $ip);
		pop @octets;
		$ip = join('.', @octets);
		$net2{$ip}++;
		@octets = split(/\./, $ip);
		pop @octets;
		$ip = join('.', @octets);
		$net3{$ip}++;
	}
	if ($exit)  {
		next unless (/ exit /);
	}
	else {
		next unless (/ enter /);
	}
	/ (\d\d):(\d\d):(\d\d)\]/;
	$hr = $1;
	$min = $2;
	$sec = $3;
	$hour{$hr}++;
	$minute{"$hr:$min"}++;
	$sec{"$hr:$min:$sec"}++;
}
$max = 25;
print "Top $max\n";
$count = 1;
print "\nPer Hour:\n";
foreach $h (sort {$hour{$b} <=> $hour{$a}} keys %hour) {
	print "$h - $hour{$h}\n";
	last if ($count++ > $max);
}
$count = 1;
print "\nPer Minute:\n";
foreach $m (sort {$minute{$b} <=> $minute{$a}} keys %minute) {
	print "$m - $minute{$m}\n";
	last if ($count++ > $max);
}
$count = 1;
print "\nPer Second:\n";
foreach $s (sort {$sec{$b} <=> $sec{$a}} keys %sec) {
	print "$s - $sec{$s}\n";
	last if ($count++ > $max);
}
$count = 1;
print "\nIndividual IP\n";
foreach $i (sort {$ips{$b} <=> $ips{$a}} keys %ips) {
	print "$i - $ips{$i}\n";
	last if ($count++ > $max);
}
$count = 1;
print "\nSubnet IP\n";
foreach $i (sort {$net1{$b} <=> $net1{$a}} keys %net1) {
	print "$i - $net1{$i}\n";
	last if ($count++ > $max);
}
$count = 1;
print "\nSubnet IP\n";
foreach $i (sort {$net2{$b} <=> $net2{$a}} keys %net2) {
	print "$i - $net2{$i}\n";
	last if ($count++ > $max);
}
$count = 1;
print "\nSubnet IP\n";
foreach $i (sort {$net3{$b} <=> $net3{$a}} keys %net3) {
	print "$i - $net3{$i}\n";
	last if ($count++ > $max);
}
