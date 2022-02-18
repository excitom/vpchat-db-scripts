#!/usr/bin/perl
#
# Periodically process pending homePage changes
#
# When the homePages database table is updated some changes to the
# homePages are propagated immediately. Others are deferred, due to
# complexity or high overhead of processing. For the deferred changes,
# records are added to the homePageChages table. This program runs
# periodically from crontab and applies the changes. 
#
# Tom Lang 6/2002
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

##############
#
# Subroutine: activate/decativate a user created room
#		We're not sure if one exists for this URL,
#		but it doesn't hurt to try.
#
sub updateUserPlace {
  my $aid = shift @_;
  my $activate = shift @_;
  my $URL = shift @_;

  $activate = 1 - $activate;	# reverse the polarity

  my $sth = $G_dbh->prepare("EXEC vpplaces..updateUserPlace $aid, $activate, '$URL'");
  die 'Prepare failed' unless (defined($sth));
  $sth->execute;
  my (@row);
  do {
    while (@row = $sth->fetchrow() ) {
	# nothing to do
    }
  } while($sth->{syb_more_results});
  $sth->finish;
}

########################
#
# START HERE
#

$ENV{'SYBASE'} ||= '/u/vplaces/s/sybase';
$dbName = 'sa';
$dbPw = 'UBIQUE';
$G_dbh = DBI->connect ( 'dbi:Sybase:', $dbName, $dbPw );
&getConfigKeys;

###die "This script should run on $G_config{'membersNFS'} not $G_config{'thisHost'}" unless($G_config{'membersNFS'} eq $G_config{'thisHost'});

$sql =<<SQL;
EXEC vpplaces..getHomePageChanges
SQL
$sth = $G_dbh->prepare($sql);
die 'Prepare failed' unless (defined($sth));
$sth->execute;

#
# Find the change records
# - the SQL procedure returns all the records and deletes them
#   from the homePageChages table in the same transaction.
#
do {
  while (@row = $sth->fetchrow() ) {
    if ($sth->{syb_result_type} == CS_ROW_RESULT) {
	# returns month day year time userID change intVal strVal
	shift @row; shift @rowf; shift @rowf; shift @rowf;
	$userID = shift @row;
	$change{$userID} = shift @row;
	$intVal{$userID} = shift @row;
	$strVal{$userID} = shift @row;
    }
  }
} while($sth->{syb_more_results});
$sth->finish;

#
# The command file is a batch of commands that will be executed
# on a web server that doesn't have access to sybase.
#
if ((scalar keys %change) > 0) {
  @t = localtime(time);
  $cmdFile = sprintf("/logs/cmds/update.cmds.%4.4d-%2.2d-%2.2d:%2.2d:%2.2d", $t[5]+1900, $t[4]+1, $t[3],$t[2], $t[1]);
  open (CMD, ">$cmdFile") || die "Can't create $cmdFile : $!";
  $srvr = 'nike';
}

#
# Process the changes
#
foreach $userID (keys %change) {
##print "$userID -- $change{$userID} -- $intVal{$userID} -- $strVal{$userID}\n";
	#
	# Change lock status
	#
	if ($change{$userID} eq 'L') {
		die "programming error - null URL" if (($strVal{$userID} eq '') || ($strVal{$userID} eq 'NULL'));

		my $dir = $G_config{'membersRoot'};
		die 'missing config key' if ($dir eq '');
		$dir = "$dir/$strVal{$userID}";
		#
		# The 'access' program is a setUID-root program that puts
		# a .htaccess file in the user's directory that locks out
		# the home page (and all sub-dirs). It's owned by root so
		# it can't be removed by the user.
		#
		if ($intVal{$userID} == 0) {
			####`/usr/local/bin/access -u $dir`;
			print CMD "/usr/local/bin/access -u $dir\n";
		} else {
			####`/usr/local/bin/access -l $dir`;
			print CMD "/usr/local/bin/access -l $dir\n";
		}
		my $url = "$G_config{'membersURL'}/$strVal{$userID}";
		&updateUserPlace($userID, $intVal{$userID}, $url);
	}
	#
	# Change delete status
	#
	elsif ($change{$userID} eq 'D') {
		die "programming error - null URL" if (($strVal{$userID} eq '') || ($strVal{$userID} eq 'NULL'));

		my $saveDir = $G_config{'deletedMembersRoot'};
		die 'missing config key' if ($saveDir eq '');
		my $docRoot = $G_config{'membersRoot'};
		die 'missing config key' if ($docRoot eq '');

		#
		# if the URL is mixed case, it is an alias for the actual dir
		#
		$URL = $strVal{$userID};
		$URL2 = $URL;
		$URL =~ tr/[A-Z]/[a-z]/;
		die "invalid URL" if ($URL =~ /^\s*$/);

		#
		# Delete the home page
		#
		if ($intVal{$userID} == 1) {

			my $dir = "$docRoot/$URL";
			####next unless (-d $dir);
			####`/usr/local/bin/access -u $dir`;  # remove sticky bit
			####`mv -- $dir $saveDir`;
			####`rm -f -- "$docRoot/$URL2"` if ($URL ne $URL2);
			print CMD <<CMD;
if [ -d $dir ]
then
  /usr/local/bin/access -u $dir
  mv -- $dir $saveDir
fi
rm -f -- "$docRoot/$URL2"
CMD
			my $url = "$G_config{'membersURL'}/$strVal{$userID}";
			&updateUserPlace($userID, 1, $url);
		}
		#
		# Restore the home page
		#
		else {
			my $dir = "$saveDir/$URL";
			###`mv -- $dir $docRoot`;
			###`ln -s -- $docRoot/$URL $docRoot/$URL2` if ($URL ne $URL2);
			###`/usr/local/bin/access -u $docRoot/$URL`;

			die ("Missing save dir") if ($dir =~ /^\s*$/);

			print CMD <<CMD;
if [ ! -d "$docRoot/$URL" ]
then
  newgrp nobody
  mkdir "$docRoot/$URL"
  chmod 777 $docRoot/$URL
fi
if [ -d "$dir" ]
then
  cd $dir
  find . -print | cpio -pdm $docRoot/$URL
  rm -r $dir
fi
/usr/local/bin/access -u $docRoot/$URL
CMD
			print CMD "ln -s -- $docRoot/$URL $docRoot/$URL2\n" if ($URL ne $URL2);
		}
	}
}
close CMD;
if ( -f $cmdFile ) {
	$tmpFile = $cmdFile . '.tmp';
	`/usr/local/bin/scp $cmdFile $srvr:$tmpFile`;
	`/usr/local/bin/ssh $srvr "mv $tmpFile $cmdFile; /u/vplaces/scripts/homePages/updatePages.pl"`;
	unlink $cmdFile;
}
