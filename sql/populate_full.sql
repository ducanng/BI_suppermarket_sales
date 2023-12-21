USE [master]
GO
/****** Object:  Database [dds]    Script Date: 12/21/2023 9:10:31 PM ******/
CREATE DATABASE [dds]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'dds', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\dds.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'dds_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\dds_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT
GO
ALTER DATABASE [dds] SET COMPATIBILITY_LEVEL = 150
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [dds].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [dds] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [dds] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [dds] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [dds] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [dds] SET ARITHABORT OFF 
GO
ALTER DATABASE [dds] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [dds] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [dds] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [dds] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [dds] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [dds] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [dds] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [dds] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [dds] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [dds] SET  ENABLE_BROKER 
GO
ALTER DATABASE [dds] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [dds] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [dds] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [dds] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [dds] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [dds] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [dds] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [dds] SET RECOVERY FULL 
GO
ALTER DATABASE [dds] SET  MULTI_USER 
GO
ALTER DATABASE [dds] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [dds] SET DB_CHAINING OFF 
GO
ALTER DATABASE [dds] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [dds] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [dds] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [dds] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
EXEC sys.sp_db_vardecimal_storage_format N'dds', N'ON'
GO
ALTER DATABASE [dds] SET QUERY_STORE = OFF
GO
USE [dds]
GO
/****** Object:  Table [dbo].[dimBranch]    Script Date: 12/21/2023 9:10:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dimBranch](
	[branchID] [bigint] NOT NULL,
	[branchNK] [nvarchar](255) NULL,
	[city] [nvarchar](255) NULL,
	[sourceID] [bigint] NULL,
	[effectiveAt] [datetime] NOT NULL,
	[expiryAt] [datetime] NULL,
	[CreatedAt] [datetime] NULL,
	[UpdatedAt] [datetime] NULL,
 CONSTRAINT [pk_dim_branch] PRIMARY KEY CLUSTERED 
(
	[branchID] ASC,
	[effectiveAt] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[dimDate]    Script Date: 12/21/2023 9:10:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dimDate](
	[dateID] [int] NOT NULL,
	[FullDate] [date] NOT NULL,
	[DayNumberOfWeek] [tinyint] NOT NULL,
	[DayNameOfWeek] [nvarchar](10) NOT NULL,
	[WeekDayType] [nvarchar](7) NOT NULL,
	[DayNumberOfMonth] [tinyint] NOT NULL,
	[DayNumberOfYear] [smallint] NOT NULL,
	[WeekNumberOfYear] [tinyint] NOT NULL,
	[MonthNameOfYear] [nvarchar](10) NOT NULL,
	[MonthNumberOfYear] [tinyint] NOT NULL,
	[QuarterNumberCalendar] [tinyint] NOT NULL,
	[QuarterNameCalendar] [nchar](2) NOT NULL,
	[SemesterNumberCalendar] [tinyint] NOT NULL,
	[SemesterNameCalendar] [nvarchar](15) NOT NULL,
	[YearCalendar] [smallint] NOT NULL,
	[MonthNumberFiscal] [tinyint] NOT NULL,
	[QuarterNumberFiscal] [tinyint] NOT NULL,
	[QuarterNameFiscal] [nchar](2) NOT NULL,
	[SemesterNumberFiscal] [tinyint] NOT NULL,
	[SemesterNameFiscal] [nvarchar](15) NOT NULL,
	[YearFiscal] [smallint] NOT NULL,
 CONSTRAINT [PK_DimDate] PRIMARY KEY CLUSTERED 
(
	[dateID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[dimInvoice]    Script Date: 12/21/2023 9:10:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dimInvoice](
	[invoiceID] [bigint] NOT NULL,
	[invoiceNK] [nvarchar](255) NULL,
	[customerType] [nvarchar](255) NULL,
	[gender] [nvarchar](255) NULL,
	[time] [time](7) NULL,
	[payment] [nvarchar](255) NULL,
	[sourceID] [bigint] NULL,
	[effectiveAt] [datetime] NOT NULL,
	[expiryAt] [datetime] NULL,
	[CreatedAt] [datetime] NULL,
	[UpdatedAt] [datetime] NULL,
 CONSTRAINT [pk_dim_invoice] PRIMARY KEY CLUSTERED 
(
	[invoiceID] ASC,
	[effectiveAt] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[dimProduct]    Script Date: 12/21/2023 9:10:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dimProduct](
	[productID] [bigint] NOT NULL,
	[productNK] [nvarchar](255) NULL,
	[productLine] [nvarchar](255) NULL,
	[unitPrice] [float] NULL,
	[sourceID] [bigint] NULL,
	[effectiveAt] [datetime] NOT NULL,
	[expiryAt] [datetime] NULL,
	[CreatedAt] [datetime] NULL,
	[UpdatedAt] [datetime] NULL,
 CONSTRAINT [pk_dim_product] PRIMARY KEY CLUSTERED 
(
	[productID] ASC,
	[effectiveAt] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[factProductSales]    Script Date: 12/21/2023 9:10:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[factProductSales](
	[dateID] [int] NOT NULL,
	[productID] [bigint] NOT NULL,
	[branchID] [bigint] NOT NULL,
	[invoiceID] [bigint] NOT NULL,
	[quantity] [int] NULL,
	[tax] [float] NULL,
	[total] [float] NULL,
	[cogs] [float] NULL,
	[grossMarginPercentage] [float] NULL,
	[grossIncome] [float] NULL,
	[Rating] [float] NULL,
	[sourceID] [bigint] NULL,
	[CreatedAt] [datetime] NULL,
	[UpdatedAt] [datetime] NULL,
 CONSTRAINT [pk_fact_product_sales] PRIMARY KEY CLUSTERED 
(
	[invoiceID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
USE [master]
GO
ALTER DATABASE [dds] SET  READ_WRITE 
GO
