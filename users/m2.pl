#!/usr/bin/perl


##################
#
# START HERE
#
$aid = shift @ARGV;

$old = $aid;

@line = `tail -1 /logs/accountIDs/$aid`;
@f = split(/\t/, $line[0]);
$new = $f[2];

$old = $aid = 200362;
$new = 'evil';

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
die "SHIT" unless -f (-f "/logs/users/$old");
unlink "/logs/users/$old";
die "FUCK" unless -f (-f "/logs/users/$new");
unlink "/logs/users/$new";
`mv /tmp/$aid /logs/accountIDs/$aid`;
die "DAMN" unless -f (-f "/logs/accountIDs/$aid");
chmod 0666,"/logs/accountIDs/$aid";
link "/logs/accountIDs/$aid", "/logs/users/$new";
chmod 0666,"/logs/users/$new";
unlink "/logs/users/$old";
