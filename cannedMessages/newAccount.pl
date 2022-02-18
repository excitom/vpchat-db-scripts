####TITLE New account opened
sub newAccount {
die 'insufficient parameters' unless($#_ == 7);
my $from = shift @_;
my $fromName = shift @_;
my $email = shift @_;
my $accountID = shift @_;
my $name = shift @_;
my $pswd = shift @_;
my $hold = shift @_;
my $freeTrial = shift @_;

my $cannedMsg =<<MSG;
From: $from
To: $email
Cc: $G_config{'billingEmail'}
Subject: Welcome To VPchat
Reply-To: $from
MSG

if ($hold) {
  $cannedMsg .=<<MSG;

Congratulations, you are VPchat's latest member!

Please retain this email for your records.

User name: $name
Password : $pswd
Account #: $accountID

If you have any questions about your account, please don't hesitate to reply to this message or email Customer Service at $from.

It may take up to 7 days to clear your first payment. Until it clears, we will not be able to activate your account. However, if you've been chatting as a guest, let us know and we'll extend the free trial.

Thank you for your business.

 --The VPchat Team

MSG
}
else {
  $cannedMsg .=<<MSG;

Congratulations, you are VPchat's latest member!

Please retain this email for your records.

User name: $name
Password : $pswd
Account #: $accountID

Here are some tips regarding your password:

1. Be careful to distinguish between 1 (one) and l (lower case L),
   0 (zero) and O (uppercase o) when you enter your password.

2. For your convenience, you can change your password by clicking
   Change Password on the Sign In page.

3. Keep your information in a secure place to prevent unauthorized
   access to your account.

VPchat wants you... To make some money. We pay our members for referrals. Invite your friends to chat, play games, and explore the web on VPchat:
$G_config{'regURL'}/invite

If you need to download the latest VPchat software:
$G_config{'chatURL'}/download

To review VPchat's community standards:
$G_config{'chatURL'}/standards.

To check on the status of your account, add and remove names,
change your password, or change your email:
$G_config{'regURL'}/VP/account

Logging into your account means that you authorize VPchat to charge your account for renewal of your subscription at the same rate. You may cancel your subscription at any time.

If you have any questions about your account, please don't hesitate to email Customer Service at $from.

Thank you for your business.

 --The VPchat Team

MSG
}
  return $cannedMsg;
}
1;
