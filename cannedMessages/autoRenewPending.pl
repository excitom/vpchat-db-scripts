{
####TITLE Subscription will renew without payment
die "Undefined variable 'from'" unless(defined($from));
die "Undefined variable 'fromName'" unless(defined($fromName));
die "Undefined variable 'to'" unless(defined($to));
die "Undefined variable 'balance'" unless(defined($balance));
die "Undefined variable 'subscrCost'" unless(defined($subscrCost));

$cannedMsg =<<MSG;
From: $from
To: $to
Reply-To: $from
Subject: Notification - Subscription Renewed

Your account has \$$balance that will be applied to your subscription cost (\$$subscrCost), so your subscription will renew automatically on $rDate and you won't owe anything at this time.

If you have any questions about your account, please don't hesitate to email Customer Service at $from.

Thank you for your business.

  --The VPchat Team

MSG
}
