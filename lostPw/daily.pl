#!/usr/bin/perl
#
# Tom Lang 9/2002
#

require "/web/reg/configKeys.pl";
die "No config keys" unless(defined(%G_config));

$dir = "/logs/lostPw";
$logFile = "$dir/process.log";
$host = `hostname`;
chomp $host;
$to = $G_config{'devEmail'};

open( MAIL, "| /usr/lib/sendmail  -f \"vplaces\@halsoft.com\" -F \"Virtual Places\" $to > /dev/null") || die "Can't send mail";

print MAIL <<MSG;
Subject: Lost Password Requests on $host
To: $to

MSG
open (LOG, "<$logFile") || die "Can't read $logFile : $!";
while (<LOG>) {
	print MAIL;
}
close LOG;
close MAIL;
open (LOG, ">$logFile") || die "Can't truncate $logFile : $!";
close LOG;
