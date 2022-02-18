{
####TITLE Credit card chargeback
die "Undefined variable 'from'" unless(defined($from));
die "Undefined variable 'fromName'" unless(defined($fromName));
die "Undefined variable 'email'" unless(defined($email));
die "Undefined variable 'aid'" unless(defined($aid));

$cannedMsg =<<MSG;
From: $from
To: $email
Reply-To: $from
Subject: Notification - Account Canceled

Account ID : $aid

We received a 'chargeback' notice from your credit card company, which means that you are disputing the charge.

As a result we are closing your account at VPchat and your credit card will not be accepted in the future.

We're sorry that we were unable to resolve any problems you might have had, and that you felt it necessary to take this step.

 --The VPchat Team

MSG
}
1;
