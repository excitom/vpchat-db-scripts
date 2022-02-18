USE master
go
DISK INIT
    NAME='Audsets',
    PHYSNAME='/u/vplaces/s/sybase/db/Audsets.dat',
    VDEVNO=12,
    SIZE=51200,
    VSTART=0,
    CNTRLTYPE=0
go
EXEC sp_diskdefault 'Audsets',defaultoff
go
IF EXISTS (SELECT * FROM master.dbo.sysdevices WHERE name='Audsets')
    PRINT '<<< CREATED DATABASE DEVICE Audsets >>>'
ELSE
    PRINT '<<< FAILED CREATING DATABASE DEVICE Audsets >>>'
go


USE master
go
DISK INIT
    NAME='Audsets_log',
    PHYSNAME='/u/vplaces/s/sybase/db/Audsets.log',
    VDEVNO=11,
    SIZE=25600,
    VSTART=0,
    CNTRLTYPE=0
go
EXEC sp_diskdefault 'Audsets_log',defaultoff
go
IF EXISTS (SELECT * FROM master.dbo.sysdevices WHERE name='Audsets_log')
    PRINT '<<< CREATED DATABASE DEVICE Audsets_log >>>'
ELSE
    PRINT '<<< FAILED CREATING DATABASE DEVICE Audsets_log >>>'
go


USE master
go
DISK INIT
    NAME='VpDatabases',
    PHYSNAME='/u/vplaces/s/sybase/db/VpDatabases.dat',
    VDEVNO=14,
    SIZE=1024000,
    VSTART=0,
    CNTRLTYPE=0
go
EXEC sp_diskdefault 'VpDatabases',defaultoff
go
IF EXISTS (SELECT * FROM master.dbo.sysdevices WHERE name='VpDatabases')
    PRINT '<<< CREATED DATABASE DEVICE VpDatabases >>>'
ELSE
    PRINT '<<< FAILED CREATING DATABASE DEVICE VpDatabases >>>'
go


USE master
go
DISK INIT
    NAME='VpDatabases_log',
    PHYSNAME='/u/vplaces/s/sybase/db/VpDatabases.log',
    VDEVNO=13,
    SIZE=512000,
    VSTART=0,
    CNTRLTYPE=0
go
EXEC sp_diskdefault 'VpDatabases_log',defaultoff
go
IF EXISTS (SELECT * FROM master.dbo.sysdevices WHERE name='VpDatabases_log')
    PRINT '<<< CREATED DATABASE DEVICE VpDatabases_log >>>'
ELSE
    PRINT '<<< FAILED CREATING DATABASE DEVICE VpDatabases_log >>>'
go


USE master
go
DISK INIT
    NAME='VpUserDetails',
    PHYSNAME='/u/vplaces/s/sybase/db/VpUserDetails.dat',
    VDEVNO=10,
    SIZE=1024000,
    VSTART=0,
    CNTRLTYPE=0
go
EXEC sp_diskdefault 'VpUserDetails',defaultoff
go
IF EXISTS (SELECT * FROM master.dbo.sysdevices WHERE name='VpUserDetails')
    PRINT '<<< CREATED DATABASE DEVICE VpUserDetails >>>'
ELSE
    PRINT '<<< FAILED CREATING DATABASE DEVICE VpUserDetails >>>'
go


USE master
go
DISK INIT
    NAME='VpUserDetails_log',
    PHYSNAME='/u/vplaces/s/sybase/db/VpUserDetails.log',
    VDEVNO=9,
    SIZE=512000,
    VSTART=0,
    CNTRLTYPE=0
go
EXEC sp_diskdefault 'VpUserDetails_log',defaultoff
go
IF EXISTS (SELECT * FROM master.dbo.sysdevices WHERE name='VpUserDetails_log')
    PRINT '<<< CREATED DATABASE DEVICE VpUserDetails_log >>>'
ELSE
    PRINT '<<< FAILED CREATING DATABASE DEVICE VpUserDetails_log >>>'
go


/* USE master
go */
/* DISK INIT
    NAME='temp_data',
    PHYSNAME='/u/vplaces/s/sybase/db/temp.dat',
    VDEVNO=18,
    SIZE=512000,
    VSTART=0,
    CNTRLTYPE=0
go */
/* EXEC sp_diskdefault 'temp_data',defaultoff
go */
/* IF EXISTS (SELECT * FROM master.dbo.sysdevices WHERE name='temp_data')
    PRINT '<<< CREATED DATABASE DEVICE temp_data >>>'
ELSE
    PRINT '<<< FAILED CREATING DATABASE DEVICE temp_data >>>'
go */ 


/* USE master
go */
/* DISK INIT
    NAME='temp_log',
    PHYSNAME='/u/vplaces/s/sybase/db/temp.log',
    VDEVNO=8,
    SIZE=1024000,
    VSTART=0,
    CNTRLTYPE=0
go */
/* EXEC sp_diskdefault 'temp_log',defaultoff
go */
/* IF EXISTS (SELECT * FROM master.dbo.sysdevices WHERE name='temp_log')
    PRINT '<<< CREATED DATABASE DEVICE temp_log >>>'
ELSE
    PRINT '<<< FAILED CREATING DATABASE DEVICE temp_log >>>'
go */

