#!/usr/bin/perl
#
# Create account log files for a new user account.
#
# This is meant to be called by rsh/ssh from another server.
#
# Input: account owner name, account ID, IP address of creator
#
# Tom Lang 3/2002


##################
#
# Write action to user-specific log file
#
sub writeLog {
	my $user = shift @_;
	my $aid = shift @_;
	my $ip = shift @_;
	my $msg = shift @_;
	$user =~ tr/[A-Z]/[a-z]/;
	$msg .= "\n" unless ($msg =~ /\n$/);
	my $logFile = "/logs/users/" . $user;
	open (LOG, ">>$logFile");
	my $now = scalar localtime;
	$msg = "$ip\t$user\t$msg";
	print LOG "$now\t$msg";
	close LOG;
	link $logFile, "/logs/accountIDs/$aid";

	&writeAcctLog( $msg );
}

##################
#
# Write action to account activity log file
#
sub writeAcctLog {
	my $msg = $_[0];
	$msg .= "\n" unless ($msg =~ /\n$/);
	open (LOG, ">>/logs/account_usage.log");
	my $now = scalar localtime;
	print LOG "$now\t$msg";
	close LOG;
}

##################
#
# START HERE
#
die "Programming error" unless ($#ARGV == 2);
$name = shift @ARGV;
$aid = shift @ARGV;
$ip = shift @ARGV;

unless (-f "/logs/accountIDs/$aid") {
	open (LF, ">/logs/accountIDs/$aid");
	close LF;
}

# if a log file existed with this name, perhaps it's
# a recycled name. let's keep the history around.

if (-f "/logs/users/$name") {
	`cat /logs/users/$name >> /logs/accountIDs/$aid`;
	unlink "/logs/users/$name";
}
link "/logs/accountIDs/$aid", "/logs/users/$name";
&writeLog( $name, $aid, $ip, " new account $aid");
chmod 0666,"/logs/accountIDs/$aid";
chmod 0666,"/logs/users/$name";
