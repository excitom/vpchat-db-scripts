#!/usr/bin/perl
#
# Tom Lang 1/2002

open (USERS, "</u/vplaces/VPCOM/VPPLACES/users.txt");
open (HTML, ">/web/reg/html/VP/users.html.tmp");
while(<USERS>) {
	@fields = split;
	if ($fields[0] =~ /B/) {
		$buddy++;
		next;
	}
	$total++;
	$room = ($fields[4] =~ /http:\/\//) ? $fields[4] : "private room";
	$room =~ s/\?.*$//;
	$users{$fields[3]} = $room;
}
close USERS;
open (USERS, "</u/vplaces/VPCOM/VPPLACES.adult/users.txt");
while(<USERS>) {
	@fields = split;
	if ($fields[0] =~ /B/) {
		$buddy++;
		next;
	}
	$atotal++;
	$room = ($fields[4] =~ /http:\/\//) ? $fields[4] : "private room";
	$room =~ s/\?.*$//;
	$users{$fields[3]} = $room;
}
close USERS;

print HTML <<HTML;
<table border=0>
<tr><td colspan=2>Total people chatting vpchat: <b>$total</b></td></tr>
<tr><td colspan=2>Total people chatting in vpadult: <b>$atotal</b></td></tr>
<tr><td colspan=2>People using Chat Tracker: <b>$buddy</b></td></tr>
<tr><td colspan=2>Online now ...</td></tr>
HTML
foreach $user (sort keys %users) {
	print HTML "<tr><td align=left colspan=2>$user</td></tr>\n";
}
print HTML <<HTML;
</table>
HTML
close HTML;
rename "/web/reg/html/VP/users.html.tmp", "/web/reg/html/VP/users.html";
