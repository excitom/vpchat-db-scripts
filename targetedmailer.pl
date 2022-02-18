#!/usr/bin/perl
#
# tom lang 6/94
#

## look for command line switches
## -l <list of names>

require "getopts.pl";   # make sure library routine is available
&Getopts('l:m:');
die "Need to specify -l <list of names>\n"      if ($opt_l eq "");

$from = "From: VP Chat<billing\@halsoft.com>\n";

open(USERS, "<$opt_l") || die "Can't open name list file $opt_l\n";
while(<USERS>) {
	next if (substr($_,0,1) eq "#");
	chop;
	(@fields) = split(/\t/);
	$to = $fields[0];
	$nickName = $fields[1];
	$password = $fields[2];
	print "$to\n";
	open(TMP, "| /usr/lib/sendmail -oi -oem -odq  -f support\@halsoft.com -t") || die "Can't open pipe to sendmail: $! ";
	print TMP <<MSG;
From: VPchat <billing\@vpchat.com>
Subject: We miss you!
To: $to

Dear Chatter,

We noticed that you haven't visited VPchat in a while. We miss you! Your friends miss you! Come on back and play some spades, attend one of our many events, or jump into a tournament. You can even keep your old name. Just in case you've forgotten your account info,

your chat name is $nickName
your password is $password

You can sign into your account at http://reg.vpchat.com/VP/account to renew it, and you'll be able to start chatting right away. We can't wait to see you back in VPchat!

best,
VPchat Support

MSG
	close(TMP);
}
