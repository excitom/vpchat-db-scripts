#!/usr/bin/perl
#
# Batch process lost password requests.
#
# Tom Lang 9/2002
#

require "/web/reg/configKeys.pl";
die "No config keys" unless(defined(%G_config));

$dir = "/logs/lostPw";
$logFile = "$dir/process.log";
$from = $G_config{'helpdeskEmail'};
$FromW = "HalSoft Customer Service";

$reqDir = "$dir/requests";
opendir REQ, $reqDir || die "Can't read $reqDir : $!";
@requests = readdir REQ;
closedir REQ;

open (LOG, ">>$logFile") || die "Can't append to $logFile : $!";

$ctr = 0;
chdir $reqDir;
foreach $req (@requests) {
	next if (($req eq '.') || ($req eq '..'));

	open (REQ, "<$req") || die "Can't read $reqDir/$req : $!";
	$email = <REQ>;
	chomp $email;
        if ( open( MAIL, "| /usr/lib/sendmail -f $from -F \"$FromW\" $email > /dev/null" ) ) {
		while (<REQ>) {
			print MAIL;
		}
		close REQ;
		unlink $req;
		$now = scalar localtime;
		print LOG join("\t", $now, "Sending password for $req to $email") . "\n";
		$ctr++;
	}
	else {
		warn "Can't send mail to $email";
	}
	close MAIL;
}

if ($ctr) {
	$now = scalar localtime;
	$rqs = ($ctr > 1) ? "requests" : "request";
	print LOG join("\t", $now, "====== Processed $ctr $rqs ======") . "\n";
}
#else {	###### DEBUG
	#$now = scalar localtime;
	#print LOG join("\t", $now, "====== DEBUG ======") . "\n";
#}	######
close LOG;
