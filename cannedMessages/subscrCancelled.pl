{
####TITLE Confirm subscription cancelled (by Cmgmt)
die "Undefined variable 'from'" unless(defined($from));
die "Undefined variable 'fromName'" unless(defined($fromName));
die "Undefined variable 'email'" unless(defined($email));
die "Undefined variable 'accountID'" unless(defined($aid));
die "Undefined variable 'type'" unless(defined($type));
die "Undefined variable 'accountStatus'" unless(defined($accountStatus));
die "Undefined variable 'renewalDate'" unless(defined($renewalDate));
$renewalDate =~ s/ \d\d*:\d\d.*$//;

$cannedMsg =<<MSG;
From: $from
To: $email
Reply-To: $from
Subject: Confirmation - Automatic Renewal Canceled
Reply-To: $from

Account number: $aid

At your request, your $subscrTypes{$type} subscription was canceled. This means that VPchat will not automatically charge you for renewal.
MSG

if ($accountStatus == 0) {
  $cannedMsg .=<<MSG;

You may continue using your account until the expiration date: $renewalDate.
MSG
}
unless(($accountStatus == 3) || ($accountStatus == 4)) {
  $cannedMsg .=<<MSG;

You are welcome to continue or reactivate your subscription at any time by sending us a payment. To send a payment or reactivate your subscription go to:
$G_config{'secureURL'}/VP/changePmtInfo

If you have any questions about your account, please don't hesitate to email Customer Service at $from.

Thank you for your business.

  --The VPchat Team
MSG
}

$cannedMsg .=<<MSG;

MSG
}
1;
