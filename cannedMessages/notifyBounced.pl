{
####TITLE Bounced check
die "Undefined variable 'from'" unless(defined($from));
die "Undefined variable 'fromName'" unless(defined($fromName));
die "Undefined variable 'email'" unless(defined($email));
die "Undefined variable 'aid'" unless(defined($aid));
die "Undefined variable 'sub'" unless(defined($sub));
die "Undefined variable 'fee'" unless(defined($fee));
die "Undefined variable 'due'" unless(defined($due));

$cannedMsg =<<MSG;
From: $from
To: $email
Subject: Notification - ECheck Payment Failed
Reply-To: $from

Account number: $aid
Payment date: $date
Amount : \$$sub
Fee    : \$$fee (Returned Check Fee)
Now Due: \$$due

Your recent payment by ECheck was rejected by your bank. There are several reasons this could have happened, other than insufficient funds.

Please double check the identification information you registered with VPchat. Make sure that it matches the information on file with your bank. 

To edit and review your payment information go to:
$G_config{'secureURL'}/VP/changePmtInfo

Your account will remain suspended until arrangements are made to clear up this matter.

If you have questions or if you feel you have received this note by mistake, please contact us at $G_config{'billingEmail'}
Thank you for your business.

 --The VPchat Team
MSG
}
1;
