####TITLE Payment receipt 
sub pmtReceipt {
  my $from = shift @_;
  my $fromName = shift @_;
  my $email = shift @_;
  my $accountID = shift @_;
  my $payment = shift @_;
  my $reason = shift @_;
  my $newBal = shift @_;
 
  my $cannedMsg =<<MSG;
From: $from
To: $email
Reply-To: $from
MSG

  #
  # PayPal echeck cleared
  #
  if ($reason eq "cleared") {
    $cannedMsg .=<<MSG;
Subject: Confirmation - PayPal Payment Cleared

Account ID : $accountID
Amount     : \$$payment

Your PayPal payment has cleared and your account balance now reflects
the payment amount. If your account had expired, it is now reactivated.
MSG
  }
  #
  # PayPal echeck denied
  #
  elsif ($reason eq "denied") {
    $cannedMsg .=<<MSG;
Subject: Notification - PayPal Payment Failed

Account ID : $accountID
Amount     : \$$payment

Your PayPal payment was rejected by your bank. You need to make other
arrangements to pay for your account.
MSG
  }
  else {
    $cannedMsg .=<<MSG;
Subject: Thank you for your payment

Account ID : $accountID
Amount     : \$$payment
MSG
  }

  #
  # OVERDUE account
  #
  if ($reason eq "overdue") {
    $cannedMsg .=<<MSG;

We received your payment and your account has been reactivated. Your
password was not changed.
MSG
  }

  #
  # payment was by echeck, acct is OK or pending
  #
  elsif ($reason eq "pending") {
    $cannedMsg .=<<MSG;

Your balance will not reflect the payment until your eCheck clears. Echecks can take up to 7 days to clear through the banking system.

You will receive confirmation when the eCheck clears. Your account will remain open during this process.
MSG
  }

  #
  # payment was insufficient to clear the balance
  #
  elsif ($reason eq "insufficient") {
    $cannedMsg .=<<MSG;

Your recent payment was not sufficient to clear the balance due on your account.
MSG
  }

  #
  # payment was a subscription renewal
  #
  elsif ($reason eq "renewal") {
    $cannedMsg .=<<MSG;

Your account is set to renew automatically. If you do not want to renew your subscription again, you may cancel future automatic payments at any time:

$G_config{'regURL'}/VP/changePmtInfo
MSG
  }

  #
  # payment was a PayPal subscription renewal
  #
  elsif ($reason eq "pprenewal") {
    $cannedMsg .=<<MSG;

Your PayPal subscription is set to renew your VPchat account automatically. If you do not want to renew your subscription again, you may cancel future automatic payments at any time:
http://www.paypal.com
MSG
  }

  #
  # payment is being held until clearance (echeck), expired
  #
  elsif ($reason eq "held") {
    $cannedMsg .=<<MSG;

Your balance will not reflect the payment until your eCheck clears. Echecks can take up to 7 days to clear through the banking system.

Since your account has expired, it may remain locked while we wait for the check to clear, depending on your payment history.

Please see $G_config{'regURL'}/VP/account for your account status. 
MSG
  }

  if (($newBal ne '') && ($newBal != 0)) {
    $cannedMsg .=<<MSG;

Your account balance is now: \$$newBal.
MSG
  }

  if (defined($acctMsg) && ($acctMsg ne '')) {
    $cannedMsg .=<<MSG;

$acctMsg
MSG
  }

  $cannedMsg .=<<MSG;

If you have any questions about your account, please don't hesitate to email Customer Service at $from.

Thank you for your business.

 --The VPchat Team
MSG

  return $cannedMsg;
}
1;
