 dbcc traceon(3604)
go 
               
 use master
go 
                                                              
-- dbcc checkalloc('vpplaces',fix)
dbcc checkalloc('vpplaces')
go                         
 dbcc checkalloc('vpusers')
go                         
 dbcc checkalloc('audset')
go                         
