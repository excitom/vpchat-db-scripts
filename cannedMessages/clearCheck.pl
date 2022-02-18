####TITLE Echeck payment cleared
sub clearCheck {
  die "Undefined variable" unless ($#_ == 4);
  my $email = shift @_;
  my $aid = shift @_;
  my $amount = shift @_;
  my $pd = shift @_;
  my $accountStatus = shift @_;
  die unless(defined($G_config{'billingEmail'}));
  my $from = $G_config{'billingEmail'};

  my $cannedMsg =<<MSG;
From: $from
To: $email
Subject: Confirmation - ECheck Cleared
Reply-To: $from

Account number: $aid
Date: $pd
Amount: \$$amount

MSG

if ($accountStatus == 1) {
  $cannedMsg .=<<MSG;
Your recent eCheck payment has cleared. You may now begin using your VPchat subscription.

MSG
}
elsif ($accountStatus == 5) {
  $cannedMsg .=<<MSG;
Your recent eCheck payment has cleared. Your account has been reactivated and your access to VPchat has been restored. Your password was not changed.

MSG
}
else {
  $cannedMsg .=<<MSG;
Your recent eCheck payment has cleared. 

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
