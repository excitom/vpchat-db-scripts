#!/usr/bin/perl
#
# Find all the names of user home pages
#

$dir = "/export/home/members/";
opendir(PAGES, $dir);
@pages = readdir(PAGES);
closedir(PAGES);


foreach $page (@pages) {
  next if ($page =~ /^index/);
  next if (($page eq '.') || ($page eq '..'));
  next if ($page =~ /^websql/);
  next if ($page eq "VP");
  my $f = $dir . $page;
  next if (-l $f);
  next unless (-d $f);
  next if (-f "$f/.new");     # skip if user hasn't uploaded anything
  next if (-f "$f/.htaccess");     # skip if locked
  #$page =~ tr/[A-Z]/[a-z]/;
  push(@p, $page);
  $homePages++;
}
print $homePages . "\n";
foreach $page (sort @p) {
	print $page . "\n";
}

