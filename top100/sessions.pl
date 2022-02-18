#!/usr/bin/perl
#
# Figure out who has been chatting the longest and create a web 
# page containing that information.

# Tom Lang 2/2002
use DBI;

BEGIN {
  $ENV{'SYBASE'} ||= '/u/vplaces/s/sybase';
  $G_dbh = DBI->connect ( 'dbi:Sybase:', 'sa', 'UBIQUE' );
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

##############################
#
# START HERE
#

&getConfigKeys;
die "missing config keys" unless(defined(%G_config));
if ($G_config{'communityName'} =~ /vpadult/) {
  #$docRoot = $G_config{'adultRoot'};
  $srvr = $G_config{'VPPLACESadultServer'};
  #@frontEndServers = split(/,/,$G_config{'adultFEWS'});
} else {
  $docRoot = $G_config{'chatRoot'};
  $srvr = $G_config{'VPPLACESserver'};
  @frontEndServers = split(/,/,$G_config{'chatFEWS'});
}
$templateDir = "/u/vplaces/templates";
$template = $templateDir . "/top100.htmp";
$tmpFile  = "/export/u03/content/chat/html/top100.php.tmp";
$outFile  = "/export/u03/content/chat/html/top100.php";
open (TEMP, "<$template") || die "Can't read $template : $!";
open (HTML, ">$tmpFile") || die "Can't create $tmpFile : $!";

$G_hostDir = "/u/vplaces";
$G_usersFile = $G_hostDir . "/VPCOM/VPPLACES/users.txt";
if ($srvr eq $G_config{'thisHost'}) {
  open (USERS, "<$G_usersFile")   || die "Can't read $G_usersFile : $!";
} else {
  open (USERS, "/bin/rsh $srvr \"cat $G_usersFile\" |")   || die "Can't read $G_usersFile : $!";
}

$n = time;
while (<USERS>) {
	chomp;
	($type, $login, $lastNav, $name, $url) = split(/\t/, $_);
	($umode, $utype, $ctype) = split(//, $type);
	next if ($ctype eq "B");	# skip buddy list users
	next if ($name =~ /vp-resmon[0-9_]+/);	# skip robots
	next if ($lastNav == 0);	# skip servers
	$stime = $n - $login;				# session length
	$session{$name} = $stime;
	#$onLine{$name} = scalar localtime($login);	# online since
	$onLine{$name} = $login;			# online since
}
close(USERS);

while (<TEMP>) {
	last if (/###END OF HEADER###/);
	1 while( s/###([^#]+)###/$G_config{$1}/ );
	print HTML;
}

print HTML <<HTML;
        <tr> 
          <th class="formheader">Rank</th>
          <th class="formheader">Chatter</th>
          <th class="formheader"> Online Since</th>
          <th class="formheader">Time Online</th>
        </tr>
HTML


#
# Loop through the sessions and build the table rows
#
$t = 1;
foreach $name (sort {$session{$b} <=> $session{$a} || $a cmp $b} keys %session) {

	$x = $session{$name};
	$hrs = int($x / (60 * 60));
	$mins = int(($x - ($hrs * 60 * 60)) / 60);
	$secs = $x % 60;
	#$since = $onLine{$name};
	$since = "<script language=javascript>dateCalc(\"$onLine{$name}\");</script>";
	if ($hrs > 24) {
		$days = int($hrs / 24);
		$hrs = $hrs % 24;
		$elapsed = sprintf "%3.1d days %2.1d hrs %2.1d min", $days, $hrs, $mins;
	}
	else {
		$elapsed = sprintf "%2.1d hrs %2.1d min %2.1d sec", $hrs, $mins, $secs;
	}

	print HTML <<HTML;
<tr>
<th class="forminfo">$t</th>
<td class="ItemBold" width='35%'>$name</td>
<th class="forminfo" width="35%">$since</th>
<th class="forminfo" width="25%">$elapsed</th>
</tr>
HTML

	last if ($t++ >= 100);
}

print HTML "</table>\n";

while (<TEMP>) {
	1 while( s/###([^#]+)###/$G_config{$1}/ );
	print HTML;
}
close TEMP;
close HTML;

foreach $server (@frontEndServers) {
  next if ($server eq $G_config{'thisHost'});
  `/bin/rcp $outFile $server:$docRoot/top100.htmp`;
  `/bin/rsh $server "mv $docRoot/top100.htmp $docRoot/top100.php"`;
}
rename $tmpFile, $outFile;
