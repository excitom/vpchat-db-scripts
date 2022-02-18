#!/usr/bin/perl
#
# tom lang 4/2004
#
# Flag: -q => no DNS lookups
#
# Example format:
# Apr 20 00:00:05 zuul %PIX-4-106023: Deny icmp src outside:12.127.49.218 dst inside:66.45.126.62 (type 3, code 13) by access-group "outside_acl"
# Apr 20 00:00:06 zuul %PIX-4-401004: Shunned packet: 192.168.2.1 ==> 66.45.126.53 on interface outside
# Apr 20 00:00:06 zuul last message repeated 5 times
#Apr 20 03:47:42 zuul %PIX-4-209003: Fragment database limit of 200 exceeded:  src = 202.226.242.74, dest = 66.45.126.54, proto = udp, id = 56750
#

use Socket;

$quiet = ($ARGV[0] eq '-q') ? 1 : 0;

$top = 25;

$start = $end = '';

$from = $to = '';
$fromPort = $toPort = 0;
while (<STDIN>) {
  /(.*) zuul /;
  $ts = $1;
  $start = $ts if ($start eq '');
  if (/Deny/) {
    /Deny ([^:]+):([^ ]+) [^:]+:([^ ]+)/;
    $from = $2;
    $p = $1;
    $to = $3;
    (@p) = split(/\s+/, $p);
    $protocol = $p[$#p-2];
    (@f) = split('/', $from);
    if ($#f == 1) {
      $from = $f[0];
      $fromPort = $f[1];
      (@t) = split('/', $to);
      $to = $t[0];
      $toPort = $t[1];
      #print "$protocol $from:$fromPort -> $to:$toPort\n";
      $ports{$toPort}++;
    }
    else {
      #print "$protocol $from -> $to\n";
    }
    $attackers{$from}++;
    $targets{$to}++;
    $lastHit{$from} = $ts;
    $lastHit{$to} = $ts;
  }
  elsif (/Shunned/) {
    /packet: ([^ ]+) ==> ([^ ]+)/;
    $from = $1;
    $to = $2;
    #print "$from -> $to\n";
    $attackers{$from}++;
    $targets{$to}++;
    $shunned{$from} = 1;
    $lastHit{$from} = $ts;
  }
  elsif (/Fragment database/) {
    /src = ([^,]+), dest = ([^,]+), proto = ([^,]+),/;
    $from = $1;
    $to = $2;
    $protocol = $3;
    #print "$protocol $from -> $to\n";
    $attackers{$from}++;
    $targets{$to}++;
    $lastHit{$from} = $ts;
    $lastHit{$to} = $ts;
  }
  elsif (/message repeated/) {
    /repeated ([0-9]+) time/;
    $times = $1;
    #print "$from Times $times\n";
    $attackers{$from} += $times;
  }
}
$end = $ts;

format STDOUT_TOP =

		PIX log analysis

Start:	@<<<<<<<<<<<<<<<<<<<<<<<<<<
$start,
End:	@<<<<<<<<<<<<<<<<<<<<<<<<<<
$end,

Rank    IP address         Denials        Last Hit     Shunned?

Attackers (Top @>>):
$top,
.

format STDOUT =
@>>>>. @<<<<<<<<<<<<<<<   @>>>>>>>    @<<<<<<<<<<<<<<< @<
$ctr, $ip, $total, $lastHit, $shunned
.

$ctr = 1;
$quiet = 1;
foreach $ip (sort {$attackers{$b} <=> $attackers{$a}} keys %attackers) {
  if ($quiet) {
    $host = '';
  } else {
    $iaddr = inet_aton($ip);
    $host = scalar gethostbyaddr $iaddr, AF_INET;
  }
  $shunned = ($shunned{$ip}) ? 'Y' : '-';
  $total = $attackers{$ip};
  $lastHit = $lastHit{$ip};
  write;
  $ctr++;
  last if ($ctr > $top);
}

print "\nTargets:\n";
$ctr = 1;
foreach $ip (sort {$targets{$b} <=> $targets{$a}} keys %targets) {
  if ($quiet) {
    $host = '';
  } else {
    $iaddr = inet_aton($ip);
    $host = scalar gethostbyaddr $iaddr, AF_INET;
  }
  $total = $targets{$ip};
  $lastHit = $lastHit{$ip};
  write;
  $ctr++;
}

#print "\nPorts:\n";
#$ctr = 1;
#foreach $p (sort {$ports{$b} cmp $ports{$a}} keys %ports) {
  #print "$ctr. $p\t$ports{$p}\n";
  #$ctr++;
#}
