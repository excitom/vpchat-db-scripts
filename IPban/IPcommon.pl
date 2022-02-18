##################
#
# Common initialization
#
BEGIN {
require "/web/reg/configKeys.pl";
	$srvr = $G_config{'VPUSERSserver'};
	$logFile = "/logs/IPban.log";
	$lockFile = "/tmp/.IPban.lock";
	$srvrURL = $G_config{'regURL'};

	$srvrHome = "/u/vplaces";
	$sigSrvr = $srvrHome . "/scripts/IPban/signalServer";
	$IPfile = $srvrHome . "/VPCOM/VPUSERS/bannedIPs/IPs.txt";

	$maxIPs = 256;
}
1;

##################
#
# subroutine: wake up the vpusers server
#
sub signalServer {
	my $primary = 0;
	$primary = shift @_ if ($#_ == 0);
	my @lines = `cat /u/vplaces/VPCOM/VPUSERS/vpusers.pid`;
	my $pid = $lines[0];
	chomp $pid;
	#`$sigSrvr -1 $pid`;	# why not just do a kill? needs to be SetUID vplaces
	kill 'HUP', $pid;

	#
	# copy file to other 'reg' web servers, to support IP ban
	# for the websql pages. also copy to the vpadult server.
	#
	if ($primary) {
	   my (@srvrs) = split(/,/, $G_config{'regFEWS'});
	   my $s;
	   foreach $s (@srvrs) {
		`/bin/rcp $IPfile $s:$IPfile`;
	   }
	   `/bin/rcp $IPfile $G_config{'VPUSERSadultServer'}:$IPfile`;
	}

	#
	# tickle the vpadult users server
	#
	`/bin/rsh -l vplaces $G_config{'VPUSERSadultServer'} /u/vplaces/scripts/IPban/signalServer.pl`;
}
1;

##################
#
# subroutine: write to the log
#
sub logMsg {
	my $msg = $_[0];
	my $who = $_[1];
	my $who2 = $_[2];
	$msg .= "\n" unless($msg =~ /\n$/);

	#
	# Log this action
	#
	open (LOG, ">>$logFile");
	my $timeStamp = localtime;
	print LOG "$timeStamp - $who $who2 - $msg";
	close LOG;
	chmod 0666, $logFile;
}
1;

##################
#
# Subroutine: file locking
#
sub lockFile {
	my $lockFile = $_[0];
	my $tmpFile = "$lockFile$$";	# append process #
	my $locked;
	open(T, ">$tmpFile") || die "Can't create $tmpFile : $!";
	close T;
	my $retry = 20;
	while (! ($locked = link($tmpFile, $lockFile))) {
		die "Can't lock $lockFile" unless($retry--);
		sleep 1;
	}
	unlink $tmpFile;
}
1;
sub unlockFile {
	my $lockFile = $_[0];
	unlink $lockFile;
}
1;

sub numerically_by_value { $minutes{$b} <=> $minutes{$a}; }
1;

##################
# 
# Subroutine: write file
#
#sub writeFile {
	#my $tmpFile = "$IPfile.$$";
	#open(LIST, ">$tmpFile") || die "Can't write to $tmpFile : $!";
	   #foreach $ip (sort numerically_by_value keys %minutes) {
		#print LIST "$ip:$netmask{$ip}:$minutes{$ip}:$hosts{$ip}\n";
	   #}
	#close LIST;
	#&lockFile($lockFile);
	#rename ($tmpFile, $IPfile) || die "Can't update $IPfile : $!";
		## if we die here, the file is left locked - but things
		## are totally hosed anyway ...
	#chmod 0666, $IPfile;
	#&unlockFile($lockFile);
#}
#1;
