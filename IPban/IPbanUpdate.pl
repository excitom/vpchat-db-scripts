#!/usr/bin/perl
#
# Function: Update the banned IP list and notify the vpusers daemon.
#
# Input: cmd = ban|forgive
#        IP address to ban
#        Person who applied the ban (chat name)
#	 IP address of person who applied the ban
#        If cmd = ban
#          Netmask
#          Minutes duration
#
# Tom Lang 
#

require "/u/vplaces/scripts/IPban/IPcommon.pl";

die "usage: IPbanUpdate.pl ban|forgive IP Who whoIP [Netmask] [Minutes]\n\n" if ($#ARGV < 3);
$cmd = shift @ARGV;
die "usage: IPbanUpdate.pl ban|forgive IP Who whoIP [Netmask] [Minutes]\n\n" unless (($cmd eq 'ban') || ($cmd eq 'forgive'));
$ip = shift @ARGV;
$who = shift @ARGV;
$whoIp = shift @ARGV;
if ($cmd eq 'ban') {
  die "usage: IPbanUpdate.pl ban IP Who whoIP Netmask Minutes\n\n" if ($#ARGV != 1);
  $netMask = shift @ARGV;
  $minutes = shift @ARGV;
}

&lockFile( $lockFile );

#
# Read the current list
#
if (-f "$IPfile") {
    open(LIST, "<$IPfile") || die "Can't read $IPfile : $!";
	# if we die here the file is left locked, but things
	# are hosed so we want to draw attention to the problem
    while (<LIST>) {
	chomp;
	my ($ip, $netMask, $time, $n) = split(/:/);
	$netMask{$ip} = $netMask;
	$minutes{$ip} = $time;
	$who{$ip} = $n;
    }
    close LIST;
}
  
open(LIST, ">$IPfile") || die "Can't write to $IPfile : $!";
foreach $i (keys %minutes) {
	#
	# If forgiving a ban, don't write out the ban record for the 
	#	forgiven IP.
	# If adding a ban, drop the existing ban for this IP, if any.
	#
	if ($i eq $ip) {
	   if ($cmd eq 'forgive') {
		&logMsg("Forgiven IP: $ip" , $who, $whoIp);
	   } else {
		&logMsg("Existing ban for $ip overridden" , $who, $whoIp);
	   }
	   next;
	}
	print LIST "$i:$netMask{$i}:$minutes{$i}:$who{$i}\n";
}
if ($cmd eq 'ban') {
	print LIST "$ip:$netMask:$minutes:$who\n";
	&logMsg("Banned IP: $ip Netmask $netMask" , $who, $whoIp);
}
close LIST;

chmod 0666, $IPfile;
&unlockFile( $lockFile );

&signalServer(1);
