#
# getCommunity -- returns the community's address
#
# Input: mode - "DB" or "FILE"
#        places service directory - directory in which the places service
#              writes the places log files.
# Output: return value is the community name
#

require "getPlacesRoot.pl";

sub getCommunity
{
  my $mode = shift @_;

  if ($mode eq "FILE") {
    ###
    ### Read file and get community from first record
    ###
    my $vpplaces_root = &getPlacesRoot();
    my $fileName = $vpplaces_root . "AllPlaces.log";
    open (LOG, "<$fileName") || die "Could not open file $fileName: $!\n";
    $line = <LOG>;
    close LOG;
    @words = split /\t/, $line;
    $community = $words[1];
  }
  elsif ($mode eq "DB") {
    ###
    ### get community address from database
    ###

    $query = "select URL from vpplaces..vpPlacesList where serialNumber = -1";
    if( ($rc = ct_sql( $ws_db, $query )) != CS_SUCCEED)
    {
      ws_error( "VP : error (Unable to process database request)." );
      return;
    }

    ###
    ### Fetch rows
    ###

    while( ($ret = ct_results( $ws_db, $result_type )) == CS_SUCCEED )
    {
      RESULTS:
      {
	if( $result_type == CS_CMD_DONE ) { last RESULTS; }
	if( $result_type == CS_CMD_FAIL ) { last RESULTS; }
	if( $result_type == CS_ROW_RESULT )
	{
	  while( @row = ct_fetch( $ws_db ) )
	  {
		$community = $row[0];
 	  }
          last RESULTS;
	}
      }
    }

    ###
    ### Check if query succeeded
    ###

    if( $ret == CS_FAIL )
    {
      ct_cancel( CS_CANCEL_ALL );
      ws_error( "VP : error (A database connection error occured)." );
    }
  }

  return $community;

}

return 1;
