#!/usr/local/bin/perl
#
# Tom Lang 3/98
#
$G_isql_exe = '/t/t/s/sybase/bin/isql -Uvpusr -Pvpusr1 -SSYBASE';
$G_statdir = "/tmp/";
$tempsql = $G_statdir . ".temp.sql.$$";

$G_isql_exe = '/u/vplaces/s/sybase/bin/isql -Uvpusr -Pvpusr1 -SSYBASE';
$FromE = "vplaces\@halsoft.com";
$FromW = "HalSoft VP.";

while (<STDIN>) {
	chop;
	$name = $_;
	$sql_cmd = qq|select email from registration,users where users.userID=registration.userID and nickName="$name"\ngo\n|;

	open (SQL_IN, ">$tempsql") || die "Can't write to $tempsql : $!\n";
	print SQL_IN $sql_cmd;
	close SQL_IN;

	open (SQL_OUT, "$G_isql_exe -i $tempsql |") || die "Can't read from $G_isql_exe -i $tempsql : $!\n";

	while (<SQL_OUT>) {
		last if (/-----/);
	}
	$_ = <SQL_OUT>;
	$_ = <SQL_OUT>;
	chop;
	s/\s+//g;
	$mailTo = $_;
	print "Sending mail to $mailTo - chat name $name\n";
        if ( open( MAIL, "| /usr/lib/sendmail  -odb -f \"$FromE\" -F \"$FromW\" $mailTo
 > /dev/null" ) ) {
                print MAIL <<MSG;
From: "HalSoft VP Chat Community"<$FromE>
To: $mailTo
Reply-To: $FromE
Errors-To: $FromE
Subject: Chat name $name restored

Dear Chat User $name:

Our system shows that your chat nickname had been banned from our
community by mistake. We have restored your chat name and you should be
able to use our service normally. 

We apologize for the incovenience this situation may have caused you.  If
you experience more difficulties, please report any problems to our
Feedback team at
http://reg.vpchat.com/feedback

Thank you very much and see you online!

-- The HalSoft Team
MSG
	close MAIL;
   }
}
unlink($tempsql);
