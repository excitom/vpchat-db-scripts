#!/usr/bin/perl
#
# Reset stats for home pages, once per month.
# The reset dates are staggered depending on when the home page was
# created.
#
# Tom Lang 6/2002
#

use DBI;
use DBD::Sybase;

$dbName = 'vpplaces';
$dbPw = 'vpplaces';
$ENV{'SYBASE'} ||= '/u/vplaces/s/sybase';
$G_dbh = DBI->connect ( 'dbi:Sybase:', $dbName, $dbPw );

$sql =<<SQL;
EXEC resetHomePageStats
SQL

$sth = $G_dbh->prepare($sql);
die 'Prepare failed' unless (defined($sth));
$sth->execute;
do {
  while (@row = $sth->fetchrow() ) {
    if ($sth->{syb_result_type} == CS_STATUS_RESULT) {
	$rc = shift @row;
    }
  }
} while($sth->{syb_more_results});
print "$sql expected 0 got $rc\n" if ($rc != 0);
$sth->finish;
