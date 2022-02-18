#!/usr/bin/perl
#
# Merge account log files when changing account owner
#
# This is meant to be called by rsh/ssh from another server.
#
# Input: new account owner name, old owner, account ID
#
# Tom Lang 4/2002


##################
#
# START HERE
#
die "Usage error 1" unless ($#ARGV == 2);
$new = shift @ARGV;
$old = shift @ARGV;
$aid = shift @ARGV;

#
# Sanity checks
#
die "Usage error 2" if (($new eq '') || ($old eq '') || ($aid eq ''));
die "Usage error 3" if (($new eq '.') || ($old eq '.'));
die "Usage error 4" if (($new eq '..') || ($old eq '..'));

#
# Log files should exist for new and old names, but 
# create new empty ones just in case.
#
unless (-f "/logs/users/$old") {
	open (LF, ">/logs/users/$old");
	close LF;
}
unless (-f "/logs/users/$new") {
	open (LF, ">/logs/users/$new");
	close LF;
}
unless (-f "/logs/accountIDs/$aid") {
	open (LF, ">/logs/accountIDs/$aid");
	close LF;
}

#
# Account owner log file SHOULD be a link to the account ID log file, and
# thus should be identical. Just in case it's not, we'll capture what's in
# the account ID file.
#
`diff /logs/users/$old /logs/accountIDs/$aid >/dev/null 2>&1`;
if ($? != 0) {
	`cat /logs/accountIDs/$aid >> /logs/users/$old`;
}

#
# Merge new and old owner's log files
#
`cat /logs/users/$old /logs/users/$new | sort -k 5,5 -M -k 2,2 -k 3,4 | uniq > /tmp/$aid`;
unlink "/logs/users/$old";
unlink "/logs/users/$new";
`mv /tmp/$aid /logs/accountIDs/$aid`;
chmod 0666,"/logs/accountIDs/$aid";
link "/logs/accountIDs/$aid", "/logs/users/$new";
chmod 0666,"/logs/users/$new";
`touch /logs/users/$old`;
chmod 0666,"/logs/users/$old";
