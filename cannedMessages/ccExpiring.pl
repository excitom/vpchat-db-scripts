####TITLE Reminder: Credit card will expire soon
sub ccExpiring
{
die 'insufficient variables' unless ($#_ == 3);
my $from = shift @_;
my $fromName = shift @_;
my $email = shift @_;
my $aid = shift @_;

$cannedMsg =<<MSG;
From: $from
To: $email
Reply-To: $from
Subject: Notification - Credit Card Expiration

Account # $aid

The credit card you use to pay for you VPchat subscription will expire before your next subscription payment is due. Please reply to this note and tell us the new expiration date for your card.

Or, you can update the information yourself using this web page:
$G_config{'secureURL'}/VP/changePmtInfo

If you have any questions about your account, please don't hesitate to email Customer Service at $from.

Thank you for your business.

  --The VPchat Team

MSG
  return $cannedMsg;
}
1;
