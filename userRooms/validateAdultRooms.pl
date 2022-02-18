#!/usr/bin/perl
#
# Periodically check the user-created vpadult.com room list and report
# anomalies.

# Tom Lang 12/2003
use DBI;

BEGIN {
#######
die "Don't run on this server\n";
#######
  $ENV{'SYBASE'} ||= '/u/vplaces/s/sybase';
  $G_dbh = DBI->connect ( 'dbi:Sybase:', 'vpusr', 'vpusr1' );
  $G_dbh2 = DBI->connect ( 'dbi:Sybase:server=SYBASE2', 'vpplaces', 'vpplaces' );
}

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

#####################################################
#
# Subroutine: get all listed rooms
#
sub getRooms {

  my $sql =<<SQL;
SELECT accountID, u.URL
FROM vpplaces..userPlaces u, 
     vpplaces..persistentPlaces p
WHERE u.URL = p.URL
SQL
  my $sth = $G_dbh2->prepare($sql);
  die 'Prepare failed' unless (defined($sth));
  $sth->execute;
  my (@row);
  do {
    while (@row = $sth->fetchrow() ) {
      my $aid = shift @row;
      my $URL = shift @row;
      $listedRooms{$URL} = $aid;
    }
  } while($sth->{syb_more_results});
  $sth->finish;
}

#####################################################
#
# Subroutine: check for expired/closed/suspended accounts with listed rooms
#
sub checkAccounts {

  print LOG "----------\nCheck for problem accounts with listed rooms\n";
  print "----------\nCheck for problem accounts with listed rooms\n";
  my $found = 0;
  my $status = 0;
  
  foreach $URL (keys %listedRooms) {
    my $a = $listedRooms{$URL};
    my $sql =<<SQL;
SELECT accountStatus
FROM userAccounts
WHERE accountID = $a
SQL
    my $sth = $G_dbh->prepare($sql);
    die 'Prepare failed' unless (defined($sth));
    $sth->execute;
    my (@row);
    do {
      while (@row = $sth->fetchrow() ) {
        $status = shift @row;
      }
    } while($sth->{syb_more_results});
    $sth->finish;

    if ($status == 5) {
      print LOG "$a EXPIRED $URL\n";
      print "$a EXPIRED $URL\n";
      $found = 1;
      $shitList{$URL}++;
    }
    if ($status == 4) {
      print LOG "$a SUSPENDED $URL\n";
      print "$a SUSPENDED $URL\n";
      $found = 1;
      $shitList{$URL}++;
    }
    if ($status == 3) {
      print LOG "$a CLOSED $URL\n";
      print "$a CLOSED $URL\n";
      $found = 1;
      $shitList{$URL}++;
    }
  }

  if (!$found) {
    print LOG "None found\n";
    print "None found\n";
  }
}

#####################################################
#
# Subroutine: check for closed accounts with listed rooms
#
sub checkClosedAccounts {

  print LOG "----------\nCheck for CLOSED accounts with listed rooms\n";
  print "----------\nCheck for CLOSED accounts with listed rooms\n";
  my $found = 0;
  
  my $sql =<<SQL;
SELECT a.accountID, u.URL
FROM vpusers..userAccounts a,
     vpplaces..userPlaces u, 
     vpplaces..persistentPlaces p
WHERE a.accountID = u.accountID
AND   u.URL = p.URL
AND   a.accountStatus = 3
SQL
  my $sth = $G_dbh->prepare($sql);
  die 'Prepare failed' unless (defined($sth));
  $sth->execute;
  my (@row);
  do {
    while (@row = $sth->fetchrow() ) {
      print LOG join(' ', @row) . "\n";
      print join(' ', @row) . "\n";
      $found = 1;
    }
  } while($sth->{syb_more_results});
  $sth->finish;

  if (!$found) {
    print LOG "None found\n";
    print "None found\n";
  }
}

#####################################################
#
# Subroutine: check for invalid member URLs
#
sub checkURLs {

  print LOG "----------\nCheck for URLs aren't in Cool Places\n";
  print "----------\nCheck for URLs aren't in Cool Places\n";
  my $found = 0;
  
  my $sql =<<SQL;
SELECT accountID, u.URL
FROM vpplaces..userPlaces u
WHERE   u.URL NOT IN (SELECT URL FROM vpplaces..persistentPlaces)
SQL
  my $sth = $G_dbh2->prepare($sql);
  die 'Prepare failed' unless (defined($sth));
  $sth->execute;
  my (@row);
  do {
    while (@row = $sth->fetchrow() ) {
      my $aid = shift @row;
      my $URL = shift @row;
      $found = 1;
      $shitList{$URL}++;
      print LOG "$aid $URL\n";
      print "$aid $URL\n";
    }
  } while($sth->{syb_more_results});
  $sth->finish;

  if (!$found) {
    print LOG "None found\n";
    print "None found\n";
  }

  print LOG "----------\nCheck for non-members.vpchat.com URLs\n";
  print "----------\nCheck for non-members.vpchat.com URLs\n";
  $found = 0;
  
  %uris = ();
  foreach $URL (keys %listedRooms) {
    $aid = $listedRooms{$URL};
    if (! ($URL =~ /^http:\/\/members.vpchat.com\//)) { 
      $found = 1;
      $shitList{$URL}++;
      print LOG "$listedRooms{$URL} $URL\n";
      print "$listedRooms{$URL} $URL\n";
    }
    #
    # save URI for later checking
    #
    $uri = $URL;
    $uri =~ s/http:\/\/members.vpchat.com//;
    $uris{$uri}++;

    #
    # extract member name for next stage checking
    #
    $URL =~ /^http:\/\/members.vpchat.com\/([^\/]+)/;
    my $n = $1;
    my $ln = $1;
    $n =~ tr/[A-Z]/[a-z]/;
    $userNames{$n} = $aid;
    $URLs{$n} = $URL;
    if ($n ne $ln) {
      $links{$ln} = $n;
    }
  } 

  if (!$found) {
    print LOG "None found\n";
    print "None found\n";
  }

  print LOG "----------\nCheck for non-existant member pages\n";
  print "----------\nCheck for non-existant member pages\n";
  $found = 0;
  my ($n, @validNames);
  foreach $n (keys %userNames) {
    if (! -d "$G_config{'membersRoot'}/$n") {
      $found = 1;
      $shitList{$URLs{$n}}++;
      print LOG "$userNames{$n} $n $URLs{$n}\n";
      print "$userNames{$n} $n $URLs{$n}\n";
    }
    else {
      push( @validNames, $n );
    }
  }

  if (!$found) {
    print LOG "None found\n";
    print "None found\n";
  }

  print LOG "----------\nCheck for non-existant pages within a valid member page\n";
  print "----------\nCheck for non-existant pages within a valid member page\n";
  $found = 0;
  my ($u);
  foreach $u (keys %uris) {
    if ((! -e "$G_config{'membersRoot'}$u") &&
        (! -e "$G_config{'membersRoot'}$u.html") &&
        (! -e "$G_config{'membersRoot'}$u.htm"))
    {
      $found = 1;
      $shitList{"$G_config{'membersURL'}$u"}++;
      print LOG "$G_config{'membersURL'}$u\n";
      print "$G_config{'membersURL'}$u\n";
    }
  }

  if (!$found) {
    print LOG "None found\n";
    print "None found\n";
  }

  print LOG "----------\nCheck for invalid mixed-case linked names\n";
  print "----------\nCheck for invalid mixed-case linked names\n";
  $found = 0;
  foreach $ln (keys %links) {
    $n = $links{$ln};
    if (! -l "$G_config{'membersRoot'}/$ln") {
      $found = 1;
      $shitList{$URLs{$n}}++;
      print LOG "$userNames{$n} $n NO LINK $URLs{$n}\n";
      print "$userNames{$n} $n NO LINK $URLs{$n}\n";
    }
    if (! -d "$G_config{'membersRoot'}/$n") {
      $found = 1;
      $shitList{$URLs{$n}}++;
      print LOG "$userNames{$n} $n BAD LINK $URLs{$n}\n";
      print "$userNames{$n} $n BAD LINK $URLs{$n}\n";
    }
  }

  if (!$found) {
    print LOG "None found\n";
    print "None found\n";
  }

  print LOG "----------\nCheck for locked/deleted member pages\n";
  print "----------\nCheck for locked/deleted member pages\n";

  $found = 0;
  foreach $n (@validNames) {
    if (&lockedPage($userNames{$n}, $n, $URLs{$n})) {
      $found = 1;
      $shitList{$URLs{$n}}++;
    }
  }

  if (!$found) {
    print LOG "None found\n";
    print "None found\n";
  }

  print LOG "----------\nCheck for locked/deleted user names\n";
  print "----------\nCheck for locked/deleted user names\n";

  $found = 0;
  foreach $n (@validNames) {
    if (&lockedUser($userNames{$n}, $n, $URLs{$n})) {
      $found = 1;
      $shitList{$URLs{$n}}++;
    }
  }

  if (!$found) {
    print LOG "None found\n";
    print "None found\n";
  }

  print LOG "----------\nCheck for missing index files\n";
  print "----------\nCheck for missing index files\n";

  $found = 0;
  foreach $n (@validNames) {
    if (&missingIndexFile($userNames{$n}, $n, $URLs{$n})) {
      $found = 1;
      $shitList{$URLs{$n}}++;
    }
  }

  if (!$found) {
    print LOG "None found\n";
    print "None found\n";
  }
}

#####################################################
#
# Subroutine: check if a web page is locked or deleted
#
sub lockedPage {
  my $aid = shift @_;
  my $name = shift @_;
  my $URL = shift @_;

  my $found = 0;
  my $sql =<<SQL;
SELECT h.locked, h.deleted
FROM vpplaces..homePages h
WHERE h.URL = "$name"
AND   (h.locked = 1 OR h.deleted = 1)
SQL
  my $sth = $G_dbh->prepare($sql);
  die 'Prepare failed' unless (defined($sth));
  $sth->execute;
  my (@row);
  do {
    while (@row = $sth->fetchrow() ) {
      my $locked = shift @row;
      my $deleted = shift @row;
      print LOG "$aid $name LOCKED $URL\n" if ($locked);
      print "$aid $name LOCKED $URL\n" if ($locked);
      print LOG "$aid $name DELETED $URL\n" if ($deleted);
      print "$aid $name DELETED $URL\n" if ($deleted);
      $found = 1;
      $shitList{$URL}++;
    }
  } while($sth->{syb_more_results});
  $sth->finish;

  return $found;
}

#####################################################
#
# Subroutine: check if a user name is locked or deleted
#
sub lockedUser {
  my $aid = shift @_;
  my $name = shift @_;
  my $URL = shift @_;

  my $found = 0;
  my $sql =<<SQL;
SELECT u.locked, r.deleteDate
FROM vpusers..users u, vpusers..registration r
WHERE u.nickName = "$name"
AND   u.userID = r.userID
AND   (u.locked = 1 OR r.deleteDate IS NOT NULL)
SQL
  my $sth = $G_dbh->prepare($sql);
  die 'Prepare failed' unless (defined($sth));
  $sth->execute;
  my (@row);
  do {
    while (@row = $sth->fetchrow() ) {
      my $locked = shift @row;
      my $deleted = shift @row;
      if ($locked) {
        print LOG "$aid $name LOCKED $URL\n";
        print "$aid $name LOCKED $URL\n";
      } else {
        print LOG "$aid $name DELETED $URL\n";
        print "$aid $name DELETED $URL\n";
      }
      $found = 1;
      $shitList{$URL}++;
    }
  } while($sth->{syb_more_results});
  $sth->finish;

  return $found;
}

#####################################################
#
# Subroutine: check for missing index files
#
sub missingIndexFile {
  my $aid = shift @_;
  my $name = shift @_;
  my $URL = shift @_;

  my $found = 0;

  #
  # If URL is not simply the member's name, it must be a file
  # or a sub-directory. Assume it doesn't need an index in this
  # case (which is not necessarily valid, but ok for now ...)
  #
  my $u = $G_config{'membersURL'} . "/" . $name;
  my $v = $URL;
  $v =~ tr/[A-Z]/[a-z]/;
  $v =~ s/\/$//;
  if ($u ne $v) {
    return 0;
  }

  opendir (DIR, "$G_config{'membersRoot'}/$name/") || die "Can't read $name : $!";
  my (@files) = grep /^index\./, readdir DIR;
  close DIR;

  if ($#files == -1) {
    $found = 1;
    $shitList{$URL}++;
    print LOG "$aid $name MISSING INDEX FILE $URL\n";
    print "$aid $name MISSING INDEX FILE $URL\n";
  }

  return $found;
}

##############################
#
# Delete selected listings
#
require "/u/vplaces/scripts/cannedMessages/deletedUserRoom.pl";
sub deleteListings {
  my $from = $G_config{'helpdeskEmail'};
  my $fromName = 'VPchat customer service';
  my $email = 'TBD-email';
  my $comm = 'vpadult.com';
  foreach $URL (keys %shitList) {
    print LOG "Deleting $listedRooms{$URL} -- $URL\n";
    print "Deleting $listedRooms{$URL} -- $URL\n";

if (0) {
    my $accountID = $listedRooms{$URL} + 0;
    next if ($accountID == 0);
    my $sql = "SELECT email FROM vpusers..userAccounts WHERE accountID=$accountID";
    my $sth = $G_dbh->prepare($sql);
    die 'Prepare failed' unless (defined($sth));
    $sth->execute;
    my (@row, $email);
    do {
      while (@row = $sth->fetchrow() ) {
        $email = shift @row;
      }
    } while($sth->{syb_more_results});
    $sth->finish;

    $sql = "delUserPlace $accountID, \"$URL\"";
    $sth = $G_dbh2->prepare($sql);
    $sth->execute;
    do {
      while (@row = $sth->fetchrow() ) {
      }
    } while($sth->{syb_more_results});
    $sth->finish;

    my $cannedMsg = &deletedUserRoom($from, $fromName, $email, $accountID, $URL, $comm);
    if ( open( MAIL, "| /usr/lib/sendmail -f $from -t > /dev/null" ) ) {
      print MAIL $cannedMsg;
      print MAIL "\n";
      close( MAIL );
      &writeLogByID( $accountID, "notification that listing was deleted sent to $email");
      print LOG "Email sent to: $email\n";
      print "Email sent to: $email\n";
    }
    else {
      die 'problem sending mail';
    }
}

  }
}

##################
#
# Write action to the database log
#
sub writeLogByID {
	my $aid = shift @_;
	my $msg = shift @_;
	$msg =~ s/"/'/g;
	my $sql = qq!EXEC vpusers..addActivityLogById $aid, "$msg"!;
	my $sth = $G_dbh->prepare($sql);
	die 'Prepare failed' unless (defined($sth));
	$sth->execute;
	my ($rc, @row);
	do {
	  while (@row = $sth->fetchrow() ) {
	    if ($sth->{syb_result_type} == CS_STATUS_RESULT) {
		$rc = shift @row;
	    }
	  }
	} while($sth->{syb_more_results});

	$sth->finish;
}

##############################
#
# START HERE
#

&getConfigKeys;
die "missing config keys" unless(defined(%G_config));

$logFile = "/logs/deletedListings";
open(LOG, ">>$logFile") || die "Can't append to $logFile : $!";
$now = scalar localtime;
print LOG "$now\tChecking user created rooms for vpadult.com\n";
print "$now\tChecking user created rooms for vpadult.com\n";

%shitList = ();

&getRooms;
&checkAccounts;
&checkURLs;

$now = scalar localtime;
print LOG "$now\tSEARCH complete\n";
print "$now\tSEARCH complete\n";

&deleteListings;

$now = scalar localtime;
print LOG "$now\tDONE\n";
print "$now\tDONE\n";
