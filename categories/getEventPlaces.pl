#
# getEventPlaces -- returns an array of auditoriums as requested
#
# Input: mode - "DB" or "FILE"
#        places service directory - directory in which the places service
#              writes the places log files.
#        index - index of first place to return
#        block length - number of places to return
#        category id - id of category for which we are getting places, 
#                      or -1.
# Output: @places - an array of places, each place represented as a line
#                   of the following format:
#          category\tURL\tReplNo\tTitle\tInRoom\tObservers\tCapacity\n
#

#require "getPlacesRoot.pl";

sub getEventPlaces
{
  my $mode = shift @_;
  my $index = shift @_;
  my $blockLen = shift @_;
  my $category = shift @_;
  my $numPlaces = 0;
  my $scrollNext = 0;
  my $i = 0;
  my $fileName = "";

  if ($mode eq "FILE") {
     # Get the places list from the log file created by the Places service
     if ($category == -1) {
       $fileName =  "AudPlaces.log";
     }
     else {
       $fileName =  "AudPlacesWithCateg.log";
     }

     my $vpplaces_root = &getPlacesRoot();
     $vpplaces_root .= '/' unless($vpplaces_root =~ /\/$/);
     my $origFile =  $vpplaces_root . $fileName;
     
     open (LOG, "<$origFile") || die "Could not open file $origFile: $!\n";
     while (<LOG>) {
      if (($blockLen != -1) && ($numPlaces >= $index + $blockLen)) {
        $scrollNext = 1;
        last;
      }
      @words = split /\t/;

      # Get only places for current category if specified...
      if ($category != -1) {
        if (@words[0] != $category) { next; }
      }
      
      # Skip first record (totals)
      if (@words[0] == -1) { next; }	

      # Keep current place if its index is in the requested range
      if (($numPlaces >= $index) && 
          (($blockLen == -1) || ($numPlaces < $index + $blockLen))) {
        @places[$i] = $_;
        $i++;
      }
      $numPlaces++;
    }
    close LOG;
  }
  elsif ($mode eq "DB") {
    # Get the places list from the database table written by the Places service
    my $temp = $blockLen;
    
    # Get one record more than requested to see if there is more to get.
    if ($blockLen >= 0) {$temp++;} 

    if ($category != -1) {	# category specified
      $query = "exec vpplaces..getPlaces 1, $category, $index, $temp";
    }
    else {
      $query = "exec vpplaces..getPlaces 1, NULL, $index, $temp";
    }

    if( ($rc = ct_sql( $ws_db, $query )) != CS_SUCCEED)
    {
      ws_error( "VP : error (Unable to process database request)." );
      return 0;
    }

    ###
    ### Fetch rows and build table
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
	    if (($blockLen != -1) && ($numPlaces >= $blockLen)) {
 		$scrollNext = 1; next;
            }
            # Store in @places array as a line including the followinf fields:
            # category URL ReplNo Title InRoom Observers Capacity
            @places[$numPlaces] = 
              @row[7]."\t".@row[0]."\t".@row[6]."\t".@row[1]."\t".@row[2]."\t".@row[3]."\t".@row[5]."\n";
	    $numPlaces++;
 	  }
          last RESULTS;
	}
	if( $result_type == CS_STATUS_RESULT )
        {
	  while( @row = ct_fetch( $ws_db ) ) {
            if ($row[0] != 0) {
              print "<P>Stored procedure return status: ", $row[0], "<P>\n";
            }
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

  return $scrollNext;
}

return 1;
