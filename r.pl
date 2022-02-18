#!/usr/bin/perl
$n = 0;
$u = 0;
$rank = 1;
while (<STDIN>) {
  /\s*(\d+)\s+(\d+).*/;
  if ($n != $1) {
    $n = $1;
    $rank = 1;
  }
  print <<SQL;
UPDATE ladderMembers SET rank=$rank
WHERE notifyID=$1 AND userID=$2
GO
SQL
  $rank++;
}
