dbcc traceon(3604)
go 
               
use master
go 
                                                              
dbcc checkdb(audset,skip_ncindex)
dbcc checkdb(vpusers,skip_ncindex)
dbcc checkdb(vpplaces,skip_ncindex)
go                         
               
use vpusers
go 
use vpplaces
go

use audset
go

