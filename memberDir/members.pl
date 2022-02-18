#!/usr/bin/perl
use Date::Manip;
use DBI;

BEGIN {
  $ENV{'SYBASE'} ||= '/u/vplaces/s/sybase';
  $G_dbh = DBI->connect ( 'dbi:Sybase:', 'sa', 'UBIQUE' );
}

###########################################################
#
# Developed for HalSoft.com - Tom Lang - 11/2001
#
# Purpose: Build a whole lot of static HTML pages which
#	   together comprise the member directory.
#	   Because they are static, performance when 
#	   browsing the directory is fast. Yet, the 
#	   information is dynamic. This program runs
#	   periodically (from crontab), so the static
#	   information updates every few minutes, 
#	   giving the impression that it's dynamic 
#	   content.
#
###########################################################

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
# Subroutine: Build lists of online users from the vpplaces users.txt file.
#	  $vpchat -> total chatters in vpchat
#	  $vpchatB -> total buddies in vpchat
#	  %users -> hash of all online users, keyed by lower-cased name
#			value is the room in which they are chatting
#	  %canonUsers -> hash of all online users, keyed by canonical name
#			value is the mixed case chat name
#
# The format of the users.txt file is one line per user, and the first
# 3 characters of the line indicate what kind of user. 
# - 1st char is R (registered) or G (guest)
# - 2nd char is D (download client) or J (java client)
# - 3rd char is C (chat) or B (buddy list)
#
sub getOnline {

 &readUsersFile( 'vpchat' );
}

sub readUsersFile {
 my $comm = shift @_;
 my $srvr = $G_config{'VPUSERSserver'};

 if ($srvr eq $G_config{'thisHost'}) {
   open (USERS, "</u/vplaces/VPCOM/VPPLACES/users.txt");
 }
 else {
   open (USERS, "/bin/rsh $srvr 'cat /u/vplaces/VPCOM/VPPLACES/users.txt' |");
 }
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
    if ($comm eq 'vpchat') {
      while(defined($canonUsers{$cn})) {
        $cn .= 'a';
      }
      $canonUsers{$cn} = $line[3];
    } else {
      while(defined($AcanonUsers{$cn})) {
        $cn .= 'a';
      }
      $AcanonUsers{$cn} = $line[3];
    }
  }
  else {
    #die "Invalid column - $line[0]";
	next;
  }
 }
 close USERS;
}

############################
#
# Subroutine: Get titles for rooms, based on their URL. This
#	information is tracked by VPSTATS.
#
#	Also a global variable is set, indicating the total
#	number of chat rooms in existance at this time. To
#	keep the number from inflating with URLs visited only
#	briefly, the counter is incremented only if the room
#	usage exceeds 10 minutes.
#
sub getRooms {
  $places = 0;		# global variable

  my @now = localtime(time);
  $now[4]++;
  $now[5] += 1900;
  my $suffix = sprintf(".%4.4d%2.2d%2.2d", $now[5], $now[4], $now[3]);
  my $roomStats = "/u/vplaces/VPCOM/VPSTATS/stat.log" . $suffix;

  if ($G_config{'VPSTATSserver'} eq $G_config{'thisHost'}) {
    open (ROOMS, "<$roomStats");
  }
  else {
    open (ROOMS, "/bin/rsh $G_config{'VPSTATSserver'} 'cat $roomStats' |");
  }
  while (<ROOMS>) {
    next unless (/^\d+/);
    chomp;
    my ($usage, $url, $title) = split(/\t/, $_, 3);
    $title =~ s/<\w[^>]*>//g;	# strip HTML tags
    $rooms{$url} = $title unless($title eq '');
    $places++ if ($usage > 10);
  }
  close ROOMS;
}

############################
#
# Subroutine: Get list of member names from the database. The SQL procedure
# 	returns a flag with the name, indicating if there's a member profile.
#
sub getMembers {
  my $sth = $G_dbh->prepare("EXEC vpusers..getMemberDir 0");
  die 'Prepare failed' unless (defined($sth));
  $sth->execute;
  my (@row);
  do {
    while (@row = $sth->fetchrow() ) {
	my $prof = shift @row;
	my $n = shift @row;
	next if ($n eq '');
        my $canonName = &canonName($n);

	$members{$canonName} = $n;
	$profiles{$n} = $prof;
	$profiles++ if ($prof);
	$members++;
    }
  } while($sth->{syb_more_results});
  $sth->finish;
}

sub getHomePages {
  my $sth = $G_dbh->prepare("SELECT URL, URL2 FROM vpplaces..homePages WHERE deleted = 0 AND locked=0");
  die 'Prepare failed' unless (defined($sth));
  $sth->execute;
  my (@row);
  do {
    while (@row = $sth->fetchrow() ) {
	my $URL = shift @row;
	my $URL2 = shift @row;
	next if ($URL eq '');
    	$pages{$URL} = ($URL2 ne '') ? $URL2 : $URL;
    	$homePages++;
    }
  } while($sth->{syb_more_results});
  $sth->finish;
}

sub getGames {
  my $inputFile = "/u/vplaces/VPCOM/VPCLUBS/snapshot.txt";
  open(GAMES, "<$inputFile");
  while(<GAMES>) {
    /^([^ ]+) .*:\s*(\d+)\s.*:\s*(\d+)\s.*:\s*(\d+)/;
    $gamePlayers{$1} = $2;
    $gamesStarted{$1} = $3;
    $gamesInProgress{$1} = $4;
  }
  close(GAMES);
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

#####################################
#
# Subroutine: Make HTML files for the full member directory list 
#
#	Note: this relies on a lot of static variables.
#
sub makeFullList {
  my $chunk = 100;		# listings per page (chunk)
  my $chunks = int($members / $chunk);
  $chunks++ if ($members % $chunk);
  my $idx = 1;			# the current chunk
  my $ctr = 1;			# total names processed
  my $i = 1;			# listing index relative to the chunk
  my $idxFrom = '';
  my $idxTo = '';
  my $n = '';
  my ($prev, $next, $buttons, $last, $file, $tmp, $cn);

  #
  # The top level page is an index which has links to one or more pages,
  # each of which is a chunk of the directory.
  #
  open(IDX, ">$fullList.0.html") || die "Can't create $fullList.0.html : $!";
  print IDX <<HTML;
<tr><td class=ItemLabel align=center colspan=4>There are <b>$members</b> active members.</td></tr>
HTML

  #
  # Loop through all the names in the member directory, using the "canonical"
  # list which alphabetizes names regardless of special character prefix.
  # 
  foreach $cn (sort keys %members) {
	$n = $members{$cn};			# Get the actual user name

	#
	# If first line of a chunk, open an new output file and 
	# create the page header.
	#
	if ($i == 1) {
		$idxFrom = $n;
		$file = "$fullList.$idx.html";
		$tmp = "$fullList.tmp";
		open (HTML, ">$tmp") || die "Can't create $tmp: $!";

		$last = $ctr + $chunk - 1;
		$last = $members if ($last > $members);

		$buttons = "";
		unless ($idx == 1) {
			$prev = $idx-1;
			$buttons .= "<input class=Button type=button value='&lt;&nbsp;Back' onClick=\'showNext($prev);\'>&nbsp;";
		} 
		$buttons .= "&nbsp;<input class=Button type=button value='Top' onClick=\'showNext(0);\'>";
		unless ($idx == $chunks) {
			$next = $idx+1;
			$buttons .= "&nbsp;<input class=Button type=button value='Next&nbsp;&gt;' onClick=\'showNext($next);\'>";
		} 

		print HTML <<HDR;
<tr>
 <td class=ItemLabel align=center colspan=4>$buttons</td>
 <td class=ItemLabel align=center colspan=1>Showing <b>$ctr</b> through <b>$last</b> of <b>$members</b>
</td>
</tr>
<tr>
 <td class=Item>&nbsp;</td>
 <th class=ItemLabel>Send<br>IM</th>
 <th class=ItemLabel>Show<br>Profile</th>
 <th class=ItemLabel colspan=2>&nbsp;User Name&nbsp;</th>
</tr>
HDR
	}

	#
	# Process one row
	# - Put a button in the "Send IM" column if the user is online
	# - Put a button in the "Profile" column if the user has a profile
	# - Show the user name as a link to his home page
	#
	my $x = "&nbsp;";
	if (exists($users{$n})) {
	  $x = "<a onClick=\'sendIM(\"$n\");\'><img border=0 width=10 height=10 src=/img/imbutton.gif></a>";
	}
	  
	my $p = "&nbsp;";
	if ($profiles{$n} == 1) {
	  $p = "<a onClick=\'show(\"$n\");\'><img border=0 width=10 height=10 src=/img/profbutton.gif></a>";
	}
	my $u = $n;
        if (exists($pages{$n})) {
	  $u = "<a href=$G_config{'membersURL'}/$pages{$n}/>$pages{$n}</a>";
	}
	print HTML <<ROW;
<tr>
 <td class=ItemLabel>&nbsp;</td>
 <td class=ItemLabel align=center>$x</td>
 <td class=ItemLabel align=center>$p</td>
 <td class=Item colspan=2>&nbsp;$u</td>
</tr>
ROW

	$i++;

	#
	# If bottom of the current page (chunk),
	# create the footer and close the output file.
	#
	if ($i > $chunk) {
		$i = 1;
		print HTML <<BUTTONS;
<tr>
 <td class=ItemLabel colspan=5>&nbsp;</td>
</tr>
<tr>
 <td class=ItemLabel align=center colspan=4>$buttons</td>
 <td class=Item>&nbsp;</td>
</tr>
BUTTONS

		close HTML;
		rename $tmp, $file;

		#
		# Now that we know the range of names in this chunk,
		# create a lne for it in the top level index.
		#
		print IDX <<ROW;
<tr><td class=ItemLabel width=20>&nbsp;</td><td class=ItemLabel colspan=2>
<a href=$G_config{'regURL'}/VP/members?idx=$idx><b>$idxFrom</b>
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

  #
  # Close out the current chunk
  #
  print HTML <<BUTTONS;
<tr>
 <td class=ItemLabel colspan=5>&nbsp;</td>
</tr>
<tr>
 <td class=ItemLabel align=center colspan=4>$buttons</td>
 <td class=Item>&nbsp;</td>
</tr>
BUTTONS

  close HTML;
  rename $tmp, $file;

  #
  # Close out the top level index
  #
  if ($idxFrom ne '') {
	print IDX <<ROW;
<tr><td class=ItemLabel width=20>&nbsp;</td><td class=ItemLabel colspan=2>
<a href=$G_config{'regURL'}/VP/members?idx=$idx><b>$idxFrom</b>
<font color=#000000>through</font>
<b>$idxTo</b></a>
</td></tr>
ROW
  }
  close IDX;
}

#####################################
#
# Subroutine: Make HTML files for the member directory list subset,
#		people with home pages.
#
#	Note: this relies on a lot of static variables.
#
sub makeHomePageList {
  my $chunk = 25;		# listings per page (chunk)
  my $chunks = int($homePages / $chunk);
  $chunks++ if ($homePages % $chunk);
  my $idx = 1;			# the current chunk
  my $ctr = 1;			# total names processed
  my $i = 1;			# listing index relative to the chunk
  my $idxFrom = '';
  my $idxTo = '';
  my $n = '';
  my ($prev, $next, $buttons, $last, $file, $tmp, $cn);

  #
  # The top level page is an index which has links to one or more pages,
  # each of which is a chunk of the directory.
  #
  open(IDX, ">$hpList.0.html") || die "Can't create $hpList.0.html : $!";
  print IDX <<HTML;
<tr><td class=ItemLabel align=center colspan=4>There are <b>$homePages</b> members with home pages.</td></tr>
HTML

  #
  # Loop through all the names in the member directory, using the "canonical"
  # list which alphabetizes names regardless of special character prefix.
  # 
  foreach $cn (sort keys %members) {
	$n = $members{$cn};			# Get the actual user name
	next unless(exists($pages{$n}));	# Skip unless it has a home page

	#
	# If first line of a chunk, open an new output file and 
	# create the page header.
	#
	if ($i == 1) {
		$idxFrom = $n;
		$file = "$hpList.$idx.html";
		$tmp = "$hpList.tmp";
		open (HTML, ">$tmp") || die "Can't create $tmp: $!";

		$last = $ctr + $chunk - 1;
		$last = $homePages if ($last > $homePages);
		$buttons = "";
		unless ($idx == 1) {
			$prev = $idx-1;
			$buttons .= "<input class=Button type=button value='&lt;&nbsp;Back' onClick=\'showNext($prev);\'>&nbsp;";
		} 
		$buttons .= "&nbsp;<input class=Button type=button value='Top' onClick=\'showNext(0);\'>";
		unless ($idx == $chunks) {
			$next = $idx+1;
			$buttons .= "&nbsp;<input class=Button type=button value='Next&nbsp;&gt;' onClick=\'showNext($next);\'>";
		} 
		print HTML <<HDR;
<tr>
 <td class=ItemLabel align=center colspan=4>$buttons</td>
 <td class=ItemLabel align=center colspan=1>Showing <b>$ctr</b> through <b>$last</b> of <b>$homePages</b>
</td>
</tr>
<tr>
 <td class=Item>&nbsp;</td>
 <th class=ItemLabel>Send<br>IM</th>
 <th class=ItemLabel>Show<br>Profile</th>
 <th class=ItemLabel colspan=2>&nbsp;User Name&nbsp;</th>
</tr>
HDR
	}

	#
	# Process one row
	# - Put a button in the "Send IM" column if the user is online
	# - Put a button in the "Profile" column if the user has a profile
	# - Show the user name as a link to his home page
	#
	my $x = "&nbsp;";
	if (exists($users{$n})) {
	  $x = "<a onClick=\'sendIM(\"$n\");\'><img border=0 width=10 height=10 src=/img/imbutton.gif></a>";
	}
	  
	my $p = "&nbsp;";
	if ($profiles{$n} == 1) {
	  $p = "<a onClick=\'show(\"$n\");\'><img border=0 width=10 height=10 src=/img/profbutton.gif></a>";
	}
	my $u = "<a href=$G_config{'membersURL'}/$n/>$n</a>";
	print HTML <<ROW;
<tr>
 <td class=ItemLabel>&nbsp;</td>
 <td class=ItemLabel align=center>$x</td>
 <td class=ItemLabel align=center>$p</td>
 <td class=Item colspan=2>&nbsp;$u</td>
</tr>
ROW

	$i++;

	#
	# If bottom of the current page (chunk),
	# create the footer and close the output file.
	#
	if ($i > $chunk) {
		$i = 1;
		print HTML <<BUTTONS;
<tr>
 <td class=ItemLabel colspan=5>&nbsp;</td>
</tr>
<tr>
 <td class=ItemLabel align=center colspan=4>$buttons</td>
 <td class=Item>&nbsp;</td>
</tr>
BUTTONS

		close HTML;
		rename $tmp, $file;

		#
		# Now that we know the range of names in this chunk,
		# create a lne for it in the top level index.
		#
		print IDX <<ROW;
<tr>
 <td class=ItemLabel width=20>&nbsp;</td>
 <td class=ItemLabel colspan=2>
<a href=$G_config{'regURL'}/VP/members?idx=$idx><b>$idxFrom</b>
<font color=#000000>through</font>
<b>$n</b></a>
 </td>
</tr>
ROW
		$idx++;
		$idxFrom = '';
	}
	$ctr++;
	$idxTo = $n;
  }

  #
  # Close out the current chunk
  #
  print HTML <<BUTTONS;
<tr>
 <td class=ItemLabel colspan=5>&nbsp;</td>
</tr>
<tr>
 <td class=ItemLabel align=center colspan=4>$buttons</td>
 <td class=Item>&nbsp;</td>
</tr>
BUTTONS

  close HTML;
  rename $tmp, $file;

  #
  # Close out the top level index
  #
  if ($idxFrom ne '') {
	print IDX <<ROW;
<tr>
 <td class=ItemLabel width=20>&nbsp;</td><td class=ItemLabel colspan=2>
<a href=$G_config{'regURL'}/VP/members?idx=$idx><b>$idxFrom</b>
<font color=#000000>through</font>
<b>$n</b></a>
 </td>
</tr>
ROW
  }
  close IDX;
}

#####################################
#
# Subroutine: Make HTML files for the member directory list subset,
#		people with profiles only.
#
#	Note: this relies on a lot of static variables.
#
sub makeProfileList {
  my $chunk = 25;		# listings per page (chunk)
  my $chunks = int($profiles / $chunk);
  $chunks++ if ($profiles % $chunk);
  my $idx = 1;			# the current chunk
  my $ctr = 1;			# total names processed
  my $i = 1;			# listing index relative to the chunk
  my $idxFrom = '';
  my $idxTo = '';
  my $n = '';
  my ($prev, $next, $buttons, $last, $file, $tmp, $cn);

  #
  # The top level page is an index which has links to one or more pages,
  # each of which is a chunk of the directory.
  #
  open(IDX, ">$profileList.0.html") || die "Can't create $profileList.0.html : $!";
  print IDX <<HTML;
<tr><td class=ItemLabel align=center colspan=4>There are <b>$profiles</b> members with profiles.</td></tr>
HTML

  #
  # Loop through all the names in the member directory, using the "canonical"
  # list which alphabetizes names regardless of special character prefix.
  # 
  foreach $cn (sort keys %members) {
	$n = $members{$cn};			# Get the actual user name
	next unless ($profiles{$n} == 1);	# Skip unless it has a profile

	#
	# If first line of a chunk, open an new output file and 
	# create the page header.
	#
	if ($i == 1) {
		$file = "$profileList.$idx.html";
		$idxFrom = $n;
		$tmp = "$profileList.tmp";
		open (HTML, ">$tmp") || die "Can't create $tmp: $!";

		$last = $ctr + $chunk - 1;
		$last = $profiles if ($last > $profiles);
		$buttons = "";
		unless ($idx == 1) {
			$prev = $idx-1;
			$buttons .= "<input class=Button type=button value='&lt;&nbsp;Back' onClick=\'showNext($prev);\'>&nbsp;";
		} 
		$buttons .= "&nbsp;<input class=Button type=button value='Top' onClick=\'showNext(0);\'>";
		unless ($idx == $chunks) {
			$next = $idx+1;
			$buttons .= "&nbsp;<input class=Button type=button value='Next&nbsp;&gt;' onClick=\'showNext($next);\'>";
		} 
		print HTML <<HDR;
<tr>
 <td class=ItemLabel align=center colspan=4>$buttons</td>
 <td class=ItemLabel align=center colspan=1>Showing <b>$ctr</b> through <b>$last</b> of <b>$profiles</b>
</td>
</tr>
<tr>
 <td class=Item>&nbsp;</td>
 <th class=ItemLabel>Send<br>IM</th>
 <th class=ItemLabel>Show<br>Profile</th>
 <th class=ItemLabel colspan=2>&nbsp;User Name&nbsp;</th>
</tr>
HDR
	}

	#
	# Process one row
	# - Put a button in the "Send IM" column if the user is online
	# - Put a button in the "Profile" column if the user has a profile
	# - Show the user name as a link to his home page
	#
	my $x = "&nbsp;";
	if (exists($users{$n})) {
	  $x = "<a onClick=\'sendIM(\"$n\");\'><img border=0 width=10 height=10 src=/img/imbutton.gif></a>";
	}
	  
	my $p = "<a onClick=\'show(\"$n\");\'><img border=0 width=10 height=10 src=/img/profbutton.gif></a>";

	my $u = $n;
	if (exists($pages{$n})) {
	  $u = "<a href=$G_config{'membersURL'}/$pages{$n}/>$pages{$n}</a>";
	}
	print HTML <<ROW;
<tr>
 <td class=ItemLabel>&nbsp;</td>
 <td class=ItemLabel align=center>$x</td>
 <td class=ItemLabel align=center>$p</td>
 <td class=Item colspan=2>&nbsp;$u</td>
</tr>
ROW

	$i++;

	#
	# If bottom of the current page (chunk),
	# create the footer and close the output file.
	#
	if ($i > $chunk) {
		$i = 1;
		print HTML <<BUTTONS;
<tr><td class=ItemLabel colspan=4><td>&nbsp;</td></tr>
<tr><td class=ItemLabel align=center colspan=4>$buttons</td></tr>
BUTTONS

		close HTML;
		rename $tmp, $file;

		#
		# Now that we know the range of names in this chunk,
		# create a lne for it in the top level index.
		#
		print IDX <<ROW;
<tr>
 <td class=ItemLabel width=20>&nbsp;</td>
 <td class=ItemLabel colspan=2>
<a href=$G_config{'regURL'}/VP/members?idx=$idx><b>$idxFrom</b>
<font color=#000000>through</font>
<b>$n</b></a>
 </td>
</tr>
ROW
		$idx++;
		$idxFrom = '';
	}
	$ctr++;
	$idxTo = $n;
  }

  #
  # Close out the current chunk
  #
  print HTML <<BUTTONS;
<tr>
 <td class=ItemLabel colspan=5>&nbsp</td>
</tr>
<tr>
 <td class=ItemLabel align=center colspan=4>$buttons</td>
 <td class=Item>&nbsp;</td>
</tr>
BUTTONS

  close HTML;
  rename $tmp, $file;

  #
  # Close out the top level index
  #
  if ($idxFrom ne '') {
	print IDX <<ROW;
<tr><td class=ItemLabel width=20>&nbsp;</td><td class=ItemLabel colspan=2>
<a href=$G_config{'regURL'}/VP/members?idx=$idx><b>$idxFrom</b>
<font color=#000000>through</font>
<b>$idxTo</b></a>
</td></tr>
ROW
  }
  close IDX;
}

#####################################
#
# Subroutine: Make HTML files for the member directory list subset,
#		people online in vpchat only.
#
#	Note: this relies on a lot of static variables.
#
sub makeVpchatList {
  my $chunk = 25;
  my $chunks = int($vpchat / $chunk);
  $chunks++ if ($vpchat % $chunk);
  my $idx = 1;
  my $ctr = 1;
  my $i = 1;
  my $idxFrom = '';
  my $idxTo = '';
  my $n = '';
  my ($prev, $next, $buttons, $last, $file, $tmp, $cn);

  open(IDX, ">$onlineList.0.html") || die "Can't create $onlineList.0.html : $!";
  print IDX <<HTML;
<tr><td class=ItemLabel align=center colspan=5>There are <b>$vpchat</b> members online now in <b><font color=#cc0000>vpchat.com</font></b>.
</td></tr>
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
		$buttons = "";
		unless ($idx == 1) {
			$prev = $idx-1;
			$buttons .= "<input class=Button type=button value='&lt;&nbsp;Back' onClick=\'showNext($prev);\'>&nbsp;";
		} 
		$buttons .= "&nbsp;<input class=Button type=button value='Top' onClick=\'showNext(0);\'>";
		unless ($idx == $chunks) {
			$next = $idx+1;
			$buttons .= "&nbsp;<input class=Button type=button value='Next&nbsp;&gt;' onClick=\'showNext($next);\'>";
		} 
		print HTML <<HDR;
<tr>
 <td class=ItemLabel align=center colspan=4>$buttons</td>
 <td class=ItemLabel align=center colspan=1>Showing <b>$ctr</b> through <b>$last</b> of <b>$vpchat</b> in <b><font color=#cc0000>vpchat.com</font></b>
</tr>
<tr>
 <td class=Item>&nbsp;</td>
 <th class=ItemLabel>Send<br>IM</th>
 <th class=ItemLabel>Show<br>Profile</th>
 <th class=ItemLabel>&nbsp;User Name&nbsp;</th>
 <th class=ItemLabel>Room</th>
</tr>
HDR
	}
	my $x = "<a onClick=\'sendIM(\"$n\");\'><img border=0 width=10 height=10 src=/img/imbutton.gif></a>";
	  
	my $p = "&nbsp;";
	if ($profiles{$n} == 1) {
	  $p = "<a onClick=\'show(\"$n\");\'><img border=0 width=10 height=10 src=/img/profbutton.gif></a>";
	}
	my $u = $canonUsers{$cn};
	if (exists($pages{$n})) {
	  $u = "<a href=$G_config{'membersURL'}/$pages{$n}/>$canonUsers{$cn}</a>";
	}
	my $room = "";
	if ($users{$n} =~ /^https*:\/\//) {
	  my $r = $users{$n};
	  my $t = (exists($rooms{$r}) && ($rooms{$r} ne '')) ? $rooms{$r} : $r;
	  $room = "<a href=$r>$t</a>";
	} else {
	  $room = "private room";
	}
	print HTML <<ROW;
<tr>
 <td class=Item>$ctr.</td>
 <td class=ItemLabel align=center>$x</td>
 <td class=ItemLabel align=center>$p</td>
 <td class=Item>&nbsp;$u</td>
 <td class=Item>$room</td>
</tr>
ROW
	$i++;
	if ($i > $chunk) {
		$i = 1;
		print HTML <<BUTTONS;
<tr>
 <td class=ItemLabel colspan=5>
</tr>
<tr>
 <td class=ItemLabel align=center colspan=4>$buttons</td>
 <td class=Item>&nbsp;</td>
</tr>
BUTTONS

		close HTML;
		rename $tmp, $file;

		print IDX <<ROW;
<tr>
 <td class=ItemLabel width=20>&nbsp;</td>
 <td class=ItemLabel colspan=2>
<a href=$G_config{'regURL'}/VP/members?idx=$idx><b>$idxFrom</b>
<font color=#000000>through</font>
<b>$n</b></a>
 </td>
</tr>
ROW
		$idx++;
		$idxFrom = '';
	}
	$ctr++;
	$idxTo = $n;
  }

  print HTML <<BUTTONS;
<tr>
 <td class=ItemLabel colspan=5>
</tr>
<tr>
 <td class=ItemLabel align=center colspan=4>$buttons</td>
 <td class=Item>&nbsp;</td>
</tr>
BUTTONS

  close HTML;
  rename $tmp, $file;

  if ($idxFrom ne '') {
	print IDX <<ROW;
<tr><td class=ItemLabel width=20>&nbsp;</td><td class=ItemLabel colspan=2>
<a href=$G_config{'regURL'}/VP/members?idx=$idx><b>$idxFrom</b>
<font color=#000000>through</font>
<b>$idxTo</b></a>
</td></tr>
ROW
  }
  close IDX;
}

#####################################
#
# Subroutine: Make PHP file with chat stats
#
sub makePhpStatsFile {
  my $phpFile = '/web/php/stats.php';
  my $tmpFile = $phpFile . '.tmp';
  open (PHP, ">$tmpFile");
  my $now = scalar localtime;
  my $rooms = scalar keys %rooms;
  print PHP <<PHP;
<?php
// This is a generated file, do not edit.
// Updated: $now

\$G_stats = array (
PHP

  my %stats = ();
  $stats{'vpchat'} = &commaPunc($vpchat);
  $stats{'places'} = &commaPunc($places);
  $stats{'totalB'} = &commaPunc($vpchatB);
  $stats{'total'} = &commaPunc($vpchat);
  $stats{'homePages'} = &commaPunc($homePages);
  $stats{'profiles'} = &commaPunc($profiles);
  $stats{'members'} = &commaPunc($members);
  $stats{'rooms'} = &commaPunc($rooms);
  $stats{'gamePlayers'} = &commaPunc($gamePlayers{'Total'});
  $stats{'gamesStarted'} = &commaPunc($gamesStarted{'Total'});
  $stats{'gamesInProgress'} = &commaPunc($gamesInProgress{'Total'});

  foreach $gm (keys %gamesStarted) {
    if ($gm ne "Total") {
      $k = $gm . "Players";
      $stats{$k} = &commaPunc($gamesStarted{$gm});
      $k = $gm . "Started";
      $stats{$k} = &commaPunc($gamesStarted{$gm});
      $k = $gm . "InProgress";
      $stats{$k} = &commaPunc($gamesInProgress{$gm});
    }
  }

  #
  # Get yesterday's totals
  #
  &getYesterday;
  $stats{'maxUsers'} = &commaPunc($maxUsers);
  $stats{'sessions'} = &commaPunc($sessions);
  $stats{'uniqueUsers'} = &commaPunc($uniqueUsers);
  $stats{'minutes'} = &commaPunc($minutes);

  my ($key, @pairs);
  foreach $key (keys %stats) {
    push(@pairs, "'$key' => '$stats{$key}'");
  }
  my $list = join(",\n", @pairs);

  print PHP <<PHP;
$list
);
?>
PHP

  close PHP;

  rename $tmpFile,$phpFile;

  #return if ($G_config{'testServer'});
  #
  # Push out to front end servers
  #
  my $srvr;
  foreach $srvr (@frontEndServers) {
    next if ($srvr eq $G_config{'thisHost'});
    `/bin/rcp $phpFile $srvr:$phpFile`;
    `/bin/rcp /u/vplaces/VPCOM/VPPLACES/users.txt $srvr:/web/php`;
  }
  foreach $srvr (@regServers) {
    next if ($srvr eq $G_config{'thisHost'});
    `/bin/rcp $phpFile $srvr:$phpFile`;
  }
}

############################
#
# Subroutine: Make the HTML chunk containing community stats,
#	which is used in $G_config{'chatURL'} and other places.
#
sub makeStatsFile { 
  my $statsFile = shift @_;
  $tmpStatsFile = $statsFile . ".tmp";

  open (HTML, ">$tmpStatsFile") || die "Can't create $tmpStatsFile : $!";

  my $now = "<script language=javascript>d=new Date;document.write(d.toLocaleString());</script>";

  my $Vpchat = &commaPunc($vpchat);
  my $Places = &commaPunc($places);
  my $TotalB = &commaPunc($vpchatB);
  my $Total = &commaPunc($vpchat);
  my $HomePages = &commaPunc($homePages);
  my $Profiles = &commaPunc($profiles);
  my $Members = &commaPunc($members);

  #
  # Get yesterday's totals
  #
  &getYesterday;
  my $MaxUsers = &commaPunc($maxUsers);
  my $Sessions = &commaPunc($sessions);
  my $UniqueUsers = &commaPunc($uniqueUsers);
  my $Minutes = &commaPunc($minutes);

  print HTML <<HTML;
 <table cellspacing=0 cellpadding=2 border=0 width=196>
 <tr bgcolor=#000000>
 <td>
 <table cellspacing=0 cellpadding=0 border=0 width=100%>
 <tr><th bgcolor=#ffffff><span class=subheader>CHAT STATS</span></th></tr>
 <td class=ItemLabel valign=center align=left bgcolor=#ffffff>
 <table border=0 width="100%">
  <tr><th colspan=2>$now</th></tr>
  <tr><td>Online Now</td><th align=right>$Total</th></tr>
  <tr><td>Chat Rooms</td><th align=right>$Places</th></tr>
  <tr><td>Using buddy list</td><th align=right>$TotalB</th></tr>
  <tr><td>Home pages</td><th align=right>$HomePages</th></tr>
  <tr><td>Member profiles</td><th align=right>$Profiles</th></tr>
  <tr><td>Active members</td><th align=right>$Members</th></tr>
  <tr><td class=ItemLabel colspan=2><a href=$G_config{'chatURL'}/topRooms>Top 100 Rooms</a></td></tr>
  <tr><td class=ItemLabel colspan=2><a href=$G_config{'chatURL'}/top100>Top 100 Chatters</a></td></tr>
  <tr><td class=ItemLabel colspan=2 align=center><i>Yesterday:</i></td></tr>
  <tr><td>Peak online</td><th align=right>$MaxUsers</th></tr>
  <tr><td>Sessions</td><th align=right>$Sessions</th></tr>
  <tr><td>Unique users</td><th align=right>$UniqueUsers</th></tr>
  <tr><td class=ItemLabel colspan=2>Chat-minutes</td></tr>
  <tr><th colspan=2 align=right>$Minutes</th></tr>
  <tr><td class=ItemLabel colspan=2><a href='javascript:subWin("$G_config{'regURL'}/health");'>Server status</a></td></tr>
  <tr><td class=ItemLabel colspan=2><a href='javascript:subWin("$G_config{'chatURL'}/demographics");'>Demographics</a></td></tr>
 </table>
 </td>
 </tr>
 </table>
 </td></tr>
 </table>
HTML

  close HTML;
  rename $tmpStatsFile, $statsFile;

  #
  # Stuff total online now into the config keys, for use
  # in other places in this program.
  #
  $G_config{'chattingNow'} = $Total;
}

###
### START HERE
###

&getConfigKeys;

@frontEndServers = split(/,/,$G_config{'chatFEWS'});
@regServers = split(/,/,$G_config{'regFEWS'});

&getRooms;
&getMembers;
&getOnline;
&getHomePages;
&getGames;

$outDir         = $G_config{'chatRoot'};
$templateDir    = "/u/vplaces/templates";
$memberDir      = "$G_config{'membersRoot'}/VP/memberDir";
$fullList       = $memberDir . "/fullList";
$hpList         = $memberDir . "/hpList";
$onlineList     = $memberDir . "/onlineList";
$profileList    = $memberDir . "/profileList";
$statsFile      = $memberDir . "/stats.html";

#
# Make the HTML chunk containing community stats, used in the home
# page and other places.
#
&makeStatsFile($statsFile);

#
# Update the PHP stats file
#
&makePhpStatsFile();

#
# Make full member directory list
#
&makeFullList;

#
# Make homepage-only directory list
#
&makeHomePageList;

#
# Make profile-only directory list
#
&makeProfileList;

#
# Make online-only directory list for vpchat
#
&makeVpchatList;
#
# Push out to front end servers
#
my $srvr;
my $memberDir      = "$G_config{'membersRoot'}/VP/memberDir";
foreach $srvr (@frontEndServers) {
  next if ($srvr eq $G_config{'thisHost'});
  `/bin/rcp -r $memberDir/ $srvr:$memberDir`;
}
$G_dbh->disconnect;
