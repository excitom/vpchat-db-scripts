#!/usr/bin/perl
#
# Periodically poll for FTP changes, and take appropriate
# action.
#
# Tom Lang 2/04
#

use DBI;
use DBD::Sybase;

BEGIN {
  $ENV{'SYBASE'} ||= '/u/vplaces/s/sybase';
  $G_dbh = DBI->connect ( 'dbi:Sybase:server=SYBASE-ANNE', 'sa', 'UBIQUE' );
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
# START HERE
#

&getConfigKeys;

$srvr = `hostname`;
chomp $srvr;

my $sql = "EXEC vpplaces..getFtpChanges '$srvr'";
my $sth = $G_dbh->prepare($sql);
die 'Prepare failed' unless (defined($sth));
$sth->execute;
my (@row);
my $i = 0;
do {
  while (@row = $sth->fetchrow() ) {
    $c = shift @row;
    last if ($c eq '0');
    $change{$i} = $c;
    $nickName{$i} = shift @row;
    $pwEntry{$i} = shift @row;
    $i++;
  }
} while($sth->{syb_more_results});
$sth->finish;

$count = scalar keys %change;
if ($count > 0) {
  foreach $i (keys %change) {

    #
    # Add 
    if (($change{$i} eq 'A') || ($change{$i} eq 'U')) {
      `/usr/local/sbin/ncftpd_passwd -f /usr/local/etc/ncftpd/passwd.db -c -u '$pwEntry{$i}'`;
    }
    elsif ($change{$i} eq 'D') {
      `/usr/local/sbin/ncftpd_passwd -f /usr/local/etc/ncftpd/passwd.db -d $nickName{$i}`;
    }

    # if changing the password, then a pw entry ought to exist already.
    # in reality, sometimes the pw entry is missing for some reason. we recover
    # by adding it at this time.
    elsif ($change{$i} eq 'P') {

      # look for existing entry

      @pwe = `/usr/local/sbin/ncftpd_passwd -f /usr/local/etc/ncftpd/passwd.db -q "$nickName{$i}"`;
      @fields = split(/:/, $pwe[0]);

      # existing entry found, so update it

      if ($fields[0] eq $nickName{$i}) {
        `/usr/local/sbin/ncftpd_passwd -c -f /usr/local/etc/ncftpd/passwd.db -p '$nickName{$i}' -P '$pwEntry{$i}'`;
      }

      # existing entry not found, so let's build one now

      else {
        $#pwe = -1;
        push(@pwe, $nickName{$i});
        push(@pwe, $pwEntry{$i});
        $sql =<<SQL;
SELECT u.userID, h.maxSpace
FROM vpusers..users u, vpplaces..homePages h
WHERE u.nickName = "$nickName{$i}"
AND u.userID=h.userID
SQL
        $sth = $G_dbh->prepare($sql);
        die 'Prepare failed' unless (defined($sth));
        $sth->execute;
        $maxSpace = 0;
        $userID = 0;
        do {
          while (@row = $sth->fetchrow() ) {	# only one row expected
            $userID = shift @row;
            $maxSpace = shift @row;
          }
        } while($sth->{syb_more_results});
        $sth->finish;
        if ($maxSpace = 0) {
          $maxSpace = 10;
        }
        push(@pwe, $userID);
        push(@pwe, 60001);
        push(@pwe, $nickName{$i});
        push(@pwe, "$G_config{'membersRoot'}/$nickName{$i}");
        push(@pwe, "/bin/false");
        push(@pwe, ($maxSpace *= 1024));
        $line = join(":", @pwe);
        `/usr/local/sbin/ncftpd_passwd -f /usr/local/etc/ncftpd/passwd.db -c -u '$line'`;
      }
    }
    else {
      warn "Unrecognized change type: $change{$i}";
    }
  }
}
