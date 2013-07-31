CREATE DATABASE [eMDW]
 ON  PRIMARY 
( NAME = N'eMDW', FILENAME = N'D:\Microsoft SQL Server\MSSQL11.MSSQLSERVER\MSSQL\DATA\eMDW.mdf' , SIZE = 10MB , FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'eMDW_log', FILENAME = N'D:\Microsoft SQL Server\MSSQL11.MSSQLSERVER\MSSQL\DATA\eMDW_log.ldf' , SIZE = 5MB , FILEGROWTH = 10%)

Go

USE [eMDW]
GO

Print '*** Create eMDW Objects =======>>>>>>'
Go
/****** Object:  Schema [stage]    Script Date: 12/13/2010 11:31:00 ******/
CREATE SCHEMA [stage]
GO

create default [dbo].[rec_create_dt_dflt] as GETDATE()
GO

/****** Object:  Table [dbo].[DB_Server_Ref]    Script Date: 12/13/2010 11:31:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[DB_Server_Ref] (
    [SQLServerEdition]     CHAR (4)     NOT NULL,
    [SQLServerDescription] VARCHAR (50) NOT NULL,
    CONSTRAINT [PK_DB_Server_Ref] PRIMARY KEY CLUSTERED ([SQLServerEdition] ASC)
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[DB_RoleMembers]    Script Date: 12/13/2010 11:31:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DB_RoleMembers](
	[DBServerID] [smallint] NOT NULL,
	[DatabaseName] [nvarchar](260) NOT NULL,
	[UserName] [nvarchar](128) NULL,
	[GroupName] [nvarchar](128) NULL,
	[LoginName] [nvarchar](128) NULL,
	[DefDBName] [nvarchar](128) NULL,
	[UID] [int] NULL,
	[RoleID] [int] NULL,
	[UserType_Desc] [nvarchar](60) NULL,
	[RoleType_Desc] [nvarchar](60) NULL,
	[RecCreateDt] [smalldatetime] NOT NULL
) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [idx_LoginName] ON [dbo].[DB_RoleMembers] 
(
	[LoginName] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [idx_ServerID_DBName] ON [dbo].[DB_RoleMembers] 
(
	[DBServerID] ASC,
	[DatabaseName] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DB_RestoreLog]    Script Date: 12/13/2010 11:31:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[DB_RestoreLog](
	[DBServerID] [smallint] NOT NULL,
	[DatabaseName] [nvarchar](260) NOT NULL,
	[RestoredBy] [nvarchar](128) NULL,
	[RestoreType] [varchar](50) NULL,
	[RestoreStartDate] [smalldatetime] NULL,
	[RestoredFrom] [nvarchar](1024) NULL,
	[RestoredTo] [nvarchar](1024) NULL,
	[RecCreateDt] [smalldatetime] NULL
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[DB_Properties_Archive]    Script Date: 12/13/2010 11:31:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DB_Properties_Archive] (
    [DBServerID]                    SMALLINT        NOT NULL,
    [DatabaseName]                  NVARCHAR (260)  NOT NULL,
    [database_id]                   INT             NOT NULL,
    [OwnerName]                     [sysname]       NULL,
    [compatibility_level]           TINYINT         NOT NULL,
    [collation_name]                [sysname]       NULL,
    [user_access_desc]              NVARCHAR (60)   NOT NULL,
    [is_read_only]                  BIT             NOT NULL,
    [is_auto_close_on]              BIT             NOT NULL,
    [is_auto_shrink_on]             BIT             NOT NULL,
    [state_desc]                    NVARCHAR (60)   NOT NULL,
    [snapshot_isolation_state_desc] NVARCHAR (60)   NOT NULL,
    [recovery_model_desc]           NVARCHAR (60)   NOT NULL,
    [page_verify_option_desc]       NVARCHAR (60)   NOT NULL,
    [is_auto_create_stats_on]       BIT             NOT NULL,
    [is_auto_update_stats_on]       BIT             NOT NULL,
    [is_fulltext_enabled]           BIT             NOT NULL,
    [is_trustworthy_on]             BIT             NOT NULL,
    [is_db_chaining_on]             BIT             NOT NULL,
    [is_broker_enabled]             BIT             NOT NULL,
    [DBCreate_dt]                   SMALLDATETIME   NOT NULL,
    [replica_id]                    VARBINARY (128) NULL,
    [group_database_id]             VARBINARY (128) NULL,
    [RecCreateDt]                   SMALLDATETIME   NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DB_Properties]    Script Date: 12/13/2010 11:31:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DB_Properties] (
    [DBServerID]                    SMALLINT        NOT NULL,
    [DatabaseName]                  NVARCHAR (260)  NOT NULL,
    [database_id]                   INT             NOT NULL,
    [DBOwnerName]                   NVARCHAR (128)  NULL,
    [compatibility_level]           TINYINT         NOT NULL,
    [collation_name]                NVARCHAR (128)  NULL,
    [user_access_desc]              NVARCHAR (60)   NOT NULL,
    [is_read_only]                  BIT             NOT NULL,
    [is_auto_close_on]              BIT             NOT NULL,
    [is_auto_shrink_on]             BIT             NOT NULL,
    [state_desc]                    NVARCHAR (60)   NOT NULL,
    [snapshot_isolation_state_desc] NVARCHAR (60)   NOT NULL,
    [recovery_model_desc]           NVARCHAR (60)   NOT NULL,
    [page_verify_option_desc]       NVARCHAR (60)   NOT NULL,
    [is_auto_create_stats_on]       BIT             NOT NULL,
    [is_auto_update_stats_on]       BIT             NOT NULL,
    [is_fulltext_enabled]           BIT             NOT NULL,
    [is_trustworthy_on]             BIT             NOT NULL,
    [is_db_chaining_on]             BIT             NOT NULL,
    [is_broker_enabled]             BIT             NOT NULL,
    [DBCreate_dt]                   SMALLDATETIME   NOT NULL,
    [replica_id]                    VARBINARY (128) NULL,
    [group_database_id]             VARBINARY (128) NULL,
    [RecCreateDt]                   SMALLDATETIME   CONSTRAINT [DF_DB_Properties_RecCreateDt] DEFAULT (getdate()) NOT NULL,
    CONSTRAINT [PK_DB_Properties_1] PRIMARY KEY CLUSTERED ([DBServerID] ASC, [DatabaseName] ASC)
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DB_ObjectsPermission]    Script Date: 12/13/2010 11:31:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[DB_ObjectsPermission](
	[DBServerID] [smallint] NOT NULL,
	[DatabaseName] [nvarchar](260) NOT NULL,
	[ObjectName] [nvarchar](128) NOT NULL,
	[ObjectID] [int] NULL,
	[Grantee] [sysname] NOT NULL,
	[Grantor] [sysname] NOT NULL,
	[PermissionType] [nvarchar](128) NULL,
	[PermissionState] [nvarchar](60) NULL,
	[ObjectType] [nvarchar](60) NULL,
	[GranteeSID] [varbinary](85) NULL,
	[RecCreateDT] [smalldatetime] NULL
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
CREATE NONCLUSTERED INDEX [idx_DBName] ON [dbo].[DB_ObjectsPermission] 
(
	[DatabaseName] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [idx_DBServerID] ON [dbo].[DB_ObjectsPermission] 
(
	[DBServerID] ASC
)
INCLUDE ( [DatabaseName],
[ObjectName],
[ObjectType]) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [idx_Grantee] ON [dbo].[DB_ObjectsPermission] 
(
	[Grantee] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [idx_ObjectName] ON [dbo].[DB_ObjectsPermission] 
(
	[ObjectName] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
/****** Object:  Table [stage].[DB_Objects]    Script Date: 12/13/2010 11:31:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [stage].[DB_Objects](
	[ServerName] [nvarchar](128) NULL,
	[DBName] [nvarchar](260) NULL,
	[TableOwner] [nvarchar](128) NULL,
	[TableName] [nvarchar](128) NULL,
	[TableType] [varchar](20) NULL
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[DB_Objects]    Script Date: 12/13/2010 11:31:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DB_Objects](
	[DBServerID] [smallint] NULL,
	[DatabaseName] [nvarchar](260) NULL,
	[ObjectName] [sysname] NOT NULL,
	[Object_id] [int] NULL,
	[SchemaName] [sysname] NOT NULL,
	[SchemaOwner] [sysname] NOT NULL,
	[ObjectType] [nvarchar](60) NULL,
	[ObjectCreate_Date] [smalldatetime] NOT NULL,
	[ObjectModify_Date] [smalldatetime] NOT NULL,
	[RecCreateDt] [smalldatetime] NOT NULL
) ON [PRIMARY]
WITH
(
DATA_COMPRESSION = PAGE
)
GO
CREATE NONCLUSTERED INDEX [idx_DB_Object] ON [dbo].[DB_Objects] 
(
	[DatabaseName] ASC,
	[ObjectName] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [idx_DBServerID] ON [dbo].[DB_Objects] 
(
	[DBServerID] ASC
)
INCLUDE ( [DatabaseName],
[ObjectName],
[ObjectType]) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [idx_object] ON [dbo].[DB_Objects] 
(
	[ObjectName] ASC
)
INCLUDE ( [SchemaName],
[SchemaOwner],
[ObjectType]) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DB_LinkedServer_Data]    Script Date: 12/13/2010 11:31:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DB_LinkedServer_Data](
	[DBServerID] [int] NOT NULL,
	[SourceServer] [nvarchar](128) NOT NULL,
	[LinkedServerName] [nvarchar](128) NOT NULL,
	[LinkedServerProvider] [nvarchar](128) NOT NULL,
	[TargetServer] [nvarchar](4000) NOT NULL,
	[LoginName] [nvarchar](128) NULL,
	[RemoteLogin] [nvarchar](128) NULL,
	[RecCreateDt] [smalldatetime] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [stage].[DB_ImportedDBs]    Script Date: 12/13/2010 11:31:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [stage].[DB_ImportedDBs](
	[DBServerID] [smallint] NOT NULL,
	[DBName] [nvarchar](260) NOT NULL,
	[DBID] [int] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DB_FileData_Archive]    Script Date: 12/13/2010 11:31:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DB_FileData_Archive](
	[DBServerID] [smallint] NOT NULL,
	[DatabaseName] [nvarchar](260) NOT NULL,
	[DatabaseFileID] [int] NOT NULL,
	[FileType] [nvarchar](60) NULL,
	[LogicalName] [nvarchar](128) NULL,
	[FileGroup] [nvarchar](128) NULL,
	[PhysicalLocation] [nvarchar](260) NULL,
	[FileState] [nvarchar](60) NULL,
	[FileSizeMB] [decimal](18, 2) NULL,
	[FileGrowthMB] [decimal](18, 2) NULL,
	[FileGrowthPercent] [smallint] NULL,
	[RecCreateDt] [smalldatetime] NOT NULL
) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [idx_CreateDt] ON [dbo].[DB_FileData_Archive] 
(
	[RecCreateDt] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [idx_SrvID_DBName] ON [dbo].[DB_FileData_Archive] 
(
	[DBServerID] ASC,
	[DatabaseName] ASC
)
INCLUDE ( [FileSizeMB]) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DB_SizeDataArchive]    Script Date: 12/13/2010 11:31:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DB_SizeDataArchive](
	[DBServerID] [smallint] NOT NULL,
	[DatabaseName] [nvarchar](260) NOT NULL,
	[TotalDBSizeMB] [decimal](18, 4) NULL,
	[DBUsedMB] [decimal](18, 4) NULL,
	[DBFreeSpaceMB] [decimal](18, 4) NULL,
	[DataFileSizeMB] [decimal](18, 4) NULL,
	[LogFileSizeMB] [decimal](18, 4) NULL,
	[DataSizeMB] [decimal](18, 4) NULL,
	[IndexSizeMB] [decimal](18, 4) NULL,
	[RecCreateDt] [smalldatetime] NOT NULL
) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [idx_serverID_dbname_dt] ON [dbo].[DB_SizeDataArchive] 
(
	[DBServerID] ASC,
	[DatabaseName] ASC,
	[RecCreateDt] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DB_ServerDisk_Data]    Script Date: 12/13/2010 11:31:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[DB_ServerDisk_Data](
	[ServerName] [varchar](50) NOT NULL,
	[BlockSize] [int] NULL,
	[DiskSizeMB] [bigint] NULL,
	[Caption] [varchar](200) NULL,
	[Compressed] [varchar](10) NULL,
	[DriveLetter] [char](3) NULL,
	[FileSystem] [char](5) NULL,
	[FreeSpaceMB] [bigint] NULL,
	[DiskLabel] [varchar](200) NULL,
	[MaxFileNameLength] [int] NULL,
	[DriveName] [varchar](50) NULL,
	[FreeSpacePercent] [real] NULL,
	[RecCreateDt] [smalldatetime] NULL
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[DB_ServerData_Archive]    Script Date: 12/13/2010 11:31:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[DB_ServerData_Archive](
	[DBServerID] [smallint] NOT NULL,
	[ComputerNetBIOS] [nvarchar](128) NULL,
	[SQLServerName] [nvarchar](128) NOT NULL,
	[MachineName] [nvarchar](128) NOT NULL,
	[InstanceName] [nvarchar](128) NULL,
	[SQLVersion] [tinyint] NULL,
	[Edition] [nvarchar](128) NULL,
	[EngineEdition] [varchar](50) NULL,
	[ProductVersion] [nvarchar](128) NULL,
	[ProductLevel] [nvarchar](50) NULL,
	[TcpPort] [nvarchar](50) NULL,
	[SQLServiceAccount] [nvarchar](50) NULL,
	[IsClustered] [varchar](10) NULL,
	[IsFullTextInstalled] [varchar](10) NULL,
	[IsIntegratedSecurityOnly] [varchar](10) NULL,
	[IsSingleUser] [varchar](10) NULL,
	[LicenseType] [nvarchar](20) NULL,
	[FilestreamShareName] [nvarchar](255) NULL,
	[ResourceLastUpdateDateTime] [smalldatetime] NULL,
	[ResourceDBVersion] [nvarchar](128) NULL,
	[Collation] [nvarchar](128) NULL,
	[CPU_Count] [int] NULL,
	[Hyperthread_Ratio] [int] NULL,
	[Physical_memory_MB] [int] NULL,
	[SQLServer_StartTime] [smalldatetime] NULL,
	[RecCreateDt] [smalldatetime] NULL
) ON [PRIMARY]
GO

/****** Object:  Table [dbo].[ExecutionLog_hist]    Script Date: 12/13/2010 11:31:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[ExecutionLog_hist](
	[LogID] [int] NOT NULL,
	[ParentLogID] [int] NULL,
	[Description] [varchar](50) NULL,
	[PackageName] [varchar](50) NOT NULL,
	[PackageGuid] [uniqueidentifier] NOT NULL,
	[MachineName] [varchar](50) NOT NULL,
	[ExecutionGuid] [uniqueidentifier] NOT NULL,
	[LogicalDate] [datetime] NOT NULL,
	[Operator] [varchar](50) NOT NULL,
	[StartTime] [datetime] NOT NULL,
	[EndTime] [datetime] NULL,
	[Status] [tinyint] NOT NULL,
	[FailureTask] [varchar](64) NULL
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[ExecutionLog]    Script Date: 12/13/2010 11:31:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[ExecutionLog](
	[LogID] [int] IDENTITY(1,1) NOT NULL,
	[ParentLogID] [int] NULL,
	[Description] [varchar](50) NULL,
	[PackageName] [varchar](50) NOT NULL,
	[PackageGuid] [uniqueidentifier] NOT NULL,
	[MachineName] [varchar](50) NOT NULL,
	[ExecutionGuid] [uniqueidentifier] NOT NULL,
	[LogicalDate] [datetime] NOT NULL,
	[Operator] [varchar](50) NOT NULL,
	[StartTime] [datetime] NOT NULL,
	[EndTime] [datetime] NULL,
	[Status] [tinyint] NOT NULL,
	[FailureTask] [varchar](64) NULL
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[ErrorEvent]    Script Date: 12/13/2010 11:31:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[ErrorEvent](
	[ErrorID] [int] IDENTITY(1,1) NOT NULL,
	[ServerName] [nvarchar](128) NULL,
	[DatabaseName] [nvarchar](128) NULL,
	[TaskName] [varchar](512) NULL,
	[ErrorCode] [int] NULL,
	[ErrorColumn] [int] NULL,
	[ErrorMsg] [varchar](4096) NULL,
	[RecCreateDt] [smalldatetime] NOT NULL
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[DB_TableSize_Archive]    Script Date: 12/13/2010 11:31:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DB_TableSize_Archive](
	[DBServerID] [tinyint] NOT NULL,
	[DatabaseName] [nvarchar](260) NOT NULL,
	[SchemaName] [nvarchar](128) NOT NULL,
	[TableName] [nvarchar](260) NOT NULL,
	[Row_Count] [int] NOT NULL,
	[ReservedSpaceKB] [decimal](18, 4) NOT NULL,
	[DataSizeKB] [decimal](18, 4) NOT NULL,
	[IndexSizeKB] [decimal](18, 4) NOT NULL,
	[UnusedSpaceKB] [decimal](18, 4) NOT NULL,
	[RecCreateDt] [smalldatetime] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DB_TableSize]    Script Date: 12/13/2010 11:31:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DB_TableSize](
	[DBServerID] [tinyint] NOT NULL,
	[DatabaseName] [nvarchar](260) NOT NULL,
	[SchemaName] [nvarchar](128) NOT NULL,
	[TableName] [nvarchar](260) NOT NULL,
	[Row_Count] [int] NOT NULL,
	[ReservedSpaceKB] [decimal](18, 4) NOT NULL,
	[DataSizeKB] [decimal](18, 4) NOT NULL,
	[IndexSizeKB] [decimal](18, 4) NOT NULL,
	[UnusedSpaceKB] [decimal](18, 4) NOT NULL,
	[RecCreateDt] [smalldatetime] NOT NULL
) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [idx_serverid_dbname] ON [dbo].[DB_TableSize] 
(
	[DBServerID] ASC,
	[DatabaseName] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [idx_TableName] ON [dbo].[DB_TableSize] 
(
	[TableName] ASC
)
INCLUDE ( [DBServerID],
[DatabaseName]) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DB_SQLUserLoginArchive]    Script Date: 12/13/2010 11:31:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[DB_SQLUserLoginArchive](
	[DBServerID] [smallint] NOT NULL,
	[Status] [smallint] NULL,
	[UserName] [sysname] NULL,
	[DBName] [sysname] NULL,
	[UserPassword] [varbinary](255) NULL,
	[language] [sysname] NULL,
	[SID] [varbinary](85) NULL,
	[DenyLogin] [smallint] NULL,
	[HasAccess] [smallint] NULL,
	[isNTname] [smallint] NULL,
	[isNTgroup] [smallint] NULL,
	[isNTuser] [smallint] NULL,
	[SysAdmin] [smallint] NULL,
	[SecurityAdmin] [smallint] NULL,
	[ServerAdmin] [smallint] NULL,
	[SetupAdmin] [smallint] NULL,
	[ProcessAdmin] [smallint] NULL,
	[DiskAdmin] [smallint] NULL,
	[DBCreator] [smallint] NULL,
	[BulkAdmin] [smallint] NULL,
	[XStatus] [smallint] NULL,
	[CreateDt] [smalldatetime] NULL,
	[UpdateDt] [smalldatetime] NULL,
	[RecCreateDt] [smalldatetime] NULL
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  UserDefinedFunction [dbo].[ParsePipeline]    Script Date: 12/13/2010 11:31:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create function [dbo].[ParsePipeline] (@message varchar(8000), @which int)
--should be created in the DB with desired sysdtslog90 table
returns varchar(200)
as begin
	--@which defines which value is desired 
	-- 1= PathID
	-- 2= declare PathIDName
	-- 3= declare ComponentID
	-- 4= declare ComponentIDName
	-- 5= declare InputID
	-- 6= declare InputIDName
	-- 7= declare rowssent

	declare @sourcemessage varchar(600)	
	declare @where as integer
	declare @mycounter integer

	If @which < 1 or @which > 7 return null
	set @mycounter=0
	--catch older versions of the messages that lacked the extra parameters
	if patindex('%:  :%', @message) = 0 return null
	
	--chop the initial wordy stuff out
	set @sourcemessage = right(@message, len(@message) - patindex('%:  :%', @message) - 3)

	--loop through occurances of : until we get to the desired one
	set @where = 99
	while @where <> 0 begin
		set @mycounter = @mycounter+1
		set @where = patindex('%:%',@sourcemessage)
		If @mycounter = 7 return @sourcemessage
		if @mycounter = @which return(left(@sourcemessage, @where - 1))
		set	@sourcemessage = right(@sourcemessage, (len(@sourcemessage) - @where))	
	end --while
	
	--should not execute this but a return is required as the last statement
	return @sourcemessage
end --function
GO

/****** Object:  Table [dbo].[DB_Features]    Script Date: 12/13/2010 11:31:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[DB_Features](
	[DBServerID] [int] NOT NULL,
	[Databasename] [nvarchar](260) NOT NULL,
	[DBFeature] [varchar](50) NOT NULL,
	[ReCreateDt] [smalldatetime] NOT NULL
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [stage].[DB_BackupSets]    Script Date: 12/13/2010 11:31:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [stage].[DB_BackupSets](
	[DBServerID] [smallint] NOT NULL,
	[Backup_Set_Id] [int] NOT NULL,
	[Server_Name] [nvarchar](128) NULL,
	[database_name] [nvarchar](260) NULL,
	[type] [char](1) NULL,
	[backup_start_date] [datetime2](3) NULL,
	[backup_finish_date] [datetime2](3) NULL,
	[backup_size] [decimal](20, 0) NULL,
	[BackupPhysicalFile] [nvarchar](260) NULL,
	[BackupSoftware] [nvarchar](256) NULL
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[DB_BackupData_Archive]    Script Date: 12/13/2010 11:31:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[DB_BackupData_Archive](
	[DBServerID] [smallint] NOT NULL,
	[DatabaseName] [varchar](260) NOT NULL,
	[BackupSetId] [int] NULL,
	[BackupStartDate] [smalldatetime] NULL,
	[BackupEndDate] [smalldatetime] NULL,
	[BackupSizeMB] [decimal](18, 2) NULL,
	[BackupType] [char](6) NULL,
	[backupPhysicalFile] [nvarchar](260) NULL,
	[Status] [varchar](20) NULL,
	[Comment] [varchar](50) NULL,
	[BackupSoftware] [varchar](256) NULL,
	[RecCreateDt] [smalldatetime] NULL
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[CMS_RegisteredServers]    Script Date: 12/13/2010 11:31:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CMS_RegisteredServers](
	[server_id] [int] NOT NULL,
	[server_group_id] [int] NULL,
	[GroupName] [sysname] NOT NULL,
	[ServerName] [sysname] NULL,
	[description] [nvarchar](2048) NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ClassRef]    Script Date: 12/13/2010 11:31:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[ClassRef](
	[ClassID] [char](4) NOT NULL,
	[ClassName] [varchar](30) NOT NULL,
	[Availability] [char](15) NULL,
	[AvailabilityRatio] [char](10) NULL,
	[PlanDownTime] [varchar](50) NULL,
	[AdvNotice] [varchar](50) NULL,
	[UnplanDownTime] [varchar](50) NULL,
	[RTO] [varchar](50) NULL,
	[RTOExternal] [varchar](50) NULL,
	[RecoveryPointObj] [varchar](50) NULL,
	[ClassDesc] [varchar](4000) NULL
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[DB_ServerPrincipalRole]    Script Date: 12/13/2010 11:31:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DB_ServerPrincipalRole](
	[DBServerID] [smallint] NOT NULL,
	[ServerPrincipal] [nvarchar](128) NOT NULL,
	[ServerRole] [nvarchar](128) NOT NULL,
	[ServerPrincipalType] [nvarchar](128) NULL,
	[RecCreateDt] [smalldatetime] NOT NULL
) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [idx_ServerID_Principal] ON [dbo].[DB_ServerPrincipalRole] 
(
	[DBServerID] ASC,
	[ServerPrincipal] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DB_ServerPermissions]    Script Date: 12/13/2010 11:31:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DB_ServerPermissions](
	[DBServerID] [tinyint] NOT NULL,
	[ServerPrincipal] [nvarchar](128) NOT NULL,
	[PrincipalType] [nvarchar](60) NULL,
	[PermissionName] [nvarchar](128) NULL,
	[PermissionState] [nvarchar](60) NULL,
	[RecCreateDt] [smalldatetime] NULL
) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [idx_serverID_principalName] ON [dbo].[DB_ServerPermissions] 
(
	[DBServerID] ASC,
	[ServerPrincipal] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DB_ServerMain_Archive]    Script Date: 12/13/2010 11:31:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[DB_ServerMain_Archive](
	[DBServerID] [smallint] IDENTITY(1,1) NOT NULL,
	[ServerName] [varchar](128) NOT NULL,
	[ServerAlias] [varchar](50) NULL,
	[ServerClass] [char](5) NULL,
	[ServerClusterName] [varchar](50) NULL,
	[ServerDescr] [varchar](200) NULL,
	[Version] [int] NULL,
	[ProdFlag] [char](1) NULL,
	[ActiveFlag] [char](1) NOT NULL,
	[ActiveFlagDt] [smalldatetime] NOT NULL,
	[DMVCollectionFlag] [char](1) NULL,
	[RecCreateDt] [smalldatetime] NOT NULL,
	[InActiveDt] [smalldatetime] NULL
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[DB_ServerMain]    Script Date: 12/13/2010 11:31:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[DB_ServerMain](
	[DBServerID] [smallint] IDENTITY(1,1) NOT NULL,
	[ServerName] [varchar](128) NOT NULL,
	[ServerAlias] [varchar](50) NULL,
	[ServerClass] [char](5) NULL,
	[ServerClusterName] [varchar](50) NULL,
	[ServerDescr] [varchar](200) NULL,
	[Version] [int] NULL,
	[ProdFlag] [char](1) NULL,
	[ActiveFlag] [char](1) NOT NULL,
	[ActiveFlagDt] [smalldatetime] NOT NULL,
	[DMVCollectionFlag] [char](1) NOT NULL,
	[RecCreateDt] [smalldatetime] NOT NULL,
	[InActiveDt] [smalldatetime] NULL,
 CONSTRAINT [PK_DBServerID] PRIMARY KEY CLUSTERED 
(
	[DBServerID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
CREATE UNIQUE NONCLUSTERED INDEX [IX_ServerName] ON [dbo].[DB_ServerMain] 
(
	[ServerName] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DB_ServerLogins_Archive]    Script Date: 12/13/2010 11:31:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[DB_ServerLogins_Archive](
	[DBServerID] [smallint] NOT NULL,
	[LoginName] [sysname] NOT NULL,
	[Principal_ID] [int] NULL,
	[sid] [varbinary](85) NULL,
	[Password_Hash] [varbinary](256) NULL,
	[Default_DBName] [sysname] NULL,
	[Default_Language] [sysname] NULL,
	[Type] [char](1) NOT NULL,
	[Type_Desc] [nvarchar](60) NULL,
	[is_Disabled] [bit] NULL,
	[is_Policy_Checked] [bit] NULL,
	[is_Expiration_Checked] [bit] NULL,
	[Create_Date] [datetime] NOT NULL,
	[Modify_Date] [datetime] NOT NULL,
	[RecCreateDt] [smalldatetime] NOT NULL
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[DB_ServerLogins]    Script Date: 12/13/2010 11:31:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[DB_ServerLogins](
	[DBServerID] [smallint] NOT NULL,
	[LoginName] [sysname] NOT NULL,
	[Principal_ID] [int] NULL,
	[sid] [varbinary](85) NULL,
	[Password_Hash] [varbinary](256) NULL,
	[Default_DBName] [sysname] NULL,
	[Default_Language] [sysname] NULL,
	[Type] [char](1) NOT NULL,
	[Type_Desc] [nvarchar](60) NULL,
	[is_Disabled] [bit] NULL,
	[is_Policy_Checked] [bit] NULL,
	[is_Expiration_Checked] [bit] NULL,
	[Create_Date] [datetime] NOT NULL,
	[Modify_Date] [datetime] NOT NULL,
	[RecCreateDt] [smalldatetime] NOT NULL,
 CONSTRAINT [PK_DB_ServerLogins] PRIMARY KEY CLUSTERED 
(
	[DBServerID] ASC,
	[LoginName] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[DB_ServerIP_Data]    Script Date: 12/13/2010 11:31:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[DB_ServerIP_Data](
	[Host] [varchar](128) NULL,
	[IPAddress] [varchar](20) NULL,
	[RecCreateDt] [smalldatetime] NULL
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[sysssislog_hist]    Script Date: 12/13/2010 11:31:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[sysssislog_hist](
	[id] [int] NOT NULL,
	[event] [sysname] NOT NULL,
	[computer] [nvarchar](128) NOT NULL,
	[operator] [nvarchar](128) NOT NULL,
	[source] [nvarchar](1024) NOT NULL,
	[sourceid] [uniqueidentifier] NOT NULL,
	[executionid] [uniqueidentifier] NOT NULL,
	[starttime] [datetime] NOT NULL,
	[endtime] [datetime] NOT NULL,
	[datacode] [int] NOT NULL,
	[databytes] [image] NULL,
	[message] [nvarchar](2048) NOT NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[sysssislog]    Script Date: 12/13/2010 11:31:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[sysssislog](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[event] [sysname] NOT NULL,
	[computer] [nvarchar](128) NOT NULL,
	[operator] [nvarchar](128) NOT NULL,
	[source] [nvarchar](1024) NOT NULL,
	[sourceid] [uniqueidentifier] NOT NULL,
	[executionid] [uniqueidentifier] NOT NULL,
	[starttime] [datetime] NOT NULL,
	[endtime] [datetime] NOT NULL,
	[datacode] [int] NOT NULL,
	[databytes] [image] NULL,
	[message] [nvarchar](2048) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [idx_sysssislog_executionid] ON [dbo].[sysssislog] 
(
	[executionid] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[sysdtslog90_hist]    Script Date: 12/13/2010 11:31:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[sysdtslog90_hist](
	[id] [int] NOT NULL,
	[event] [nvarchar](128) NOT NULL,
	[computer] [nvarchar](128) NOT NULL,
	[operator] [nvarchar](128) NOT NULL,
	[source] [nvarchar](1024) NOT NULL,
	[sourceid] [uniqueidentifier] NOT NULL,
	[executionid] [uniqueidentifier] NOT NULL,
	[starttime] [datetime] NOT NULL,
	[endtime] [datetime] NOT NULL,
	[datacode] [int] NOT NULL,
	[databytes] [image] NULL,
	[message] [nvarchar](2048) NOT NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[sysdtslog90]    Script Date: 12/13/2010 11:31:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[sysdtslog90](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[event] [nvarchar](128) NOT NULL,
	[computer] [nvarchar](128) NOT NULL,
	[operator] [nvarchar](128) NOT NULL,
	[source] [nvarchar](1024) NOT NULL,
	[sourceid] [uniqueidentifier] NOT NULL,
	[executionid] [uniqueidentifier] NOT NULL,
	[starttime] [datetime] NOT NULL,
	[endtime] [datetime] NOT NULL,
	[datacode] [int] NOT NULL,
	[databytes] [image] NULL,
	[message] [nvarchar](2048) NOT NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO

/****** Object:  Table [dbo].[SQL_Instance_Mapping]    Script Date: 12/13/2010 11:31:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[SQL_Instance_Mapping](
	[SQL_Instance] [varchar](30) NULL,
	[SQL_Alias] [varchar](30) NULL
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  StoredProcedure [dbo].[spHexadecimal]    Script Date: 12/13/2010 11:31:03 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[spHexadecimal]
    @binvalue varbinary(256),
    @hexvalue varchar(256) OUTPUT
AS
DECLARE @charvalue varchar(255)
DECLARE @i int
DECLARE @length int
DECLARE @hexstring char(16)
SELECT @charvalue = '0x'
SELECT @i = 1
SELECT @length = DATALENGTH (@binvalue)
SELECT @hexstring = '0123456789ABCDEF'
WHILE (@i <= @length)
BEGIN
  DECLARE @tempint int
  DECLARE @firstint int
  DECLARE @secondint int
  SELECT @tempint = CONVERT(int, SUBSTRING(@binvalue,@i,1))
  SELECT @firstint = FLOOR(@tempint/16)
  SELECT @secondint = @tempint - (@firstint*16)
  SELECT @charvalue = @charvalue +
    SUBSTRING(@hexstring, @firstint+1, 1) +
    SUBSTRING(@hexstring, @secondint+1, 1)
  SELECT @i = @i + 1
END
SELECT @hexvalue = @charvalue
GO
/****** Object:  StoredProcedure [dbo].[up_Event_Package_OnError]    Script Date: 12/13/2010 11:31:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[up_Event_Package_OnError]
	 @logID		int
	,@message	varchar(64) = null	--optional, for custom failures
with execute as caller
as
/**********************************************************************************************************
* SP Name:
*		dbo.up_Event_Package_OnError
* Parameters:
*		 @logID		int
*		,@message	varchar(64) = null	--optional, for custom failures
*  
* Purpose:	This stored procedure logs an error entry in the custom event-log table.
*	Status = 0: Running (Incomplete)
*	Status = 1: Complete
*	Status = 2: Failed
*              
* Example:
		exec dbo.up_Event_Package_OnError 1, 'Failed'
		select * from dbo.ExecutionLog where LogID = 1
*              

*
**********************************************************************************************************/
begin
	set nocount on
	
	declare
		 @failureTask		varchar(64)
		,@packageName		varchar(64)
		,@executionGuid		uniqueidentifier
		,@count				int

	if @message is null begin
		select 
			 @packageName = upper(PackageName)
			,@executionGuid = ExecutionGuid
		from dbo.ExecutionLog
		where LogID = @logID


		select @count = count(*) from sysssislog
		where sysssislog.executionid = @executionGuid

		if @count >=1
			begin
				select top 1 @failureTask = source
				from dbo.sysssislog
				where executionid = @executionGuid
				and (upper(event) = 'ONERROR')
				and upper(source) <> @packageName
				order by endtime desc
			end
		else
			begin
				select top 1 @failureTask = source
				from dbo.sysdtslog90
				where executionid = @executionGuid
				and (upper(event) = 'ONERROR')
				and upper(source) <> @packageName
				order by endtime desc
			end

	end else begin
		set @failureTask = @message
	end --if

	update dbo.ExecutionLog set
		 EndTime = getdate()
		,Status = 2	--Failed
		,FailureTask = @failureTask
	where
		LogID = @logID

	set nocount off
end --proc
GO
/****** Object:  StoredProcedure [dbo].[up_Event_Package_OnEnd]    Script Date: 12/13/2010 11:31:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[up_Event_Package_OnEnd]
	 @logID				int
with execute as caller
as
/**********************************************************************************************************
* SP Name:
*		dbo.up_Event_Package_OnEnd
* Parameters:
*		@logID			int
*  
* Purpose:	This stored procedure updates an existing entry in the custom event-log table. It flags the
*	execution run as complete.
*	Status = 0: Running (Incomplete)
*	Status = 1: Complete
*	Status = 2: Failed
*              
* Example:
		declare @logID int
		set @logID = 0
		exec dbo.up_Event_Package_OnEnd @logID
		select * from dbo.ExecutionLog where LogID = @logID
*              

*
**********************************************************************************************************/
begin
	set nocount on

	update dbo.ExecutionLog set
		 EndTime = getdate() --Note: This should NOT be @logicalDate
		,Status = case
			when Status = 0 then 1	--Complete
			else Status
		end --case
	where 
		LogID = @logID

	set nocount off
end --proc
GO
/****** Object:  StoredProcedure [dbo].[up_Event_Package_OnBegin]    Script Date: 12/13/2010 11:31:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[up_Event_Package_OnBegin]
	 @ParentLogID		int
	,@Description		varchar(50) = null
	,@PackageName		varchar(50)
	,@PackageGuid		uniqueidentifier
	,@MachineName		varchar(50)
	,@ExecutionGuid		uniqueidentifier
	--,@logicalDate		datetime
	,@operator			varchar(30)
	,@logID				int = null output
with execute as caller
as
/**********************************************************************************************************
* SP Name:
*		dbo.up_Event_Package_OnBegin
* Parameters:
*		 @ParentLogID		int
*		,@Description		varchar(50) = null
*		,@PackageName		varchar(50)
*		,@PackageGuid		uniqueidentifier
*		,@MachineName		varchar(50)
*		,@ExecutionGuid		uniqueidentifier
*		,@logicalDate		datetime
*		,@operator			varchar(30)
*		,@logID				int = null output
*  
* Purpose:	This stored procedure logs a starting event to the custom event-log table
*              
* Example:
		declare @logID int
		exec dbo.up_Event_Package_OnBegin 
			 0, 'Description'
			,'PackageName' ,'00000000-0000-0000-0000-000000000000'
			,'MachineName', '00000000-0000-0000-0000-000000000000'
			,'2004-01-01', null, @logID output
		select * from dbo.ExecutionLog where LogID = @logID
*              

**********************************************************************************************************/
begin
	set nocount on

	--Coalesce @logicalDate
	--set @logicalDate = isnull(@logicalDate, getdate())

	--Coalesce @operator
	set @operator = nullif(ltrim(rtrim(@operator)), '')
	set @operator = isnull(@operator, suser_sname())

	--Root-level nodes should have a null parent
	if @ParentLogID <= 0 set @ParentLogID = null

	--Root-level nodes should not have a null Description
	set @Description = nullif(ltrim(rtrim(@Description)), '')
	if @Description is null and @ParentLogID is null set @Description = @PackageName

	--Insert the log record
	insert into dbo.ExecutionLog(
		 ParentLogID
		,Description
		,PackageName
		,PackageGuid
		,MachineName
		,ExecutionGuid
		,LogicalDate
		,Operator
		,StartTime
		,EndTime
		,Status
		,FailureTask
	) values (
		 @ParentLogID
		,@Description
		,@PackageName
		,@PackageGuid
		,@MachineName
		,@ExecutionGuid
		,getdate() --,@logicalDate
		,@operator
		,getdate() --Note: This should NOT be @logicalDate
		,null
		,0	--InProcess
		,null
	)
	set @logID = scope_identity()

	set nocount off
end --proc
GO

/****** Object:  View [dbo].[vwOnPipelineRowsSent]    Script Date: 12/13/2010 11:31:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE view [dbo].[vwOnPipelineRowsSent] 
--should be created in the DB with desired sysdtslog90 table
as
	select
		 source
		,sourceid
		,executionid
		,dbo.ParsePipeline([message], 1) as PathID
		,dbo.ParsePipeline([message], 2) as PathIDName
		,dbo.ParsePipeline([message], 3) as ComponentID
		,dbo.ParsePipeline([message], 4) as ComponentIDName
		,dbo.ParsePipeline([message], 5) as InputID
		,dbo.ParsePipeline([message], 6) as InputIDName
		,convert(int, dbo.ParsePipeline([message], 7)) as RowsSent
		,StartTime
	from dbo.sysdtslog90
	where [event] like 'onpipelinerowssent%'
	union
	select
		 source
		,sourceid
		,executionid
		,dbo.ParsePipeline([message], 1) as PathID
		,dbo.ParsePipeline([message], 2) as PathIDName
		,dbo.ParsePipeline([message], 3) as ComponentID
		,dbo.ParsePipeline([message], 4) as ComponentIDName
		,dbo.ParsePipeline([message], 5) as InputID
		,dbo.ParsePipeline([message], 6) as InputIDName
		,convert(int, dbo.ParsePipeline([message], 7)) as RowsSent
		,StartTime
	from dbo.sysssislog
	where [event] like 'onpipelinerowssent%'
GO
/****** Object:  StoredProcedure [dbo].[spGenSQLLoginScript]    Script Date: 12/13/2010 11:31:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE Proc [dbo].[spGenSQLLoginScript] 
	    @SRVName varchar(50)

AS

DECLARE   
          @UsrNm varchar(255),
          @DBNm sysname,
          @SID1 varbinary(85),
          @Lang varchar(50),
          @NTnm char(1),
          @txtpwd sysname,
          @txtsid varchar(256),
          @binpwd varbinary(256),
          @tmpstr varchar(500),
          @xstatus int

Set nocount on

Create Table ##Temp (Txt varchar(8000))

--Create a Cursor to list to SQL Server in ServerRef table
Declare Usr cursor scroll for
Select LoginName, Default_DBName, Password_Hash, SID, Default_Language, Type 
From DB_ServerLogins l Join  dbo.DB_ServerMain s ON l.DBServerID = s.DBServerID
Where s.Servername = @SRVName AND LoginName <> 'sa'
Order by LoginName

Open Usr
fetch next from Usr into @UsrNm, @DBNm, @binpwd, @SID1, @Lang, @NTnm

While @@fetch_status = 0
BEGIN
  Insert ##Temp (txt) Values ('')
--  Print ''
  Insert ##Temp (txt) Values ('-- Add User : '+@Usrnm)
--  Print '-- Add User : '+@Usrnm
--  Print ''
  Insert ##Temp (txt) Values ('')

  Insert ##Temp (txt) Values ('DECLARE @pwd sysname')
--  PRINT 'DECLARE @pwd sysname'
--  PRINT 'DECLARE @SID1 sysname'
--  PRINT ''

  If @NTnm <> 'S'
   Begin
      Insert ##Temp (txt) Values ('EXEC master..sp_grantlogin '''+ @UsrNm + '''')
--      Print 'EXEC master..sp_grantlogin '''+ @UsrNm + ''''
      Insert ##Temp (txt) Values ('EXEC sp_defaultdb '''+ @UsrNm +''', '''+ @DBNm +'''')  
--      Print 'EXEC sp_defaultdb '''+ @UsrNm +''', '''+ @DBNm +''''
   End
  Else
   Begin
      EXEC spHexadecimal @binpwd, @txtpwd OUT 
      Exec spHexadecimal @SID1, @txtsid OUT 
      SET @tmpstr = 'SET @pwd = CONVERT (varbinary(255), ' + @txtpwd + ')'
      Insert ##Temp (txt) Values (@tmpstr)

--      PRINT @tmpstr 

      SET @tmpstr = 'EXEC sp_addlogin '''+ @Usrnm +''', @pwd, '''+ @DBNm +''', '''+ @Lang +''', @SID='+@txtSID+', @encryptopt = ''skip_encryption'''
      Insert ##Temp (txt) Values (@tmpstr)
--      Print @tmpstr 
   
  End   

  SET @tmpstr = 'Go'
--   Print @tmpstr 
   Insert ##Temp (txt) Values (@tmpstr)

   fetch next from Usr into @UsrNm, @DBNm, @binpwd, @SID1, @Lang, @NTnm
 
End

Select * from ##temp
set nocount off
Close Usr
Deallocate Usr
drop table ##temp

Return
GO
/****** Object:  StoredProcedure [dbo].[spDBGrowthRate]    Script Date: 12/13/2010 11:31:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create procedure [dbo].[spDBGrowthRate] AS

Select DB_ServerMain.ServerName, DB_SizeDataArchive.DatabaseName,MIN(DB_SizeDataArchive.TotalDBSizeMB) AS MinSize, 
MAX(DB_SizeDataArchive.TotalDBSizeMB) AS MaxSize,
ISNULL((MAX(DB_SizeDataArchive.TotalDBSizeMB) - MIN(DB_SizeDataArchive.TotalDBSizeMB)),0) AS DBGrowthMB, 
COUNT(month(DB_SizeDataArchive.RecCreateDt)) AS DBGrowthLast_n_Month,
ISNULL((MAX(DB_SizeDataArchive.TotalDBSizeMB) - MIN(DB_SizeDataArchive.TotalDBSizeMB)),0)+ MAX(DB_SizeDataArchive.TotalDBSizeMB) AS DBFutureGrowthMB,
COUNT(month(DB_SizeDataArchive.RecCreateDt)) AS DBGrowNext_n_Month

From DB_SizeDataArchive INNER JOIN
                      DB_ServerMain ON DB_SizeDataArchive.DBServerID = DB_ServerMain.DBServerID
Group By DB_ServerMain.ServerName, DB_SizeDataArchive.DatabaseName, YEAR(DB_SizeDataArchive.RecCreateDt)
GO
/****** Object:  UserDefinedFunction [dbo].[uf_GetExecutionLogRoot]    Script Date: 12/13/2010 11:31:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE function [dbo].[uf_GetExecutionLogRoot](@logID int)
returns int
with returns null on null input,
execute as caller
as
/**********************************************************************************************************
* UDF Name:		
*		part.uf_GetDatabaseIsPartitioned
* Parameters:
*
* Purpose: This function returns the root of the execution log tree that the specified 
*	node belongs to.
*
* Example:
	select dbo.uf_GetExecutionLogRoot(3)
*              
*
**********************************************************************************************************/
begin
	declare @rootID int

	--Derive result using a CTE as the table is self-referencing
	;with graph as (
		--select the anchor (specified) node
		select LogID, ParentLogID from dbo.ExecutionLog where LogID = @logID
		union all
		--select the parent node
		select node.LogID, node.ParentLogID from dbo.ExecutionLog as node
		inner join graph as leaf on (node.LogID = leaf.ParentLogID)
	)
	select @rootID = LogID from graph where ParentLogID is null
	
	--Return result
	return isnull(@rootID, @logID)
end --function
GO
/****** Object:  StoredProcedure [dbo].[spUserLookup]    Script Date: 12/13/2010 11:31:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[spUserLookup] @user varchar(128)
AS

Set @user = '%'+@user+'%'

SELECT     DB_ServerMain.ServerName, DB_RoleMembers.DatabaseName, DB_RoleMembers.GroupName, DB_RoleMembers.UserName, 
                      DB_RoleMembers.LoginName, DB_RoleMembers.UserType_Desc
FROM         DB_RoleMembers INNER JOIN
                      DB_ServerMain ON DB_RoleMembers.DBServerID = DB_ServerMain.DBServerID
WHERE     (DB_RoleMembers.LoginName LIKE @user) 
UNION ALL
SELECT     s.ServerName, 'master' AS Expr1, p.ServerRole, p.ServerPrincipal, p.ServerPrincipal AS Expr2, 
                      p.ServerPrincipalType
FROM         DB_ServerPrincipalRole AS p INNER JOIN
                      DB_ServerMain AS s ON p.DBServerID = s.DBServerID
WHERE     (p.ServerPrincipal LIKE @user)
ORDER BY DB_ServerMain.ServerName, DB_RoleMembers.DatabaseName, DB_RoleMembers.LoginName
GO
/****** Object:  StoredProcedure [dbo].[sp_ssis_addlogentry]    Script Date: 12/13/2010 11:31:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_ssis_addlogentry]  @event sysname,  @computer nvarchar(128),  @operator nvarchar(128),  @source nvarchar(1024),  @sourceid uniqueidentifier,  @executionid uniqueidentifier,  @starttime datetime,  @endtime datetime,  @datacode int,  @databytes image,  @message nvarchar(2048)AS  INSERT INTO sysssislog (      event,      computer,      operator,      source,      sourceid,      executionid,      starttime,      endtime,      datacode,      databytes,      message )  VALUES (      @event,      @computer,      @operator,      @source,      @sourceid,      @executionid,      @starttime,      @endtime,      @datacode,      @databytes,      @message )  RETURN 0
GO
/****** Object:  StoredProcedure [dbo].[sp_dts_addlogentry]    Script Date: 12/13/2010 11:31:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_dts_addlogentry]  @event sysname,  @computer nvarchar(128),  @operator nvarchar(128),  @source nvarchar(1024),  @sourceid uniqueidentifier,  @executionid uniqueidentifier,  @starttime datetime,  @endtime datetime,  @datacode int,  @databytes image,  @message nvarchar(2048)AS  INSERT INTO sysdtslog90 (      event,      computer,      operator,      source,      sourceid,      executionid,      starttime,      endtime,      datacode,      databytes,      message )  VALUES (      @event,      @computer,      @operator,      @source,      @sourceid,      @executionid,      @starttime,      @endtime,      @datacode,      @databytes,      @message )  RETURN 0
GO

/****** Object:  Table [dbo].[DB_ServerGroup]    Script Date: 12/13/2010 11:31:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DB_ServerGroup](
	[DBServerID] [smallint] NULL,
	[GroupName] [sysname] NULL,
	[GroupDescription] [nvarchar](2048) NULL,
	[SubGroupName] [sysname] NULL,
	[SubGroupDescription] [nvarchar](2048) NULL,
	[ServerName] [sysname] NOT NULL,
	[ServerDescription] [nvarchar](2048) NULL,
	[RecCreateDt] [smalldatetime] NOT NULL
) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [idx_DBSrvID] ON [dbo].[DB_ServerGroup] 
(
	[DBServerID] ASC
)
INCLUDE ( [GroupName],
[SubGroupName]) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [idx_Group_Subgroup] ON [dbo].[DB_ServerGroup] 
(
	[GroupName] ASC,
	[SubGroupName] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Database_Data]    Script Date: 12/13/2010 11:31:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Database_Data](
	[DBServerID] [smallint] NOT NULL,
	[DBID] [smallint] NOT NULL,
	[DatabaseName] [nvarchar](260) NOT NULL,
	[ClassID] [char](4) NULL,
	[DatabaseDescr] [varchar](250) NULL,
	[DatabaseType] [char](10) NULL,
	[DailyBackupFlag] [char](1) NOT NULL,
	[DisasterRecovery] [char](1) NULL,
	[BackupFullFreqHr] [int] NULL,
	[BackupDiffFreqHr] [tinyint] NULL,
	[BackupLogFreqHr] [tinyint] NULL,
	[ActiveFlag] [char](1) NOT NULL,
	[ActiveFlagDt] [smalldatetime] NULL,
	[UpdateDt] [smalldatetime] NULL,
	[RecCreateDt] [smalldatetime] NOT NULL,
 CONSTRAINT [PK_Database_Data] PRIMARY KEY CLUSTERED 
(
	[DBServerID] ASC,
	[DatabaseName] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
CREATE UNIQUE NONCLUSTERED INDEX [IX_Server_DB_Name] ON [dbo].[Database_Data] 
(
	[DBServerID] ASC,
	[DatabaseName] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DB_Applications]    Script Date: 12/13/2010 11:31:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[DB_Applications] (
    [DBServerID]      SMALLINT      NOT NULL,
    [ApplicationName] VARCHAR (260) NOT NULL,
    [DatabaseName]    VARCHAR (260) NOT NULL,
    [RecCreateDt]     SMALLDATETIME CONSTRAINT [DF_DB_Applications_RecCreateDt] DEFAULT (getdate()) NOT NULL,
    CONSTRAINT [FK_DB_Applications_DB_ServerMain] FOREIGN KEY ([DBServerID]) REFERENCES [dbo].[DB_ServerMain] ([DBServerID])
) ON [Primary]
GO

SET ANSI_PADDING OFF
GO
CREATE UNIQUE NONCLUSTERED INDEX [idx_app_server_db] ON [dbo].[DB_Applications] 
(
	[ApplicationName] ASC,
	[DBServerID] ASC,
	[DatabaseName] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DB_SQLJobs]    Script Date: 12/13/2010 11:31:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DB_SQLJobs](
	[DBServerID] [smallint] NOT NULL,
	[job_id] [uniqueidentifier] NOT NULL,
	[name] [sysname] NOT NULL,
	[Job_Enabled] [tinyint] NOT NULL,
	[description] [nvarchar](512) NULL,
	[notify_level_eventlog] [int] NOT NULL,
	[notify_level_email] [int] NOT NULL,
	[notify_level_netsend] [int] NOT NULL,
	[notify_level_page] [int] NOT NULL,
	[notify_email_operator_id] [int] NOT NULL,
	[date_created] [datetime] NOT NULL,
	[Category_Name] [sysname] NOT NULL,
	[next_run_date] [int] NULL,
	[next_run_time] [int] NULL,
	[last_run_outcome] [tinyint] NULL,
	[last_outcome_message] [nvarchar](1024) NULL,
	[last_run_date] [int] NULL,
	[last_run_time] [int] NULL,
	[last_run_duration] [int] NULL,
	[Notify_Operator] [sysname] NULL,
	[email_address] [nvarchar](100) NULL,
	[Job_Version] [int] NULL,
	[date_modified] [datetime] NOT NULL,
	[Package_run_date] [datetime] NOT NULL,
	[Schedule_Name] [sysname] NULL,
	[enabled] [int] NULL,
	[freq_type] [int] NULL,
	[freq_interval] [int] NULL,
	[freq_subday_type] [int] NULL,
	[freq_subday_interval] [int] NULL,
	[freq_relative_interval] [int] NULL,
	[freq_recurrence_factor] [int] NULL,
	[active_start_date] [int] NULL,
	[active_end_date] [int] NULL,
	[active_start_time] [int] NULL,
	[active_end_time] [int] NULL,
	[Date_Sched_Created] [datetime] NULL,
	[Date_Sched_Modified] [datetime] NULL,
	[version_number] [int] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DB_ServerData]    Script Date: 12/13/2010 11:31:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[DB_ServerData](
	[DBServerID] [smallint] NOT NULL,
	[ComputerNetBIOS] [nvarchar](128) NULL,
	[SQLServerName] [nvarchar](128) NOT NULL,
	[MachineName] [nvarchar](128) NOT NULL,
	[InstanceName] [nvarchar](128) NULL,
	[SQLVersion] [tinyint] NULL,
	[Edition] [nvarchar](128) NULL,
	[EngineEdition] [varchar](50) NULL,
	[ProductVersion] [nvarchar](128) NULL,
	[ProductLevel] [nvarchar](50) NULL,
	[TcpPort] [nvarchar](50) NULL,
	[SQLServiceAccount] [nvarchar](50) NULL,
	[IsClustered] [varchar](10) NULL,
	[IsFullTextInstalled] [varchar](10) NULL,
	[IsIntegratedSecurityOnly] [varchar](10) NULL,
	[IsSingleUser] [varchar](10) NULL,
	[LicenseType] [nvarchar](20) NULL,
	[FilestreamShareName] [nvarchar](255) NULL,
	[ResourceLastUpdateDateTime] [smalldatetime] NULL,
	[ResourceDBVersion] [nvarchar](128) NULL,
	[Collation] [nvarchar](128) NULL,
	[CPU_Count] [int] NULL,
	[Hyperthread_Ratio] [int] NULL,
	[Physical_memory_MB] [int] NULL,
	[SQLServer_StartTime] [smalldatetime] NULL,
	[RecCreateDt] [smalldatetime] NULL
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
CREATE UNIQUE NONCLUSTERED INDEX [IX_DBServerID] ON [dbo].[DB_ServerData] 
(
	[DBServerID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
CREATE UNIQUE NONCLUSTERED INDEX [IX_SQLServerName] ON [dbo].[DB_ServerData] 
(
	[SQLServerName] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DB_ServerAlias]    Script Date: 12/13/2010 11:31:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DB_ServerAlias](
	[DBServerID] [smallint] NOT NULL,
	[SQLAlias] [nvarchar](128) NOT NULL,
	[RecCreateDt] [smalldatetime] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DB_SizeData]    Script Date: 12/13/2010 11:31:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DB_SizeData](
	[DBServerID] [smallint] NOT NULL,
	[DatabaseName] [nvarchar](260) NOT NULL,
	[TotalDBSizeMB] [decimal](18, 4) NULL,
	[DBUsedMB] [decimal](18, 4) NULL,
	[DBFreeSpaceMB] [decimal](18, 4) NULL,
	[DataFileSizeMB] [decimal](18, 4) NULL,
	[LogFileSizeMB] [decimal](18, 4) NULL,
	[DataSizeMB] [decimal](18, 4) NULL,
	[IndexSizeMB] [decimal](18, 4) NULL,
	[RecCreateDt] [smalldatetime] NOT NULL,
 CONSTRAINT [PK_DB_SizeData] PRIMARY KEY CLUSTERED 
(
	[DBServerID] ASC,
	[DatabaseName] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DB_FileData]    Script Date: 12/13/2010 11:31:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DB_FileData](
	[DBServerID] [smallint] NOT NULL,
	[DatabaseName] [nvarchar](260) NOT NULL,
	[DatabaseFileID] [int] NOT NULL,
	[FileType] [nvarchar](60) NULL,
	[LogicalName] [nvarchar](128) NULL,
	[FileGroup] [nvarchar](128) NULL,
	[PhysicalLocation] [nvarchar](260) NULL,
	[FileState] [nvarchar](60) NULL,
	[FileSizeMB] [decimal](18, 2) NULL,
	[FileGrowthMB] [decimal](18, 2) NULL,
	[FileGrowthPercent] [smallint] NULL,
	[RecCreateDt] [smalldatetime] NOT NULL,
 CONSTRAINT [PK_DB_FileData] PRIMARY KEY CLUSTERED 
(
	[DBServerID] ASC,
	[DatabaseName] ASC,
	[DatabaseFileID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DB_BackupData]    Script Date: 12/13/2010 11:31:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[DB_BackupData](
	[DBServerID] [smallint] NOT NULL,
	[DatabaseName] [nvarchar](260) NOT NULL,
	[BackupSetId] [int] NULL,
	[BackupStartDate] [smalldatetime] NULL,
	[BackupEndDate] [smalldatetime] NULL,
	[BackupSizeMB] [decimal](18, 2) NULL,
	[BackupType] [char](6) NULL,
	[BackupPhysicalFile] [nvarchar](260) NULL,
	[Status] [varchar](20) NULL,
	[Comment] [varchar](50) NULL,
	[BackupSoftware] [varchar](256) NULL,
	[RecCreateDt] [smalldatetime] NULL,
 CONSTRAINT [PK_DB_BackupData] PRIMARY KEY CLUSTERED 
(
	[DBServerID] ASC,
	[DatabaseName] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO

/****** Object:  StoredProcedure [dbo].[spUpdateDatabaseData]    Script Date: 12/13/2010 11:31:04 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[spUpdateDatabaseData]
AS

--Deactivate all dropped dbs
Update Database_Data Set ActiveFlag = 'N', UpdateDt = GetDate()
from Database_Data dl Left Outer Join stage.DB_ImportedDBs db
on db.DBName = DL.DatabaseName
and db.DBServerID = DL.DBServerID
where db.DBName is null

--Active existing dbs after recreate
Update Database_Data Set ActiveFlag = 'Y', UpdateDt = Getdate()
from Database_Data dl Join stage.DB_ImportedDBs db
on db.DBName = DL.DatabaseName
and db.DBServerID = DL.DBServerID
Where dl.ActiveFlag = 'N'

--Insert new created dbs
INSERT INTO Database_Data (DBServerID, DatabaseName, dbid, DailyBackupFlag)
Select db.DBServerID, db.DBName,db.dbid,
CASE WHEN db.DBName in ('tempdb','model','northwind','pubs')
		THEN 'N'
 	     ELSE 'Y'
		END
from stage.DB_ImportedDBs db full outer join Database_Data dl 
on db.DBName = dl.DatabaseName
and db.DBServerID = dl.DBServerID
where dl.databasename is null
GO
/****** Object:  UserDefinedFunction [dbo].[uf_GetExecutionLogTree]    Script Date: 12/13/2010 11:31:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE function [dbo].[uf_GetExecutionLogTree](
	 @logID			int
	,@fromRoot		bit = 0
) 
returns table
--with execute as caller
as
/**********************************************************************************************************
* UDF Name:		
*	part.uf_GetExecutionLogTree
* Parameters:
*	 @logID			int
*	,@fromRoot		bit = 0
*
* Purpose: This function returns the execution log tree that the specified node belongs to,
*	either the subtree starting from the node, or the whole tree from the root.
*
* Example:
	select * from dbo.ExecutionLog order by LogID desc
	select * from dbo.uf_GetExecutionLogTree(3, 1)
*              

**********************************************************************************************************/
return
(
	--Derive result using a CTE as the table is self-referencing
	with graph as (
		--select the anchor (specified) node
		select *, 0 as Depth from dbo.ExecutionLog
		where LogID = case @fromRoot
			when 1 then dbo.uf_GetExecutionLogRoot(@logID)
			else @logID
		end --case
		--select the child nodes
		union all
		select leaf.*, Depth + 1 from dbo.ExecutionLog as leaf
		inner join graph as node on (node.LogID = leaf.ParentLogID)
	)
	select
		 *
		,datediff(ss, StartTime, EndTime) as Seconds
	from graph
) --function
GO

/****** Object:  UserDefinedFunction [dbo].[uf_Progress]    Script Date: 12/13/2010 11:31:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE function [dbo].[uf_Progress]()
returns table
--with execute as caller
as
-- select * from dbo.uf_Progress()
return(
	with cte as (
		select 
			 f.LogID 
			,f.ParentLogID
			,f.depth
			,space(f.depth * 4) + f.PackageName as 'PackageName'
			--,convert(varchar(10), f.LogicalDate, 102) as 'LogicalDate'
			,f.StartTime
			,f.EndTime
			,f.Seconds
			,convert(varchar, f.Seconds / 60) + ':' + right('00' + convert(varchar, f.Seconds % 60), 2) as 'Time'
			,case f.Status
				when 1 then 'OK'
				when 2 then 'Failed'
				else 'Processing'
			end as 'Status'
			,f.PackageGUID
			,f.ExecutionGUID
			,t.MachineName
		from dbo.ExecutionLog t
		cross apply dbo.uf_GetExecutionLogTree(t.LogID, 0) f
		where t.ParentLogID is null
	)
	select top (100) percent
		 c.LogID 
		,c.ParentLogID
		,c.PackageName
		--,c.LogicalDate
		,c.StartTime
		,c.EndTime
		,c.Status
		,c.PackageGUID
		,c.ExecutionGUID
	--	,c.FailureTask
	--  ,s.Rows
	    ,c.[Time]
	--	,s.TimeMS
	--	,case when nullif(c.seconds, 0) is null then null else s.Rows / c.seconds end as 'OverallRps'
	--	,s.MinRowsPerSec as MinRps
	--	,s.MeanRowsPerSec as MeanRps
	--	,s.MaxRowsPerSec as MaxRps
		,c.depth
		,c.MachineName
	from
		cte c
	--left join 
	--	dbo.StatisticLog s on c.LogID = s.LogID and s.ComponentName = 'STAT Source'
	--order by
	--	c.LogID
)
GO
/****** Object:  StoredProcedure [dbo].[spCheckDBBackup]    Script Date: 12/13/2010 11:31:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[spCheckDBBackup]
AS

Truncate Table dbo.DB_BackupData


INSERT INTO dbo.DB_BackupData (DBServerID, BackupSetId, DatabaseName, BackupStartDate, BackupEndDate, BackupSizeMB, BackupType, BackupPhysicalFile, BackupSoftware, Status, Comment)
select 	   s.DBServerID, 
             b.Backup_Set_Id,
           s.DatabaseName,      
	b.backup_start_date,		 
	b.backup_finish_date,
             b.backup_size/(1024*1024),
			 CASE WHEN  b.Type = 'D' THEN 'FULL' 
			      WHEN  b.Type = 'I' THEN 'DIFF' ELSE b.Type END,
			  	b.BackupPhysicalFile,  
			  	b.BackupSoftware,  
             CASE WHEN DATEDIFF(hour, b.backup_start_date, Getdate()) < d.BackupFullFreqHr THEN 'Compliant'
                  WHEN b.backup_start_date is NULL THEN 'New'
 	          ELSE 'Non-Compliant'
		END,
	CASE WHEN DATEDIFF(hour, b.backup_start_date, Getdate()) < d.BackupFullFreqHr THEN 'Backup is current'
         WHEN b.backup_start_date is NULL THEN '***NEW DATABASE!!!***'
 	ELSE '***CHECK BACKUP!!!***'
		END
from Database_data s
LEFT OUTER JOIN	stage.DB_BackupSets b
	ON s.databasename = b.database_name
Join Database_Data d on b.DBServerID = d.DBServerID and b.Database_Name = d.DatabaseName
--Select only the active db
WHERE	s.DatabaseName in (select databasename from dbo.Database_Data where DailyBackupFlag = 'Y' AND DBServerID = s.DBServerID AND ActiveFlag = 'Y') 
        and (b.DBServerID = s.DBServerID or b.server_name is null)
ORDER BY 	s.DBServerID, s.DatabaseName


--Delete backups date > 12 month
Delete from DB_BackupData_Archive where datediff( m, reccreatedt, getdate()) > 12
GO
/****** Object:  StoredProcedure [dbo].[spTopNmetrics]    Script Date: 12/13/2010 11:31:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create Proc [dbo].[spTopNmetrics] 
AS
--Top n Server by Disk space
Select Top 10 s.ServerName, SUM(d.TotalDBSizeMB ) AS TotDiskSpaecMB
From dbo.DB_ServerMain s JOIN dbo.DB_SizeData d ON s.DBServerID = d.DBServerID
Where s.ActiveFlag = 'Y'
Group By s.ServerName
Order by TotDiskSpaecMB  Desc, s.ServerName

-- Top n Database by size
Select Top 10 s.ServerName, d.DatabaseName, d.TotalDBSizeMB 
From dbo.DB_ServerMain s JOIN dbo.DB_SizeData d ON s.DBServerID = d.DBServerID
Where s.ActiveFlag = 'Y'
Order by TotalDBSizeMB  Desc, s.ServerName, d.DatabaseName

-- Top n Table by size
Select Top 10 s.ServerName, t.DatabaseName, t.TableName, (ReservedSpaceKB/1024) AS TotalTableSizeMB
From dbo.DB_ServerMain s JOIN dbo.DB_TableSize t ON s.DBServerID = t.DBServerID
Where s.ActiveFlag = 'Y'
Order by TotalTableSizeMB Desc, s.ServerName, t.DatabaseName, t.TableName

-- Top n Table by row count
Select Top 10 s.ServerName, t.DatabaseName, t.TableName, Row_Count 
From dbo.DB_ServerMain s JOIN dbo.DB_TableSize t ON s.DBServerID = t.DBServerID
Where s.ActiveFlag = 'Y'
Order by Row_Count Desc, s.ServerName, t.DatabaseName, t.TableName


-- Top n Servers by db count
Select Top 10 s.ServerName, COUNT(d.DatabaseName) AS DB_Count
From dbo.DB_ServerMain s JOIN dbo.Database_Data d ON s.DBServerID = d.DBServerID
Where s.ActiveFlag = 'Y'
Group By s.ServerName
Order by DB_Count desc,s.ServerName

-- Top n Application by size
Select Top 10 a.ApplicationName, SUM(TotalDBSizeMB) AS TotalDBSizeMB
From dbo.DB_Applications a JOIN dbo.DB_ServerMain s ON a.DBServerID = s.DBServerID
JOIN dbo.DB_SizeData d ON a.DBServerID = d.DBServerID AND a.DatabaseName = d.DatabaseName 
Where s.ActiveFlag = 'Y'
Group By a.ApplicationName 
Order by TotalDBSizeMB desc, a.ApplicationName
GO
/****** Object:  Default [DF_DBRoleMembers_RecCreateDt]    Script Date: 12/13/2010 11:31:02 ******/
ALTER TABLE [dbo].[DB_RoleMembers] ADD  CONSTRAINT [DF_DBRoleMembers_RecCreateDt]  DEFAULT (getdate()) FOR [RecCreateDt]
GO
/****** Object:  Default [DF_DatabaseRestoredLog_RecCreatedt]    Script Date: 12/13/2010 11:31:02 ******/
ALTER TABLE [dbo].[DB_RestoreLog] ADD  CONSTRAINT [DF_DatabaseRestoredLog_RecCreatedt]  DEFAULT (getdate()) FOR [RecCreateDt]
GO

/****** Object:  Default [DF_DB_ObjectPermission_RecCreateDT]    Script Date: 12/13/2010 11:31:02 ******/
ALTER TABLE [dbo].[DB_ObjectsPermission] ADD  CONSTRAINT [DF_DB_ObjectPermission_RecCreateDT]  DEFAULT (getdate()) FOR [RecCreateDT]
GO
/****** Object:  Default [DF_DB_All_Objects_RecCreateDt]    Script Date: 12/13/2010 11:31:02 ******/
ALTER TABLE [dbo].[DB_Objects] ADD  CONSTRAINT [DF_DB_All_Objects_RecCreateDt]  DEFAULT (getdate()) FOR [RecCreateDt]
GO
/****** Object:  Default [DF_DB_LinkedServer_Data_RecCreateDt]    Script Date: 12/13/2010 11:31:02 ******/
ALTER TABLE [dbo].[DB_LinkedServer_Data] ADD  CONSTRAINT [DF_DB_LinkedServer_Data_RecCreateDt]  DEFAULT (getdate()) FOR [RecCreateDt]
GO
/****** Object:  Default [DF_DB_ServerDisk_Data_RecCreateDt]    Script Date: 12/13/2010 11:31:02 ******/
ALTER TABLE [dbo].[DB_ServerDisk_Data] ADD  CONSTRAINT [DF_DB_ServerDisk_Data_RecCreateDt]  DEFAULT (getdate()) FOR [RecCreateDt]
GO
/****** Object:  Default [DF_ErrorEvent_RecCreateDt]    Script Date: 12/13/2010 11:31:02 ******/
ALTER TABLE [dbo].[ErrorEvent] ADD  CONSTRAINT [DF_ErrorEvent_RecCreateDt]  DEFAULT (getdate()) FOR [RecCreateDt]
GO
/****** Object:  Default [DF_DB_TableSize_RecCreateDt]    Script Date: 12/13/2010 11:31:02 ******/
ALTER TABLE [dbo].[DB_TableSize] ADD  CONSTRAINT [DF_DB_TableSize_RecCreateDt]  DEFAULT (getdate()) FOR [RecCreateDt]
GO
/****** Object:  Default [DF_DB_Features_ReCreateDt]    Script Date: 12/13/2010 11:31:02 ******/
ALTER TABLE [dbo].[DB_Features] ADD  CONSTRAINT [DF_DB_Features_ReCreateDt]  DEFAULT (getdate()) FOR [ReCreateDt]
GO
/****** Object:  Default [DF_DB_ServerPrincipal_RecCreateDt]    Script Date: 12/13/2010 11:31:02 ******/
ALTER TABLE [dbo].[DB_ServerPrincipalRole] ADD  CONSTRAINT [DF_DB_ServerPrincipal_RecCreateDt]  DEFAULT (getdate()) FOR [RecCreateDt]
GO
/****** Object:  Default [DF_DB_ServerPermissions_RecCreateDt]    Script Date: 12/13/2010 11:31:02 ******/
ALTER TABLE [dbo].[DB_ServerPermissions] ADD  CONSTRAINT [DF_DB_ServerPermissions_RecCreateDt]  DEFAULT (getdate()) FOR [RecCreateDt]
GO
/****** Object:  Default [DF_DBServerRef_ActiveIndDt]    Script Date: 12/13/2010 11:31:02 ******/
ALTER TABLE [dbo].[DB_ServerMain] ADD  CONSTRAINT [DF_DBServerRef_ActiveIndDt]  DEFAULT (getdate()) FOR [ActiveFlagDt]
GO
/****** Object:  Default [DF_DB_ServerMain_DMVCollectionFlag]    Script Date: 12/13/2010 11:31:02 ******/
ALTER TABLE [dbo].[DB_ServerMain] ADD  CONSTRAINT [DF_DB_ServerMain_DMVCollectionFlag]  DEFAULT ('N') FOR [DMVCollectionFlag]
GO
/****** Object:  Default [DF_DBServerRef_RecCreateDt]    Script Date: 12/13/2010 11:31:02 ******/
ALTER TABLE [dbo].[DB_ServerMain] ADD  CONSTRAINT [DF_DBServerRef_RecCreateDt]  DEFAULT (getdate()) FOR [RecCreateDt]
GO
/****** Object:  Default [DF_DB_ServerLogins_RecCreateDt]    Script Date: 12/13/2010 11:31:02 ******/
ALTER TABLE [dbo].[DB_ServerLogins] ADD  CONSTRAINT [DF_DB_ServerLogins_RecCreateDt]  DEFAULT (getdate()) FOR [RecCreateDt]
GO
/****** Object:  Default [DF_DBServerIP_Data_RecCreateDt]    Script Date: 12/13/2010 11:31:02 ******/
ALTER TABLE [dbo].[DB_ServerIP_Data] ADD  CONSTRAINT [DF_DBServerIP_Data_RecCreateDt]  DEFAULT (getdate()) FOR [RecCreateDt]
GO
/****** Object:  Default [DF_DB_ServerGroup_RecCreateDt]    Script Date: 12/13/2010 11:31:04 ******/
ALTER TABLE [dbo].[DB_ServerGroup] ADD  CONSTRAINT [DF_DB_ServerGroup_RecCreateDt]  DEFAULT (getdate()) FOR [RecCreateDt]
GO
/****** Object:  Default [DF_DatabaseRef_DatabaseType]    Script Date: 12/13/2010 11:31:04 ******/
ALTER TABLE [dbo].[Database_Data] ADD  CONSTRAINT [DF_DatabaseRef_DatabaseType]  DEFAULT ('MSSQL') FOR [DatabaseType]
GO
/****** Object:  Default [DF_DatabaseRef_DailyBackupInd]    Script Date: 12/13/2010 11:31:04 ******/
ALTER TABLE [dbo].[Database_Data] ADD  CONSTRAINT [DF_DatabaseRef_DailyBackupInd]  DEFAULT ('Y') FOR [DailyBackupFlag]
GO
/****** Object:  Default [DF_DatabaseRef_BackupFullFreqHr]    Script Date: 12/13/2010 11:31:04 ******/
ALTER TABLE [dbo].[Database_Data] ADD  CONSTRAINT [DF_DatabaseRef_BackupFullFreqHr]  DEFAULT ((24)) FOR [BackupFullFreqHr]
GO
/****** Object:  Default [DF_DatabaseRef_BackupDiffFreqHr]    Script Date: 12/13/2010 11:31:04 ******/
ALTER TABLE [dbo].[Database_Data] ADD  CONSTRAINT [DF_DatabaseRef_BackupDiffFreqHr]  DEFAULT ((0)) FOR [BackupDiffFreqHr]
GO
/****** Object:  Default [DF_DatabaseRef_BackupLogFreqHr]    Script Date: 12/13/2010 11:31:04 ******/
ALTER TABLE [dbo].[Database_Data] ADD  CONSTRAINT [DF_DatabaseRef_BackupLogFreqHr]  DEFAULT ((0)) FOR [BackupLogFreqHr]
GO
/****** Object:  Default [DF_DatabaseRef_ActiveInd]    Script Date: 12/13/2010 11:31:04 ******/
ALTER TABLE [dbo].[Database_Data] ADD  CONSTRAINT [DF_DatabaseRef_ActiveInd]  DEFAULT ('Y') FOR [ActiveFlag]
GO
/****** Object:  Default [DF_DatabaseRef_ActiveIndDt]    Script Date: 12/13/2010 11:31:04 ******/
ALTER TABLE [dbo].[Database_Data] ADD  CONSTRAINT [DF_DatabaseRef_ActiveIndDt]  DEFAULT (getdate()) FOR [ActiveFlagDt]
GO
/****** Object:  Default [DF_DatabaseRef_RecCreateDt]    Script Date: 12/13/2010 11:31:04 ******/
ALTER TABLE [dbo].[Database_Data] ADD  CONSTRAINT [DF_DatabaseRef_RecCreateDt]  DEFAULT (getdate()) FOR [RecCreateDt]
GO

/****** Object:  Default [DF_DBServer_Data_RecCreateDt]    Script Date: 12/13/2010 11:31:04 ******/
ALTER TABLE [dbo].[DB_ServerData] ADD  CONSTRAINT [DF_DBServer_Data_RecCreateDt]  DEFAULT (getdate()) FOR [RecCreateDt]
GO
/****** Object:  Default [DF_DBServer_Alias_RecCreateDt]    Script Date: 12/13/2010 11:31:04 ******/
ALTER TABLE [dbo].[DB_ServerAlias] ADD  CONSTRAINT [DF_DBServer_Alias_RecCreateDt]  DEFAULT (getdate()) FOR [RecCreateDt]
GO
/****** Object:  Default [DF_DatabaseSizeLog_RecCreateDt]    Script Date: 12/13/2010 11:31:04 ******/
ALTER TABLE [dbo].[DB_SizeData] ADD  CONSTRAINT [DF_DatabaseSizeLog_RecCreateDt]  DEFAULT (getdate()) FOR [RecCreateDt]
GO
/****** Object:  Default [DF_DatabaseFileRef_RecCreateDt]    Script Date: 12/13/2010 11:31:04 ******/
ALTER TABLE [dbo].[DB_FileData] ADD  CONSTRAINT [DF_DatabaseFileRef_RecCreateDt]  DEFAULT (getdate()) FOR [RecCreateDt]
GO
/****** Object:  Default [DF_DatabaseBackupLog_RecCreateDt]    Script Date: 12/13/2010 11:31:04 ******/
ALTER TABLE [dbo].[DB_BackupData] ADD  CONSTRAINT [DF_DatabaseBackupLog_RecCreateDt]  DEFAULT (getdate()) FOR [RecCreateDt]
GO

/****** Object:  ForeignKey [FK_DB_ServerGroup_DB_ServerMain]    Script Date: 12/13/2010 11:31:04 ******/
ALTER TABLE [dbo].[DB_ServerGroup]  WITH CHECK ADD  CONSTRAINT [FK_DB_ServerGroup_DB_ServerMain] FOREIGN KEY([DBServerID])
REFERENCES [dbo].[DB_ServerMain] ([DBServerID])
GO
ALTER TABLE [dbo].[DB_ServerGroup] CHECK CONSTRAINT [FK_DB_ServerGroup_DB_ServerMain]
GO
/****** Object:  ForeignKey [FK_Database_Data_DB_ServerMain]    Script Date: 12/13/2010 11:31:04 ******/
ALTER TABLE [dbo].[Database_Data]  WITH CHECK ADD  CONSTRAINT [FK_Database_Data_DB_ServerMain] FOREIGN KEY([DBServerID])
REFERENCES [dbo].[DB_ServerMain] ([DBServerID])
GO
ALTER TABLE [dbo].[Database_Data] CHECK CONSTRAINT [FK_Database_Data_DB_ServerMain]
GO



/****** Object:  ForeignKey [FK_DB_SQLJobs_DB_ServerMain]    Script Date: 12/13/2010 11:31:04 ******/
ALTER TABLE [dbo].[DB_SQLJobs]  WITH CHECK ADD  CONSTRAINT [FK_DB_SQLJobs_DB_ServerMain] FOREIGN KEY([DBServerID])
REFERENCES [dbo].[DB_ServerMain] ([DBServerID])
GO
ALTER TABLE [dbo].[DB_SQLJobs] CHECK CONSTRAINT [FK_DB_SQLJobs_DB_ServerMain]
GO

/****** Object:  ForeignKey [FK_DB_ServerData_DB_ServerMain]    Script Date: 12/13/2010 11:31:04 ******/
ALTER TABLE [dbo].[DB_ServerData]  WITH CHECK ADD  CONSTRAINT [FK_DB_ServerData_DB_ServerMain] FOREIGN KEY([DBServerID])
REFERENCES [dbo].[DB_ServerMain] ([DBServerID])
GO
ALTER TABLE [dbo].[DB_ServerData] CHECK CONSTRAINT [FK_DB_ServerData_DB_ServerMain]
GO
/****** Object:  ForeignKey [FK_DB_ServerAlias_DB_ServerMain]    Script Date: 12/13/2010 11:31:04 ******/
ALTER TABLE [dbo].[DB_ServerAlias]  WITH CHECK ADD  CONSTRAINT [FK_DB_ServerAlias_DB_ServerMain] FOREIGN KEY([DBServerID])
REFERENCES [dbo].[DB_ServerMain] ([DBServerID])
GO
ALTER TABLE [dbo].[DB_ServerAlias] CHECK CONSTRAINT [FK_DB_ServerAlias_DB_ServerMain]
GO
/****** Object:  ForeignKey [FK_DB_SizeData_Database_Data]    Script Date: 12/13/2010 11:31:04 ******/
ALTER TABLE [dbo].[DB_SizeData]  WITH CHECK ADD  CONSTRAINT [FK_DB_SizeData_Database_Data] FOREIGN KEY([DBServerID], [DatabaseName])
REFERENCES [dbo].[Database_Data] ([DBServerID], [DatabaseName])
GO
ALTER TABLE [dbo].[DB_SizeData] CHECK CONSTRAINT [FK_DB_SizeData_Database_Data]
GO
/****** Object:  ForeignKey [FK_DB_FileData_Database_Data]    Script Date: 12/13/2010 11:31:04 ******/
ALTER TABLE [dbo].[DB_FileData]  WITH CHECK ADD  CONSTRAINT [FK_DB_FileData_Database_Data] FOREIGN KEY([DBServerID], [DatabaseName])
REFERENCES [dbo].[Database_Data] ([DBServerID], [DatabaseName])
GO
ALTER TABLE [dbo].[DB_FileData] CHECK CONSTRAINT [FK_DB_FileData_Database_Data]
GO
/****** Object:  ForeignKey [FK_DB_BackupData_Database_Data]    Script Date: 12/13/2010 11:31:04 ******/
ALTER TABLE [dbo].[DB_BackupData]  WITH CHECK ADD  CONSTRAINT [FK_DB_BackupData_Database_Data] FOREIGN KEY([DBServerID], [DatabaseName])
REFERENCES [dbo].[Database_Data] ([DBServerID], [DatabaseName])
GO
ALTER TABLE [dbo].[DB_BackupData] CHECK CONSTRAINT [FK_DB_BackupData_Database_Data]
GO

CREATE View [dbo].[vDBGrowthRate] AS

Select DB_ServerMain.ServerName, DB_SizeDataArchive.DatabaseName,MIN(DB_SizeDataArchive.TotalDBSizeMB) AS MinSizeMB, 
MAX(DB_SizeDataArchive.TotalDBSizeMB) AS MaxSizeMB,
AVG(DB_SizeDataArchive.TotalDBSizeMB) AS AvgSizeMB,
ISNULL((MAX(DB_SizeDataArchive.TotalDBSizeMB) - MIN(DB_SizeDataArchive.TotalDBSizeMB)),0) AS DBGrowthMB, 
COUNT(month(DB_SizeDataArchive.RecCreateDt)) AS DBGrowthLast_n_Month,
ISNULL((MAX(DB_SizeDataArchive.TotalDBSizeMB) - MIN(DB_SizeDataArchive.TotalDBSizeMB)),0)+ MAX(DB_SizeDataArchive.TotalDBSizeMB) AS DBFutureSizeMB,
COUNT(month(DB_SizeDataArchive.RecCreateDt)) AS DBGrowNext_n_Month

From DB_SizeDataArchive INNER JOIN
                      DB_ServerMain ON DB_SizeDataArchive.DBServerID = DB_ServerMain.DBServerID
Group By DB_ServerMain.ServerName, DB_SizeDataArchive.DatabaseName, YEAR(DB_SizeDataArchive.RecCreateDt)
GO




                  /****** Populate Refernce tables ******/

/****** Object:  Table [dbo].[DB_Server_Ref]    Script Date: 12/13/2010 11:53:52 ******/
Truncate Table [DB_Server_Ref]
Go
INSERT [dbo].[DB_Server_Ref] ([SQLServerEdition], [SQLServerDescription]) VALUES (N'8.00', N'SQL2000')
INSERT [dbo].[DB_Server_Ref] ([SQLServerEdition], [SQLServerDescription]) VALUES (N'9.00', N'SQL2005')
INSERT [dbo].[DB_Server_Ref] ([SQLServerEdition], [SQLServerDescription]) VALUES (N'10.0', N'SQL2008')
INSERT [dbo].[DB_Server_Ref] ([SQLServerEdition], [SQLServerDescription]) VALUES (N'10.5', N'SQL2008R2')
INSERT [dbo].[DB_Server_Ref] ([SQLServerEdition], [SQLServerDescription]) VALUES (N'11.0', N'SQL2012')


Print '>>>>>---- eMDW Objects have created'