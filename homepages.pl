#!/usr/bin/perl
while (<>) {
  chomp;
  ($aid, $url, $bytes) = split;
  print "$aid\t$url\n" if ($bytes > 1024);
}
