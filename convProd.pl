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
    s!chat.halsoft.com!vpchat.com!g;
    s!adult.halsoft.com!vpadult.com!g;
    s!reg.halsoft.com!reg.vpchat.com!g;
    s!members.halsoft.com!members.vpchat.com!g;
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
