USE tdcfloripa2024;
GO

insert into dbo.events (type) values (CONVERT(varchar(255), NEWID()) );
GO