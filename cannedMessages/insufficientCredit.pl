####TITLE Account expired, insufficient credit, no auto-renew subscription
sub insufficientCredit {
die 'insufficient parameters' unless($#_ == 7);
my $from = shift @_;
my $fromName = shift @_;
my $to = shift @_;
my $aid = shift @_;
my $amt = shift @_;
my $diff = shift @_;
my $bal = shift @_;
my $poBox = shift @_;

my $cannedMsg =<<MSG;
From: $from
To: $to
Reply-To: $from
Subject: Notification - Account Expiration

Your VPchat account expired today (account ID $aid). The account balance is \$$amt. We applied your \$$bal credit. The remaining balance is \$$diff. 

If you wish to renew your account, please go to:
$G_config{'secureURL'}/VP/pay

Or, you can send a check or money order for \$$diff to:

$poBox

Please include your account number ($aid) on the check. Your account will be reactivated when the check is received. 

If you have any questions about your account, please don't hesitate to Customer Service at $from.

Thank you for your business.

  --The VPchat Team

MSG
  return $cannedMsg;
}
1;
