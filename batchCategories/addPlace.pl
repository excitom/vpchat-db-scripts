#!/usr/local/bin/perl
#
# Add places to categories in batch mode
#
# Tom Lang 8/1999
#
$G_isql_exe = '/u/vplaces/s/sybase/bin/isql -Uvpplaces -Pvpplaces -SSYBASE';
$G_tmpdir = "/tmp/";
$tempsql = $G_tmpdir . ".temp.sql.$$";
$ENV{'SYBASE'} ||= '/u/vplaces/s/sybase';
$category = "";
#
# Loop through input
#
while (<STDIN>) {
	chop;
	next if (/^\s*$/);
	#
	# Process category name
	#
	if (/^#/) {
		$category = substr $_, 1, length($_)-1;
		print "Processing $category\n";
		open (SQL_IN, ">$tempsql") || die "Can't write to $tempsql : $!\n";
		print SQL_IN qq|select category from categories where description='$category'\n|;
		print SQL_IN "go\n";
		close SQL_IN;
		open (SQL_OUT, "$G_isql_exe -i $tempsql |") || die "Can't read from $G_isql_exe -i $tempsql : $!\n";
		$found = 0;
		while (<SQL_OUT>) {
			if (/---/) {
				$found=1;
				last;
			}
		}
		die "$category not in database" unless ($found);
		$parent = <SQL_OUT>;
		close SQL_OUT;
		chop $parent;
		print "$parent\n";
	} else
	#
	# Process sub-category
	#
	{
		die "No category" if ($category eq "");
		$title = $_;
		$url = <STDIN>;
		chomp $url;
		die "Something's hosed - URL: $url" unless ($url =~ /^http:\/\//);
		#
		# prevent name conflict
		#
		$title .= " Chat" if ($title eq $category);

		#
		# Create "Cool Place" with this URL
		#
		#open (SQL_IN, ">$tempsql") || die "Can't write to $tempsql : $!\n";
		#print SQL_IN qq|addPersistentPlace "$url", 2112, "$title", 25, 0, 0, 0, "row"\n|;
		#print SQL_IN "go\n";
		#close SQL_IN;
		#open (SQL_OUT, "$G_isql_exe -i $tempsql |") || die "Can't read from $G_isql_exe -i $tempsql : $!\n";
		#$ok = 0;
		#while (<SQL_OUT>) {
			#if (/return status = 0/) {
				#$ok=1;
				#last;
			#}
		#}
		#close SQL_OUT;
		#die "Add cool place $title FAILED" unless($ok);

		#
		# Add the new "Cool Place" as a sub-category
		#
		open (SQL_IN, ">$tempsql") || die "Can't write to $tempsql : $!\n";
		print SQL_IN qq|addPlaceToCategory $parent, "$url", 0\n|;
		print SQL_IN "go\n";
		close SQL_IN;
		open (SQL_OUT, "$G_isql_exe -i $tempsql |") || die "Can't read from $G_isql_exe -i $tempsql : $!\n";
		$ok = 0;
		while (<SQL_OUT>) {
			if (/return status = 0/) {
				$ok=1;
				last;
			}
		}
		close SQL_OUT;
		die "Add category $title FAILED" unless($ok);
	
		print " --- Added $title\n";
	}
}
unlink $tempsql;
