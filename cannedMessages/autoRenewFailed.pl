####TITLE Automatic renewal payment failed
sub autoRenewFailed {
die "insufficient parameters" unless($#_ == 3);
my $from = shift @_;
my $fromName = shift @_;
my $to = shift @_;
my $aid = shift @_;

my $cannedMsg =<<MSG;
From: $from
To: $to
Reply-To: $from
Subject: Notification - Subscription Renewal Failed

Your VPchat subscription expired today (account ID $aid). You have a subscription that renews automatically. We tried to process a renewal payment but unfortunately there was a problem with your credit card.

The most common problems are that the expiration date on your card has passed or that your billing address information has changed. 

To update your credit card information, please go to:
$G_config{'regURL'}/VP/pay

You can make a payment and renew your subscription in this area.

Because we appreciate your business, we are leaving your account active while you make the necessary changes to your account. Please update your information promptly to prevent any interruption to your service.

If you have any questions about your account, please don't hesitate to email Customer Service at $from.

Thank you for your business.

  --The VPchat Team
MSG
  return $cannedMsg;
}
1;
