#!/usr/bin/perl
use Socket;
$ip = $ARGV[0];
$iaddr = inet_aton($ip);
print "$ip\n";
$host = scalar gethostbyaddr $iaddr, AF_INET;
print "$host\n";
