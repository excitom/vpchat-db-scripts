####TITLE Alert List access granted
sub alertRequest {
  die "insufficient parameters" unless($#_ == 2);
  my $from = shift @_;
  my $email = shift @_;
  my $description = shift @_;

  my $cannedMsg =<<MSG;
From: $from 
To: $email
Reply-To: $from
Subject: Notification - Activity Alerts

Your request to send Activity Alerts has been approved.

List name: $description

To review the guidelines for Activity Alerts go to:
$G_config{'chatURL'}/h/helpsendingalerts

If you have any questions about your account, please don't hesitate to email Customer Service at $from.

Thank you for your business.

  --The VPchat Team

MSG
  return $cannedMsg;
}
1;
