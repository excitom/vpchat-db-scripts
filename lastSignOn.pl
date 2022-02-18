#!/usr/bin/perl
while(<>) {
  chomp;
  @cols = split(' ', $_, 5);
  print join(',', @cols) . "\n";
}
