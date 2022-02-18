#!/usr/bin/perl

if ($ARGV[0] eq '-t') {
  shift @ARGV;
  $template = 1;
} else {
  $template = 0;
}

$tmp = '/tmp';
foreach $file (@ARGV) {
  $file =~ s/^\.\///;
  open(OLD, "<$file") || die "Can't read $file : $!";
  open(TMP, ">$tmp/$file") || die "Can't create $tmp/$file : $!";
  while (<OLD>) {
    s/\r//g;
    s!http://reg.halsoft.com!http://reg.vpchat.com!;
    s!https://reg.halsoft.com!https://reg.vpchat.com!;
    s!http://chat.halsoft.com!http://vpchat.com!;
    s!http://adult.halsoft.com!http://vpadult.com!;
    s!http://members.halsoft.com!http://members.vpchat.com!;
    }
    print TMP;
  }
  close OLD;
  close TMP;
  @lines = `diff $tmp/$file $file`;
  if ($#lines == -1) {
    print "NO CHANGE: $file\n";
  }
  else {
    print "UPDATED: $file\n";
    `mv "$tmp/$file" $file`;
  }
  unlink "$tmp/$file";
}
