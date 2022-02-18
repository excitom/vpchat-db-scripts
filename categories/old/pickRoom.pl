#!/usr/bin/perl
#
# Build an page showing a chat room heirarchy, annotated with
# current number of people chatting in each room.
#
# Tom Lang 1/2002
#
use DBI;

BEGIN {
  $ENV{'SYBASE'} ||= '/u/vplaces/s/sybase';
  $G_dbh = DBI->connect ( 'dbi:Sybase:server=SYBASE', 'sa', 'UBIQUE' );
}

sub numerically { $a <=> $b; }
sub descending { $people{$b} <=> $people{$a}; }

sub getPlacesRoot {
  my $v = $vpplaces_root . '/';
  return $v;
}


################
#
# Find rooms with multiple copies
#
sub getRoomCopies {
	open(ROOMS, "/u/vplaces/VPCOM/VPCATEGORY/AllPlaces.log");
	while (<ROOMS>) {
	  my (@cols) = split(/\t/, $_);
	  my $URL = $cols[1];
	  my $copy = $cols[2];
	  my $people = $cols[4] + $cols[5];
	  if (defined($biggestCopy{$URL})) {
	    if ($people > $peopleInCopy{$URL}) {
              $peopleInCopy{$URL} = $people;
              $biggestCopy{$URL} = $copy;
            }
          }
          else {
            $peopleInCopy{$URL} = $people;
            $biggestCopy{$URL} = $copy;
          }
	}
	close ROOMS;
}

################
#
# Create 'chatting now' file
#
sub chatNow {
  my $total = $vpadult + $vpchat;
if (0) {
  my $file = "$G_docRoot/chatNow.html";
  open(CN, ">$file") || die "Can't create $file : $!";
  print CN <<HTML;
document.write('<span class="chat">There are <font color="#FFFFFF">$total</font><br>people chatting now.</span><br>');
HTML
  close CN;

  $file = "$G_docRoot/chatNow.pl";
  open(CN, ">$file") || die "Can't create $file : $!";
  print CN <<PL;
\$chatNow = $total;
PL
  close CN;
}

  my $file = "$G_config{'phpRoot'}/chatNow.php";
  open(CN, ">$file") || die "Can't create $file : $!";
  print CN <<HTML;
<?php
  \$chatNow = $total;
?>
HTML
  close CN;
}

################
#
# Get total number of people online now
#
sub getOnline {
 if ($G_config{'thisHost'} eq $G_config{'VPPLACESserver'}) {
   open (USERS, "</u/vplaces/VPCOM/VPPLACES/users.txt");
 } else {
   open (USERS, "/bin/rsh $G_config{'VPPLACESserver'} 'cat /u/vplaces/VPCOM/VPPLACES/users.txt' |");
 }
 while (<USERS>) {
  if (substr($_,2,1) eq 'B') {
    $vpchatB++;
  } else {
    $vpchat++;
  }
 }
 close USERS;
 if ($G_config{'VPPLACESadultServer'} ne $G_config{'VPPLACESserver'}) {
   if ($G_config{'thisHost'} eq $G_config{'VPPLACESadultServer'}) {
     open (USERS, "</u/vplaces/VPCOM/VPPLACES/users.txt");
   } else {
     open (USERS, "/bin/rsh $G_config{'VPPLACESadultServer'} 'cat /u/vplaces/VPCOM/VPPLACES/users.txt' |");
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
  else {
    $vpadult = $vpadultB = 0;
  }
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
    my $vpplaces_root = &getPlacesRoot();
    $vpplaces_root .= '/' unless($vpplaces_root =~ /\/$/);
    my $fileName =  $vpplaces_root . "Categories.log";
    open (LOG, "<$fileName") || die "Could not open file $fileName: $!";
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
	   open (LOG, "<$lf") || die "Could not open file $lf: $!";
	   while (<LOG>) {
		@words = split(/\t/);
		if ($words[0] == $level) {
			my $title;
			$title = $words[3];
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
        my $vpplaces_root = &getPlacesRoot();
        $vpplaces_root .= '/' unless($vpplaces_root =~ /\/$/);
	my $catFile = $vpplaces_root . "Categories.log";
	my ($child, $parent, $name);

	$#children = -1;	# reset global variable

	open (CAT, "<$catFile") || die "Could not open file $catFile: $!";
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
	my ($i);
	undef @topCategories;
	for($i = 0; $i <= $#userCategories; $i++) {
		$topCategories[$i] = $userCategories[$i];
	}
}

#####################################################
#
# Subroutine: read in list of top level categories to use
#
sub getTopCategories {
  @topCategories = ();
  @userCategories = ();

  my $sth = $G_dbh->prepare("EXEC vpplaces..getCategories 1");
  die 'Prepare failed' unless (defined($sth));
  $sth->execute;
  my (@row);
  do {
    while (@row = $sth->fetchrow() ) {
      my $cat = shift @row;
      my $desc = shift @row;
      my $parent = shift @row;
      $parent += 0;
      my $catOrder = shift @row;
      next if ($catOrder == 0);
      push(@topCategories, $cat) if ($parent == 0);
      push(@userCategories, $cat) if ($parent == $G_config{'userRoomsCategory'});
    }
  } while($sth->{syb_more_results});
  $sth->finish;
}

#####################################################
#
# Subroutine: get count of home pages
#
sub getHomePages {
  return 0;
}

#####################################################
#
# Subroutine: create HTML file
#
sub createHtmlFile {
	my $file = shift @_;
	my $vpLinks = shift @_;
	my $userPages = shift @_;

	open(HTML, ">$G_docRoot/$file.html") || die "Can't create $G_docRoot/$file.html : $!";

	open(TMPLT, "<$G_templateDir/$file.htmp") || die "Can't read $G_templateDir/$file.htmp : $!";

	while (<TMPLT>) {
		last if (/###PROMO###/);
		s/###CSS###/$promoCss{$file}/;
		print HTML;
	}
	my $html = $promoHtml{$file};
	#
	# Fix up, in case the person updating the promo got confused ...
	#
	if ($G_config{'testServer'}) {
	  $html =~ s!http://reg.vpchat.com!$G_config{'regURL'}!g;
	  $html =~ s!http://chat.vpchat.com!$G_config{'chatURL'}!g;
	  $html =~ s!http://vpchat.com!$G_config{'chatURL'}!g;
	  $html =~ s!http://chat.vpadult.com!$G_config{'adultURL'}!g;
	  $html =~ s!http://vpadult.com!$G_config{'adultURL'}!g;
	  $html =~ s!http://members.vpchat.com!$G_config{'membersURL'}!g;
	} else {
	  $html =~ s!http://reg.halsoft.com!$G_config{'regURL'}!g;
	  $html =~ s!http://chat.halsoft.com!$G_config{'chatURL'}!g;
	  $html =~ s!http://adult.halsoft.com!$G_config{'adultURL'}!g;
	  $html =~ s!http://members.halsoft.com!$G_config{'membersURL'}!g;
	}
	print HTML $html;

	#
	# Update PHP version of the promo
	#
	#if ($file eq 'home') {
		#open(PHP, ">$G_promoPhp") || die "Can't write to $G_promoPhp : $!";
		#print PHP $html;
		#close PHP;
	#}

	my ($chatURL, $here, $there);
	if ($comm eq 'vpchat')  {
		$chatURL = $G_config{'chatURL'};
		$here = $vpchat;
		$there = $vpadult;
		$otherComm = 'vpadult';
		#$thisComm = 'vpchat.com';
	}
	else {
		$chatURL = $G_config{'adultURL'};
		$here = $vpadult;
		$there = $vpchat;
		$otherComm = 'vpchat';
		#$thisComm = 'vpadult.com';
	}
	#$thisComm = 'robin.halsoft.com' if ($G_config{'testServer'});
	my $prefix = '';
	if ($vpLinks) {
		$promoHtml{$file} =~ s/[Hh][Rr][Ee][Ff]=(['"]*http)/href=vp:\/\/\?rep=1\&place=$1/g;
		$prefix = "vp://\?rep=1&place=";
	}

			
	#
	# Figure out what to put in the Links bar
	#
	my (@links);
	push (@links , "<a href=$prefix$chatURL/$pageName{'topRooms'}>Top 100 Rooms</a>");
	push (@links , "<a href=$prefix$chatURL/$pageName{'top100'}>Top 100 Chatters</a>");
	if ($userPages) {
		push (@links, "<a href=$prefix$G_config{'regURL'}/VP/$pageName{'roomRequest'}>List My Chat Room</a>");
	   	if ($vpLinks) {
			push (@links , "<a href=$chatURL/$pageName{'roompicker'}>HalSoft Rooms</a>");
	   	} else {
			push (@links , "<a href=$chatURL/$pageName{'home'}>HalSoft Rooms</a>");
	   	}
	} else {
	   if ($vpLinks) {
		push (@links , "<a href=$chatURL/$pageName{'roompicker2'}>User-Created Rooms</a>");
	   } else {
		push (@links , "<a href=$chatURL/$pageName{'home2'}>User-Created Rooms</a>");
	   }
	   push (@links , "<a href=$prefix$G_config{'regURL'}/VP/members>Where Is Everyone?</a>");
	}

	my $bgColor = ($comm eq 'vpchat') ? '#ffcc10' : '#003d84';
	my $fgColor = ($comm eq 'vpchat') ? '#000000' : '#ffffff';
	my $navRow = join(' | ', @links);
	my $popRow = "There are <span class=red>$here</span> people chatting now, <span class=red>$there</span> more in $otherComm.";

	while (<TMPLT>) {
		last if (/###NAVROWS###/);
		print HTML;
	}

	print HTML <<ROW;
<tr><th width='100%' class=big align=center bgColor=$bgColor><font color=$fgColor>$navRow</font></th></tr>
<tr><td class=big align=center>$popRow</td></tr>
ROW

	while (<TMPLT>) {
		last if (/###CATEGORIES###/);
		print HTML;
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
		print HTML <<CELL;
<td bgcolor="$bgColor"><b><span class=big><font color=$fgColor>&nbsp;$name</font></span></b></td>
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
			$n = substr($n, 0, 35);
			$n =~ s/ /&nbsp;/g;
			last if ($people{$p} == 0);
			my $rep = $biggestCopy{$URLs{$p}};
			if ($vpLinks) {
				$_ = qq|<tr><td><span class=footer><a href=vp://?rep=$rep&place=$URLs{$p}>$n&nbsp;($people{$p})</a></font></td></tr>\n|;
			} else {
			  if ($rep > 1) {
				$_ = qq|<tr><td><span class=footer><a href=vp://?rep=$rep&place=$URLs{$p}>$n&nbsp;($people{$p})</a></font></td></tr>\n|;
			  }
			  else {
				$_ = qq|<tr><td><span class=footer><a href=$URLs{$p}>$n&nbsp;($people{$p})</a></font></td></tr>\n|;
			  }
			}
			print HTML;
		}

		#
		# show empty rooms alphabeticaly
		#
		foreach $p (sort keys %people) {
			$n = $p;
			$n = substr($n, 0, 45);
			$n =~ s/ /&nbsp;/g;
			next if ($people{$p} > 0);
			if ($vpLinks) {
				$_ = qq|<tr><td><span class=footer><a href=vp://?rep=1&place=$URLs{$p}>$n</a></font></td></tr>\n|;
			} else {
				$_ = qq|<tr><td><span class=footer><a href=$URLs{$p}>$n</a></font></td></tr>\n|;
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
}

#####################################################
#
# Subroutine: get promo box HTML from the database
#
sub getPromoBoxHtml {
  my ($key);
  foreach $key (keys %promoKey) {
    my $sth = $G_dbh->prepare("SELECT sourceCode FROM vpplaces..html WHERE description = \'$promoKey{$key}\'");
    die 'Prepare failed' unless (defined($sth));
    $sth->execute;
    my (@row);
    do {
      while (@row = $sth->fetchrow() ) {
        $promoHtml{$key} = shift @row;
      }
    } while($sth->{syb_more_results});
 
    my $css = $promoKey{$key} . 'CSS';
    $sth = $G_dbh->prepare("SELECT sourceCode FROM vpplaces..html WHERE description = \'$css\'");
    die 'Prepare failed' unless (defined($sth));
    $sth->execute;
    do {
      while (@row = $sth->fetchrow() ) {
        $promoCss{$key} = shift @row;
      }
    } while($sth->{syb_more_results});
    $sth->finish;
  }
}

#####################################################
#
# Create PTG places page
#
sub doPtgPage {

  my $skipUncategorized = shift @_;
  my $logFile = shift @_;
  my $htmlFile = shift @_;
  my $pageTitle = shift @_;
  my $tableHeader = shift @_;
  my $total = shift @_;

  my %people  = ();
  my %title = ();
  open (LOG, "<$logFile") || die "Can't read $logFile";
  while (<LOG>) {
    chomp;
    my @cols = split(/\t/, $_);
    next if ($cols[0] == -1);
    next if (($cols[0] == 0) && $skipUncategorized);
    my $url = $cols[1];
    my $copy = $cols[2];
    $people{$url}{$copy} = $cols[4]+$cols[5];
    $title{$url}{$copy} = $cols[3];
  }
  close LOG;

  open (TMPLT, "</u/vplaces/templates/chatRooms.htmp") || die "Can't open template : $!";

  open(HTML, ">$htmlFile") || die "Can't create $htmlFile : $!";
  while (<TMPLT>) {
    print HTML;
  }
  close TMPLT;

  print HTML <<HTML;
<table width="500" border="0" cellspacing="1" cellpadding="1">
  <tr>
    <th class="ItemLabel" align=right>$total chatting now</th>
  </tr>
  <tr> 
    <td bgcolor="#666666"> 
      <table width="500" border="0" cellspacing="0" cellpadding="2">
        <tr> 
$tableHeader
        </tr>
      </table>
      <table width="500" border="0" cellspacing="0" cellpadding="2">
        <tr> 
          <td class="instruct" width="10">In</td>
          <td class="instruct" width="3">&nbsp;</td>
          <td class="instruct" class="instruct">Name</td>
        </tr>
HTML

  my %tbl = ();
  my %population = ();
  my %titles = ();
  my %biggestCopy = ();
  my $idx = 0;
  foreach $url (keys %people) {
    my $copies = scalar ( keys %{ $people{$url}} );
    foreach $copy ( keys %{ $people{$url} } ) {
      my $title = $title{$url}{$copy};
      my $pop = $people{$url}{$copy};
      $tbl{$idx} = "<a href='vp://?rep=$copy&place=$url'>$title</a>";
      if ($copies > 1) {
	if (defined($biggestCopy{$url})) {
	  if ($pop > $biggestCopy{$url}) {
              $biggestCopy{$url} = $pop;
              $tbl{$idx} = "<a href='vp://?rep=$copy&place=$url'>$title</a> ($copies)";
          }
          else {
            $biggestCopy{$url} = $pop;
            $tbl{$idx} = "<a href='vp://?rep=$copy&place=$url'>$title</a> ($copies)";
          }
        }
      }
      $population{$idx} = $pop;
      $title =~ s/%\d\d//g;
      $title =~ s/&#\d+;//g;
      $title =~ s/\W+//g;
      $titles{$idx} = $title;
      $idx++;
    }
  }
  my $ctr = 1;
  foreach $pop (sort {$population{$b} <=> $population{$a} || $titles{$a} cmp $titles{$b};} keys %population) { 
    print HTML <<HTML;
        <tr> 
          <td class="ColumnFormNumbers" width=10>$population{$pop}</td>
          <td class="ColumnFormText">&nbsp;</td>
          <td class="ColumnFormText">$tbl{$pop}</td>
        </tr>
HTML
    if (($ctr++ % 20) == 0) {
      print HTML <<HTML;
      </table>
      <table width="500" border="0" cellspacing="0" cellpadding="2">
HTML
    }
  }
  print HTML <<HTML;
        <tr>
          <th colspan=3 class="instruct">viewing 1 - $idx</th>
        </tr>
      </table>
    </td>
  </tr>
</table>
</body>
</html>
HTML

  close HTML;
}

#####################################################
#
# Create PTG places pages
#
sub doPtgPages {
  return; 	# handled in ptg.pl

  my $logFile = $vpplaces_root . "/AllPlacesWithCateg.log";
  my $total = 0;
  open (LOG, "<$logFile") || die "Can't read $logFile";
  while (<LOG>) {
    my (@cols) = split(/\t/, $_);
    if ($cols[0] == -1) {
      $total = $cols[4]+$cols[5];
      last;
    }
  }
  close LOG;

  my $coolLog = $vpplaces_root . "/CoolPlacesWithCateg.log";
  my $allLog = $vpplaces_root . "/AllPlacesWithCateg.log";
  my $eventLog = $vpplaces_root . "/AudPlacesWithCateg.log";

  my $coolFile = "CoolPlaces.html";
  my $allFile = "AllPlaces.html";
  my $eventFile = "EventPlaces.html";

  my $coolTitle = "Virtual Places Chat - Cool Places";
  my $allTitle = "Virtual Places Chat - All Places";
  my $eventTitle = "Virtual Places Chat - Special Events";

  my $coolHdr =<<HDR;
          <td width="33%" class="TableHeader">Cool Places</td>
          <td width="33%" class="TableLink"><a href="AllPlaces">All Places</a></td>
          <td width="33%" class="TableLink"><a href="EventPlaces">Special Events</a></td>
HDR
  my $allHdr =<<HDR;
          <td width="33%" class="TableLink"><a href="CoolPlaces">Cool Places</a></td>
          <td width="33%" class="TableHeader">All Places</td>
          <td width="33%" class="TableLink"><a href="EventPlaces">Special Events</a></td>
HDR
  my $eventHdr =<<HDR;
          <td width="33%" class="TableLink"><a href="CoolPlaces">Cool Places</a></td>
          <td width="33%" class="TableLink"><a href="AllPlaces">All Places</a></td>
          <td width="33%" class="TableHeader">Special Events</td>
HDR

  &doPtgPage(1, $coolLog, "$G_config{'chatRoot'}/$coolFile", $coolTitle, $coolHdr, $total);
  &doPtgPage(0, $allLog, "$G_config{'chatRoot'}/$allFile", $allTitle, $allHdr, $total);
  &doPtgPage(0, $eventLog, "$G_config{'chatRoot'}/$eventFile", $eventTitle, $eventHdr, $total);

  if ($comm eq 'vpchat') {
    @srvrs = split(',', $G_config{'chatFEWS'});
  } else {
    @srvrs = split(',', $G_config{'adultFEWS'});
  }
  push (@hf, $coolFile);
  push (@hf, $allFile);
  push (@hf, $eventFile);
  foreach $s (@srvrs) {
     foreach $h (@hf) {
	next if ($s eq $G_config{'thisHost'});
	next if ($s eq 'sparky');	# debug
	`/bin/rcp $G_config{'chatRoot'}/$h $s:$G_config{'chatRoot'}/$h`;
     }
  }
}

#####################################################
#
# START HERE
#
chdir "/u/vplaces/scripts/categories";
&getConfigKeys;
$comm = $G_config{'communityName'};
if ($G_config{'thisHost'} eq $G_config{'VPPLACESadultServer'}) {
  $comm = 'vpadult.com';
}
$comm =~ s/\.com$//;

if ($comm eq 'vpchat') {
  $G_docRoot = $G_config{'chatRoot'};
  $G_baseUrl = $G_config{'chatURL'};
} else {
  $G_docRoot = $G_config{'adultRoot'};
  $G_baseUrl = $G_config{'adultURL'};
}

#$pageName{'home'} = $G_config{'HomePage'};
$pageName{'home'} = 'home';
$pageName{'home'} =~ s/.*\///;
$pageName{'home'} =~ s/\..*$//;
#$pageName{'home2'} = $G_config{'communityCentreUrl'};
$pageName{'home2'} = 'home2';
$pageName{'home2'} =~ s/.*\///;
$pageName{'home2'} =~ s/\..*$//;
#$pageName{'roompicker'} = $G_config{'PTG_Places'};
#$pageName{'roompicker'} = 'roompicker';
#$pageName{'roompicker'} =~ s/.*\///;
#$pageName{'roompicker'} =~ s/\..*$//;
#$pageName{'roompicker2'} = $G_config{'coolPlacesListUrl'};
#$pageName{'roompicker2'} = 'roompicker2';
#$pageName{'roompicker2'} =~ s/.*\///;
#$pageName{'roompicker2'} =~ s/\..*$//;
$pageName{'top100'} = 'top100';
$pageName{'topRooms'} = 'topRooms';
$pageName{'roomRequest'} = 'roomRequest';

#$G_promoPhp = "/web/php/promo.php";

%promoKey = (
  'home' => 'homePromoBox',
  'home2' => 'userHomePromoBox',
  'roompicker' => 'roomsPromoBox',
  'roompicker2' => 'userRoomsPromoBox'
);

$G_templateDir = "/u/vplaces/templates";
$vpplaces_root = "/u/vplaces/VPCOM/VPCATEGORY";

push(@G_logFile, $vpplaces_root . "/CoolPlacesWithCateg.log");
#push(@G_logFile, $vpplaces_root . "/AudPlacesWithCateg.log");

### not currently used ### $homePages = &getHomePages;

&getPromoBoxHtml;

$vpchat = $vpadult = 0;
&getOnline;

#
# Fill in the %categories hash with the children of category 0,
# i.e. the top level index.
#
&getSubCategories(0);

&getTopCategories;

&getRoomCopies;

## $vpLinks = 1;
## $userPages = 0;
## &createHtmlFile($pageName{'roompicker'}, $vpLinks, $userPages);

$vpLinks = 0;
$userPages = 0;
&createHtmlFile($pageName{'home'}, $vpLinks, $userPages);
#
# Process user-created rooms
#
@topCategories = ();
&getUserCategories;
&getSubCategories($G_config{'userRoomsCategory'});

## $vpLinks = 1;
## $userPages = 1;
## &createHtmlFile($pageName{'roompicker2'}, $vpLinks, $userPages);

$vpLinks = 0;
$userPages = 1;
&createHtmlFile($pageName{'home2'}, $vpLinks, $userPages);

#
# Create chat room directory
#
#&doPtgPages;

#
# create 'chatting now' HTML fragment
#
if ($comm eq 'vpchat') {
  &chatNow;
}

#
# Propagate the template to the front-end web servers
#
if ($comm eq 'vpchat') {
  @srvrs = split(',', $G_config{'chatFEWS'});
} else {
  @srvrs = split(',', $G_config{'adultFEWS'});
}
push (@hf, "$pageName{'home'}.html");
push (@hf, "$pageName{'home2'}.html");
#push (@hf, "$pageName{'roompicker'}.html");
#push (@hf, "$pageName{'roompicker2'}.html");
#push (@hf, "chatNow.html") if ($comm eq 'vpchat');
foreach $h (@hf) {
   foreach $s (@srvrs) {
	# kludge: there is now a home.php, and we want it to
	# show up by default but HTML seems to take precedence,
	# so change the HTML file name
	$h2 = ($h eq 'home.html') ? 'home1.html' : $h;
	next if ($s eq $G_config{'thisHost'});
	`/bin/rcp $G_docRoot/$h $s:$G_docRoot/$h2`;
	#`/bin/rcp $G_promoPhp $s:$G_promoPhp`;
   }
}
foreach $h (@hf) {
  $h2 = ($h eq 'home.html') ? 'home1.html' : $h;
  `cp $G_config{'chatRoot'}/$h "/web/content/chat/$h2"`;
}

if (0) {
if ($comm eq 'vpchat') {
  undef @srvrs;
  @srvrs = split(',', $G_config{'regFEWS'});
  foreach $s (@srvrs) {
    if ($s eq $G_config{'thisHost'}) {
      `cp $G_docRoot/chatNow.html $G_config{'regRoot'}`;
      `cp $G_docRoot/chatNow.pl $G_config{'regRoot'}/VP`;
    } else {
      `/bin/rcp $G_docRoot/chatNow.html $s:$G_config{'regRoot'}`;
      `/bin/rcp $G_docRoot/chatNow.pl $s:$G_config{'regRoot'}/VP`;
    }
  }
  undef @srvrs;
  @srvrs = split(',', $G_config{'adultFEWS'});
  foreach $s (@srvrs) {
    next if ($s eq $G_config{'thisHost'});
    `/bin/rcp $G_docRoot/chatNow.html $s:$G_config{'adultRoot'}/$h`;
  }
}
}

undef @srvrs;
@srvrs = split(',', $G_config{'chatFEWS'});
foreach $s (@srvrs) {
  $srvrs{$s} = 1;
}
@srvrs = split(',', $G_config{'regFEWS'});
foreach $s (@srvrs) {
  $srvrs{$s} = 1;
}
@srvrs = split(',', $G_config{'adultFEWS'});
foreach $s (@srvrs) {
  $srvrs{$s} = 1;
}
foreach $s (keys %srvrs) {
  next if ($s eq 'sparky');
  if ($s ne $G_config{'thisHost'}) {
    `/bin/rcp $G_config{'phpRoot'}/chatNow.php $s:$G_config{'phpRoot'}`;
  }
}
`/bin/cp $G_config{'phpRoot'}/chatNow.php "/web/content/php"`;

$G_dbh->disconnect;
