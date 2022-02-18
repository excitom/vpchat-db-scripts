#!/usr/bin/perl
use Date::Manip;
###########################################################
#
# Developed for HalSoft.com - Tom Lang - 11/2001
#
###########################################################

############################
#
# Subroutine: Convert name to 'canonical' form which means, in this case,
# 	lower case with hyphens, underscores, and periods removed. The name is
#	already lower cased when this subroutine is called. After stripping
#	special chars two names may hash to the same value, for example 'tom'
#	and 'tom_'. A suffix is added in this case to make all canonical names
#	unique.
#
#	Why convert to this canonical form? For improved sorting. We want
#	'.tom' to sort next to 'tom', not with all the other names that start 
#	with a period.
# 
sub canonName {
  my $n = shift @_;
  $n =~ s/[-._]+//g;
  $n = "a" if ($n eq "");
  while(defined($members{$n})) {
    $n .= 'a';
  }
  return $n;
}

############################
#
# Subroutine: Extra hash of online users from the vpplaces users.txt file.
#	Both vpadult and vpchat are processed. Several global variables 
#	are set:
#	  $vpchat -> total chatters in vpchat
#	  $vpchatB -> total buddies in vpchat
#	  $vpadult -> total chatters in vpadult
#	  $vpadultB -> total buddies in vpadult
#	  %users -> hash of all online users, keyed by lower-cased name
#			value is the room in which they are chatting
#	  %canonUsers -> hash of all online users, keyed by canonical name
#			value is the mixed case chat name
#
sub getOnline {
 open (USERS, "/bin/rsh anne 'cat /u/vplaces/VPCOM/VPPLACES/users.txt' |");
 while (<USERS>) {
  chomp;
  my @line = split(/\t/, $_);
  if ($line[0] =~ /^[RG][DJ]B/) {
    $vpchatB++;
  }
  elsif ($line[0] =~ /^[RG][DJ]C/) {
    my $n = $line[3];
    $n =~ tr/[A-Z]/[a-z]/;
    $users{$n} = $line[4];
    $vpchat++;
    my $cn = $n;
    $cn =~ s/[-._]+//g;
    $cn = "a" if ($cn eq "");
    while(defined($canonUsers{$cn})) {
      $cn .= 'a';
    }
    $canonUsers{$cn} = $line[3];
  }
  else {
    #die "Invalid column - $line[0]";
	next;
  }
 }
 close USERS;
 open (USERS, "/bin/rsh amy 'cat /u/vplaces/VPCOM/VPPLACES/users.txt' |");
 while (<USERS>) {
  chomp;
  my @line = split(/\t/, $_);
  my $n = $line[3];
  $n =~ tr/[A-Z]/[a-z]/;
  $Ausers{$n} = 1;	# hash of online vpadult users
  if (substr($_,2,1) eq 'B') {
    $vpadultB++;
  } else {
    $vpadult++;
  }
 }
 close USERS;
}

############################
#
# Subroutine: Get titles for rooms, based on their URL. This
#	information is tracked by VPSTATS.
#
sub getRooms {
  my @now = localtime(time);
  $now[4]++;
  $now[5] += 1900;
  my $suffix = sprintf(".%4.4d%2.2d%2.2d", $now[5], $now[4], $now[3]);
  my $roomStats = "/u/vplaces/VPCOM/VPSTATS/stat.log" . $suffix;
  open (ROOMS, "<$roomStats");
  while (<ROOMS>) {
    next unless (/^\d+/);
    chomp;
    my ($junk, $url, $title) = split(/\t/, $_, 3);
    $rooms{$url} = $title unless($title eq '');
  }
  close ROOMS;
}

############################
#
# Subroutine: Get list of member names from the database. The SQL procedure
# 	returns a flag with the name, indicating if there's a member profile.
#
sub getMembers {

  open (SQL_IN, ">$tempsql") || die "Can't write to $tempsql : $!\n";
  print SQL_IN "getMemberDir 0\ngo\n";
  close SQL_IN;

  open (SQL_OUT, "$G_isql_exe -i $tempsql |") || die "Can't read from $G_isql_exe -i $tempsql : $!\n";

  $_ = <SQL_OUT>;	# ignore header lines
  $_ = <SQL_OUT>;
  while (<SQL_OUT>) {
	last if (/^\s*$/);
	my ($prof, $n) = split;
        my $canonName = &canonName($n);
	$members{$canonName} = $n;
	$profiles{$n} = $prof;
	$profiles++ if ($prof);
	$members++;
  }
  close SQL_OUT;
}

sub getHomePages {
  open (SQL_IN, ">$tempsql") || die "Can't write to $tempsql : $!\n";
  print SQL_IN "SELECT 'XX', URL, URL2 FROM vpplaces..homePages WHERE deleted = 0 AND locked=0\nGO\n";
  close SQL_IN;
  open (SQL_OUT, "$G_isql_exe -i $tempsql |") || die "Can't read from $G_isql_exe -i $tempsql : $!\n";

  #
  # Three lines will be returned per home page -- the marker line with 'XX' in it, 
  # followed by a line containing the URL (lower case member name) and a line
  # containing the mixed-case member name (or the string 'NULL' if there isn't
  # a mixed case name).
  #
  while (<SQL_OUT>) {
    next unless (/XX/);
    my $URL = <SQL_OUT>;
    chomp $URL;
    $URL =~ s/^\s+//;
    $URL =~ s/\s+$//;
    my $URL2 = <SQL_OUT>;
    chomp $URL2;
    $URL2 =~ s/^\s+//;
    $URL2 =~ s/\s+$//;
    $pages{$URL} = ($URL2 ne 'NULL') ? $URL2 : $URL;
    $homePages++;
  }
  close SQL_OUT;
 
}

sub getPlaces {
  my $d = &ParseDate('today');
  my $today = &UnixDate( $d, '%Y%m%d');
  open(STATS, qq!/bin/rsh anne "cat /u/vplaces/VPCOM/VPSTATS/stat.log.$today"| !);
  my @lines = <STATS>;
  close STATS;
  my $i;
  $places = 0;
  for ($i=2; $i < ($#lines); $i++) {	# skip 1st two and last line
    my @cols = split(/\t/, $lines[$i]);
    $places++ if ($cols[0] > 10);
  }
  open(STATS, qq!/bin/rsh amy "cat /u/vplaces/VPCOM/VPSTATS/stat.log.$today"| !);
  @lines = <STATS>;
  close STATS;
  for ($i=2; $i < ($#lines-1); $i++) {
    my @cols = split(/\t/, $lines[$i]);
    $places++ if ($cols[0] > 10);
  }
}

sub getYesterday {
  my $datFile = "/u/vplaces/scripts/memberDir/yesterday.dat";
  open (DAT, "<$datFile") || die "Can't read $datFile : $!";
  #
  # The dat file contains Perl assignment statements. We use 'eval'
  # here to execute those statements, thus assigning values to
  # variables.
  # We expect to find:
  #   $minutes
  #   $maxUsers
  #   $sessions
  #   $uniqueUsers
  #
  while (<DAT>) {
    eval;
  }
  close DAT;
}

sub commaPunc {
  my $n = shift @_;
  1 while ($n =~ s/(\d+)(\d\d\d)/$1,$2/);
  return $n;
}

#
# Make full member directory list
#
sub makeFullList {
  my $comm = shift @_;
  $idx = 1;
  $ctr = 1;
  $i = 1;
  $idxFrom = '';
  $n = '';

  open(IDX, ">$fullList.0.html") || die "Can't create $fullList.0.html : $!";
  print IDX <<HTML;
<tr><td align=center colspan=3>There are <b>$members</b> active members.</td></tr>
HTML

  foreach $cn (sort keys %members) {
	$n = $members{$cn};
	if ($i == 1) {
		$idxFrom = $n;
		$file = "$fullList.$idx.html";
		$tmp = "$fullList.tmp";
		open (HTML, ">$tmp") || die "Can't create $tmp: $!";

		$last = $ctr + $chunk - 1;
		$last = $members if ($last > $members);
		print HTML <<HDR;
<tr><td align=center colspan=3>Showing <b>$ctr</b> through <b>$last</b> of <b>$members</b></td></tr>
<tr><th><font size=-2>Send<br>IM</font></th><th><font size=-2>Show<br>Profile</font></th><th>&nbsp;User Name&nbsp;</font></th></tr>
HDR
	}
	my $x = "&nbsp;";
	my $u = ($comm eq 'vpchat') ? $users{$n} : $Ausers{$n};
	if (exists($u)) {
	  $x = "<a onClick=\'sendIM(\"$n\");\'><img border=0 width=10 height=10 src=/img/imbutton.gif></a>";
	}
	  
	my $p = "&nbsp;";
	if ($profiles{$n} == 1) {
	  $p = "<a onClick=\'show(\"$n\");\'><img border=0 width=10 height=10 src=/img/profbutton.gif></a>";
	}
	my $u = $n;
        if (exists($pages{$n})) {
	  $u = "<a href=http://members.vpchat.com/$pages{$n}/>$pages{$n}</a>";
	}
	print HTML "<tr><td align=center>$x</td><td align=center>$p</td><td>&nbsp;$u</td></tr>\n";

	$i++;
	if ($i > $chunk) {
		$i = 1;
		$buttons = "";
		unless ($idx == 1) {
			$prev = $idx-1;
			$buttons .= "<input type=button value='&lt;&nbsp;Back' onClick=\'showNext($prev);\'>&nbsp;";
		} 
		$buttons .= "&nbsp;<input type=button value='Top' onClick=\'showNext(0);\'>";
		unless ($idx == $chunks) {
			$next = $idx+1;
			$buttons .= "&nbsp;<input type=button value='Next&nbsp;&gt;' onClick=\'showNext($next);\'>";
		} 
		print HTML <<BUTTONS;
<tr><td colspan=3><td>&nbsp;</td></tr>
<tr><td align=center colspan=3>$buttons</td></tr>
BUTTONS

		close HTML;
		rename $tmp, $file;

		print IDX <<ROW;
<tr><td width=20>&nbsp;</td><td colspan=2>
<a href=http://reg.vpchat.com/VP/members?idx=$idx><b>$idxFrom</b>
<font color=#000000>through</font>
<b>$n</b></a>
</td></tr>
ROW

		$idx++;
		$idxFrom = '';
	}
	$ctr++;
	$idxTo = $n;
  }

  $prev = $idx-1;
  $buttons = "<input type=button value='&lt;&nbsp;Back' onClick=\'showNext($prev);\'>&nbsp;<input type=button value='Top' onClick=\'showNext(0);\'>";
  print HTML <<BUTTONS;
<tr><td colspan=3><td>&nbsp;</td></tr>
<tr><td align=center colspan=3>$buttons</td></tr>
BUTTONS

  close HTML;
  rename $tmp, $file;

if ($idxFrom ne '') {
	print IDX <<ROW;
<tr><td width=20>&nbsp;</td><td colspan=2>
<a href=http://reg.vpchat.com/VP/members?idx=$idx><b>$idxFrom</b>
<font color=#000000>through</font>
<b>$idxTo</b></a>
</td></tr>
ROW
}
close IDX;

###
### START HERE
###

$dbName = 'vpusr';
$dbPw = 'vpusr1';
$G_isql_exe = "/u/vplaces/s/sybase/bin/isql -U$dbName -P$dbPw -SSYBASE";
$G_statdir = "/tmp/";
$tempsql = $G_statdir . ".temp.sql.$$";
$ENV{'SYBASE'} ||= '/u/vplaces/s/sybase';

&getRooms;
&getMembers;
&getOnline;
&getHomePages;
&getPlaces;
&getYesterday;

$outDir         = "/web/reg/tmp";
$templateDir    = "/u/vplaces/templates";
$memberDir      = "/export/home/members/VP/memberDir";
$statsFile      = $memberDir . "/stats.html";
$tmpStatsFile   = $statsFile . ".tmp";
$fullList       = $memberDir . "/fullList";
$hpList         = $memberDir . "/hpList";
$onlineList     = $memberDir . "/onlineList";
$profileList    = $memberDir . "/profileList";

#
# Make stats file
#
open (HTML, ">$tmpStatsFile") || die "Can't create $tmpStatsFile : $!";

$now = "<script language=javascript>d=new Date;document.write(d.toLocaleString());</script>";

$Vpchat = &commaPunc($vpchat);
$Places = &commaPunc($places);
$Vpadult = &commaPunc($vpadult);
$VpchatB = &commaPunc($vpchatB);
$HomePages = &commaPunc($homePages);
$Profiles = &commaPunc($profiles);
$Members = &commaPunc($members);
$MaxUsers = &commaPunc($maxUsers);
$Sessions = &commaPunc($sessions);
$UniqueUsers = &commaPunc($uniqueUsers);
$Minutes = &commaPunc($minutes);

print HTML <<HTML;
 <table cellspacing=0 cellpadding=1 border=0 width=150>
 <tr bgcolor=#ffcc10>
 <td>
 <table cellspacing=0 cellpadding=0 border=0 width=100%>
 <tr><td align=center>
 <b>Statistics</b>
 </td></tr>
 <td valign=center align=left bgcolor=#ffffff>
 <table border=0>
  <tr><th colspan=2><font size=-2>$now</font></th></tr>
  <tr><td>Online in vpchat</td><th align=right>$Vpchat</th></tr>
  <tr><td>Chat Rooms</td><th align=right>$Places</th></tr>
  <tr><td>Online in vpadult</td><th align=right>$Vpadult</th></tr>
  <tr><td>Using buddy list</td><th align=right>$VpchatB</th></tr>
  <tr><td>Home pages</td><th align=right>$HomePages</th></tr>
  <tr><td>Member profiles</td><th align=right>$Profiles</th></tr>
  <tr><td>Active members</td><th align=right>$Members</th></tr>
  <tr><td colspan=2><a href=http://vpchat.com/topRooms>Top 100 Rooms</a></td></tr>
  <tr><td colspan=2><a href=http://vpchat.com/top100>Top 100 Chatters</a></td></tr>
  <tr><td colspan=2 align=center><i>Yesterday:</i></td></tr>
  <tr><td>Peak online</td><th align=right>$MaxUsers</th></tr>
  <tr><td>Sessions</td><th align=right>$Sessions</th></tr>
  <tr><td>Unique users</td><th align=right>$UniqueUsers</th></tr>
  <tr><td colspan=2>Chat-minutes</td></tr>
  <tr><th colspan=2 align=right>$Minutes</th></tr>
  <tr><td colspan=2><a href=http://reg.vpchat.com/health.cgi>Server status</a></td></tr>
  <tr><td colspan=2><a href=http://vpchat.com/demographics.html>Demographics</a></td></tr>
 </table>
 </td>
 </tr>
 </table>
 </td></tr>
 </table>
HTML

close HTML;
rename $tmpStatsFile, $statsFile;

$chunk = 100;
$chunks = int($members / $chunk);
$chunks++ if ($members % $chunk);

#
# Make full member directory list
#
&makeFullList($comm);

#
# Make homepage-only directory list
#
$chunk = 25;
$chunks = int($homePages / $chunk);
$chunks++ if ($homePages % $chunk);
$idx = 1;
$ctr = 1;
$i = 1;
$idxFrom = '';
$idxTo = '';
$n = '';

open(IDX, ">$hpList.0.html") || die "Can't create $hpList.0.html : $!";
print IDX <<HTML;
<tr><td align=center colspan=3>There are <b>$homePages</b> members with home pages.</td></tr>
HTML

foreach $cn (sort keys %members) {
	$n = $members{$cn};
	next unless(exists($pages{$n}));
	if ($i == 1) {
		$idxFrom = $n;
		$file = "$hpList.$idx.html";
		$tmp = "$hpList.tmp";
		open (HTML, ">$tmp") || die "Can't create $tmp: $!";

		$last = $ctr + $chunk - 1;
		$last = $homePages if ($last > $homePages);
		print HTML <<HDR;
<tr><td align=center colspan=3>Showing <b>$ctr</b> through <b>$last</b> of <b>$homePages</b></td></tr>
<tr><th><font size=-2>Send<br>IM</font></th><th><font size=-2>Show<br>Profile</font></th><th>&nbsp;User Name&nbsp;</font></th></tr>
HDR
	}
	my $x = "&nbsp;";
	if (exists($users{$n})) {
	  $x = "<a onClick=\'sendIM(\"$n\");\'><img border=0 width=10 height=10 src=/img/imbutton.gif></a>";
	}
	  
	my $p = "&nbsp;";
	if ($profiles{$n} == 1) {
	  $p = "<a onClick=\'show(\"$n\");\'><img border=0 width=10 height=10 src=/img/profbutton.gif></a>";
	}
	my $u = "<a href=http://members.vpchat.com/$n/>$n</a>";
	print HTML "<tr><td align=center>$x</td><td align=center>$p</td><td>&nbsp;$u</td></tr>\n";

	$i++;
	if ($i > $chunk) {
		$i = 1;
		$buttons = "";
		unless ($idx == 1) {
			$prev = $idx-1;
			$buttons .= "<input type=button value='&lt;&nbsp;Back' onClick=\'showNext($prev);\'>&nbsp;";
		} 
		$buttons .= "&nbsp;<input type=button value='Top' onClick=\'showNext(0);\'>";
		unless ($idx == $chunks) {
			$next = $idx+1;
			$buttons .= "&nbsp;<input type=button value='Next&nbsp;&gt;' onClick=\'showNext($next);\'>";
		} 
		print HTML <<BUTTONS;
<tr><td colspan=3><td>&nbsp;</td></tr>
<tr><td align=center colspan=3>$buttons</td></tr>
BUTTONS

		close HTML;
		rename $tmp, $file;

		print IDX <<ROW;
<tr><td width=20>&nbsp;</td><td colspan=2>
<a href=http://reg.vpchat.com/VP/members?idx=$idx><b>$idxFrom</b>
<font color=#000000>through</font>
<b>$n</b></a>
</td></tr>
ROW
		$idx++;
		$idxFrom = '';
	}
	$ctr++;
	$idxTo = $n;
}

$prev = $idx-1;
$buttons = "<input type=button value='&lt;&nbsp;Back' onClick=\'showNext($prev);\'>&nbsp;<input type=button value='Top' onClick=\'showNext(0);\'>";
print HTML <<BUTTONS;
<tr><td colspan=3><td>&nbsp;</td></tr>
<tr><td align=center colspan=3>$buttons</td></tr>
BUTTONS

close HTML;
rename $tmp, $file;

if ($idxFrom ne '') {
	print IDX <<ROW;
<tr><td width=20>&nbsp;</td><td colspan=2>
<a href=http://reg.vpchat.com/VP/members?idx=$idx><b>$idxFrom</b>
<font color=#000000>through</font>
<b>$idxTo</b></a>
</td></tr>
ROW
}
close IDX;

#
# Make profile-only directory list
#
$chunk = 25;
$chunks = int($profiles / $chunk);
$chunks++ if ($profiles % $chunk);
$idx = 1;
$ctr = 1;
$i = 1;
$idxFrom = '';
$n = '';

open(IDX, ">$profileList.0.html") || die "Can't create $profileList.0.html : $!";
print IDX <<HTML;
<tr><td align=center colspan=3>There are <b>$profiles</b> members with profiles.</td></tr>
HTML

foreach $cn (sort keys %members) {
	$n = $members{$cn};
	next unless ($profiles{$n} == 1);
	if ($i == 1) {
		$file = "$profileList.$idx.html";
		$idxFrom = $n;
		$tmp = "$profileList.tmp";
		open (HTML, ">$tmp") || die "Can't create $tmp: $!";

		$last = $ctr + $chunk - 1;
		$last = $profiles if ($last > $profiles);
		print HTML <<HDR;
<tr><td align=center colspan=3>Showing <b>$ctr</b> through <b>$last</b> of <b>$profiles</b></td></tr>
<tr><th><font size=-2>Send<br>IM</font></th><th><font size=-2>Show<br>Profile</font></th><th>&nbsp;User Name&nbsp;</font></th></tr>
HDR
	}
	my $x = "&nbsp;";
	if (exists($users{$n})) {
	  $x = "<a onClick=\'sendIM(\"$n\");\'><img border=0 width=10 height=10 src=/img/imbutton.gif></a>";
	}
	  
	my $p = "<a onClick=\'show(\"$n\");\'><img border=0 width=10 height=10 src=/img/profbutton.gif></a>";

	my $u = $n;
	if (exists($pages{$n})) {
	  $u = "<a href=http://members.vpchat.com/$pages{$n}/>$pages{$n}</a>";
	}
	print HTML "<tr><td align=center>$x</td><td align=center>$p</td><td>&nbsp;$u</td></tr>\n";

	$i++;
	if ($i > $chunk) {
		$i = 1;
		$buttons = "";
		unless ($idx == 1) {
			$prev = $idx-1;
			$buttons .= "<input type=button value='&lt;&nbsp;Back' onClick=\'showNext($prev);\'>&nbsp;";
		} 
		$buttons .= "&nbsp;<input type=button value='Top' onClick=\'showNext(0);\'>";
		unless ($idx == $chunks) {
			$next = $idx+1;
			$buttons .= "&nbsp;<input type=button value='Next&nbsp;&gt;' onClick=\'showNext($next);\'>";
		} 
		print HTML <<BUTTONS;
<tr><td colspan=3><td>&nbsp;</td></tr>
<tr><td align=center colspan=3>$buttons</td></tr>
BUTTONS

		close HTML;
		rename $tmp, $file;

		print IDX <<ROW;
<tr><td width=20>&nbsp;</td><td colspan=2>
<a href=http://reg.vpchat.com/VP/members?idx=$idx><b>$idxFrom</b>
<font color=#000000>through</font>
<b>$n</b></a>
</td></tr>
ROW
		$idx++;
		$idxFrom = '';
	}
	$ctr++;
	$idxTo = $n;
}

$prev = $idx-1;
$buttons = "<input type=button value='&lt;&nbsp;Back' onClick=\'showNext($prev);\'>&nbsp;<input type=button value='Top' onClick=\'showNext(0);\'>";
print HTML <<BUTTONS;
<tr><td colspan=3><td>&nbsp;</td></tr>
<tr><td align=center colspan=3>$buttons</td></tr>
BUTTONS

close HTML;
rename $tmp, $file;

if ($idxFrom ne '') {
	print IDX <<ROW;
<tr><td width=20>&nbsp;</td><td colspan=2>
<a href=http://reg.vpchat.com/VP/members?idx=$idx><b>$idxFrom</b>
<font color=#000000>through</font>
<b>$idxTo</b></a>
</td></tr>
ROW
}
close IDX;

#
# Make online-only directory list
#
$chunk = 25;
$chunks = int($vpchat / $chunk)+1;
$chunks++ if ($vpchat % $chunk);
$idx = 1;
$ctr = 1;
$i = 1;
$idxFrom = '';
$n = '';

open(IDX, ">$onlineList.0.html") || die "Can't create $onlineList.0.html : $!";
print IDX <<HTML;
<tr><td align=center colspan=3>There are <b>$vpchat</b> members online now.</td></tr>
HTML

foreach $cn (sort keys %canonUsers) {
	$n = $canonUsers{$cn};
	$n =~ tr/[A-Z]/[a-z]/;
	if ($i == 1) {
		$file = "$onlineList.$idx.html";
		$idxFrom = $n;
		$tmp = "$onlineList.tmp";
		open (HTML, ">$tmp") || die "Can't create $tmp: $!";

		$last = $ctr + $chunk - 1;
		$last = $vpchat if ($last > $vpchat);
		print HTML <<HDR;
<tr><td align=center colspan=3>Showing <b>$ctr</b> through <b>$last</b> of <b>$vpchat</b></td></tr>
<tr><td colspan=3>
<table>
<tr><td>&nbsp;</td><th><font size=-2>Send<br>IM</font></th><th><font size=-2>Show<br>Profile</font></th><th>&nbsp;User Name&nbsp;</font></th><th>Room</th></tr>
HDR
	}
	my $x = "<a onClick=\'sendIM(\"$n\");\'><img border=0 width=10 height=10 src=/img/imbutton.gif></a>";
	  
	my $p = "&nbsp;";
	if ($profiles{$n} == 1) {
	  $p = "<a onClick=\'show(\"$n\");\'><img border=0 width=10 height=10 src=/img/profbutton.gif></a>";
	}
	my $u = $canonUsers{$cn};
	if (exists($pages{$n})) {
	  $u = "<a href=http://members.vpchat.com/$pages{$n}/>$canonUsers{$cn}</a>";
	}
	my $room = "";
	if ($users{$n} =~ /^https*:\/\//) {
	  my $r = $users{$n};
	  my $t = (exists($rooms{$r}) && ($rooms{$r} ne '')) ? $rooms{$r} : $r;
	  $room = "<a href=$r>$t</a>";
	} else {
	  $room = "private room";
	}
	print HTML "<tr><td>$ctr.</td><td align=center>$x</td><td align=center>$p</td><td>&nbsp;$u</td><td>$room</tr>\n";

	$i++;
	if ($i > $chunk) {
		$i = 1;
		$buttons = "";
		unless ($idx == 1) {
			$prev = $idx-1;
			$buttons .= "<input type=button value='&lt;&nbsp;Back' onClick=\'showNext($prev);\'>&nbsp;";
		} 
		$buttons .= "&nbsp;<input type=button value='Top' onClick=\'showNext(0);\'>";
		unless ($idx == $chunks) {
			$next = $idx+1;
			$buttons .= "&nbsp;<input type=button value='Next&nbsp;&gt;' onClick=\'showNext($next);\'>";
		} 
		print HTML <<BUTTONS;
<tr><td colspan=3><td>&nbsp;</td></tr>
<tr><td align=center colspan=3>$buttons</td></tr>
BUTTONS

		close HTML;
		rename $tmp, $file;

		print IDX <<ROW;
<tr><td width=20>&nbsp;</td><td colspan=2>
<a href=http://reg.vpchat.com/VP/members?idx=$idx><b>$idxFrom</b>
<font color=#000000>through</font>
<b>$n</b></a>
</td></tr>
ROW
		$idx++;
		$idxFrom = '';
	}
	$ctr++;
	$idxTo = $n;
}

$prev = $idx-1;
$buttons = "<input type=button value='&lt;&nbsp;Back' onClick=\'showNext($prev);\'>&nbsp;<input type=button value='Top' onClick=\'showNext(0);\'>";
print HTML <<BUTTONS;
</tr></tr></table>
<tr><td colspan=3><td>&nbsp;</td></tr>
<tr><td align=center colspan=3>$buttons</td></tr>
BUTTONS

close HTML;
rename $tmp, $file;

if ($idxFrom ne '') {
	print IDX <<ROW;
<tr><td width=20>&nbsp;</td><td colspan=2>
<a href=http://reg.vpchat.com/VP/members?idx=$idx><b>$idxFrom</b>
<font color=#000000>through</font>
<b>$idxTo</b></a>
</td></tr>
ROW
}
close IDX;

#
# Update vpchat.com home page
#
$template = $templateDir . "/index.htmp";
$template_g = $templateDir . "/google.htmp";
$indexFile = $outDir . "/index.html";
$indexFile_g = $outDir . "/g.html";
open (TEMPLATE, "$template") || die "Can't find vpchat.com index file: $!";
open (HTML, ">$indexFile") || die "Can't create new vpchat.com index file: $!";

while (<TEMPLATE>) {
	if (/####STATS####/) {
		open (STATS, "$statsFile") || die "Can't read $statsFile: $!";
		while(<STATS>) {
			print HTML;
		}
		close STATS;
	} else {
		print HTML;
	}
}
close TEMPLATE;
close HTML;

open (TEMPLATE, "$template_g") || die "Can't find vpchat.com index file: $!";
open (HTML, ">$indexFile_g") || die "Can't create new vpchat.com index file: $!";

while (<TEMPLATE>) {
	if (/####STATS####/) {
		open (STATS, "$statsFile") || die "Can't read $statsFile: $!";
		while(<STATS>) {
			print HTML;
		}
		close STATS;
	} else {
		print HTML;
	}
}
close TEMPLATE;
close HTML;

#
# Push out to front end servers
#
`/bin/rcp $indexFile sparky:/web/chat/html/index.html`;
`/bin/rcp $indexFile ramsey:/web/chat/html/index.html`;
`/bin/rcp $indexFile nala:/web/reg/html/index.html`;
`/bin/rcp $indexFile chang:/web/reg/html/index.html`;
`/bin/rcp $indexFile anne:/web/reg/html/index.html`;
`/bin/rcp $indexFile_g sparky:/web/chat/html/n.html`;
`/bin/rcp $indexFile_g ramsey:/web/chat/html/n.html`;
`/bin/rcp $indexFile_g nala:/web/reg/html/n.html`;
`/bin/rcp $indexFile_g chang:/web/reg/html/n.html`;
`/bin/rcp $indexFile_g anne:/web/reg/html/n.html`;


#
# Update the chat number on the sign in pages
#
$template = $templateDir . "/signIn.vpchat.htmp";
$outFile  = $outDir . "/signIn.vpchat.html";
open (TEMP, "<$template") || die "Can't open $template : $!";
open (HTML, ">$outFile") || die "Can't open $outFile : $!";

while (<TEMP>) {
	s/###Vpchat###/$Vpchat/;
	s/###Places###/$Places/;
	print HTML;
}
close TEMP;
close HTML;
`/bin/rcp $outFile ramsey:/web/chat/html`;
`/bin/rsh ramsey 'mv /web/chat/html/signIn.vpchat.html /web/chat/html/signIn.html'`;
`/bin/rcp $outFile sparky:/web/chat/html`;
`/bin/rsh sparky 'mv /web/chat/html/signIn.vpchat.html /web/chat/html/signIn.html'`;

$template = $templateDir . "/signIn.vpadult.htmp";
$outFile  = $outDir . "/signIn.vpadult.html";
open (TEMP, "<$template") || die "Can't open $template : $!";
open (HTML, ">$outFile") || die "Can't open $outFile : $!";

while (<TEMP>) {
	s/###Vpadult###/$Vpadult/;
	print HTML;
}
close TEMP;
close HTML;
`/bin/rcp $outFile ramsey:/web/adult/html`;
`/bin/rsh ramsey 'mv /web/adult/html/signIn.vpadult.html /web/adult/html/signIn.html'`;
`/bin/rcp $outFile sparky:/web/adult/html`;
`/bin/rsh sparky 'mv /web/adult/html/signIn.vpadult.html /web/adult/html/signIn.html'`;

unlink($tempsql);
