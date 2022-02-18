#!/usr/bin/perl
while (<STDIN>) {
	chomp;
	($keyName, $belongsTo, $type, $keyID, $intValue, $strValue) = split;
	if ($type == 1) {
		print <<SQL;
EXEC addConfigKey "$keyName", $belongsTo, 1, $keyID, $intValue
SQL
	}
	elsif ($type == 2) {
		print <<SQL;
EXEC addStrConfigKey "$keyName", $belongsTo, 2, $keyID, "$strValue"
SQL
	}
	else {
		print <<SQL;
EXEC addConfigKey "$keyName", $belongsTo, 3, $keyID, $intValue
SQL
	}
}
