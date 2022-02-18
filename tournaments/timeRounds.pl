#!/usr/bin/perl
#
# Periodically update tournaments with timed rounds.
#
# Tom Lang 1/05
#

use DBI;
use DBD::Sybase;

BEGIN {
  $ENV{'SYBASE'} ||= '/u/vplaces/s/sybase';
  $G_dbh = DBI->connect ( 'dbi:Sybase:', 'audset', 'audset1' );
}

my $sql = "EXEC timeRounds";
my $sth = $G_dbh->prepare($sql);
die 'Prepare failed' unless (defined($sth));
$sth->execute;
my (@row);
do {
  while (@row = $sth->fetchrow() ) {
    my $tournID = shift @row;
    next if ($tournID == 0);
    my $startTime = shift @row;
    my $now = shift @row;
    my $timeLimit = shift @row;
    print "TournID $tournID\t$startTime\t$now\t$timeLimit\n";
  }
} while($sth->{syb_more_results});
$sth->finish;
