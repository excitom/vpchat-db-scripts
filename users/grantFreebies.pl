#!/usr/bin/perl
use Date::Manip;
use DBI;

BEGIN {
  $ENV{'SYBASE'} ||= '/u/vplaces/s/sybase';
  $G_dbh = DBI->connect ( 'dbi:Sybase:', 'vpusr', 'vpusr1' );
}


open(OUT, ">/tmp/userPoints.sql") || die;

my $sth = $G_dbh->prepare("DELETE userPoints");
$sth->execute;

my $sql =<<SQL;
SELECT COUNT(u.userID)
FROM users u, registration r
WHERE locked = 0
AND accountID != 0
AND u.userID = r.userID
SQL

$sth = $G_dbh->prepare($sql);
$sth->execute;
my (@row);
do {
  while (@row = $sth->fetchrow() ) {
    $users = shift @row;
  }
} while($sth->{syb_more_results});
$sth->finish;

$sql =<<SQL;
SELECT COUNT(accountID)
FROM userAccounts
WHERE accountStatus = 0 OR accountStatus = 2
SQL

$sth = $G_dbh->prepare($sql);
$sth->execute;
my (@row);
do {
  while (@row = $sth->fetchrow() ) {
    $accounts = shift @row;
  }
} while($sth->{syb_more_results});
$sth->finish;

$sql =<<SQL;
SELECT u.userID
FROM users u, registration r
WHERE locked = 0
AND accountID != 0
AND u.userID = r.userID
SQL

$i = 1;
$sth = $G_dbh->prepare($sql);
$sth->execute;
my (@row);
do {
  while (@row = $sth->fetchrow() ) {
    $userID = shift @row;
    if ($i % 10 == 0) {
      print "$i OF $users Users\n";
    }
    print OUT <<SQL;
INSERT userPoints (userID, points) VALUES($userID, 500)
GO
SQL

    $i++;
  }
} while($sth->{syb_more_results});
$sth->finish;

$sql =<<SQL;
SELECT ownerID, nameLimit
FROM userAccounts
WHERE accountStatus = 0 OR accountStatus = 2
SQL

$i = 1;
$sth = $G_dbh->prepare($sql);
$sth->execute;
my (@row);
do {
  while (@row = $sth->fetchrow() ) {
    $ownerID = shift @row;
    $names = shift @row;
    $names--;	# already gave the owner 500
    if ($i % 10 == 0) {
      print "$i OF $accounts Accounts\n";
    }

    print OUT <<SQL;
UPDATE userPoints SET points = points+($names*500) WHERE userID = $ownerID
GO
SQL

    $i++;
  }
} while($sth->{syb_more_results});
$sth->finish;


$G_dbh->disconnect;
close OUT;
