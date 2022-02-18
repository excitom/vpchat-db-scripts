{
####TITLE Account balance adjusted
die "Undefined variable 'from'" unless(defined($from));
die "Undefined variable 'email'" unless(defined($email));
die "Undefined variable 'accountID'" unless(defined($accountID));
die "Undefined variable 'payment'" unless(defined($payment));
die "Undefined variable 'newBal'" unless(defined($newBal));

$msg =~ s/\r//g;
$msg = '' if ($msg =~ /^\s*$/);
$cannedMsg =<<MSG;
From: $from
To: $email
Reply-To: $from
Subject: Confirmation - Account Balance Adjustment

We have adjusted your account balance.

Account ID: $accountID
Adjustment: \$$payment

Your account balance is now: \$$newBal

If you have any questions about your account, please don't hesitate to email Customer Service at $from.
MSG

  if ($msg ne '') {
    $cannedMsg .= "\n$msg\n";
  } 

  $cannedMsg .=<<MSG;

Thank you for your business.

  --The VPchat Team

MSG

  return $cannedMsg;

 }
1;
