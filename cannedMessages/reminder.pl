{
####TITLE Reminders (many variations)
die "Undefined variable 'from'" unless(defined($from));
die "Undefined variable 'fromName'" unless(defined($fromName));
die "Undefined variable 'email'" unless(defined($email));
die "Undefined variable 'aid'" unless(defined($aid));
die "Undefined variable 'accountStatus'" unless(defined($accountStatus));
die "Undefined variable 'paymentStatus'" unless(defined($paymentStatus));
die "Undefined variable 'type'" unless(defined($type));
die "Undefined variable 'autoRenew'" unless(defined($autoRenew));
die "Undefined variable 'renewalDate'" unless(defined($renewalDate));
die "Undefined variable 'due'" unless(defined($due));
die "Undefined variable 'poBox'" unless(defined($poBox));

$line1 = '';
$part2 = '';
#
# New, unpaid account?
#
if ($accountStatus == 1) {
  $subject = 'Payment reminder';
  $line1 =<<MSG;
Congratulations on your new VPchat subscription. We haven't received your payment yet.
MSG
  #
  # no subscription -- a paper check or money order payer
  #
  if ($type == 0) {
    $part2 =<<MSG;

For fastest, easiest payment please visit our credit card page:
$G_config{'secureURL'}/VP/pay

You can make your payment directly and your account will be reactivated immediately.\n

You may also mail payments to:
$poBox

Please remember to put your account number ($aid) on the check. Also remember that we will be unable to reactivate your account until the payment arrives.
MSG
  }
  #
  # paypal subscription
  #
  elsif ($type == 1) {
    $part2 =<<MSG;

To activate your account, you can simply send money from PayPal to us at: $G_config{'billingEmail'}

Or, go to $G_config{'secureURL'}/VP/pay and pay us directly.
MSG
  }
  #
  # credit card subscription
  #
  elsif ($type == 2) {
    $part2 =<<MSG;

To activate your account, go to $G_config{'secureURL'}/VP/pay 

You can update your credit card information and make a payment.
MSG
  }
  #
  # echeck subscription
  #
  elsif ($type == 3) {
    $part2 =<<MSG;

To activate your account, go to $G_config{'secureURL'}/VP/pay

You can update your bank account information and make a payment.
MSG
  }
}
#
# Pending echeck
#
elsif ($paymentStatus == 4) {
  $subject = "Pending Echeck payment";
  $line1 =<<MSG;
You have made a payment for your VPchat subscription using an electronic check. It may take up to 7 days for the bank to clear your check.
MSG

  #
  # new account
  #
  if ($accountStatus == 1) {
    $part2 =<<MSG;
We will not be able to activate your new account until your check clears. 

Because of the amount of online banking and check fraud, we are forced to have this policy. Our apologies for any undue delay.
MSG
  }
  #
  # pending or OK account
  #
  elsif (($accountStatus == 2) || ($accountStatus == 0)) {
    $part2 =<<MSG;
However, since you are a customer in good standing, we are leaving your account active while we wait for the check to clear. You may continue to use our service during this time.
MSG
  }
  #
  # expired account
  #
  elsif ($accountStatus == 5) {
    $part2 =<<MSG;
Unfortunately, we are unable to re-activate your new account until your check clears. 

Because of the amount of online banking and check fraud, we are forced to have this policy. Our apologies for any undue delay.
MSG
  }
  #
  # something that shouldn't happen
  #
  else {
    die "Incorrect usage: sending a payment reminder to an account with $accountStatus{$accountStatus} status";
  }
}
#
# Overdue account with autorenew?
#
elsif (($accountStatus == 5) || (($accountStatus == 2) && ($paymentStatus == 2))) {
  $subject = "Renewal Reminder";
  $line1 = "This note is a reminder about renewing your VPchat subscription.\n";

  #
  # expired
  #
  if ($accountStatus == 5) {
    $part2 =<<MSG;
We'd love to have you back :-)

MSG
  }
  #
  # auto-renew subscription
  #
  if ($autoRenew) {
    #
    # paypal subscription
    #
    if ($type == 1) {
      $part2 .=<<MSG;
Unfortunately, there seems to be a problem with your PayPal subscription. For some reason, PayPal was unable to process the payment. 

You can send money from PayPal to us at: 
$G_config{'billingEmail'}

Or:
 $G_config{'secureURL'}/VP/pay and pay us directly.
MSG
    }
    #
    # credit card subscription
    #
    elsif ($type == 2) {
      $part2 .=<<MSG;
Unfortunately, there seems to be a problem with your credit card. Perhaps the expiration date has passed. Please go to $G_config{'secureURL'}/VP/pay and update your credit card information. You can make your payment as you do so, and your account will be reactivated immediately.
MSG
    }
    #
    # echeck subscription
    #
    elsif ($type == 3) {
      $part2 .=<<MSG;
Unfortunately, there seems to be a problem with your eCheck information. Please go to: $G_config{'secureURL'}/VP/pay and update your bank account information. You can make your payment as you do so, and your account will be reactivated immediately.
MSG
    }
  }
  #
  # Not an auto-renew subscription
  #
  else {
    #
    # check or money order payer
    #
    if ($type == 0) {
      $part2 .=<<MSG;
For fastest, easiest payment please visit our credit card page:
$G_config{'secureURL'}/VP/pay

You can make your payment directly and your account will be
reactivated immediately.

You may also mail payments to:
$poBox

Please remember to put your account number ($aid) on the check. Also remember that we will be unable to reactivate your account until the payment arrives.
MSG
    }
    #
    # paypal but not autorenew
    #
    elsif ($type == 1) {
      $part2 .=<<MSG;
You originally had an auto-renewing PayPal subscription but it was cancelled. To reactivate your account, please send a payment to:
$G_config{'billingEmail'}

Or go to: $G_config{'secureURL'}/VP/pay and pay us directly.
MSG
    }
    #
    # echeck or credit card but not auto-renew
    #
    elsif (($type == 3) || ($type == 2)) {
      $part2 .=<<MSG;
You originally had an auto-renewing subscription but it was cancelled. To reactivate please visit our payment page:
$G_config{'secureURL'}/VP/pay

Your account can be reactivated immediately.
MSG
    }
  }
}
#
# Account is Pending or Waiting Payment
#
elsif (($accountStatus == 2) || ($paymentStatus == 3)) {
  $subject = "Payment Reminder";
  $line1 = "This note is a reminder about payment for your VPchat subscription.\n";

  if ($type == 1) {
    $part2 .=<<MSG;
The reason for this is that you changed your subscription for VPchat but your PayPal subscription payment has not been updated.

We encourage you to pay us directly using our web page:
$G_config{'secureURL'}/VP/pay

You can pay by credit card, debit card, or electronic check. You should also cancel your PayPal subscription, so they won't charge you for any future payments. If you forget to do this, we'll do it for you.
MSG
  }
  elsif ($type == 2) {
    $part2 .=<<MSG;
Unfortunately, there seems to be a problem with your credit card. Perhaps the expiration date has passed. Please go to $G_config{'secureURL'}/VP/pay and update your credit card information. You can make your payment as you do so, and your account will be reactivated immediately.
MSG
  }
  elsif ($type == 3) {
    $part2 .=<<MSG;
Unfortunately, there seems to be a problem with your
eCheck information. Please go to: $G_config{'secureURL'}/VP/pay and update your bank account information. You can make your payment as you do so, and your account will be reactivated immediately.
MSG
  }
}
#
# Miscellaneous
#
elsif (($accountStatus == 0) || ($accountStatus == 3) || ($accountStatus == 4)) {
  die "Incorrect usage: sending a payment reminder to an account with $accountStatus{$accountStatus} status";
}
else {
  die "Unknown combination";
}

$cannedMsg =<<MSG;
From: $from
To: $email
Subject: $subject
Reply-To: $from

Hi,
$line1
Account number: $aid
Renewal date: $renewalDate
Status: $accountStatus{$accountStatus}
Amount due: \$$due

$part2
If you have questions or comments, please don't hesitate to contact us at $G_config{'billingEmail'} 

Thank you for your business.

 ---The VPchat Team

MSG

}
1;
