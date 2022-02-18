####TITLE Reminder: Echeck subscription will auto-renew soon
sub autoRenewing
{
die "missing variable" unless($#_ == 5);
$from = shift @_;
$fromName = shift @_;
$email = shift @_;
$aid = shift @_;
$rDate = shift @_;
$amount = shift @_;

my $cannedMsg =<<MSG;
From: $from
To: $email
Reply-To: $from
Subject: Notification - Account Will Auto-Renew

Account $aid

Your subscription is due for renewal on $rDate and it is set to renew automatically. You've chosen to pay with an electronic check, and the cost to renew will be \$$amount.

If you want your subscription to renew, there's nothing you need to do. We'll take care of it.

If you do NOT want to renew your subscription, please go to:

$G_config{'secureURL'}/VP/changePmtInfo

Sign in with your chat name and password and click the Cancel button.

If you have any questions about your account, please don't hesitate to email Customer Service at $from.

Thank you for your business.

  --The VPchat Team

MSG

return $cannedMsg;

}
1;
