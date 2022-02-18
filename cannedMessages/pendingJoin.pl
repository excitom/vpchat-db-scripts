#!/usr/bin/perl
####TITLE Pending requests to join a private list
sub pendingJoin {

  my $from = shift @_;
  my $to = shift @_;
  my $aid = shift @_;
  my $pending = shift @_;

  my $peopleHave = ($pending > 1) ? 'People have' : 'Someone has';
  my $are = ($pending > 1) ? 'are' : 'is';
  my $people = ($pending > 1) ? 'people' : 'person';

  my $cannedMsg =<<MSG;
From: $from
To: $to
Reply-To: $from
Subject: $peopleHave requested to join your list

You have one or more Private Alert Lists at Halsoft VPchat,
and there $are $pending $people waiting to join.

To review and approve people who have asked to join your list,
go to $G_config{'regURL'}/VP/privateAlertsOut

Thank you for using Private Alert Lists.

 ---The VPchat Team

MSG

  return $cannedMsg;

}
1;
