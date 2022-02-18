{
####TITLE Account renewed using credit balance, some credit left
die "Undefined variable 'from'" unless(defined($from));
die "Undefined variable 'fromName'" unless(defined($fromName));
die "Undefined variable 'to'" unless(defined($to));
die "Undefined variable 'aid'" unless(defined($aid));
die "Undefined variable 'amt'" unless(defined($amt));
die "Undefined variable 'bal'" unless(defined($bal));

$cannedMsg =<<MSG;
From: $from
To: $to
Reply-To: $from
Subject: Notification - Account Renewed

Your VPchat account renewed today (account ID $aid). We applied your credit to the \$$amt balance. You have \$$bal credit remaining.

If you have any questions about your account, please don't hesitate to email Customer Service at $from.

Thank you for your business.

  --The VPchat Team

MSG
}
1;
