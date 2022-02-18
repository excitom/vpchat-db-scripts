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
  $G_dbh = DBI->connect ( 'dbi:Sybase:', 'vpplaces', 'vpplaces' );
}


#####################################################
#
# START HERE
#

##$srvr = `hostname`;
##chomp $srvr;
$srvr = 'nike';		## proxy for server which doesn't have sybase

my $sql = "EXEC getFtpChanges '$srvr'";
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

  @t = localtime(time);
  $cmdFile = sprintf("/logs/cmds/updateFtp.cmds.%4.4d-%2.2d-%2.2d:%2.2d:%2.2d", $t[5]+1900, $t[4]+1, $t[3],$t[2], $t[1]);
  open (CMD, ">$cmdFile") || die "Can't create $cmdFile : $!";

  foreach $i (keys %change) {

    #
    # add a new page
    #
    if ($change{$i} eq 'A') {
      @f = split(/:/, $pwEntry{$i});
      $docRoot = '/export/home/members/' . $f[0];
      print CMD <<CMD;
if [ ! -d "$docRoot" ]
then
  newgrp nobody
  mkdir -- "$docRoot"
  chmod 777 -- "$docRoot"
fi
/usr/local/sbin/ncftpd_passwd -f /usr/local/etc/ncftpd/passwd.db -c -u "$pwEntry{$i}"
CMD
    }

    #
    # update a page
    #
    elsif ($change{$i} eq 'U') {
      @f = split(/:/, $pwEntry{$i});
      $docRoot = '/export/home/members/' . $f[0];
      print CMD <<CMD;
if [ ! -d "$docRoot" ]
then
  newgrp nobody
  mkdir -- "$docRoot"
  chmod 777 -- "$docRoot"
fi
/usr/local/sbin/ncftpd_passwd -f /usr/local/etc/ncftpd/passwd.db -c -u '$pwEntry{$i}'
CMD
    }

    #
    # delete a page
    #
    elsif ($change{$i} eq 'D') {
      $docRoot = '/export/home/members/' . $nickName{$i};
      die "programming error" if ($nickName{$i} eq '');
      print CMD <<CMD;
/usr/local/sbin/ncftpd_passwd -f /usr/local/etc/ncftpd/passwd.db -d $nickName{$i}
CMD
    }

    #
    # change password
    #
    elsif ($change{$i} eq 'P') {
      print CMD <<CMD;
/usr/local/sbin/ncftpd_passwd -c -f /usr/local/etc/ncftpd/passwd.db -p '$nickName{$i}' -P '$pwEntry{$i}'
CMD
    }
    else {
      warn "Unrecognized change type: $change{$i}";
    }
  }
  close CMD;
  $tmpFile = $cmdFile . '.tmp';
  `/usr/local/bin/scp $cmdFile $srvr:$tmpFile`;
  `/usr/local/bin/ssh $srvr "mv $tmpFile $cmdFile; /u/vplaces/scripts/homePages/updateFtp.pl"`;
  unlink $cmdFile;
}
