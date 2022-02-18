####TITLE Deleted room from user-created rooms list
sub deletedUserRoom {
die 'insufficient parameters' unless ($#_ == 5);
my $from = shift @_;
my $fromName = shift @_;
my $to = shift @_;
my $aid = shift @_;
my $dn = shift @_;
my $comm = shift @_;

my $cannedMsg =<<MSG;
From: $from
To: $to
Reply-To: $from
Subject: Notification - User Room Listing Deleted

The chat room you listed in the user-created room list has been deleted. 

Account:   $aid
URL:       $dn
Community: $comm

We deleted the listing since there was a problem with the link or the web page. Common problems include:

- You deleted the web page, but forgot to remove the listing
- There was a typo in the listing, so that it did not work correctly
- There isn't any index file (for example, index.html) in the web page folder
- Your account is closed, suspended, or expired

You may put this room back in the list if you wish, after correcting any problems.

Vpchat deletes rooms from the lists because we want to make sure the lists are as accurate and useful as possible.  

If you have any questions about your account, please don't hesitate to email Customer Service at $from.

Thank you for your business.

  --The VPchat Team
MSG
  return $cannedMsg;
}
1;
