#!/usr/bin/perl
#
# SIGHUP the vpusers.exe process so it will re-read the IP ban file
#
# Tom Lang 2/2002
#
@lines = `cat /u/vplaces/VPCOM/VPUSERS/vpusers.pid`;
open (L, ">>/logs/x");
$> = $<;
$pid = $lines[0];
print L "PID $pid";
print L "UID $> $<\n";
chomp $pid;
#`kill -1 $pid`;
$cnt = kill 'HUP', $pid;
print L "$cnt\n";
close L;
