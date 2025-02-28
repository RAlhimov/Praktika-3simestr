USE [master]
GO
/****** Object:  Database [Tourism]    Script Date: 28.02.2025 22:05:38 ******/
IF NOT EXISTS (SELECT name FROM sys.databases WHERE name = N'Tourism')
BEGIN
CREATE DATABASE [Tourism]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'Tourism', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.SQLEXPRESS\MSSQL\DATA\Tourism.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'Tourism_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.SQLEXPRESS\MSSQL\DATA\Tourism_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT, LEDGER = OFF
END
GO
ALTER DATABASE [Tourism] SET COMPATIBILITY_LEVEL = 160
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [Tourism].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [Tourism] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [Tourism] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [Tourism] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [Tourism] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [Tourism] SET ARITHABORT OFF 
GO
ALTER DATABASE [Tourism] SET AUTO_CLOSE ON 
GO
ALTER DATABASE [Tourism] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [Tourism] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [Tourism] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [Tourism] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [Tourism] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [Tourism] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [Tourism] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [Tourism] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [Tourism] SET  ENABLE_BROKER 
GO
ALTER DATABASE [Tourism] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [Tourism] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [Tourism] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [Tourism] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [Tourism] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [Tourism] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [Tourism] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [Tourism] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [Tourism] SET  MULTI_USER 
GO
ALTER DATABASE [Tourism] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [Tourism] SET DB_CHAINING OFF 
GO
ALTER DATABASE [Tourism] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [Tourism] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [Tourism] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [Tourism] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
ALTER DATABASE [Tourism] SET QUERY_STORE = ON
GO
ALTER DATABASE [Tourism] SET QUERY_STORE (OPERATION_MODE = READ_WRITE, CLEANUP_POLICY = (STALE_QUERY_THRESHOLD_DAYS = 30), DATA_FLUSH_INTERVAL_SECONDS = 900, INTERVAL_LENGTH_MINUTES = 60, MAX_STORAGE_SIZE_MB = 1000, QUERY_CAPTURE_MODE = AUTO, SIZE_BASED_CLEANUP_MODE = AUTO, MAX_PLANS_PER_QUERY = 200, WAIT_STATS_CAPTURE_MODE = ON)
GO
USE [Tourism]
GO
/****** Object:  Table [dbo].[Countries]    Script Date: 28.02.2025 22:05:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Countries]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[Countries](
	[CountryID] [int] IDENTITY(1,1) NOT NULL,
	[CountryName] [nvarchar](100) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[CountryID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[Hotels]    Script Date: 28.02.2025 22:05:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Hotels]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[Hotels](
	[HotelID] [int] IDENTITY(1,1) NOT NULL,
	[HotelName] [nvarchar](100) NOT NULL,
	[CountryID] [int] NOT NULL,
	[Stars] [int] NULL,
	[Description] [nvarchar](max) NULL,
PRIMARY KEY CLUSTERED 
(
	[HotelID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[Orders]    Script Date: 28.02.2025 22:05:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Orders]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[Orders](
	[OrderID] [int] IDENTITY(1,1) NOT NULL,
	[TourID] [int] NOT NULL,
	[CustomerName] [nvarchar](100) NOT NULL,
	[OrderDate] [datetime2](7) NOT NULL,
	[NumberOfPeople] [int] NOT NULL,
	[TotalPrice] [decimal](10, 2) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[OrderID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[Tours]    Script Date: 28.02.2025 22:05:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Tours]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[Tours](
	[TourID] [int] IDENTITY(1,1) NOT NULL,
	[TourTypeID] [int] NOT NULL,
	[HotelID] [int] NOT NULL,
	[TourName] [nvarchar](200) NOT NULL,
	[DepartureDate] [date] NOT NULL,
	[Duration] [int] NOT NULL,
	[Price] [decimal](10, 2) NOT NULL,
	[Description] [nvarchar](max) NULL,
PRIMARY KEY CLUSTERED 
(
	[TourID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[TourTypes]    Script Date: 28.02.2025 22:05:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[TourTypes]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[TourTypes](
	[TourTypeID] [int] IDENTITY(1,1) NOT NULL,
	[TourTypeName] [nvarchar](100) NOT NULL,
	[Description] [nvarchar](max) NULL,
PRIMARY KEY CLUSTERED 
(
	[TourTypeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Index [IX_Hotels_CountryID]    Script Date: 28.02.2025 22:05:38 ******/
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[Hotels]') AND name = N'IX_Hotels_CountryID')
CREATE NONCLUSTERED INDEX [IX_Hotels_CountryID] ON [dbo].[Hotels]
(
	[CountryID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF__Orders__OrderDat__4222D4EF]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[Orders] ADD  DEFAULT (getdate()) FOR [OrderDate]
END
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__Hotels__CountryI__3B75D760]') AND parent_object_id = OBJECT_ID(N'[dbo].[Hotels]'))
ALTER TABLE [dbo].[Hotels]  WITH CHECK ADD FOREIGN KEY([CountryID])
REFERENCES [dbo].[Countries] ([CountryID])
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__Orders__TourID__4316F928]') AND parent_object_id = OBJECT_ID(N'[dbo].[Orders]'))
ALTER TABLE [dbo].[Orders]  WITH CHECK ADD FOREIGN KEY([TourID])
REFERENCES [dbo].[Tours] ([TourID])
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__Tours__HotelID__3F466844]') AND parent_object_id = OBJECT_ID(N'[dbo].[Tours]'))
ALTER TABLE [dbo].[Tours]  WITH CHECK ADD FOREIGN KEY([HotelID])
REFERENCES [dbo].[Hotels] ([HotelID])
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__Tours__TourTypeI__3E52440B]') AND parent_object_id = OBJECT_ID(N'[dbo].[Tours]'))
ALTER TABLE [dbo].[Tours]  WITH CHECK ADD FOREIGN KEY([TourTypeID])
REFERENCES [dbo].[TourTypes] ([TourTypeID])
GO
USE [master]
GO
ALTER DATABASE [Tourism] SET  READ_WRITE 
GO
