#!/usr/bin/perl
#
# Periodically scan the userPoints table (a.k.a. Chat Chits) and create
# a Top 100 list.
#
# Tom Lang 11/2004
#
use DBI;
use DBD::Sybase;

BEGIN {
  $ENV{'SYBASE'} ||= '/u/vplaces/s/sybase';
  $G_dbh = DBI->connect ( 'dbi:Sybase:', 'vpusr', 'vpusr1' );
}

$outDir = "/export/u03/content/php/";
$outFile = $outDir . "chits.phpi";
$tmpFile = $outFile . ".tmp";
open (OUT, ">$tmpFile") || die "Can't write $tmpFile : $!";
$now = scalar localtime;
print OUT <<PHP;
<?
// This is a generated file, do not edit.
// Updated: $now

\$userPoints = array (
PHP

$sql =<<SQL;
SELECT nickName, points
FROM users u, userPoints p
WHERE  u.userID = p.userID
ORDER BY points DESC, nickName ASC
SQL

$ctr = 1;
$limit = 100;
@rows = ();
$sth = $G_dbh->prepare($sql);
die 'Prepare failed' unless (defined($sth));
$sth->execute;
do {
  while (@row = $sth->fetchrow() ) {
    my $nickName = shift @row;
    my $points = shift @row;
    push(@rows, "  '$nickName' => $points");
    $ctr++;
    last if ($ctr > $limit);
  }
} while($sth->{syb_more_results});
$sth->finish;

print OUT join( ",\n", @rows);
print OUT <<PHP;
);
?>
PHP
close OUT;
rename $tmpFile, $outFile;
