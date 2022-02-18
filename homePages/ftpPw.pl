#!/usr/bin/perl
#
# Sync the FTP password database with the Sybase database
#
# Tom Lang 6/2004
#
use DBI;
use DBD::Sybase;

$ENV{'SYBASE'} ||= '/u/vplaces/s/sybase';
$dbName = 'sa';
$dbPw = 'UBIQUE';
$G_dbh = DBI->connect ( 'dbi:Sybase:', $dbName, $dbPw );

$sql =<<SQL;
SELECT r.userID, URL, password, maxSpace
FROM vpusers..registration r, vpplaces..homePages h
WHERE r.userID = h.userID
AND   r.deleteDate IS NULL
AND   h.deleted = 0
SQL
$sth = $G_dbh->prepare($sql);
die 'Prepare failed' unless (defined($sth));
$sth->execute;

do {
  while (@row = $sth->fetchrow() ) {
    if ($sth->{syb_result_type} == CS_ROW_RESULT) {
	$userID = shift @row;
	$nickName{$userID} = shift @row;
	$password{$userID} = shift @row;
	$maxSpace{$userID} = shift @row;
    }
  }
} while($sth->{syb_more_results});
$sth->finish;

$max = scalar keys %nickName;
$i = 1;
foreach $userID (keys %nickName) {
  if ($i % 10 == 0) {
    print "$i of $max\n";
  }
  $i++;
  @pwe = ();
  push(@pwe, $nickName{$userID});
  push(@pwe, $password{$userID});
  push(@pwe, $userID);
  push(@pwe, 60001);
  push(@pwe, $nickName{$userID});
  push(@pwe, "/export/home/members/$nickName{$userID}");
  push(@pwe, "/bin/false");
  $ms = $maxSpace{$userID} * 1024;
  push(@pwe, $ms);
  $pwEntry = join(':', @pwe);
  `/usr/local/sbin/ncftpd_passwd -f /usr/local/etc/ncftpd/passwd.db -c -u \"$pwEntry\"`;
}
