{
####TITLE Name transferred to a different account
die "Undefined variable 'from'" unless(defined($from));
die "Undefined variable 'fromName'" unless(defined($fromName));
die "Undefined variable 'email'" unless(defined($email));
die "Undefined variable 'name'" unless(defined($name));
die "Undefined variable 'pswd'" unless(defined($pswd));
$fee = 0 unless(defined($fee));

$cannedMsg =<<MSG;
From: $from
To: $email
Reply-To: $from
Subject: Confirmation - $noun Transferred

We've transferred the following $noun to your account:
MSG

if ($pswd eq '') {
  my ($n);
  foreach $n (keys %inclNames) {
    $cannedMsg .=<<MSG;

Chat name: $n
Password : $passwords{$n}
MSG

  }
}
else {
  $cannedMsg .=<<MSG;

Chat name: $name
Password : $pswd
MSG

}

if ($fee > 0) {
  $fee = sprintf "%8.2f", $fee;
  $fee =~ s/^\s+//;
  $cannedMsg .=<<MSG;

A \$ $fee fee was charged to your account for this name transfer.
MSG
}

$cannedMsg .=<<MSG;

If you have any questions about your account, please don't hesitate to reply to this message or email Customer Service at $from.

Thank you for your business.
MSG

$cannedMsg .=<<MSG;

 ---The VPchat Team

MSG
}
1;
