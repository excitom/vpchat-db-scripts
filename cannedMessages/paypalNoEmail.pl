####TITLE Paypal payment received, but problem with determining the account
sub paypalNoEmail {
die 'insufficient parameters' unless($#_ == 4);
my $from = shift @_;
my $fromName = shift @_;
my $to = shift @_;
my $amount = shift @_;
my $reason = shift @_;

my $cannedMsg =<<MSG;
From: $from
To: $to
Reply-To: $from
Subject: Notification - Payment Problem

Thank you!

We received your payment of \$$amount.
MSG

if ($reason eq "unknown") {
 $cannedMsg .=<<MSG;

Unfortunately, your payment cannot be applied because your email address is not registered in our system. The email address that you used to register with VPchat may be different than the email address you used to make a payment.

Please tell us your chat name or account number, so that we may correctly credit your payment.

If you have any questions about your account, please don't hesitate to email Customer Service at $from.

Thank you for your business.
MSG
}
elsif ($reason eq "dup") {
  $cannedMsg .=<<MSG;

However, your email address is associated with more than one account. Please email us which chat name or account number should be credited with this payment.

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
