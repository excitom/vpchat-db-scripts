#!/usr/bin/perl
#
# Function: Periodically read the list of banned IPs, decrement
#	penalty times, and notify the vpusers daemon when any expire.
#
# Tom Lang 
#

require "/u/vplaces/scripts/IPban/IPcommon.pl";

#
# Since we run two communities, sharing a user database, the procedure
# is different for the secondary community. The primary community (vpchat)
# maintains the IP ban list, and copies it to the secondary (vpadult) when
# it changes. The secondary community just needs to notice when the file
# changes, and sigHUP the vpusers server.
#
$primary = 1;
if ($#ARGV == 0) {
  $flag = shift @ARGV;
  $primary = 0 if ($flag eq '-s');
}

if ($primary) {
  &lockFile( $lockFile );

  if (-f "$IPfile") {
    open(LIST, "<$IPfile") || die "Can't read $IPfile : $!";
	# if we die here the file is left locked, but things
	# are hosed so we want to draw attention to the problem
    while (<LIST>) {
	chomp;
	($ip, $netmask, $time, $h) = split(/:/);
	$netmask{$ip} = $netmask;
	$minutes{$ip} = $time;
	$hosts{$ip} = $h;
    }
    close LIST;
  }
  
  $alert = 0;
  open(LIST, ">$IPfile") || die "Can't write to $IPfile : $!";
  foreach $ip (keys %minutes) {
	$minutes{$ip}--;
	if ($minutes{$ip}) {
		print LIST "$ip:$netmask{$ip}:$minutes{$ip}:$hosts{$ip}\n";
	} else {
		$alert = 1;
		push (@expired, $ip);
	}
  }
  close LIST;

  chmod 0666, $IPfile;
  &unlockFile( $lockFile );

  if ($alert) {
	$expired = join(',', @expired);
	&signalServer($primary);
	&logMsg("Penalty expired for $expired - vpusers notified", "monitor deamon", "");
  }
}

else {
  if (-f $IPfile) {
	&signalServer($primary);
	unlink $IPfile;
  }
}
