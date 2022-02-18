#!/usr/local/bin/perl
#
# Build an page showing a chat room heirarchy, annotated with
# current number of people chatting in each room.
#
# Tom Lang 1/2002
#
$G_scriptDir = "/u/vplaces/scripts/categories";
$G_templateDir = "/u/vplaces/templates";
$G_HTMLdir = "/$G_scriptDir/html";
$G_topCat = "/$G_scriptDir/categories.list";
$G_userCat = "/$G_scriptDir/userCategories.list";
require "$G_scriptDir/getPlacesRoot.pl";
$vpplaces_root = "/u/vplaces/VPCOM/VPCATEGORY/";
push (@INC, $vpplaces_root);
require "getAllPlaces.pl";
require "getCommunity.pl";
require "getCoolPlaces.pl";
require "getEventPlaces.pl";
require "getParents.pl";
require "getTotalUsage.pl";

push(@G_logFile, $vpplaces_root . "CoolPlacesWithCateg.log");
#push(@G_logFile, $vpplaces_root . "AudPlacesWithCateg.log");

$#topCat      = -1;

sub numerically { $a <=> $b; }
sub descending { $people{$b} <=> $people{$a}; }

################
#
# Bulid list of all rooms
#
sub getAllRooms {
	#open(ROOMS, "/u/vplaces/VPCOM/VPCATEGORY/AllPlaces.log");
}

################
#
# Get total number of people online now
#
sub getOnline {
 my $host = shift @_;
 if ($host eq 'anne') {
   open (USERS, "</u/vplaces/VPCOM/VPPLACES/users.txt");
 } else {
   open (USERS, "/bin/rsh anne 'cat /u/vplaces/VPCOM/VPPLACES/users.txt |");
 }
 while (<USERS>) {
  if (substr($_,2,1) eq 'B') {
    $vpchatB++;
  } else {
    $vpchat++;
  }
 }
 close USERS;
 if ($host eq 'amy') {
   open (USERS, "</u/vplaces/VPCOM/VPPLACES/users.txt");
 } else {
   open (USERS, "/bin/rsh amy 'cat /u/vplaces/VPCOM/VPPLACES/users.txt |");
 }
 while (<USERS>) {
  if (substr($_,2,1) eq 'B') {
    $vpadultB++;
  } else {
    $vpadult++;
  }
 }
 close USERS;
}

#####################################################
# Subroutine: returns a hash of all sub categories for a given
#                    category
#
# Input: 
#        parent category - id of the category for which a list of 
#              subcategories is requested
# Output: %categories - a hash in which each entry represents a subcategory 
#              with the following format:
#		<category id>\t<parent category id>\t<category name>\n
#

sub getSubCategories {

  my $parentCategory = shift @_;

    ###
    ### Read file and get Sub Categories
    ###
    my $fileName =  $vpplaces_root . "Categories.log";
    open (LOG, "<$fileName") || die "Could not open file $fileName: $!\n";
    while (<LOG>) {
      @words = split /\t/;
      next if ($words[0] == -1);
      next if ($words[1] != $parentCategory);
      $categories{$words[0]} = $_;
    }
    close LOG;
}

#####################################################
#
# Subroutine: Get children usage
#
sub getChildUsage {
	my $level = $_[0];
	my $lf;

	undef %URLs;
	undef %people;

	foreach $lf (@G_logFile) {
	   open (LOG, "<$lf") || die "Could not open file $lf: $!\n";
	   while (<LOG>) {
		@words = split(/\t/);
		if ($words[0] == $level) {

			#
			# kludge: the title is screwing up in the raw
			# data file sometimes ...
			#
			my $title;
			if ($words[1] =~ /fishbowl/) {
				$title = "The Fishbowl";
			} else {
				$title = $words[3];
			}
				
			$URLs{$title} = $words[1];
			$people{$title} = $words[4] + $words[5];
		}
	   }
	   close LOG;
	}
}

#####################################################
#
# Subroutine: Get children 
#
sub getChildren {

	my $level = $_[0];
	my $catFile = $vpplaces_root . "Categories.log";
	my ($child, $parent, $name);

	$#children = -1;	# reset global variable

	open (CAT, "<$catFile") || die "Could not open file $catFile: $!\n";
	while (<CAT>) {
		chomp;
		($child, $parent, $name) = split(/\t/);
		push (@children, $name) if ($parent == $level);
	}
	close LOG;
}

#####################################################
#
# Subroutine: read in list of user categories to use
#
sub getUserCategories {
	open (TOP, "<$G_userCat") || die "Could not open file $G_userCat: $!\n";
	my $first = 1;
	while (<TOP>) {
		next if (/^#/);
		chomp;
		if ($first) {
			$userCat = $_;
			$first = 0;
		}
		else {
			push (@topCategories, $_);
		}
	}
	close TOP;
}

#####################################################
#
# Subroutine: read in list of top level categories to use
#
sub getTopCategories {
	open (TOP, "<$G_topCat") || die "Could not open file $G_topCat: $!\n";
	while (<TOP>) {
		next if (/^#/);
		chomp;
		push (@topCategories, $_);
	}
	close TOP;
}

#####################################################
#
# Subroutine: get count of home pages
#
sub getHomePages {
  my $host = shift @_;
  my $db = ($host eq 'anne') ? 'SYBASE' : 'SYBASE2';

  my $dbName = 'vpusr';
  my $dbPw = 'vpusr1';
  my $G_isql_exe = "/u/vplaces/s/sybase/bin/isql -U$dbName -P$dbPw -S$db";
  my $G_statdir = "/tmp/";
  my $tempsql = $G_statdir . ".temp.sql.$$";
  $ENV{'SYBASE'} ||= '/u/vplaces/s/sybase';

  open (SQL_IN, ">$tempsql") || die "Can't write to $tempsql : $!\n";
  print SQL_IN "SELECT 'XX', COUNT(URL) FROM vpplaces..homePages WHERE deleted = 0 AND locked=0\nGO\n";
  close SQL_IN;
  open (SQL_OUT, "$G_isql_exe -i $tempsql |") || die "Can't read from $G_isql_exe -i $tempsql : $!\n";

  my ($junk, $h);
  while (<SQL_OUT>) {
    next unless (/XX/);
    chomp;
    ($junk, $h) = split;
  }
  close SQL_OUT;
  unlink $tempsql;
  return $h+0;
}

#####################################################
#
# Subroutine: create HTML file
#
sub createHtmlFile {
	my $file = shift @_;
	my $vpLinks = shift @_;
	my $userPages = shift @_;
	my $host = shift @_;

	#&getTotalUsage("FILE");
	#$total = $participants + $observers;
	$vpchat = $vpadult = 0;
	&getOnline($host);

	open(HTML, ">$G_HTMLdir/$file.html") || die "Can't create $G_HTMLdir/$file.html : $!";

	open(TMPLT, "<$G_templateDir/$file.htmp") || die "Can't read $G_templateDir/$file.htmp : $!";
	while (<TMPLT>) {
		last if (/###CATEGORIES###/);
		print HTML;
	}

	$link = "http://members.vpchat.com";
	$link = "vp://rep=1&place=" . $link if ($vpLinks);
	if ($userPages) {
		$link1 = "http://$comm.com/topRooms";
		$link2 = "http://$comm.com/top100";
		$link3 = "http://reg.vpchat.com/VP/roomRequest";
		if($vpLinks) {
			$link1 = "vp://?rep=1&place=" . $link1;
			$link2 = "vp://?rep=1&place=" . $link2;
			$link3 = "vp://?rep=1&place=" . $link3;
		}
		print HTML <<ROW;
<tr>
<td align=center class=big>
<a class=big href=$link1>The Top 100 Rooms</a>&nbsp;--&nbsp;<a class=big href=$link2>The Top 100 Chatters</a>&nbsp;--&nbsp;<a class=big href=$link3>Submit Your Room for This List</a>
</td>
</tr>
</table>
<table width="541" border="0" cellpadding="2">
ROW
	}
	else {
		$link1 = "http://$comm.com/topRooms";
		$link2 = "http://$comm.com/top100";
		$link3 = "http://$comm.com/home2";
		$link4 = "http://reg.vpchat.com/VP/members";
		if($vpLinks) {
			$link1 = "vp://?rep=1&place=" . $link1;
			$link2 = "vp://?rep=1&place=" . $link2;
			$link3 = "vp://?rep=1&place=http://$comm.com/roompicker2";
			$link4 = "vp://?rep=1&place=" . $link4;
		}
		$here = ($host eq 'anne') ? $vpchat : $vpadult;
		$there = ($host eq 'anne') ? $vpadult : $vpchat;
		print HTML <<ROW;
<tr><td class=big colspan=6>
<font color=#cc0000><b>$here</b></font> people are chatting now!
(<font color=#cc0000><b>$there</b></font> more in $otherComm)
There are <font color=#cc0000><b>$homePages</b></font> member <a class=big href=$link>home pages</a>.
</td></tr>
<tr><td class=big align=center>
<a class=big href=$link1>The Top 100 Rooms</a>&nbsp;--&nbsp;<a class=big href=$link2>The Top 100 Chatters</a>&nbsp;--&nbsp;<a class=big href=$link3>User Created Rooms</a>
&nbsp;--&nbsp;<a class=big href=$link4>Where is everyone?</a>
</td></tr>
</table>
<table width="541" border="0" cellpadding="2">
ROW
	}

	print HTML "<tr>\n";
	foreach $k (@topCategories) {
		$x = $categories{$k};
		chomp $x;
		($cat, $parent, $name) = split(/\t/, $x);

		#
		# fills in the %people and %URLs hashes for children of this
		# category.
		#
		&getChildUsage($cat);

		$people = 0;
		foreach $p (sort descending keys %people) {
			$people += $people{$p};
		}

		#
		# output HTML table rows
		#
		my $bgColor = ($comm eq 'vpchat') ? '#ffcc10' : '#003d84';
		my $fgColor = ($comm eq 'vpchat') ? '#000000' : '#ffffff';
		print HTML <<CELL;
<td bgcolor="$bgColor"><b><font size="2" color=$fgColor>&nbsp;$name</font></b></td>
CELL
	}

	print HTML "</tr><tr>\n";

	foreach $k (@topCategories) {
		$x = $categories{$k};
		chomp $x;
		($cat, $parent, $name) = split(/\t/, $x);
		#
		# output HTML table rows
		#
		print HTML <<CELL;
<td valign=top><table border=0>
CELL
		#
		# fills in the %people and %URLs hashes for children of this
		# category.
		#
		&getChildUsage($cat);

		#
		# show busiest rooms first
		#
		foreach $p (sort descending keys %people) {
			$n = $p;
			$n =~ s/ /&nbsp;/g;
			last if ($people{$p} == 0);
			if ($vpLinks) {
				$_ = qq|<tr><td><a href=vp://?rep=1&place=$URLs{$p}>$n&nbsp;($people{$p})</a></td></tr>\n|;
			} else {
				$_ = qq|<tr><td><a href=$URLs{$p}>$n&nbsp;($people{$p})</a></td></tr>\n|;
			}
			print HTML;
		}

		#
		# show empty rooms alphabeticaly
		#
		foreach $p (sort keys %people) {
			$n = $p;
			$n =~ s/ /&nbsp;/g;
			next if ($people{$p} > 0);
			if ($vpLinks) {
				$_ = qq|<tr><td><a href=vp://?rep=1&place=$URLs{$p}>$n</a></td></tr>\n|;
			} else {
				$_ = qq|<tr><td><a href=$URLs{$p}>$n</a></td></tr>\n|;
			}
			print HTML;
		}
		print HTML <<TBLR;
</table>
</TD>
TBLR
	}

	print HTML "</tr></table>\n";

	#
	# output the remainder of the templates
	#

	while (<TMPLT>) {
		print HTML;
	}
	close TMPLT;
	close HTML;
}

#####################################################
#
# START HERE
#
$host = `hostname`;
chomp $host;
if ($host eq 'anne') {
  $comm = "vpchat";
  $otherComm = "vpadult";
  $docRoot = "/web/chat/html";
} else {
  $comm = "vpadult";
  $otherComm = "vpchat";
  $docRoot = "/web/adult/html";
}

$homePages = &getHomePages($host);
#
# Fill in the %categories hash with the children of category 0,
# i.e. the top level index.
#
&getSubCategories(0);
#
# Read from a config file to find the names, and ordering, of
# the categories which are to be used in the room picker
#
&getTopCategories;

$vpLinks = 1;
$userPages = 0;
&createHtmlFile("roompicker", $vpLinks, $userPages, $host);

$vpLinks = 0;
&createHtmlFile("home", $vpLinks, $userPages, $host);

#
# Process user-created rooms
#
$#topCategories = -1;
&getUserCategories;
&getSubCategories($userCat);

$vpLinks = 1;
$userPages = 1;
&createHtmlFile("roompicker2", $vpLinks, $userPages, $host);

$vpLinks = 0;
&createHtmlFile("home2", $vpLinks, $userPages, $host);

#
# Propagate the template to the front-end web servers
#
push(@srvrs, "ramsey");
push(@srvrs, "sparky");
push(@srvrs, "siesta");
push (@hf, "roompicker.html");
push (@hf, "home.html");
push (@hf, "home2.html");
push (@hf, "roompicker2.html");
foreach $s (@srvrs) {
   foreach $h (@hf) {
	`/bin/rcp $G_scriptDir/html/$h $s:$docRoot/$h`;
   }
}

unlink $tempsql;
