#!/usr/bin/perl
#
# Periodically clean up homePages
#
# Tom Lang 4/2006
#
use DBI;
use DBD::Sybase;

#####################################################
#
# Subroutine: get configuration keys from the database
#
sub getConfigKeys {
  undef %G_config;
  
  my $sth = $G_dbh->prepare("EXEC vpusers..getServerConfig");
  die 'Prepare failed' unless (defined($sth));
  $sth->execute;
  my (@row);
  do {
    while (@row = $sth->fetchrow() ) {
      my $key = shift @row;
      $G_config{$key} = shift @row;
    }
  } while($sth->{syb_more_results});
  $sth->finish;
  die "database error - missing config keys" unless((scalar keys %G_config) > 0);
  my $host = `hostname`;
  chomp $host;
  $G_config{'thisHost'} = $host;

  my @now = localtime(time);
  $G_config{'curYear'} = $now[5]+1900;
}


########################
#
# START HERE
#

$ENV{'SYBASE'} ||= '/u/vplaces/s/sybase';
$dbName = 'sa';
$dbPw = 'UBIQUE';
$dbSrvr = 'SYBASE-ANNE';
$G_dbh = DBI->connect ( "dbi:Sybase:server=$dbSrvr", $dbName, $dbPw );
&getConfigKeys;

die "This script should run on $G_config{'membersNFS'} not $G_config{'thisHost'}" unless($G_config{'membersNFS'} eq $G_config{'thisHost'});

$delDir = $G_config{'deletedMembersRoot'};
$docRoot = $G_config{'membersRoot'};
die ("Fatal error") if ($delDir eq "");
die ("Fatal error") if ($docRoot eq "");

opendir(HPAGES, $docRoot);
@homePages = readdir(HPAGES);
closedir(HPAGES);

$ctr = $#homePages;
print "Processing $ctr directories\n";
print "Deleting zombies ...\n";
$i = 1;
foreach $url (@homePages) {
  print "$i of $ctr\n" if ($i % 100 == 0);
  $i++;
  next if ($url eq "VP");
  next if ($url eq ".");
  next if ($url eq "..");
  $dir = "$docRoot/$url";
  next if (-l $dir);
  if (-d $dir) {
    $sql =<<SQL;
SELECT r.accountID FROM
vpusers..registration r, vpplaces..homePages h
WHERE h.URL = '$url'
AND h.deleted = 0
AND h.userID=r.userID
AND r.accountID != 0
SQL
    $sth = $G_dbh->prepare($sql);
    die 'Prepare failed' unless (defined($sth));
    $sth->execute;
    my (@row);
    $aid = 0;
    do {
      while (@row = $sth->fetchrow() ) {
        $aid = shift @row;
      }
    } while($sth->{syb_more_results});
    $sth->finish;
    if ($aid == 0) {
      print "Zombie home page: $url\n";
      die ("OOPS you screwed up") unless ($dir =~ /\/export/);
      die ("OOPS you screwed up again") unless ("$delDir/$url" =~ /\/export/);
      `rm -rf $delDir/$url`;
      `mv $dir $delDir`;
      `chown -R nobody $delDir/$url`;
    }
  }
}
print "Deleting zombie links ...\n";
$i = 1;
foreach $url (@homePages) {
  print "$i of $ctr\n" if ($i % 100 == 0);
  $i++;
  next if ($url eq "VP");
  next if ($url eq ".");
  next if ($url eq "..");
  $dir = "$docRoot/$url";
  next unless (-l $dir);
  $u = $url;
  $u =~ tr/[A-Z]/[a-z]/;
  $dir = "$docRoot/$u";
  if (! -d $dir) {
    print "Removing $url\n";
    `rm -f $docRoot/$url`;
  }
}
#
# fix up missing symlinks
#
print "Fixing missing symlinks...\n";
$sql =<<SQL;
select URL,URL2 from vpplaces..homePages
where deleted=0
AND URL2 is not null
SQL
$sth = $G_dbh->prepare($sql);
die 'Prepare failed' unless (defined($sth));
$sth->execute;
my (@row);
$aid = 0;
do {
  while (@row = $sth->fetchrow() ) {
    $url = shift @row;
    $lnk = shift @row;
    $dir = "$docRoot/$url";
    if (! -d $dir) {
      print "ERROR: $dir missing\n";
    }
    else {
      $symlink = "$docRoot/$lnk";
      if (! -f $symlink) {
        print "Adding $symlink => $dir\n";
        `ln -s $dir $symlink`;
      }
    }
  }
} while($sth->{syb_more_results});
$sth->finish;
