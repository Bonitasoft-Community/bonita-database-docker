print '================================================================================================'
print '====           Starting configuration of SQL server 2017 for Bonita compatibility           ===='
print '================================================================================================'

USE master
GO

IF NOT EXISTS (SELECT name FROM sys.server_principals WHERE name = 'bonita')
BEGIN
    CREATE LOGIN bonita WITH PASSWORD = 'bpm', CHECK_POLICY = OFF
END
GO

IF NOT EXISTS (SELECT name FROM sys.server_principals WHERE name = 'business_data')
BEGIN
    CREATE LOGIN business_data WITH PASSWORD = 'bpm', CHECK_POLICY = OFF
END
GO

-------------------------------- create database BONITA ----------------------------
IF NOT EXISTS (SELECT name FROM master.dbo.sysdatabases WHERE name = N'bonita')
BEGIN
    CREATE DATABASE [bonita]
    -- Enable Row Versioning-Based Isolation Levels
    ALTER DATABASE bonita SET ALLOW_SNAPSHOT_ISOLATION OFF
    ALTER DATABASE bonita SET READ_COMMITTED_SNAPSHOT OFF
END
GO

-------------------------------- create database BUSINESS DATA ----------------------------
IF NOT EXISTS (SELECT name FROM master.dbo.sysdatabases WHERE name = N'business_data')
BEGIN
    CREATE DATABASE [business_data]
    -- Enable Row Versioning-Based Isolation Levels
    ALTER DATABASE business_data SET ALLOW_SNAPSHOT_ISOLATION OFF
    ALTER DATABASE business_data SET READ_COMMITTED_SNAPSHOT OFF
END
GO

USE bonita
GO

IF NOT EXISTS (SELECT name FROM sys.database_principals WHERE name = 'bonita')
BEGIN
    CREATE USER bonita FOR LOGIN bonita
    -- Grant permissions
    EXEC sp_addrolemember N'db_datareader', N'bonita'
    EXEC sp_addrolemember N'db_datawriter', N'bonita'
    EXEC sp_addrolemember N'db_ddladmin', N'bonita'
END
GO

USE business_data
GO

IF NOT EXISTS (SELECT name FROM sys.database_principals WHERE name = 'business_data')
BEGIN
    CREATE USER business_data FOR LOGIN business_data
    -- Grant permissions
    EXEC sp_addrolemember N'db_datareader', N'business_data'
    EXEC sp_addrolemember N'db_datawriter', N'business_data'
    EXEC sp_addrolemember N'db_ddladmin', N'business_data'
END
GO

-- Use master database
USE master
GO

IF NOT EXISTS (SELECT name FROM sys.database_principals WHERE name = 'bonita')
BEGIN
    CREATE USER bonita FOR LOGIN bonita
    CREATE USER business_data FOR LOGIN business_data

    --------------------------- Support of XA transactions ---------------------------
    print 'SQLJDBC XA installation and configuration...'
    EXEC sp_sqljdbc_xa_install

    -- Grant privileges to [SqlJDBCXAUser] role to the extended stored procedures.
    grant execute on sp_sqljdbc_xa_install to [SqlJDBCXAUser]

    grant execute on xp_sqljdbc_xa_init to [SqlJDBCXAUser]
    grant execute on xp_sqljdbc_xa_start to [SqlJDBCXAUser]
    grant execute on xp_sqljdbc_xa_end to [SqlJDBCXAUser]
    grant execute on xp_sqljdbc_xa_prepare to [SqlJDBCXAUser]
    grant execute on xp_sqljdbc_xa_commit to [SqlJDBCXAUser]
    grant execute on xp_sqljdbc_xa_rollback to [SqlJDBCXAUser]
    grant execute on xp_sqljdbc_xa_recover to [SqlJDBCXAUser]
    grant execute on xp_sqljdbc_xa_forget to [SqlJDBCXAUser]
    grant execute on xp_sqljdbc_xa_rollback_ex to [SqlJDBCXAUser]
    grant execute on xp_sqljdbc_xa_forget_ex to [SqlJDBCXAUser]
    grant execute on xp_sqljdbc_xa_prepare_ex to [SqlJDBCXAUser]
    grant execute on xp_sqljdbc_xa_init_ex to [SqlJDBCXAUser]

    -- Add users to the user [SqlJDBCXAUser] role as needed.
    EXEC sp_addrolemember [SqlJDBCXAUser], 'bonita'
    EXEC sp_addrolemember [SqlJDBCXAUser], 'business_data'
    print 'SQLJDBC XA DLL installation script complete. Check for any error messages generated above.'
END
GO

print 'Bonita SQL Server initialization complete'


