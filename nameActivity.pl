#!/usr/bin/perl

$ip = $name = $accountID = '';
if ($ARGV[0] eq '-i') {
  $ip = $ARGV[1];
}
if ($ARGV[0] eq '-a') {
  $accountID = $ARGV[1];
}
if ($ARGV[0] eq '-n') {
  $name = $ARGV[1];
}
open (LOG, 'tail -10000 /logs/account_usage.log |');
while (<LOG>) {
  if (/\tdeleted / || /\tadded /) {
	@fields = split(/\t/);
	if ($ip ne '') {
		next unless ($fields[1] eq $ip);
	}
	if ($name ne '') {
		next unless ($fields[2] eq $name);
	}
	print;
  }
}
