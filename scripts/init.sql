CREATE DATABASE tdcfloripa2024;
GO

USE tdcfloripa2024;
GO

CREATE TABLE dbo.events (
    id int IDENTITY(1,1) primary key,
    type varchar(50) not null
);
GO

EXEC sys.sp_cdc_enable_db;
GO

EXEC sys.sp_cdc_enable_table
@source_schema = N'dbo',
@source_name   = N'events',
@role_name     = N'cdc_role',
@filegroup_name = NULL,
@supports_net_changes = 0;
GO