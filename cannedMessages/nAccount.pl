####TITLE New account opened
sub newAccount {
  die "Undefined varialble(s)" unless ($#_ == 7);
  my $from = shift @_;
  my $fromName = shift @_;
  my $email = shift @_;
  my $accountID = shift @_;
  my $name = shift @_;
  my $pswd = shift @_;
  my $hold = shift @_;
  my $freeTrial = shift @_;

  my $cannedMsg =<<MSG;
From: $from ($fromName)
To: $email
Subject: Thank you for your new subscription
Reply-To: $from

Congratulations!

You are VPchat's latest member!

Account #: $accountID
User name: $name
Password : $pswd
MSG

  if ($hold) {
    $cannedMsg .=<<MSG;

Unfortunately, due to a high rate of fraud, we will not be able
to activate your account immediately. It may take up to 7 days
before your bank confirms that your check has cleared.

We regret that a small number of trouble makers have caused us to
take this action, but we hope that you will understand this is
necessary to maintain the quality of our community.

Your renewal date will be adjusted if necessary so that you will
receive the full length of time you have paid for.
MSG
  }
  if ($freeTrial) {
    $cannedMsg .=<<MSG;

You have signed up for a FREE TRIAL subscription, which lasts seven
days. You may cancel at any time by going to the $G_config{'regURL'}/VP/account
web page,
signing in with your chat name and password, and clicking the
Cancel button.

If you are satisfied with our service, at the end of seven days
we will convert your subscription to a regular account which
renews monthy, and your first month payment will be processed
at that time.
MSG
  }

  $cannedMsg .=<<MSG;

Here are some tips regarding your password:

1. Be careful to distinguish between 1 (one) and l (lower case L),
0 (zero) and O (uppercase o) when you enter your password.
2. For your convenience, you can change your password by clicking
Change Password on the Sign In page.
3. Keep your information in a secure place to prevent unauthorized
access to your account.

Want to make some money off your account? Invite friend to join and
get paid if they do!
$G_config{'regURL'}/invite

If you need to download the VPchat software, go to
$G_config{'chatURL'}/download

Community standards can be found at
$G_config{'chatURL'}/standards.

To check on the status of your account, or to add and remove names,
change your password, or change your email, visit
$G_config{'regURL'}/VP/account

Logging into your account means that you authorize VPchat to charge
your account for renewal of your subscription at the same rate. You
may cancel your subscription at any time.

Thanks for signing up, and have fun!

---The VPchat Team

MSG
  return $cannedMsg;
}
1;





