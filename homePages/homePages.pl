#!/usr/bin/perl
# 
# Create main index page for member home pages
#
# The main page has links to sub pages, which group the member pages
# 25 per group. The program also creates the sub pages.
#
# Tom Lang 2/2002
#
$pageSize = 25;
$htmpDir = "/u/vplaces/scripts/homePages";
$dir = "/export/home/members/";
$dbName = 'vpplaces';
$dbPw = 'vpplaces';
$G_isql_exe = "/u/vplaces/s/sybase/bin/isql -U$dbName -P$dbPw -SSYBASE";
$G_statdir = "/tmp/";
$tempsql = $G_statdir . ".temp.sql.$$";
$ENV{'SYBASE'} ||= '/u/vplaces/s/sybase';

#
# Find all the member home pages
#
open (SQL_IN, ">$tempsql") || die "Can't write to $tempsql : $!\n";
print SQL_IN "SELECT 'XX', URL, URL2 FROM homePages WHERE deleted = 0 AND locked=0\nGO\n";
close SQL_IN;
open (SQL_OUT, "$G_isql_exe -i $tempsql |") || die "Can't read from $G_isql_exe -i $tempsql : $!\n";

#
# Three lines will be returned per home page -- the marker line with 'XX' in it, followed
# by a line containing the URL (lower case member name) and a line containing the mixed-case
# member name (or the string 'NULL' if there isn't a mixed case name).
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
  $pages{$URL} = $URL2 if ($URL2 ne 'NULL');
  #
  # Build a hash of the pages, the key is the canonical form of the
  # name (special characters removed). The hash values are the actual
  # page names. We do this so that we sort name only on alphabetical and numeric
  # characters, not including dot, dash, and underscore. Therefore _tom and -tom sort
  # together with tom rather than all the -_. crap sorting at the front of the list.
  #
  $canonpage = $URL;
  $canonpage =~ s/[-._]+//g;			# strip the crap
  $canonpage = "a" if ($canonpage eq "");
  while (defined($cp{$canonpage})) {		# after stripping the crap, append a
    $canonpage .= '.';				# character to insure unique names, 
  }						# if necessary.
  $cp{$canonpage} = $URL;
  $homePages++;
}
close SQL_OUT;
unlink($tempsql);
#
# Sort the pages by canonical name, building an array of actual page names
#
$i = 0;
foreach $p (sort keys %cp) {
  if (defined($pages{$cp{$p}})) {
    $pages[$i] = $pages{$cp{$p}};	# take mixed case name, if any
  } else {
    $pages[$i] = $cp{$p};
  }
  $i++;
}

#
# Create the HTML files from templates. Temporary files are created,
# then later renamed to the .html file names so that update is an
# atomic operation.
#
open(TEMPLATE, "<$htmpDir/index.htmp") || die "Can't read $htmpDir/index.htmp : $!";
$out = $dir . "index.html";
push (@out, $out);
$out .= ".tmp";
open(HTML, ">$out") || die "Can't create $out : $!";
while (<TEMPLATE>) {
  last if (/####TABLE####/);
  print HTML;
}

print HTML <<HTML;
<table border=0 width=430>
<tr>
<td>
There are <b>$homePages</b> user home pages.
The links below are organized in alphabetical order (ignoring
characters like period, hyphen, and underscore)
in groups of <b>$pageSize</b>.
</td>
</tr>
HTML

#
# Build the sub-index pages
#
$i = $pageSize;
$idx = 0;
$first = 1;
$firstPage = $lastPage = "";
foreach $page (@pages) {

  #
  # First link in a sub-page, so output the sub-page template header
  #
  if ($first) {
    $first = 0;
    $idx++;
    $out2 = $dir . "index." . $idx . ".html";
    push (@out, $out2);
    $out2 .= ".tmp";
    open(TEMPLATE2, "<$htmpDir/subindex.htmp") || die "Can't read $htmpDir/subindex.htmp : $!";
    open(HTML2, ">$out2") || die "Can't create $out2 : $!";
    while(<TEMPLATE2>) {
      last if (/####TABLE####/);
      print HTML2;
    }
    $firstPage = $page;
  }
  
  print HTML2 <<ROW;
<tr><td><a href="$page">$page</a></td></tr>
ROW

  $lastPage = $page;
  #
  # Last link in a sub-page, so finish off the template and add a
  # row to the main index page.
  #
  if ($i-- == 0) {
    $i = $pageSize;
    $first = 1;

    #
    # Create Next and Previous links
    #
    $next = $idx + 1;
    if ($idx == 1) {
      print HTML2 <<LINKS;
<tr><td>&nbsp;</td></tr>
<tr><td>
<a href="index.html">TOP</a>
&nbsp;-&nbsp;
<a href="index.$next.html">NEXT&nbsp;&gt;</a>
</td></tr>
LINKS
    } else {
      $prev = $idx - 1;
      print HTML2 <<LINKS;
<tr><td>&nbsp;</td></tr>
<tr><td>
<a href="index.$prev.html">&lt;&nbsp;PREVIOUS</a>
&nbsp;-&nbsp;
<a href="index.html">TOP</a>
&nbsp;-&nbsp;
<a href="index.$next.html">NEXT&nbsp;&gt;</a>
</td></tr>
LINKS
    }
    while(<TEMPLATE2>) {
      print HTML2;
    }
    close TEMPLATE2;
    close HTML2;

    print HTML <<ROW;
<tr><td><a href="index.$idx.html"><b>$firstPage</b><font color=#000000> through </font><b>$lastPage</b></a></td></tr>
ROW
  }
}
#
# Unless we just finished a sub-page, finish it now.
#
if ($first == 0) {
  $prev = $idx - 1;
  print HTML2 <<LINKS;
<tr><td>&nbsp;</td></tr>
<tr><td>
<a href="index.$prev.html">&lt;&nbsp;PREVIOUS</a>
&nbsp;-&nbsp;
<a href="index.html">TOP</a>
</td></tr>
LINKS
  while(<TEMPLATE2>) {
    print HTML2;
  }
  close TEMPLATE2;
  close HTML2;

  print HTML <<ROW;
<tr><td><a href="index.$idx.html"><b>$firstPage</b><font color=#000000> through </font><b>$lastPage</b></a></td></tr>
ROW
}

#
# Finish the main index page.
#
print HTML "</table>\n";
while (<TEMPLATE>) {
  print HTML;
}
close TEMPLATE;
close HTML;

#
# Move the temp files into position.
#
foreach $f (@out) {
  $t = $f . ".tmp";
  if (! -f $t) {
    print "Found $f but not $t\n";
    next;
  }
  rename $t, $f;
}
