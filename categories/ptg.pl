#!/usr/bin/perl
#
# Build web pages that simulate the function of the Quick Directory.
#
# Tom Lang 9/2003
#
use DBI;

BEGIN {
  $ENV{'SYBASE'} ||= '/u/vplaces/s/sybase';
  $G_dbh = DBI->connect ( 'dbi:Sybase:server=SYBASE', 'sa', 'UBIQUE' );
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
  my $total2 = shift @_;
  my $comm = shift @_;

  my %people  = ();
  my %title = ();
  open (LOG, "<$logFile") || die "Can't read $logFile";
  while (<LOG>) {
    chomp;
    my @cols = split(/\t/, $_);
    next if ($cols[0] == -1);
    next if (($cols[0] == 0) && $skipUncategorized);
    my $url = $cols[1];
    next if ($url =~ /kernal.net/);
    my $copy = $cols[2];
    $people{$url}{$copy} = $cols[4]+$cols[5];
    my $ttl = $cols[3];
    if ($ttl =~ /^http/) {
      $ttl =~ s/\?.*$//;
    }
# hack
if ($ttl =~ /hacked/i) {
 $ttl = $url;
}
    $ttl =~ s/<\w[^>]*>//g;	# strip HTML tags
    $title{$url}{$copy} = $ttl;
  }
  close LOG;

  open (TMPLT, "</u/vplaces/templates/chatRooms.htmp") || die "Can't open template : $!";

  open(HTML, ">$htmlFile") || die "Can't create $htmlFile : $!";
  while (<TMPLT>) {
    s/###pageTitle###/$pageTitle/;
    print HTML;
  }
  close TMPLT;

  $eventUrl = "vp://?rep=1&place=" . $G_config{'regURL'} . "/events";
  my $otherComm = '';
  if ($comm eq 'vpchat') {
    $otherComm = "($total2 in <a href=vp://?comm=vpadult.com&place=$G_config{'adultURL'}/home>vpadult</a>)";
    $thisTotal = $total;
  }
  else {
    $otherComm = "($total in <a href=vp://?comm=vpchat.com&place=$G_config{'chatURL'}/home>vpchat</a>)";
    $thisTotal = $total2;
  }
  print HTML <<HTML;
<span class='breadcrumbsecondary'><a href='$eventUrl'>Events Directory</a></span></br>
<table width="500" border="0" cellspacing="1" cellpadding="1">
  <tr>
    <th class="ItemLabel" align=right>$thisTotal chatting now $otherComm</th>
  </tr>
  <tr>
   <td>
<table width="100%" border="0" cellspacing="0" cellpadding="1">
  <tr>
    <td height="20" bgcolor="#FFCC00" colspan="2">
      <div align="center"> <b><font face="Verdana, Arial, Helvetica, sans-serif" size="-1">How Do You Rank? <br>
<a href="vp://?place=$G_config{'regURL'}/ratings">Top Game Players</a>
| <a href="vp://?place=$G_config{'regURL'}/VP/chitEarners">Top Chit Earners</a>
| <a href="vp://?place=$G_config{'chatURL'}/laddersOverview">Game Ladders Info</a>
</div>
    </td>
  </tr>
</table> 
   </td>
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
  my $idx = 0;
  foreach $url (keys %people) {
    next if (($skipUncategorized == 0) && ($url eq $G_config{'HomePage'}));
    my $copies = scalar ( keys %{ $people{$url}} );
    foreach $copy ( keys %{ $people{$url} } ) {
      my $title = $title{$url}{$copy};
      my $pop = $people{$url}{$copy};
      if ($url =~ /'/) {
        $tbl{$idx} = qq|<a href="vp://?rep=$copy&place=$url">$title</a>|;
      }
      elsif ($url =~ /"/) {
        $tbl{$idx} = qq|<a href='vp://?rep=$copy&place=$url'>$title</a>|;
      }
      else {
        $tbl{$idx} = "<a href='vp://?rep=$copy&place=$url'>$title</a>";
      }
      if (($copies > 1) || ($skipUncategorized)) {
        $cpy = 1;
	if (defined($biggestCopy{$url})) {
          $cpy = $biggestCopy{$url};
        }
        my $cpys = ($copies > 1) ? "($copies)" : '';
        if ($skipUncategorized) {
          $tbl{$idx} = "<a href='vp://?rep=$cpy&place=$url'>$title</a> $cpys";
        } else {
          $tbl{$idx} = "<a href='vp://?rep=$copy&place=$url'>$title</a> (room copy $copy)";
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

  my $vpplaces_root = '/u/vplaces/VPCOM/VPCATEGORY';
  my $logFile = $vpplaces_root . "/AllPlacesWithCateg.log";
  my $total = 0;
  #open (LOG, "<$logFile") || die "Can't read $logFile";
  #while (<LOG>) {
    #my (@cols) = split(/\t/, $_);
    #if ($cols[0] == -1) {
      #$total = $cols[4]+$cols[5];
      #last;
    #}
  #}
  #close LOG;
  my $total2 = 0;
  open( STATS, "</web/php/stats.php");
  while (<STATS>) {
    if (/'vpchat'/) {
      /=>\s+'(\d+)'/;
      $total = $1;
    }
    if (/'vpadult'/) {
      /=>\s+'(\d+)'/;
      $total2 = $1;
    }
  }

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

  &doPtgPage(1, $coolLog, "$G_docRoot/$coolFile", $coolTitle, $coolHdr, $total, $total2, $comm);
  &doPtgPage(0, $allLog, "$G_docRoot/$allFile", $allTitle, $allHdr, $total, $total2, $comm);
  &doPtgPage(0, $eventLog, "$G_docRoot/$eventFile", $eventTitle, $eventHdr, $total, $total2, $comm);

  my ($contentDir);
  if ($comm eq 'vpchat') {
    @srvrs = split(',', $G_config{'chatFEWS'});
    $contentDir = "/web/content/chat/html";
  } else {
    @srvrs = split(',', $G_config{'adultFEWS'});
    $contentDir = "/web/content/adult/html";
  }
  push (@hf, $coolFile);
  push (@hf, $allFile);
  push (@hf, $eventFile);
  #foreach $s (@srvrs) {
     #foreach $h (@hf) {
	#next if ($s eq $G_config{'thisHost'});
	#`/bin/rcp $G_docRoot/$h $s:$G_docRoot/$h`;
     #}
  #}
  # new technique - NFS-mounted content directory
  foreach $h (@hf) {
    `cp $G_docRoot/$h $contentDir/$h.tmp;mv $contentDir/$h.tmp $contentDir/$h`;
  }
}

#####################################################
#
# Create guest room picker list
#
sub doGuestRoomPicker {
  my $vpplaces_root = '/u/vplaces/VPCOM/VPCATEGORY';
  my $logFile = $vpplaces_root . "/CoolPlacesWithCateg.log";
  my $dataFile = "/web/php/guestRoomPicker.php";
  my $contentDataFile = "/web/content/php/guestRoomPicker.php";

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

  my %roomCopy = ();
  my %population = ();
  my %titles = ();
  foreach $url (keys %people) {
    foreach $copy ( keys %{ $people{$url} } ) {
      my $title = $title{$url}{$copy};
      my $pop = $people{$url}{$copy};
      $cpy = (defined($biggestCopy{$url})) ? $biggestCopy{$url} : 1;
      $population{$url} = $pop;
      $roomCopy{$url} = $cpy;
      $title =~ s/^\s+//;
      $title =~ s/\s+$//;
      $title =~ s/\s+/ /g;
      $title =~ s/"//g;
      $titles{$url} = $title;
    }
  }

  open(PHP, ">$dataFile") || die "Can't create $dataFile : $!";

  my $ctr = 0;
  my (@items);
  foreach $url (sort {$population{$b} <=> $population{$a};} keys %population) { 
    next if ($url eq $G_config{'HomePage'});
next if ($url =~ /YourMusicalDestiny.html/);
    $url =~ s/"//g;
    my $item = "'$ctr' => array (
    'url' => \"$url\",
    'rep' => $roomCopy{$url},
    'title' => \"$titles{$url}\"
  )";
    push (@items, $item);
    last if ($ctr++ == 14);
  }
  my $items = join( ",\n", @items);
  print PHP <<PHP;
<?php
// Generated file, do not edit
\$G_guestRooms = array (
$items
);
?>
PHP

  close PHP;

  my (@srvrs) = split(',', $G_config{'regFEWS'});
  foreach $s (@srvrs) {
    next if ($s eq $G_config{'thisHost'});
    `/bin/rcp $dataFile $s:$dataFile`;
  }
  # new technique - NFS-mounted content directory
  #`/bin/cp $dataFile $contentDataFile`;
}

#####################################################
#
# START HERE
#
chdir "/u/vplaces/scripts/categories";
&getConfigKeys;
$comm = $G_config{'communityName'};
$comm =~ s/\.com$//;

$G_docRoot = $G_config{'chatRoot'};
$G_baseUrl = $G_config{'chatURL'};

&getRoomCopies;

&doPtgPages;


if ($comm eq 'vpchat') {
  &doGuestRoomPicker();
}
