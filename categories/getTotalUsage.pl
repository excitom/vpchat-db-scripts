# getTotalusage - returns the total number of users in the community
#
# Input: mode - "DB" or "FILE"
#        places service directory - directory in which the places service
#              writes the places log files.
# Output: $participants - number of users in VP rooms
#         $observers    - number of observers in the community
#

#require "getPlacesRoot.pl";

sub getTotalUsage
{
  my $mode = shift @_;

  if ($mode eq "FILE") {
    ###
    ### Read file and get number of people
    ###

    my $vpplaces_root = &getPlacesRoot();
    $vpplaces_root .= '/' unless($vpplaces_root =~ /\/$/);
    my $fileName =  $vpplaces_root . "AllPlaces.log";

    open (LOG, "<$fileName") || die "Could not open file $fileName: $!\n";
    $line = <LOG>;
    close LOG;
    @words = split /\t/, $line;
    $participants = $words[4];
    $observers = $words[5];
  }
  elsif ($mode eq "DB") {
    ###
    ### get number of people from database
    ###

    $query = qq!select roomUsage,corrUsage from vpplaces..vpPlacesList where serialNumber = -1!;
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
		$participants = $row[0];
		$observers    = $row[1];
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

  return 1;

}

return 1;
