#
# getParents -- returns an array of categories who are the path (ancestores)
#  of a given category
# Input: mode - "DB" or "FILE"
#        category id - id of category for which we are getting path, 
#                      or -1.
# Output: @categories - an array of categories, each category represented as a line
#                   of the following format:
#          category\tdescription\tparent category\n
#

#require "getPlacesRoot.pl";

sub getParents
{
  my $mode = shift @_;
  my $category = shift @_;
  my $i = 0;

  if ($category <= 0) {
    return 0;
  }

  if ($mode eq "FILE") {
    $fileName = "Categories.log";
    my $vpplaces_root = &getPlacesRoot();
    $vpplaces_root .= '/' unless($vpplaces_root =~ /\/$/);
    my $origFile =  $vpplaces_root . $fileName;
 
    ###
    ### Load category file to array
    ###
    open (LOG, "<$origFile") || die "Could not open file $origFile: $!\n";
    while (<LOG>) {
      @words = split /\t/;
      $categInfo{@words[0]}= $_;
    }
    close LOG;
  }

  elsif ($mode eq "DB") {
    ###
    ### get list of catgeories from database
    ###

    $query = "exec vpplaces..getCategories";
    if( ($rc = ct_sql( $ws_db, $query )) != CS_SUCCEED)
    {
      ws_error( "VP : error (Unable to process database request)." );
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
            $categInfo{@row[0]} = @row[0]."\t".@row[2]."\t".@row[1];
          }
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

  ###
  ### Build the category path
  ###
  # Get current category info
  @info = split /\t/, $categInfo{$category}; 
  $parent      = @info[1];
  @categPath[$i] = $categInfo{$category};
  $i++;

  # Get ancestors info
  while ($parent >= 0) {
    if ($parent == 0) {
      @categPath[$i] = "-1\tTop\t-1";
      $parent = -1;
    }
    else {
      @categPath[$i] = $categInfo{$parent};
      @info = split /\t/, $categInfo{$parent}; 
      $parent = @info[1];
      $i++;
    }
  }

}

return 1;
