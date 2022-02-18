#!/usr/bin/perl
#
# Build PHP arrays representing chat room population, for use
# in the Room Picker web page.
#
# Tom Lang 12/2003
#
use DBI;
require "/web/reg/configKeys.pl";

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
# hack
if ($title =~ /hacked/i) {
 $title = $words[1];
 $title =~ s/"//g;
}
			my $url = $words[1];
			$url =~ s/"//g;
			$URLs{$title} = $url;
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
sub getAUserCategories {
	my ($i);
	undef @topCategories;
	for($i = 0; $i <= $#AuserCategories; $i++) {
		$topCategories[$i] = $AuserCategories[$i];
	}
}

#####################################################
#
# Subroutine: read in list of top level categories to use
#
sub getTopCategories {
  $parent = shift @_;
  @topCategories = ();
  @userCategories = ();
  @AuserCategories = ();

  my $sth = $G_dbh->prepare("EXEC vpplaces..getCategories 1");
  die 'Prepare failed' unless (defined($sth));
  $sth->execute;
  my (@row);
  do {
    while (@row = $sth->fetchrow() ) {
      my $cat = shift @row;
      my $desc = shift @row;
      my $p = shift @row;
      $parent += 0;
      my $catOrder = shift @row;

      # skip hidden categories
      next if ($catOrder == 0);

      push(@topCategories, $cat) if ($p == $parent);
      push(@userCategories, $cat) if ($p == $G_config{'userRoomsCategory'});
      push(@AuserCategories, $cat) if ($p == $G_config{'AuserRoomsCategory'});
    }
  } while($sth->{syb_more_results});
  $sth->finish;
}

#####################################################
#
# Subroutine: derive canonical form of title (crap stripped)
#
sub canonicalTitle {
	my $t = shift @_;
	$t =~ s/'/\&rsquo;/g;
	$t =~ s/</\&lt;/g;
	$t =~ s/"/\&quot;/g;
	$t =~ s/^\s+//;		# no extraneous space
	$t =~ s/\s+$//;
	$t =~ s/\s+/ /g;
	$t =~ s/_+/_/g;
	$t =~ s/\\//g;
	return $t;
}

#####################################################
#
# Subroutine: create PHP file
#
sub createPHPFile {
	my $phpFile = shift @_;
	my $userRooms = shift @_;
	my $comm = shift @_;
	my $arrayName = ($userRooms) ? 'userRooms' : 'ourRooms';
	$arrayName .= "_$comm";

	if ($userRooms) {
		open(PHP, ">>$phpFile") || die "Can't create $phpFile : $!";
	} else {
		open(PHP, ">$phpFile") || die "Can't create $phpFile : $!";
		my $now = scalar localtime;
		print PHP <<PHP;
<?php
// This is a generated file, do not edit.
// Last updated: $now
\$promoHtml =<<<HTML
$G_promoHtml
HTML;
\$promoCss =<<<HTML
$G_promoCss
HTML;

PHP
	}

	my (@groups);
	foreach $k (@topCategories) {
		$x = $categories{$k};
		chomp $x;
		($cat, $parent, $name) = split(/\t/, $x);

		#
		# fills in the %people and %URLs hashes for children of this
		# category.
		#

		&getChildUsage($cat);

		#
		# show busiest rooms first
		#
		my (@rooms);
		foreach $t (sort descending keys %people) {
			last if ($people{$t} == 0);
			$title = canonicalTitle($t);
			my $rep = $biggestCopy{$URLs{$t}};
			my $php =<<PHP;
    "$URLs{$t}" => array (
      'title'  => "$title",
      'people' => '$people{$t}',
      'rep'    => '$rep'
    )
PHP
			push (@rooms, $php);
		}

		#
		# show empty rooms alphabeticaly
		#
		foreach $t (sort keys %people) {
			next if ($people{$t} > 0);
			$title = canonicalTitle($t);
			my $rep = $biggestCopy{$URLs{$t}};
			my $php =<<PHP;
    "$URLs{$t}" => array (
      'title'  => "$title",
      'people' => '$people{$t}',
      'rep'    => '1'
    )
PHP
			push (@rooms, $php);
		}
		my $list = join(",\n", @rooms);
		my $group =<<PHP;
  '$name' => array (
$list
  )
PHP
		push(@groups, $group);
	}
	my $list = join(",\n", @groups);
        print PHP <<PHP;
\$$arrayName = array (
$list
);
PHP

	close PHP;
}

#####################################################
#
# Subroutine: get promo box HTML from the database
#
sub getPromoBoxHtml {
  my $sth = $G_dbh->prepare("SELECT sourceCode FROM vpplaces..html WHERE description = 'homePromoBox'");
  die 'Prepare failed' unless (defined($sth));
  $sth->execute;
  my (@row);
  do {
    while (@row = $sth->fetchrow() ) {
      $G_promoHtml = shift @row;
    }
  } while($sth->{syb_more_results});
 
  $sth = $G_dbh->prepare("SELECT sourceCode FROM vpplaces..html WHERE description = 'homePromoBoxCSS'");
  die 'Prepare failed' unless (defined($sth));
  $sth->execute;
  do {
    while (@row = $sth->fetchrow() ) {
      $G_promoCss = shift @row;
    }
  } while($sth->{syb_more_results});
  $sth->finish;
}

#####################################################
#
# Create all-rooms list
#
sub doAllRooms {
  my $phpFile = shift @_;
  my $comm = shift @_;

  my $vpplaces_root = '/u/vplaces/VPCOM/VPCATEGORY';
  my $logFile = $vpplaces_root . "/AllPlacesWithCateg.log";
  my $total = 0;
  %people = ();
  open (LOG, "<$logFile") || die "Can't read $logFile";
  while (<LOG>) {
    chomp;
    my (@cols) = split(/\t/, $_);
    next unless($tc{$cols[0]} == 1);
    if ($cols[0] == -1) {
      $total = $cols[4]+$cols[5];
    }
    else {
      my $url = $cols[1];
      $url =~ s/"//g;
      next unless ($url =~ /^http/);
      my $copy = $cols[2];
      $people{$url}{$copy} = $cols[4]+$cols[5];
      my $ttl = $cols[3];
      if ($ttl =~ /^http/) {
        $ttl =~ s/\?.*$//;
      }
      $title{$url}{$copy} = $ttl;
    }
  }
  close LOG;

  open(PHP, ">>$phpFile") || die "Can't append to $phpFile : $!";

  my %tbl = ();
  my %population = ();
  my %titles = ();
  my $idx = 0;
  foreach $url (keys %people) {
    my $copies = scalar ( keys %{ $people{$url}} );
    foreach $copy ( keys %{ $people{$url} } ) {
      my $title = &canonicalTitle($title{$url}{$copy});
      my $pop = $people{$url}{$copy};
      $tbl{$idx} = $url;
      $population{$idx} = $pop;
      $copies{$idx} = $copies;
      $titles{$idx} = $title;
      $title =~ s/\W+//g;	# take out special chars to improve collation
      $canonTitles{$idx} = $title;
      $rep{$idx} = $copy;
      $idx++;
    }
  }
  my $ctr = 1;
  foreach $pop (sort {$population{$b} <=> $population{$a} || $canonTitles{$a} cmp $canonTitles{$b};} keys %population) { 
    next if ($tbl{$pop} =~ /kernal.net/);
    my $room =<<PHP;
  $ctr => array (
    'href' => "$tbl{$pop}",
    'people' => $population{$pop},
    'title'  => "$titles{$pop}",
    'copies' => $copies{$pop},
    'rep'    => $rep{$pop}
  )
PHP
    push (@rooms, $room);
    $ctr++;
  }
  my $list = join(",\n", @rooms);
  print PHP <<PHP;
\$allRooms_$comm = array (
$list
);
PHP

  close PHP;
}

#####################################################
#
# Push rooms to front end servers
#

sub pushChanges {
  push(@c, 'chatFEWS');
  push(@c, 'regFEWS');
  foreach $c (@c) {
    @srvrs = split(',', $G_config{$c});
    foreach $s (@srvrs) {
      next if ($s eq $G_config{'thisHost'});
      $phpFile = '/web/php/pop.vpchat.php';
      `/bin/rcp $phpFile $s:$phpFile.tmp`;
      `rsh $s "mv $phpFile.tmp $phpFile"`;
      $phpFile = '/web/php/pop.vpadult.php';
      `/bin/rcp $phpFile $s:$phpFile.tmp`;
      `rsh $s "mv $phpFile.tmp $phpFile"`;
    }
  }
}

#####################################################
#
# START HERE
#
chdir "/u/vplaces/scripts/categories";

$vpplaces_root = "/u/vplaces/VPCOM/VPCATEGORY";
push(@G_logFile, $vpplaces_root . "/CoolPlacesWithCateg.log");

&getPromoBoxHtml;

#
# Fill in the %categories hash with the children of category 0,
# i.e. the top level index.
#
&getSubCategories(0);
%topC = %categories;
foreach $c (keys %topC) {
	$x = $topC{$c};
	chomp $x;
	($cat, $parent, $name) = split(/\t/, $x);
	$comm = ($name eq 'Family') ? 'vpchat' : 'vpadult';
	$phpFile = $G_config{'phpRoot'} . "/pop.$comm.php";
	&getSubCategories($c);

	&getTopCategories($c);
	&getRoomCopies;
	$userPages = 0;
	&createPHPFile($phpFile, $userPages, $comm);

	#
	# Process user-created rooms
	#
	if ($comm eq 'vpchat') {
		@topCategories = ();
		&getUserCategories;
		&getSubCategories($G_config{'userRoomsCategory'});

		$userPages = 1;
		&createPHPFile($phpFile, $userPages, $comm);
	} else {
		@topCategories = ();
		&getAUserCategories;
		&getSubCategories($G_config{'AuserRoomsCategory'});

		$userPages = 1;
		&createPHPFile($phpFile, $userPages, $comm);
	}

	&getSubCategories($c);
	%tc = {};
	foreach $cat (@topCategories) {
		$tc{$cat} = 1;
	}
	&doAllRooms($phpFile, $comm);
}

$G_dbh->disconnect;

&pushChanges;
