#!/usr/bin/perl
#
# First run this SQL query -
#  SELECT 'XX',ownerID,nickName
#  FROM userAccounts,users
#  WHERE userAccounts.ownerID = users.userID
#
# Then use the output of the query as input to this script.
#
# Tom Lang 6/2002
#
$ad = "/logs/accountIDs";
$ud = "/logs/users";
#
# For each account
#
while(<STDIN>) {
	next unless(/^\s*XX/);
	chomp;
	($junk,$aid,$n) = split;	# get accountID and user name
	#
	# accountID log exists but not user name log.
	#
	if (! -f "$ad/$aid") {
		print "Link $ud/$n -> $ad/$aid\n";
		link "$ud/$n", "$ad/$aid";
	}
	#
	# user name log exists but not accountID log.
	#
	elsif (! -f "$ud/$n") {
		print "Link $ad/$aid -> $ud/$n\n";
		link "$ad/$aid", "$ud/$n";
	}
	else {
		@lines = `ls -l $ad/$aid $ud/$n`;	# returns 2 lines
		$_ = shift @lines;
		@f = split;	# split the first line into fields
		#
		# get the file size field from 'ls -l'
		#
		$as = $f[4];
		#
		# get the file modification date from 'ls -l'
		#
		$at = join(' ', $f[5], $f[6], $f[7]);

		#
		# repeat for the second file name
		#
		$_ = shift @lines;
		@f = split;
		$us = $f[4];
		$ut = join(' ', $f[5], $f[6], $f[7]);

		#
		# If file size or modification date differ, merge the two files
		# into one, and create a link
		#
		if (($as != $us) || ($at ne $ut)) {
			print "Merging $ad/$aid $ud/$n\n";
			`cat $ad/$aid $ud/$n | sort -k 5,5 -M -k 2,2 -k 3,4 | uniq > /tmp/$aid`;
			unlink "$ad/$aid";
			unlink "$ud/$n";
			`mv /tmp/$aid $ad/$aid`;
			chmod 0666,"$ad/$aid";
			link "$ad/$aid", "$ud/$n";
			chmod 0666,"$ud/$n";
		}
	}
}
