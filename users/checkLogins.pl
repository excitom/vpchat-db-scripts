#!/usr/bin/perl

push (@srvrs, 'chang');
push (@srvrs, 'nala');
$mergedLogFile = "/tmp/accountLogins.log";
$file = "/logs/accountLogins.log";
push (@files, $file);

foreach $srvr (@srvrs) {
	open(L, "/bin/rsh $srvr \"cat $file\" |") || die "Can't get log from $srvr";
	$tmp = "/tmp/log.$srvr";
	push (@files, $tmp);
	open (TMP, ">$tmp") || die "Can't make temp file $tmp : $!";
	while (<L>) {
		print TMP;
	}
	close L;
	close TMP;
}
$list = join(' ', @files);
`cat $list | sort -k 5,5 -M -k 2,2 -k 3,4 | uniq > $mergedLogFile`;

open (LOG, "<$mergedLogFile") || die "Can't read $mergedLogFile : $!";
while (<LOG>) {
	next unless(/invalid password/);
	($date, $ip, $msg) = split(/\t/);
	$msg =~ /^<([^>]*)>/;
	$who = $1;
	$who{$who}++;
	$ip{$ip}++;
	$date{$who} = $date;
	$date{$ip} = $date;
}

print "\nMost common names:\n\n";
$i = 10;
foreach $n (sort { $who{$b} <=> $who{$a} } keys %who) {
	print "$who{$n}\t$n\t$date{$n}\n";
	last if (--$i == 0);
}

print "\nMost common IPs:\n\n";
$i = 10;
foreach $n (sort { $ip{$b} <=> $ip{$a} } keys %ip) {
	print "$ip{$n}\t$n\t$date{$n}\n";
	last if (--$i == 0);
}

foreach $srvr (@srvrs) {
	unlink "/tmp/log.$srvr";
}
unlink $mergedLogFile;
