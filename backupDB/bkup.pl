#!/usr/bin/perl

sub dump {
	my $db = shift @_;
	open (CMD, ">$cmdFile") || die $!;
	print CMD <<CMD;
use $db
go
sp_help
go
CMD
	close CMD;
	undef %objects;
	open (OUT, "$ISQL -i $cmdFile |");
	while (<OUT>) {
		next if (/---/);
		next if (/^\s+$/);
		/^\s*(\w+)\s+\w+\s+(\w+)\s*/;
		$objects{$1} = $2;
	}
	foreach $k (keys %objects) {
		if ($objects{$k} eq 'user') {
			print "Dumping $db..$k\n";
			open (BCP, "bcp $db.dbo.$k out /logs/backup/$k -c -Usa -SSYBASE -PUBIQUE |");
			while (<BCP>) {
				print;
			}
		}
	}
}


$ISQL = "/u/vplaces/s/sybase/bin/isql -Usa -PUBIQUE -SSYBASE -w300";
$cmdFile = "/tmp/isql";
for $i ('audset', 'vpusers', 'vpplaces') {
	&dump($i);
}

