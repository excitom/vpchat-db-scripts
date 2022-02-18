####TITLE Reminder: subscription will expire soon, non-autorenew
sub preExpire
{

die "missing variable" unless($#_ == 10);
$from = shift @_;
$fromName = shift @_;
$email = shift @_;
$aid = shift @_;
$amount = shift @_;
$cost = shift @_;
$subscrCost = shift @_;
$balance = shift @_;
$poBox = shift @_;
$rDate = shift @_;
$cred = shift @_;

my $cannedMsg =<<MSG;
From: $from
To: $email
Reply-To: $from
Subject: Notification - Subscription Expiration


MSG

if ($amount <=0 ) {
  $cannedMsg .=<<MSG;

Your subscription is due to expire on $rDate, but your account has sufficient credit to cover the renewal payment. No payment is necessary at this time. Your subscription will renew automatically.

If you have any questions about your account, please don't hesitate to email Customer Service at $from.

Thank you for your business.

MSG
}
else {
  $cannedMsg .=<<MSG;

Your subscription will expire on $rDate and we want to make sure you renew as soon as possible. To renew your subscription please go to $G_config{'secureURL'}/VP/pay and send us \$$amount using a credit card, debit card, or electronic check.

Or, you can send a check or money order for \$$amount to:
$poBox

Please include your account number ($aid) on the check.  

If your payment does not reach us by $rDate, you will experience an interruption in service until the payment arrives.

If you have any questions about your account, please don't hesitate to email Customer Service at $from.

Thank you for your business.

MSG
}

#
# Account has credit, but not enough
#
if ($cred) {
    $cannedMsg .=<<MSG;

Your account has \$$balance that will be applied to your subscription cost, which is \$$subscrCost, so the balance due is \$$amount.

If you have any questions about your account, please don't hesitate to email Customer Service at $from.

Thank you for your business.

MSG

}

#
# Account had balance due
#
if ($amount > $cost) {
  $cannedMsg .=<<MSG;

Your total amount due is the subscription cost (\$$subscrCost) plus the outstanding balance due (\$ $balance).

If you have any questions about your account, please don't hesitate to email Customer Service at $from.

Thank you for your business.

MSG
}


$cannedMsg .=<<MSG;

   --The VPchat Team

MSG
  return $cannedMsg;
}
1;
