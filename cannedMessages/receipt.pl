####TITLE Payment receipt
sub pmtReceipt {
  die "Undefined variable(s)" unless ($#_ == 6);
  my $from = shift @_;
  my $fromName = shift @_;
  my $email = shift @_;
  my $accountID = shift @_;
  my $payment = shift @_;
  my $reason = shift @_;
  my $newBal = shift @_;

  my $cannedMsg =<<MSG;
From: $from ($fromName)
To: $email
Reply-To: $from
Subject: Thanks for your payment

Thank you for your payment!

Account ID : $accountID
Amount     : \$$payment
MSG

  #
  # OVERDUE account
  #
  if ($reason eq "overdue") {
    $cannedMsg .=<<MSG;

Your account was temporarily suspended while we awaited your payment.
Your account should be reactivated now. Your password was not changed.

MSG
  }

  #
  # payment was insufficient to clear the balance
  #
  elsif ($reason eq "insufficient") {
    $cannedMsg .=<<MSG;

Your payment was not sufficient to clear the balance due on your account.
If you feel this is an error, please contact us at:
$G_config{'billingEmail'}

MSG
  }

  #
  # payment was a subscription renewal
  #
  elsif ($reason eq "renewal") {
    $cannedMsg .=<<MSG;

When you signed up for your account you agreed to a subscription that
renews automatically. If you do not want to renew your subscription
again, you may cancel future automatic payments at any time before
your next renewal using this web page:
$G_config{'regURL'}/VP/changePmtInfo

MSG
  }

  if (defined($newBal) && ($newBal ne '')) {
    $cannedMsg .=<<MSG;

Your account balance is now: \$$newBal.
MSG
  }


  #
  # payment is being held until clearance (echeck)
  #
  elsif ($reason eq "held") {
    $cannedMsg .=<<MSG;

PLEASE NOTE: You have paid using an ELECTRONIC CHECK. It may take up
to 7 days for your bank to process your check. If your account was
deactivated due to overdue payment, it may remain locked while we wait
for the check to clear, depending on your payment history.

Please see $G_config{'regURL'}/VP/account for your account status, and
reply to this message if you have questions.

MSG
  }

  if (defined($acctMsg) && ($acctMsg ne '')) {
    $cannedMsg .=<<MSG;

$acctMsg
MSG
  }

  $cannedMsg .=<<MSG;

-- The VPchat Team

MSG

  return $cannedMsg;
}
1;









