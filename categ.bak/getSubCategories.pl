# getSubCategories - returns an array of all sub categories for a given
#                    category
#
# Input: mode - "DB" or "FILE"
#        places service directory - directory in which the places service
#              writes the places log files.
#        parent category - id of the category for which a list of 
#              subcategories is requested
# Output: @categories - an array in which each entry represents a subcategory 
#              with the following format:
#		<category id>\t<parent category id>\t<category name>\n
#

require "getPlacesRoot.pl";

sub getSubCategories
{
  my $mode = shift @_;
  my $parentCategory = shift @_;
  my $i = 0;

  if ($mode eq "FILE") {
    ###
    ### Read file and get Sub Categories
    ###
    my $vpplaces_root = &getPlacesRoot();
    my $fileName =  $vpplaces_root . "Categories.log";
    open (LOG, "<$fileName") || die "Could not open file $fileName: $!\n";
    while (<LOG>) {
      @words = split /\t/;
      if (@words[0] == -1) { next; }
      if (@words[1] != $parentCategory) { next; }
      @categories[$i++] = $_;
    }
    close LOG;
  }
  elsif ($mode eq "DB") {
    ###
    ### get sub categories from database
    ###
    my $temp = $parentCategory;
    if ($temp == 0) {
      $temp = "NULL";
    }

    $query = "exec vpplaces..getSubCategories $temp";
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
            @categories[$i++] = @row[0]."\t".$parentcategory."\t".@row[1]."\n";
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

  return 1;

}

return 1;
