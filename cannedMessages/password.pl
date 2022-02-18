{
####TITLE Send password to existing account
die "Undefined variable 'from'" unless(defined($from));
die "Undefined variable 'fromName'" unless(defined($fromName));
die "Undefined variable 'email'" unless(defined($email));
die "Undefined variable 'accountID'" unless(defined($accountID));
die "Undefined variable 'name'" unless(defined($name));
die "Undefined variable 'pswd'" unless(defined($pswd));

$cannedMsg =<<MSG;
From: $from
To: $email
Subject: Notification - Account Password
Reply-To: $from

Here is the password for your account.

Account #: $accountID
User name: $name
Password : $pswd

If you have any questions about your account, please don't hesitate to email Customer Service at $from.

Thank you for your business.


  --The VPchat Team

MSG
}
1;
