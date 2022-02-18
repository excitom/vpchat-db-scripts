#!/usr/bin/perl
#
# Monthly referral bonus processing.
# - Apply referral bonus to each referrer's account
# - Send email to each referrer
#
# This assumes two previous steps have occurred.
# - findNames.pl has been run, which fills in missing account
#   IDs for referrers, where possible
# - findReferrals.pl has been run, which generates a file of
#   SQL statements which are input to this program.
#
# findNames.pl and findReferrals.pl can be run at any time, and
# can be run multiple times with no problem. This program should
# run only once per month to avoid duplicate payments, which 
# would be bad. As a safety precaution, the addReferralBonus SQL
# procedure will return an error if you try to apply to bonus
# credits to an account in the same month.
#
# Tom Lang 1/2002
#


#
# Subroutine: Send email message to the referrer
#
sub sendThankYou
{
    my $email = shift @_;
    my $refers = shift @_;
    my $amount = shift @_;
    my $amt = sprintf("\$ %5.2f", $amount);
    my $from = "billing\@halsoft.com";
    my $FromW = "HalSoft Customer Service";

    print "Sending email to $email, amount = $amt\n";

        if ( open( MAIL, "| /usr/lib/sendmail -odq -f $from -F \"$FromW\" $email > /dev/null" ) ) {
                print MAIL <<MAILMSG;
From: $from ($FromW)
To: $email
Reply-To: $from
Subject: Your monthly referral bonus!

Thank you for helping our community grow! We are pleased to share our
success with you in return for referring new members to our community.

People who referred to you when they signed up: $refers
Amount credited to your account: $amt

Remember that we will keep paying you for each referral as long as
the people remain active members.

Click this link to see more information about your account:
http://reg.vpchat.com/VP/referral

With our sincere appreciation,
    The HalSoft Team

MAILMSG
		close( MAIL );
	}
}

####################
#
# START HERE
#
$dbName = 'vpusr';
$dbPw = 'vpusr1';

$G_isql_exe = "/u/vplaces/s/sybase/bin/isql -U$dbName -P$dbPw -SSYBASE";
$G_statdir = "/tmp/";
$tempsql = $G_statdir . ".temp.sql.$$";
$ENV{'SYBASE'} ||= '/u/vplaces/s/sybase';

open (SQL_IN, ">$tempsql") || die "Can't write to $tempsql : $!\n";

$inFile = "/tmp/referralList";
open (IN, "<$inFile") || die "Can't read $inFile : $!";

while (<IN>) {
	chomp;
	($aid, $referrals, $amount, $email) = split;
	print SQL_IN <<SQL;
addReferralBonus $aid, $amount
GO
SQL
	&sendThankYou( $email, $referrals, $amount );
}
close IN;
close SQL_IN;

open (SQL_OUT, "$G_isql_exe -i $tempsql |") || die "Can't read from $G_isql_exe -i $tempsql : $!\n";

while (<SQL_OUT>) {
	print;
}
unlink($tempsql);
`/usr/lib/sendmail -q`;		# flush the mail queue
