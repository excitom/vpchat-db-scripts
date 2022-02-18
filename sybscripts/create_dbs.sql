USE master
go
CREATE DATABASE audset
    ON Audsets=100
go
ALTER DATABASE audset 
    LOG ON Audsets_log=50
go
USE master
go
EXEC sp_dboption 'audset','abort tran on log full',true
go
USE audset
go
CHECKPOINT
go
IF DB_ID('audset') IS NOT NULL
    PRINT '<<< CREATED DATABASE audset >>>'
ELSE
    PRINT '<<< FAILED CREATING DATABASE audset >>>'
go


USE master
go
ALTER DATABASE tempdb 
    ON temp_log=2000
go
ALTER DATABASE tempdb 
    ON temp_data=1000
go
USE master
go
EXEC sp_dboption 'tempdb','select into/bulkcopy',true
go
USE tempdb
go
CHECKPOINT
go
IF DB_ID('tempdb') IS NOT NULL
    PRINT '<<< CREATED DATABASE tempdb >>>'
ELSE
    PRINT '<<< FAILED CREATING DATABASE tempdb >>>'
go


USE master
go
CREATE DATABASE vpplaces
    ON VpDatabases=2000
go
ALTER DATABASE vpplaces 
    LOG ON VpDatabases_log=1000
go
USE master
go
EXEC sp_dboption 'vpplaces','abort tran on log full',true
go
USE vpplaces
go
CHECKPOINT
go
IF DB_ID('vpplaces') IS NOT NULL
    PRINT '<<< CREATED DATABASE vpplaces >>>'
ELSE
    PRINT '<<< FAILED CREATING DATABASE vpplaces >>>'
go


USE master
go
CREATE DATABASE vpusers
    ON VpUserDetails=2000
go
ALTER DATABASE vpusers 
    LOG ON VpUserDetails_log=1000
go
USE master
go
EXEC sp_dboption 'vpusers','abort tran on log full',true
go
USE vpusers
go
CHECKPOINT
go
IF DB_ID('vpusers') IS NOT NULL
    PRINT '<<< CREATED DATABASE vpusers >>>'
ELSE
    PRINT '<<< FAILED CREATING DATABASE vpusers >>>'
go

use audset 
go
sp_changedbowner audset, true
go

use vpplaces
go
sp_changedbowner vpplaces, true
go

use vpusers
go
sp_changedbowner vpusr, true
go

use master
go
exec sp_role 'grant','sa_role','audset'
go

