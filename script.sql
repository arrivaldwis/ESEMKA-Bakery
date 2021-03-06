USE [master]
GO
/****** Object:  Database [selectiontestwsc2017]    Script Date: 12/23/2016 11:29:42 AM ******/
CREATE DATABASE [selectiontestwsc2017]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'selectiontestwsc2017', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL12.SQLEXPRESS\MSSQL\DATA\selectiontestwsc2017.mdf' , SIZE = 5312KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'selectiontestwsc2017_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL12.SQLEXPRESS\MSSQL\DATA\selectiontestwsc2017_log.ldf' , SIZE = 832KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [selectiontestwsc2017] SET COMPATIBILITY_LEVEL = 120
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [selectiontestwsc2017].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [selectiontestwsc2017] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [selectiontestwsc2017] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [selectiontestwsc2017] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [selectiontestwsc2017] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [selectiontestwsc2017] SET ARITHABORT OFF 
GO
ALTER DATABASE [selectiontestwsc2017] SET AUTO_CLOSE ON 
GO
ALTER DATABASE [selectiontestwsc2017] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [selectiontestwsc2017] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [selectiontestwsc2017] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [selectiontestwsc2017] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [selectiontestwsc2017] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [selectiontestwsc2017] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [selectiontestwsc2017] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [selectiontestwsc2017] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [selectiontestwsc2017] SET  ENABLE_BROKER 
GO
ALTER DATABASE [selectiontestwsc2017] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [selectiontestwsc2017] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [selectiontestwsc2017] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [selectiontestwsc2017] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [selectiontestwsc2017] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [selectiontestwsc2017] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [selectiontestwsc2017] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [selectiontestwsc2017] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [selectiontestwsc2017] SET  MULTI_USER 
GO
ALTER DATABASE [selectiontestwsc2017] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [selectiontestwsc2017] SET DB_CHAINING OFF 
GO
ALTER DATABASE [selectiontestwsc2017] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [selectiontestwsc2017] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
ALTER DATABASE [selectiontestwsc2017] SET DELAYED_DURABILITY = DISABLED 
GO
USE [selectiontestwsc2017]
GO
/****** Object:  Table [dbo].[employee]    Script Date: 12/23/2016 11:29:42 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[employee](
	[employeeid] [int] IDENTITY(1,1) NOT NULL,
	[employeename] [varchar](100) NOT NULL,
	[password] [varchar](100) NOT NULL,
	[employeeaddress] [text] NOT NULL,
	[employeephone] [varchar](60) NOT NULL,
	[status] [char](1) NOT NULL,
	[email] [varchar](100) NOT NULL,
 CONSTRAINT [PK__employee__C135F5E992E3727A] PRIMARY KEY CLUSTERED 
(
	[employeeid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[food]    Script Date: 12/23/2016 11:29:42 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[food](
	[foodid] [int] IDENTITY(1,1) NOT NULL,
	[foodname] [varchar](100) NOT NULL,
	[description] [text] NOT NULL,
	[price] [int] NOT NULL,
	[status] [char](1) NOT NULL,
 CONSTRAINT [PK__food__77E7E631EB4365BC] PRIMARY KEY CLUSTERED 
(
	[foodid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[incomingrawmaterialdetail]    Script Date: 12/23/2016 11:29:42 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[incomingrawmaterialdetail](
	[incomingrawmaterialid] [int] NOT NULL,
	[rawmaterialid] [int] NOT NULL,
	[priceper100gram] [int] NOT NULL,
	[bestbeforedate] [datetime] NOT NULL,
	[weightingram] [int] NOT NULL,
 CONSTRAINT [PK_IncomingRawMaterialDetail$] PRIMARY KEY CLUSTERED 
(
	[incomingrawmaterialid] ASC,
	[rawmaterialid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[incomingrawmaterialheader]    Script Date: 12/23/2016 11:29:42 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[incomingrawmaterialheader](
	[incomingrawmaterialid] [int] IDENTITY(1,1) NOT NULL,
	[incomingdate] [datetime] NOT NULL,
	[employeeid] [int] NOT NULL,
	[description] [text] NOT NULL,
 CONSTRAINT [PK__incoming__C0BA08F7D798EFC0] PRIMARY KEY CLUSTERED 
(
	[incomingrawmaterialid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[productiondetail]    Script Date: 12/23/2016 11:29:42 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[productiondetail](
	[productionid] [int] NOT NULL,
	[batchnumber] [int] IDENTITY(1,1) NOT NULL,
	[foodid] [int] NOT NULL,
	[productionoutputqty] [int] NOT NULL,
	[expireddate] [datetime] NOT NULL,
 CONSTRAINT [PK_productiondetail] PRIMARY KEY CLUSTERED 
(
	[productionid] ASC,
	[batchnumber] ASC,
	[foodid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[productionheader]    Script Date: 12/23/2016 11:29:42 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[productionheader](
	[productionid] [int] IDENTITY(1,1) NOT NULL,
	[productiondate] [datetime] NOT NULL,
	[description] [text] NOT NULL,
	[employeeid] [int] NOT NULL,
	[status] [char](1) NOT NULL,
 CONSTRAINT [PK__producti__77817CB84AF6630C] PRIMARY KEY CLUSTERED 
(
	[productionid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[rawmaterial]    Script Date: 12/23/2016 11:29:42 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[rawmaterial](
	[rawmaterialid] [int] IDENTITY(1,1) NOT NULL,
	[rawmaterialname] [varchar](100) NOT NULL,
	[description] [text] NOT NULL,
	[employeeid] [int] NOT NULL,
	[inputeddate] [datetime] NOT NULL,
	[status] [char](1) NOT NULL,
 CONSTRAINT [PK__rawmater__7F2F261D4667C0B9] PRIMARY KEY CLUSTERED 
(
	[rawmaterialid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[rawmaterialintake]    Script Date: 12/23/2016 11:29:42 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[rawmaterialintake](
	[batchnumber] [int] NOT NULL,
	[rawmaterialid] [int] NOT NULL,
	[incomingrawmaterialid] [int] NOT NULL,
	[weightingram] [int] NOT NULL,
 CONSTRAINT [PK_RawMaterialIntake$] PRIMARY KEY CLUSTERED 
(
	[batchnumber] ASC,
	[rawmaterialid] ASC,
	[incomingrawmaterialid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[recipedetail]    Script Date: 12/23/2016 11:29:42 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[recipedetail](
	[recipeid] [int] NOT NULL,
	[rawmaterialid] [int] NOT NULL,
	[weightingram] [int] NOT NULL,
 CONSTRAINT [PK_recipedetail] PRIMARY KEY CLUSTERED 
(
	[recipeid] ASC,
	[rawmaterialid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[recipeheader]    Script Date: 12/23/2016 11:29:42 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[recipeheader](
	[recipeid] [int] IDENTITY(1,1) NOT NULL,
	[foodid] [int] NOT NULL,
	[outputunitinpieces] [int] NOT NULL,
	[description] [text] NOT NULL,
	[employeeid] [int] NOT NULL,
	[createddate] [datetime] NOT NULL,
	[status] [char](1) NOT NULL,
 CONSTRAINT [PK__recipehe__C117EB9BC2DB5E6A] PRIMARY KEY CLUSTERED 
(
	[recipeid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[sellingdetail]    Script Date: 12/23/2016 11:29:42 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[sellingdetail](
	[sellingid] [int] NOT NULL,
	[foodid] [int] NOT NULL,
	[batchnumber] [int] NOT NULL,
	[qty] [int] NOT NULL,
	[price] [int] NOT NULL,
 CONSTRAINT [PK_sellingdetail] PRIMARY KEY CLUSTERED 
(
	[sellingid] ASC,
	[foodid] ASC,
	[batchnumber] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[sellingheader]    Script Date: 12/23/2016 11:29:42 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[sellingheader](
	[sellingid] [int] IDENTITY(1,1) NOT NULL,
	[sellingdate] [datetime] NOT NULL,
	[discount] [int] NOT NULL,
	[employeeid] [int] NOT NULL,
 CONSTRAINT [PK__sellingh__7D75C71CE491DC8D] PRIMARY KEY CLUSTERED 
(
	[sellingid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET IDENTITY_INSERT [dbo].[employee] ON 

INSERT [dbo].[employee] ([employeeid], [employeename], [password], [employeeaddress], [employeephone], [status], [email]) VALUES (1, N'Andi Widodo', N'N@.3AwSX*&', N'Salatiga', N'081213078081', N'A', N'andi.widodo@gmail.com')
INSERT [dbo].[employee] ([employeeid], [employeename], [password], [employeeaddress], [employeephone], [status], [email]) VALUES (2, N'Ririn Pudjiastuti', N'$Nw!%eRT_^', N'Jogja', N'085770123768', N'A', N'ririn.pudjiastuti@gmail.com')
INSERT [dbo].[employee] ([employeeid], [employeename], [password], [employeeaddress], [employeephone], [status], [email]) VALUES (3, N'Joko Budi Santoso', N'#T.Wq@20E', N'Tegal', N'085620314821', N'A', N'joko.budi.santoso@gmail.com')
INSERT [dbo].[employee] ([employeeid], [employeename], [password], [employeeaddress], [employeephone], [status], [email]) VALUES (4, N'Bambang Triadmotjo', N'X!^NmEH&.', N'Cirebon', N'081235623910', N'D', N'bambang.triadmotjo@gmail.com')
SET IDENTITY_INSERT [dbo].[employee] OFF
SET IDENTITY_INSERT [dbo].[food] ON 

INSERT [dbo].[food] ([foodid], [foodname], [description], [price], [status]) VALUES (1, N'Chocolate Bread', N'Bread with Chocolate Block Inside', 7000, N'A')
INSERT [dbo].[food] ([foodid], [foodname], [description], [price], [status]) VALUES (2, N'Cheese Bread', N'Bread with Cheese Block Inside', 7500, N'A')
INSERT [dbo].[food] ([foodid], [foodname], [description], [price], [status]) VALUES (3, N'Cream Cheese Bread', N'Bread with Cream Cheese Inside', 8000, N'A')
INSERT [dbo].[food] ([foodid], [foodname], [description], [price], [status]) VALUES (4, N'Pizza Bread', N'Bread with Sausages and onion layered by mozarella', 11000, N'A')
INSERT [dbo].[food] ([foodid], [foodname], [description], [price], [status]) VALUES (5, N'Cheese Burger', N'Bread with beef meat, tomato, cheese, and delicious sauce inside', 13000, N'A')
INSERT [dbo].[food] ([foodid], [foodname], [description], [price], [status]) VALUES (6, N'Double Cheese Burger', N'Bread with beef meat, tomato, double cheese, and delicious sauce inside', 15000, N'A')
SET IDENTITY_INSERT [dbo].[food] OFF
INSERT [dbo].[incomingrawmaterialdetail] ([incomingrawmaterialid], [rawmaterialid], [priceper100gram], [bestbeforedate], [weightingram]) VALUES (1, 1, 2, CAST(N'2015-10-01 00:00:00.000' AS DateTime), 420000)
INSERT [dbo].[incomingrawmaterialdetail] ([incomingrawmaterialid], [rawmaterialid], [priceper100gram], [bestbeforedate], [weightingram]) VALUES (1, 2, 1, CAST(N'2019-10-01 00:00:00.000' AS DateTime), 332560)
INSERT [dbo].[incomingrawmaterialdetail] ([incomingrawmaterialid], [rawmaterialid], [priceper100gram], [bestbeforedate], [weightingram]) VALUES (1, 3, 2, CAST(N'2019-10-01 00:00:00.000' AS DateTime), 278084)
INSERT [dbo].[incomingrawmaterialdetail] ([incomingrawmaterialid], [rawmaterialid], [priceper100gram], [bestbeforedate], [weightingram]) VALUES (1, 4, 3, CAST(N'2019-10-01 00:00:00.000' AS DateTime), 397064)
INSERT [dbo].[incomingrawmaterialdetail] ([incomingrawmaterialid], [rawmaterialid], [priceper100gram], [bestbeforedate], [weightingram]) VALUES (1, 5, 2, CAST(N'2019-10-01 00:00:00.000' AS DateTime), 798400)
INSERT [dbo].[incomingrawmaterialdetail] ([incomingrawmaterialid], [rawmaterialid], [priceper100gram], [bestbeforedate], [weightingram]) VALUES (2, 6, 1, CAST(N'2019-11-12 00:00:00.000' AS DateTime), 896800)
INSERT [dbo].[incomingrawmaterialdetail] ([incomingrawmaterialid], [rawmaterialid], [priceper100gram], [bestbeforedate], [weightingram]) VALUES (2, 7, 3, CAST(N'2019-11-12 00:00:00.000' AS DateTime), 410000)
INSERT [dbo].[incomingrawmaterialdetail] ([incomingrawmaterialid], [rawmaterialid], [priceper100gram], [bestbeforedate], [weightingram]) VALUES (2, 8, 3, CAST(N'2019-11-12 00:00:00.000' AS DateTime), 120000)
INSERT [dbo].[incomingrawmaterialdetail] ([incomingrawmaterialid], [rawmaterialid], [priceper100gram], [bestbeforedate], [weightingram]) VALUES (2, 9, 2, CAST(N'2019-11-12 00:00:00.000' AS DateTime), 849864)
INSERT [dbo].[incomingrawmaterialdetail] ([incomingrawmaterialid], [rawmaterialid], [priceper100gram], [bestbeforedate], [weightingram]) VALUES (2, 10, 1, CAST(N'2019-11-12 00:00:00.000' AS DateTime), 900000)
INSERT [dbo].[incomingrawmaterialdetail] ([incomingrawmaterialid], [rawmaterialid], [priceper100gram], [bestbeforedate], [weightingram]) VALUES (2, 11, 1, CAST(N'2019-11-12 00:00:00.000' AS DateTime), 220000)
INSERT [dbo].[incomingrawmaterialdetail] ([incomingrawmaterialid], [rawmaterialid], [priceper100gram], [bestbeforedate], [weightingram]) VALUES (3, 12, 2, CAST(N'2019-07-12 00:00:00.000' AS DateTime), 97200)
INSERT [dbo].[incomingrawmaterialdetail] ([incomingrawmaterialid], [rawmaterialid], [priceper100gram], [bestbeforedate], [weightingram]) VALUES (3, 13, 3, CAST(N'2019-07-12 00:00:00.000' AS DateTime), 179200)
INSERT [dbo].[incomingrawmaterialdetail] ([incomingrawmaterialid], [rawmaterialid], [priceper100gram], [bestbeforedate], [weightingram]) VALUES (3, 14, 2, CAST(N'2019-07-12 00:00:00.000' AS DateTime), 169200)
INSERT [dbo].[incomingrawmaterialdetail] ([incomingrawmaterialid], [rawmaterialid], [priceper100gram], [bestbeforedate], [weightingram]) VALUES (3, 15, 2, CAST(N'2019-07-12 00:00:00.000' AS DateTime), 150000)
INSERT [dbo].[incomingrawmaterialdetail] ([incomingrawmaterialid], [rawmaterialid], [priceper100gram], [bestbeforedate], [weightingram]) VALUES (4, 1, 2, CAST(N'2019-07-12 00:00:00.000' AS DateTime), 104276)
INSERT [dbo].[incomingrawmaterialdetail] ([incomingrawmaterialid], [rawmaterialid], [priceper100gram], [bestbeforedate], [weightingram]) VALUES (4, 2, 3, CAST(N'2019-07-12 00:00:00.000' AS DateTime), 150000)
INSERT [dbo].[incomingrawmaterialdetail] ([incomingrawmaterialid], [rawmaterialid], [priceper100gram], [bestbeforedate], [weightingram]) VALUES (4, 3, 3, CAST(N'2019-07-12 00:00:00.000' AS DateTime), 800000)
INSERT [dbo].[incomingrawmaterialdetail] ([incomingrawmaterialid], [rawmaterialid], [priceper100gram], [bestbeforedate], [weightingram]) VALUES (4, 4, 2, CAST(N'2019-07-12 00:00:00.000' AS DateTime), 100000)
INSERT [dbo].[incomingrawmaterialdetail] ([incomingrawmaterialid], [rawmaterialid], [priceper100gram], [bestbeforedate], [weightingram]) VALUES (4, 5, 1, CAST(N'2019-07-12 00:00:00.000' AS DateTime), 750000)
INSERT [dbo].[incomingrawmaterialdetail] ([incomingrawmaterialid], [rawmaterialid], [priceper100gram], [bestbeforedate], [weightingram]) VALUES (5, 6, 1, CAST(N'2019-11-12 00:00:00.000' AS DateTime), 900000)
INSERT [dbo].[incomingrawmaterialdetail] ([incomingrawmaterialid], [rawmaterialid], [priceper100gram], [bestbeforedate], [weightingram]) VALUES (5, 7, 2, CAST(N'2019-11-12 00:00:00.000' AS DateTime), 110000)
INSERT [dbo].[incomingrawmaterialdetail] ([incomingrawmaterialid], [rawmaterialid], [priceper100gram], [bestbeforedate], [weightingram]) VALUES (5, 8, 2, CAST(N'2019-11-12 00:00:00.000' AS DateTime), 120000)
INSERT [dbo].[incomingrawmaterialdetail] ([incomingrawmaterialid], [rawmaterialid], [priceper100gram], [bestbeforedate], [weightingram]) VALUES (5, 9, 3, CAST(N'2019-11-12 00:00:00.000' AS DateTime), 850000)
INSERT [dbo].[incomingrawmaterialdetail] ([incomingrawmaterialid], [rawmaterialid], [priceper100gram], [bestbeforedate], [weightingram]) VALUES (6, 10, 3, CAST(N'2019-11-12 00:00:00.000' AS DateTime), 900000)
INSERT [dbo].[incomingrawmaterialdetail] ([incomingrawmaterialid], [rawmaterialid], [priceper100gram], [bestbeforedate], [weightingram]) VALUES (6, 11, 1, CAST(N'2019-10-01 00:00:00.000' AS DateTime), 120000)
INSERT [dbo].[incomingrawmaterialdetail] ([incomingrawmaterialid], [rawmaterialid], [priceper100gram], [bestbeforedate], [weightingram]) VALUES (6, 12, 1, CAST(N'2019-10-01 00:00:00.000' AS DateTime), 200000)
INSERT [dbo].[incomingrawmaterialdetail] ([incomingrawmaterialid], [rawmaterialid], [priceper100gram], [bestbeforedate], [weightingram]) VALUES (6, 13, 1, CAST(N'2019-10-01 00:00:00.000' AS DateTime), 380000)
INSERT [dbo].[incomingrawmaterialdetail] ([incomingrawmaterialid], [rawmaterialid], [priceper100gram], [bestbeforedate], [weightingram]) VALUES (7, 14, 2, CAST(N'2019-10-01 00:00:00.000' AS DateTime), 370000)
INSERT [dbo].[incomingrawmaterialdetail] ([incomingrawmaterialid], [rawmaterialid], [priceper100gram], [bestbeforedate], [weightingram]) VALUES (7, 15, 2, CAST(N'2019-10-01 00:00:00.000' AS DateTime), 450000)
INSERT [dbo].[incomingrawmaterialdetail] ([incomingrawmaterialid], [rawmaterialid], [priceper100gram], [bestbeforedate], [weightingram]) VALUES (10, 1, 100, CAST(N'2016-12-22 15:16:03.000' AS DateTime), 1000)
INSERT [dbo].[incomingrawmaterialdetail] ([incomingrawmaterialid], [rawmaterialid], [priceper100gram], [bestbeforedate], [weightingram]) VALUES (10, 4, 100, CAST(N'2016-12-31 15:16:03.000' AS DateTime), 3000)
INSERT [dbo].[incomingrawmaterialdetail] ([incomingrawmaterialid], [rawmaterialid], [priceper100gram], [bestbeforedate], [weightingram]) VALUES (11, 11, 100, CAST(N'2016-12-31 15:16:03.000' AS DateTime), 3000)
INSERT [dbo].[incomingrawmaterialdetail] ([incomingrawmaterialid], [rawmaterialid], [priceper100gram], [bestbeforedate], [weightingram]) VALUES (11, 14, 2100, CAST(N'2016-12-31 15:16:03.000' AS DateTime), 2000)
SET IDENTITY_INSERT [dbo].[incomingrawmaterialheader] ON 

INSERT [dbo].[incomingrawmaterialheader] ([incomingrawmaterialid], [incomingdate], [employeeid], [description]) VALUES (1, CAST(N'2016-09-12 00:00:00.000' AS DateTime), 1, N'Incoming Raw Material at 3.00 PM Afternoon')
INSERT [dbo].[incomingrawmaterialheader] ([incomingrawmaterialid], [incomingdate], [employeeid], [description]) VALUES (2, CAST(N'2016-09-13 00:00:00.000' AS DateTime), 2, N'Incoming Raw Material at 10.00 AM Morning')
INSERT [dbo].[incomingrawmaterialheader] ([incomingrawmaterialid], [incomingdate], [employeeid], [description]) VALUES (3, CAST(N'2016-09-14 00:00:00.000' AS DateTime), 3, N'Late Incoming Raw Material at 9.00 PM Evening')
INSERT [dbo].[incomingrawmaterialheader] ([incomingrawmaterialid], [incomingdate], [employeeid], [description]) VALUES (4, CAST(N'2016-09-15 00:00:00.000' AS DateTime), 4, N'Incoming Raw Material at 3.00 PM Afternoon')
INSERT [dbo].[incomingrawmaterialheader] ([incomingrawmaterialid], [incomingdate], [employeeid], [description]) VALUES (5, CAST(N'2016-09-16 00:00:00.000' AS DateTime), 1, N'Incoming Raw Material at 12.00 PM Afternoon')
INSERT [dbo].[incomingrawmaterialheader] ([incomingrawmaterialid], [incomingdate], [employeeid], [description]) VALUES (6, CAST(N'2016-09-17 00:00:00.000' AS DateTime), 2, N'Incoming Raw Material at 5.00 PM Afternoon')
INSERT [dbo].[incomingrawmaterialheader] ([incomingrawmaterialid], [incomingdate], [employeeid], [description]) VALUES (7, CAST(N'2016-09-18 00:00:00.000' AS DateTime), 3, N'Early Incoming Raw Material at 5.00 AM Morning')
INSERT [dbo].[incomingrawmaterialheader] ([incomingrawmaterialid], [incomingdate], [employeeid], [description]) VALUES (10, CAST(N'2016-12-22 15:16:03.963' AS DateTime), 1, N'asdasd')
INSERT [dbo].[incomingrawmaterialheader] ([incomingrawmaterialid], [incomingdate], [employeeid], [description]) VALUES (11, CAST(N'2016-12-22 15:16:03.963' AS DateTime), 1, N'Incoming')
SET IDENTITY_INSERT [dbo].[incomingrawmaterialheader] OFF
SET IDENTITY_INSERT [dbo].[productiondetail] ON 

INSERT [dbo].[productiondetail] ([productionid], [batchnumber], [foodid], [productionoutputqty], [expireddate]) VALUES (1, 1, 1, 100, CAST(N'2016-10-07 00:00:00.000' AS DateTime))
INSERT [dbo].[productiondetail] ([productionid], [batchnumber], [foodid], [productionoutputqty], [expireddate]) VALUES (1, 1, 2, 80, CAST(N'2017-10-07 00:00:00.000' AS DateTime))
INSERT [dbo].[productiondetail] ([productionid], [batchnumber], [foodid], [productionoutputqty], [expireddate]) VALUES (1, 1, 3, 100, CAST(N'2017-10-07 00:00:00.000' AS DateTime))
INSERT [dbo].[productiondetail] ([productionid], [batchnumber], [foodid], [productionoutputqty], [expireddate]) VALUES (1, 2, 1, 70, CAST(N'2017-10-07 00:00:00.000' AS DateTime))
INSERT [dbo].[productiondetail] ([productionid], [batchnumber], [foodid], [productionoutputqty], [expireddate]) VALUES (1, 2, 4, 70, CAST(N'2017-10-07 00:00:00.000' AS DateTime))
INSERT [dbo].[productiondetail] ([productionid], [batchnumber], [foodid], [productionoutputqty], [expireddate]) VALUES (1, 2, 5, 70, CAST(N'2017-10-07 00:00:00.000' AS DateTime))
INSERT [dbo].[productiondetail] ([productionid], [batchnumber], [foodid], [productionoutputqty], [expireddate]) VALUES (2, 3, 1, 80, CAST(N'2017-10-08 00:00:00.000' AS DateTime))
INSERT [dbo].[productiondetail] ([productionid], [batchnumber], [foodid], [productionoutputqty], [expireddate]) VALUES (2, 3, 2, 100, CAST(N'2017-10-08 00:00:00.000' AS DateTime))
INSERT [dbo].[productiondetail] ([productionid], [batchnumber], [foodid], [productionoutputqty], [expireddate]) VALUES (2, 3, 3, 80, CAST(N'2017-10-08 00:00:00.000' AS DateTime))
INSERT [dbo].[productiondetail] ([productionid], [batchnumber], [foodid], [productionoutputqty], [expireddate]) VALUES (2, 4, 4, 70, CAST(N'2017-10-08 00:00:00.000' AS DateTime))
INSERT [dbo].[productiondetail] ([productionid], [batchnumber], [foodid], [productionoutputqty], [expireddate]) VALUES (2, 4, 5, 70, CAST(N'2017-10-08 00:00:00.000' AS DateTime))
INSERT [dbo].[productiondetail] ([productionid], [batchnumber], [foodid], [productionoutputqty], [expireddate]) VALUES (2, 4, 6, 70, CAST(N'2017-10-08 00:00:00.000' AS DateTime))
INSERT [dbo].[productiondetail] ([productionid], [batchnumber], [foodid], [productionoutputqty], [expireddate]) VALUES (3, 5, 1, 53, CAST(N'2017-10-09 00:00:00.000' AS DateTime))
INSERT [dbo].[productiondetail] ([productionid], [batchnumber], [foodid], [productionoutputqty], [expireddate]) VALUES (3, 5, 2, 78, CAST(N'2017-10-09 00:00:00.000' AS DateTime))
INSERT [dbo].[productiondetail] ([productionid], [batchnumber], [foodid], [productionoutputqty], [expireddate]) VALUES (3, 5, 3, 80, CAST(N'2017-10-09 00:00:00.000' AS DateTime))
INSERT [dbo].[productiondetail] ([productionid], [batchnumber], [foodid], [productionoutputqty], [expireddate]) VALUES (3, 6, 4, 70, CAST(N'2017-10-09 00:00:00.000' AS DateTime))
INSERT [dbo].[productiondetail] ([productionid], [batchnumber], [foodid], [productionoutputqty], [expireddate]) VALUES (3, 6, 5, 70, CAST(N'2017-10-09 00:00:00.000' AS DateTime))
INSERT [dbo].[productiondetail] ([productionid], [batchnumber], [foodid], [productionoutputqty], [expireddate]) VALUES (3, 6, 6, 70, CAST(N'2017-10-09 00:00:00.000' AS DateTime))
INSERT [dbo].[productiondetail] ([productionid], [batchnumber], [foodid], [productionoutputqty], [expireddate]) VALUES (4, 7, 1, 100, CAST(N'2017-10-10 00:00:00.000' AS DateTime))
INSERT [dbo].[productiondetail] ([productionid], [batchnumber], [foodid], [productionoutputqty], [expireddate]) VALUES (4, 7, 2, 80, CAST(N'2017-10-10 00:00:00.000' AS DateTime))
INSERT [dbo].[productiondetail] ([productionid], [batchnumber], [foodid], [productionoutputqty], [expireddate]) VALUES (4, 7, 3, 80, CAST(N'2017-10-10 00:00:00.000' AS DateTime))
INSERT [dbo].[productiondetail] ([productionid], [batchnumber], [foodid], [productionoutputqty], [expireddate]) VALUES (4, 8, 4, 70, CAST(N'2017-10-10 00:00:00.000' AS DateTime))
INSERT [dbo].[productiondetail] ([productionid], [batchnumber], [foodid], [productionoutputqty], [expireddate]) VALUES (4, 8, 5, 70, CAST(N'2017-10-10 00:00:00.000' AS DateTime))
INSERT [dbo].[productiondetail] ([productionid], [batchnumber], [foodid], [productionoutputqty], [expireddate]) VALUES (4, 8, 6, 70, CAST(N'2017-10-10 00:00:00.000' AS DateTime))
INSERT [dbo].[productiondetail] ([productionid], [batchnumber], [foodid], [productionoutputqty], [expireddate]) VALUES (5, 9, 1, 100, CAST(N'2017-10-11 00:00:00.000' AS DateTime))
INSERT [dbo].[productiondetail] ([productionid], [batchnumber], [foodid], [productionoutputqty], [expireddate]) VALUES (5, 9, 2, 80, CAST(N'2017-10-11 00:00:00.000' AS DateTime))
INSERT [dbo].[productiondetail] ([productionid], [batchnumber], [foodid], [productionoutputqty], [expireddate]) VALUES (5, 9, 3, 80, CAST(N'2017-10-11 00:00:00.000' AS DateTime))
INSERT [dbo].[productiondetail] ([productionid], [batchnumber], [foodid], [productionoutputqty], [expireddate]) VALUES (5, 10, 4, 70, CAST(N'2017-10-11 00:00:00.000' AS DateTime))
INSERT [dbo].[productiondetail] ([productionid], [batchnumber], [foodid], [productionoutputqty], [expireddate]) VALUES (5, 10, 5, 70, CAST(N'2017-10-11 00:00:00.000' AS DateTime))
INSERT [dbo].[productiondetail] ([productionid], [batchnumber], [foodid], [productionoutputqty], [expireddate]) VALUES (5, 10, 6, 70, CAST(N'2017-10-11 00:00:00.000' AS DateTime))
INSERT [dbo].[productiondetail] ([productionid], [batchnumber], [foodid], [productionoutputqty], [expireddate]) VALUES (6, 11, 1, 100, CAST(N'2017-10-12 00:00:00.000' AS DateTime))
INSERT [dbo].[productiondetail] ([productionid], [batchnumber], [foodid], [productionoutputqty], [expireddate]) VALUES (6, 11, 2, 80, CAST(N'2017-10-12 00:00:00.000' AS DateTime))
INSERT [dbo].[productiondetail] ([productionid], [batchnumber], [foodid], [productionoutputqty], [expireddate]) VALUES (6, 11, 3, 80, CAST(N'2017-10-12 00:00:00.000' AS DateTime))
INSERT [dbo].[productiondetail] ([productionid], [batchnumber], [foodid], [productionoutputqty], [expireddate]) VALUES (6, 12, 4, 70, CAST(N'2017-10-12 00:00:00.000' AS DateTime))
INSERT [dbo].[productiondetail] ([productionid], [batchnumber], [foodid], [productionoutputqty], [expireddate]) VALUES (6, 12, 5, 70, CAST(N'2017-10-12 00:00:00.000' AS DateTime))
INSERT [dbo].[productiondetail] ([productionid], [batchnumber], [foodid], [productionoutputqty], [expireddate]) VALUES (6, 12, 6, 35, CAST(N'2017-10-12 00:00:00.000' AS DateTime))
INSERT [dbo].[productiondetail] ([productionid], [batchnumber], [foodid], [productionoutputqty], [expireddate]) VALUES (7, 13, 1, 50, CAST(N'2017-10-13 00:00:00.000' AS DateTime))
INSERT [dbo].[productiondetail] ([productionid], [batchnumber], [foodid], [productionoutputqty], [expireddate]) VALUES (7, 13, 2, 40, CAST(N'2017-10-13 00:00:00.000' AS DateTime))
INSERT [dbo].[productiondetail] ([productionid], [batchnumber], [foodid], [productionoutputqty], [expireddate]) VALUES (7, 13, 3, 40, CAST(N'2017-10-13 00:00:00.000' AS DateTime))
INSERT [dbo].[productiondetail] ([productionid], [batchnumber], [foodid], [productionoutputqty], [expireddate]) VALUES (7, 14, 4, 35, CAST(N'2017-10-13 00:00:00.000' AS DateTime))
INSERT [dbo].[productiondetail] ([productionid], [batchnumber], [foodid], [productionoutputqty], [expireddate]) VALUES (7, 14, 5, 35, CAST(N'2017-10-13 00:00:00.000' AS DateTime))
INSERT [dbo].[productiondetail] ([productionid], [batchnumber], [foodid], [productionoutputqty], [expireddate]) VALUES (7, 14, 6, 35, CAST(N'2017-10-13 00:00:00.000' AS DateTime))
INSERT [dbo].[productiondetail] ([productionid], [batchnumber], [foodid], [productionoutputqty], [expireddate]) VALUES (8, 15, 1, 100, CAST(N'2017-10-14 00:00:00.000' AS DateTime))
INSERT [dbo].[productiondetail] ([productionid], [batchnumber], [foodid], [productionoutputqty], [expireddate]) VALUES (8, 15, 2, 80, CAST(N'2017-10-14 00:00:00.000' AS DateTime))
INSERT [dbo].[productiondetail] ([productionid], [batchnumber], [foodid], [productionoutputqty], [expireddate]) VALUES (8, 15, 3, 80, CAST(N'2017-10-14 00:00:00.000' AS DateTime))
INSERT [dbo].[productiondetail] ([productionid], [batchnumber], [foodid], [productionoutputqty], [expireddate]) VALUES (8, 16, 4, 70, CAST(N'2017-10-14 00:00:00.000' AS DateTime))
INSERT [dbo].[productiondetail] ([productionid], [batchnumber], [foodid], [productionoutputqty], [expireddate]) VALUES (8, 16, 5, 70, CAST(N'2017-10-14 00:00:00.000' AS DateTime))
INSERT [dbo].[productiondetail] ([productionid], [batchnumber], [foodid], [productionoutputqty], [expireddate]) VALUES (8, 16, 6, 70, CAST(N'2017-10-14 00:00:00.000' AS DateTime))
INSERT [dbo].[productiondetail] ([productionid], [batchnumber], [foodid], [productionoutputqty], [expireddate]) VALUES (9, 17, 1, 1825, CAST(N'2016-12-22 17:57:47.300' AS DateTime))
INSERT [dbo].[productiondetail] ([productionid], [batchnumber], [foodid], [productionoutputqty], [expireddate]) VALUES (10, 18, 1, 3000, CAST(N'2016-12-22 17:57:47.300' AS DateTime))
INSERT [dbo].[productiondetail] ([productionid], [batchnumber], [foodid], [productionoutputqty], [expireddate]) VALUES (11, 19, 1, 500, CAST(N'2016-12-22 17:57:47.300' AS DateTime))
INSERT [dbo].[productiondetail] ([productionid], [batchnumber], [foodid], [productionoutputqty], [expireddate]) VALUES (12, 20, 1, 500, CAST(N'2016-12-22 17:57:47.300' AS DateTime))
INSERT [dbo].[productiondetail] ([productionid], [batchnumber], [foodid], [productionoutputqty], [expireddate]) VALUES (13, 21, 1, 800, CAST(N'2016-12-22 17:57:47.300' AS DateTime))
INSERT [dbo].[productiondetail] ([productionid], [batchnumber], [foodid], [productionoutputqty], [expireddate]) VALUES (14, 22, 1, 34, CAST(N'2016-12-22 17:57:47.300' AS DateTime))
INSERT [dbo].[productiondetail] ([productionid], [batchnumber], [foodid], [productionoutputqty], [expireddate]) VALUES (15, 24, 1, 1933, CAST(N'2016-12-22 17:59:40.547' AS DateTime))
INSERT [dbo].[productiondetail] ([productionid], [batchnumber], [foodid], [productionoutputqty], [expireddate]) VALUES (15, 25, 1, 3000, CAST(N'2016-12-22 17:59:40.547' AS DateTime))
INSERT [dbo].[productiondetail] ([productionid], [batchnumber], [foodid], [productionoutputqty], [expireddate]) VALUES (15, 26, 1, 500, CAST(N'2016-12-22 17:59:40.547' AS DateTime))
INSERT [dbo].[productiondetail] ([productionid], [batchnumber], [foodid], [productionoutputqty], [expireddate]) VALUES (15, 27, 1, 500, CAST(N'2016-12-22 17:59:40.547' AS DateTime))
INSERT [dbo].[productiondetail] ([productionid], [batchnumber], [foodid], [productionoutputqty], [expireddate]) VALUES (15, 28, 1, 800, CAST(N'2016-12-22 17:59:40.547' AS DateTime))
INSERT [dbo].[productiondetail] ([productionid], [batchnumber], [foodid], [productionoutputqty], [expireddate]) VALUES (15, 29, 1, 34, CAST(N'2016-12-22 17:59:40.547' AS DateTime))
INSERT [dbo].[productiondetail] ([productionid], [batchnumber], [foodid], [productionoutputqty], [expireddate]) VALUES (15, 30, 1, 700, CAST(N'2016-12-22 17:59:40.547' AS DateTime))
SET IDENTITY_INSERT [dbo].[productiondetail] OFF
SET IDENTITY_INSERT [dbo].[productionheader] ON 

INSERT [dbo].[productionheader] ([productionid], [productiondate], [description], [employeeid], [status]) VALUES (1, CAST(N'2017-10-01 00:00:00.000' AS DateTime), N'Production at 9.00 AM Morning', 1, N'A')
INSERT [dbo].[productionheader] ([productionid], [productiondate], [description], [employeeid], [status]) VALUES (2, CAST(N'2017-10-02 00:00:00.000' AS DateTime), N'Production at 9.00 AM Morning', 2, N'A')
INSERT [dbo].[productionheader] ([productionid], [productiondate], [description], [employeeid], [status]) VALUES (3, CAST(N'2017-10-03 00:00:00.000' AS DateTime), N'Production at 10.00 AM Morning', 3, N'A')
INSERT [dbo].[productionheader] ([productionid], [productiondate], [description], [employeeid], [status]) VALUES (4, CAST(N'2017-10-04 00:00:00.000' AS DateTime), N'Production at 9.00 AM Morning', 4, N'A')
INSERT [dbo].[productionheader] ([productionid], [productiondate], [description], [employeeid], [status]) VALUES (5, CAST(N'2017-10-05 00:00:00.000' AS DateTime), N'Production at 8.00 AM Morning', 1, N'A')
INSERT [dbo].[productionheader] ([productionid], [productiondate], [description], [employeeid], [status]) VALUES (6, CAST(N'2017-10-06 00:00:00.000' AS DateTime), N'Production at 7.00 AM Morning', 2, N'A')
INSERT [dbo].[productionheader] ([productionid], [productiondate], [description], [employeeid], [status]) VALUES (7, CAST(N'2017-10-07 00:00:00.000' AS DateTime), N'Production at 1.00 PM Afternoon', 3, N'A')
INSERT [dbo].[productionheader] ([productionid], [productiondate], [description], [employeeid], [status]) VALUES (8, CAST(N'2017-10-08 00:00:00.000' AS DateTime), N'Production at 9.00 AM Morning', 4, N'A')
INSERT [dbo].[productionheader] ([productionid], [productiondate], [description], [employeeid], [status]) VALUES (9, CAST(N'2016-12-22 17:42:17.170' AS DateTime), N'', 1, N'A')
INSERT [dbo].[productionheader] ([productionid], [productiondate], [description], [employeeid], [status]) VALUES (10, CAST(N'2016-12-22 17:45:21.673' AS DateTime), N'', 1, N'A')
INSERT [dbo].[productionheader] ([productionid], [productiondate], [description], [employeeid], [status]) VALUES (11, CAST(N'2016-12-22 17:49:11.377' AS DateTime), N'', 1, N'A')
INSERT [dbo].[productionheader] ([productionid], [productiondate], [description], [employeeid], [status]) VALUES (12, CAST(N'2016-12-30 17:54:49.000' AS DateTime), N'Production at 17:54:49', 1, N'A')
INSERT [dbo].[productionheader] ([productionid], [productiondate], [description], [employeeid], [status]) VALUES (13, CAST(N'2016-12-22 17:55:55.960' AS DateTime), N'Production at 17:55:55.9592865', 1, N'A')
INSERT [dbo].[productionheader] ([productionid], [productiondate], [description], [employeeid], [status]) VALUES (14, CAST(N'2016-12-22 17:57:47.300' AS DateTime), N'Production at 17:57:47.3005316', 1, N'A')
INSERT [dbo].[productionheader] ([productionid], [productiondate], [description], [employeeid], [status]) VALUES (15, CAST(N'2016-12-22 17:59:40.547' AS DateTime), N'Production at 17:59:40.5451307', 1, N'A')
SET IDENTITY_INSERT [dbo].[productionheader] OFF
SET IDENTITY_INSERT [dbo].[rawmaterial] ON 

INSERT [dbo].[rawmaterial] ([rawmaterialid], [rawmaterialname], [description], [employeeid], [inputeddate], [status]) VALUES (1, N'Egg', N'Chicken Egg', 1, CAST(N'2016-12-22 10:10:02.027' AS DateTime), N'A')
INSERT [dbo].[rawmaterial] ([rawmaterialid], [rawmaterialname], [description], [employeeid], [inputeddate], [status]) VALUES (2, N'Flour', N'Bogarasa Flour', 1, CAST(N'2016-12-22 10:10:02.057' AS DateTime), N'A')
INSERT [dbo].[rawmaterial] ([rawmaterialid], [rawmaterialname], [description], [employeeid], [inputeddate], [status]) VALUES (3, N'Margarin', N'Blueband Margarin', 1, CAST(N'2016-12-22 10:10:02.073' AS DateTime), N'A')
INSERT [dbo].[rawmaterial] ([rawmaterialid], [rawmaterialname], [description], [employeeid], [inputeddate], [status]) VALUES (4, N'Sugar', N'Gulaku Sugar', 1, CAST(N'2016-12-22 10:10:02.073' AS DateTime), N'A')
INSERT [dbo].[rawmaterial] ([rawmaterialid], [rawmaterialname], [description], [employeeid], [inputeddate], [status]) VALUES (5, N'Yeast', N'Yeast is an ingredient to make the bread expand', 1, CAST(N'2016-12-22 10:10:02.073' AS DateTime), N'A')
INSERT [dbo].[rawmaterial] ([rawmaterialid], [rawmaterialname], [description], [employeeid], [inputeddate], [status]) VALUES (6, N'Cocoa', N'Dark Chocolate Flour', 1, CAST(N'2016-12-22 10:10:02.073' AS DateTime), N'A')
INSERT [dbo].[rawmaterial] ([rawmaterialid], [rawmaterialname], [description], [employeeid], [inputeddate], [status]) VALUES (7, N'Beef Meat', N'Beef Meat is bacon beef meat', 1, CAST(N'2016-12-22 10:10:02.090' AS DateTime), N'A')
INSERT [dbo].[rawmaterial] ([rawmaterialid], [rawmaterialname], [description], [employeeid], [inputeddate], [status]) VALUES (8, N'Cheese', N'Cheddar single cheese used to layered the burger', 1, CAST(N'2016-12-22 10:10:02.090' AS DateTime), N'A')
INSERT [dbo].[rawmaterial] ([rawmaterialid], [rawmaterialname], [description], [employeeid], [inputeddate], [status]) VALUES (9, N'Tomato', N'Tomato', 1, CAST(N'2016-12-22 10:10:02.090' AS DateTime), N'A')
INSERT [dbo].[rawmaterial] ([rawmaterialid], [rawmaterialname], [description], [employeeid], [inputeddate], [status]) VALUES (10, N'Lettuce', N'Lettuce', 1, CAST(N'2016-12-22 10:10:02.090' AS DateTime), N'A')
INSERT [dbo].[rawmaterial] ([rawmaterialid], [rawmaterialname], [description], [employeeid], [inputeddate], [status]) VALUES (11, N'Sauce', N'Mustard, Mayonaise, and Chilli Sauce', 1, CAST(N'2016-12-22 10:10:02.103' AS DateTime), N'A')
INSERT [dbo].[rawmaterial] ([rawmaterialid], [rawmaterialname], [description], [employeeid], [inputeddate], [status]) VALUES (12, N'Chocolate Block', N'Cadburry Chocolate Block', 1, CAST(N'2016-12-22 10:10:02.103' AS DateTime), N'A')
INSERT [dbo].[rawmaterial] ([rawmaterialid], [rawmaterialname], [description], [employeeid], [inputeddate], [status]) VALUES (13, N'Cream Cheese', N'Cheddar Cream Cheese', 1, CAST(N'2016-12-22 10:10:02.103' AS DateTime), N'A')
INSERT [dbo].[rawmaterial] ([rawmaterialid], [rawmaterialname], [description], [employeeid], [inputeddate], [status]) VALUES (14, N'Cheese Block', N'Cheddar Cheese Block', 1, CAST(N'2016-12-22 10:10:02.103' AS DateTime), N'A')
INSERT [dbo].[rawmaterial] ([rawmaterialid], [rawmaterialname], [description], [employeeid], [inputeddate], [status]) VALUES (15, N'Mozarella', N'Mozarella Cheese for pizza ingredient', 1, CAST(N'2016-12-22 10:10:02.120' AS DateTime), N'A')
SET IDENTITY_INSERT [dbo].[rawmaterial] OFF
INSERT [dbo].[rawmaterialintake] ([batchnumber], [rawmaterialid], [incomingrawmaterialid], [weightingram]) VALUES (1, 1, 1, 40000)
INSERT [dbo].[rawmaterialintake] ([batchnumber], [rawmaterialid], [incomingrawmaterialid], [weightingram]) VALUES (1, 2, 1, 50000)
INSERT [dbo].[rawmaterialintake] ([batchnumber], [rawmaterialid], [incomingrawmaterialid], [weightingram]) VALUES (1, 3, 1, 40000)
INSERT [dbo].[rawmaterialintake] ([batchnumber], [rawmaterialid], [incomingrawmaterialid], [weightingram]) VALUES (1, 4, 1, 50000)
INSERT [dbo].[rawmaterialintake] ([batchnumber], [rawmaterialid], [incomingrawmaterialid], [weightingram]) VALUES (1, 5, 1, 25000)
INSERT [dbo].[rawmaterialintake] ([batchnumber], [rawmaterialid], [incomingrawmaterialid], [weightingram]) VALUES (1, 6, 1, 30000)
INSERT [dbo].[rawmaterialintake] ([batchnumber], [rawmaterialid], [incomingrawmaterialid], [weightingram]) VALUES (1, 7, 1, 37000)
INSERT [dbo].[rawmaterialintake] ([batchnumber], [rawmaterialid], [incomingrawmaterialid], [weightingram]) VALUES (1, 8, 1, 30000)
INSERT [dbo].[rawmaterialintake] ([batchnumber], [rawmaterialid], [incomingrawmaterialid], [weightingram]) VALUES (1, 9, 1, 29000)
INSERT [dbo].[rawmaterialintake] ([batchnumber], [rawmaterialid], [incomingrawmaterialid], [weightingram]) VALUES (1, 10, 1, 30000)
INSERT [dbo].[rawmaterialintake] ([batchnumber], [rawmaterialid], [incomingrawmaterialid], [weightingram]) VALUES (1, 11, 1, 40000)
INSERT [dbo].[rawmaterialintake] ([batchnumber], [rawmaterialid], [incomingrawmaterialid], [weightingram]) VALUES (1, 12, 1, 33000)
INSERT [dbo].[rawmaterialintake] ([batchnumber], [rawmaterialid], [incomingrawmaterialid], [weightingram]) VALUES (1, 13, 1, 60000)
INSERT [dbo].[rawmaterialintake] ([batchnumber], [rawmaterialid], [incomingrawmaterialid], [weightingram]) VALUES (1, 14, 1, 64000)
INSERT [dbo].[rawmaterialintake] ([batchnumber], [rawmaterialid], [incomingrawmaterialid], [weightingram]) VALUES (1, 15, 1, 50000)
INSERT [dbo].[rawmaterialintake] ([batchnumber], [rawmaterialid], [incomingrawmaterialid], [weightingram]) VALUES (2, 1, 1, 40000)
INSERT [dbo].[rawmaterialintake] ([batchnumber], [rawmaterialid], [incomingrawmaterialid], [weightingram]) VALUES (2, 2, 1, 50000)
INSERT [dbo].[rawmaterialintake] ([batchnumber], [rawmaterialid], [incomingrawmaterialid], [weightingram]) VALUES (2, 3, 1, 40000)
INSERT [dbo].[rawmaterialintake] ([batchnumber], [rawmaterialid], [incomingrawmaterialid], [weightingram]) VALUES (2, 4, 1, 50000)
INSERT [dbo].[rawmaterialintake] ([batchnumber], [rawmaterialid], [incomingrawmaterialid], [weightingram]) VALUES (2, 5, 1, 25000)
INSERT [dbo].[rawmaterialintake] ([batchnumber], [rawmaterialid], [incomingrawmaterialid], [weightingram]) VALUES (2, 6, 1, 30000)
INSERT [dbo].[rawmaterialintake] ([batchnumber], [rawmaterialid], [incomingrawmaterialid], [weightingram]) VALUES (2, 7, 1, 37000)
INSERT [dbo].[rawmaterialintake] ([batchnumber], [rawmaterialid], [incomingrawmaterialid], [weightingram]) VALUES (2, 8, 1, 30000)
INSERT [dbo].[rawmaterialintake] ([batchnumber], [rawmaterialid], [incomingrawmaterialid], [weightingram]) VALUES (2, 9, 1, 29000)
INSERT [dbo].[rawmaterialintake] ([batchnumber], [rawmaterialid], [incomingrawmaterialid], [weightingram]) VALUES (2, 10, 1, 30000)
INSERT [dbo].[rawmaterialintake] ([batchnumber], [rawmaterialid], [incomingrawmaterialid], [weightingram]) VALUES (2, 11, 1, 40000)
INSERT [dbo].[rawmaterialintake] ([batchnumber], [rawmaterialid], [incomingrawmaterialid], [weightingram]) VALUES (2, 12, 1, 33000)
INSERT [dbo].[rawmaterialintake] ([batchnumber], [rawmaterialid], [incomingrawmaterialid], [weightingram]) VALUES (2, 13, 1, 60000)
INSERT [dbo].[rawmaterialintake] ([batchnumber], [rawmaterialid], [incomingrawmaterialid], [weightingram]) VALUES (2, 14, 1, 64000)
INSERT [dbo].[rawmaterialintake] ([batchnumber], [rawmaterialid], [incomingrawmaterialid], [weightingram]) VALUES (2, 15, 1, 50000)
INSERT [dbo].[rawmaterialintake] ([batchnumber], [rawmaterialid], [incomingrawmaterialid], [weightingram]) VALUES (3, 1, 1, 40000)
INSERT [dbo].[rawmaterialintake] ([batchnumber], [rawmaterialid], [incomingrawmaterialid], [weightingram]) VALUES (3, 2, 1, 50000)
INSERT [dbo].[rawmaterialintake] ([batchnumber], [rawmaterialid], [incomingrawmaterialid], [weightingram]) VALUES (3, 3, 1, 40000)
INSERT [dbo].[rawmaterialintake] ([batchnumber], [rawmaterialid], [incomingrawmaterialid], [weightingram]) VALUES (3, 4, 1, 50000)
INSERT [dbo].[rawmaterialintake] ([batchnumber], [rawmaterialid], [incomingrawmaterialid], [weightingram]) VALUES (3, 5, 1, 25000)
INSERT [dbo].[rawmaterialintake] ([batchnumber], [rawmaterialid], [incomingrawmaterialid], [weightingram]) VALUES (3, 6, 1, 30000)
INSERT [dbo].[rawmaterialintake] ([batchnumber], [rawmaterialid], [incomingrawmaterialid], [weightingram]) VALUES (3, 7, 1, 37000)
INSERT [dbo].[rawmaterialintake] ([batchnumber], [rawmaterialid], [incomingrawmaterialid], [weightingram]) VALUES (3, 8, 1, 30000)
INSERT [dbo].[rawmaterialintake] ([batchnumber], [rawmaterialid], [incomingrawmaterialid], [weightingram]) VALUES (3, 9, 1, 29000)
INSERT [dbo].[rawmaterialintake] ([batchnumber], [rawmaterialid], [incomingrawmaterialid], [weightingram]) VALUES (3, 10, 1, 30000)
INSERT [dbo].[rawmaterialintake] ([batchnumber], [rawmaterialid], [incomingrawmaterialid], [weightingram]) VALUES (3, 11, 1, 40000)
INSERT [dbo].[rawmaterialintake] ([batchnumber], [rawmaterialid], [incomingrawmaterialid], [weightingram]) VALUES (3, 12, 1, 33000)
INSERT [dbo].[rawmaterialintake] ([batchnumber], [rawmaterialid], [incomingrawmaterialid], [weightingram]) VALUES (3, 13, 1, 60000)
INSERT [dbo].[rawmaterialintake] ([batchnumber], [rawmaterialid], [incomingrawmaterialid], [weightingram]) VALUES (3, 14, 1, 64000)
INSERT [dbo].[rawmaterialintake] ([batchnumber], [rawmaterialid], [incomingrawmaterialid], [weightingram]) VALUES (3, 15, 1, 50000)
INSERT [dbo].[rawmaterialintake] ([batchnumber], [rawmaterialid], [incomingrawmaterialid], [weightingram]) VALUES (4, 1, 2, 40000)
INSERT [dbo].[rawmaterialintake] ([batchnumber], [rawmaterialid], [incomingrawmaterialid], [weightingram]) VALUES (4, 2, 2, 50000)
INSERT [dbo].[rawmaterialintake] ([batchnumber], [rawmaterialid], [incomingrawmaterialid], [weightingram]) VALUES (4, 3, 2, 40000)
INSERT [dbo].[rawmaterialintake] ([batchnumber], [rawmaterialid], [incomingrawmaterialid], [weightingram]) VALUES (4, 4, 2, 50000)
INSERT [dbo].[rawmaterialintake] ([batchnumber], [rawmaterialid], [incomingrawmaterialid], [weightingram]) VALUES (4, 5, 2, 25000)
INSERT [dbo].[rawmaterialintake] ([batchnumber], [rawmaterialid], [incomingrawmaterialid], [weightingram]) VALUES (4, 6, 2, 30000)
INSERT [dbo].[rawmaterialintake] ([batchnumber], [rawmaterialid], [incomingrawmaterialid], [weightingram]) VALUES (4, 7, 2, 37000)
INSERT [dbo].[rawmaterialintake] ([batchnumber], [rawmaterialid], [incomingrawmaterialid], [weightingram]) VALUES (4, 8, 2, 30000)
INSERT [dbo].[rawmaterialintake] ([batchnumber], [rawmaterialid], [incomingrawmaterialid], [weightingram]) VALUES (4, 9, 2, 29000)
INSERT [dbo].[rawmaterialintake] ([batchnumber], [rawmaterialid], [incomingrawmaterialid], [weightingram]) VALUES (4, 10, 2, 30000)
INSERT [dbo].[rawmaterialintake] ([batchnumber], [rawmaterialid], [incomingrawmaterialid], [weightingram]) VALUES (4, 11, 2, 40000)
INSERT [dbo].[rawmaterialintake] ([batchnumber], [rawmaterialid], [incomingrawmaterialid], [weightingram]) VALUES (4, 12, 2, 33000)
INSERT [dbo].[rawmaterialintake] ([batchnumber], [rawmaterialid], [incomingrawmaterialid], [weightingram]) VALUES (4, 13, 2, 60000)
INSERT [dbo].[rawmaterialintake] ([batchnumber], [rawmaterialid], [incomingrawmaterialid], [weightingram]) VALUES (4, 14, 2, 64000)
INSERT [dbo].[rawmaterialintake] ([batchnumber], [rawmaterialid], [incomingrawmaterialid], [weightingram]) VALUES (4, 15, 2, 50000)
INSERT [dbo].[rawmaterialintake] ([batchnumber], [rawmaterialid], [incomingrawmaterialid], [weightingram]) VALUES (5, 1, 2, 40000)
INSERT [dbo].[rawmaterialintake] ([batchnumber], [rawmaterialid], [incomingrawmaterialid], [weightingram]) VALUES (5, 2, 2, 50000)
INSERT [dbo].[rawmaterialintake] ([batchnumber], [rawmaterialid], [incomingrawmaterialid], [weightingram]) VALUES (5, 3, 2, 40000)
INSERT [dbo].[rawmaterialintake] ([batchnumber], [rawmaterialid], [incomingrawmaterialid], [weightingram]) VALUES (5, 4, 2, 50000)
INSERT [dbo].[rawmaterialintake] ([batchnumber], [rawmaterialid], [incomingrawmaterialid], [weightingram]) VALUES (5, 5, 2, 25000)
INSERT [dbo].[rawmaterialintake] ([batchnumber], [rawmaterialid], [incomingrawmaterialid], [weightingram]) VALUES (5, 6, 2, 30000)
INSERT [dbo].[rawmaterialintake] ([batchnumber], [rawmaterialid], [incomingrawmaterialid], [weightingram]) VALUES (5, 7, 2, 37000)
INSERT [dbo].[rawmaterialintake] ([batchnumber], [rawmaterialid], [incomingrawmaterialid], [weightingram]) VALUES (5, 8, 2, 30000)
INSERT [dbo].[rawmaterialintake] ([batchnumber], [rawmaterialid], [incomingrawmaterialid], [weightingram]) VALUES (5, 9, 2, 29000)
INSERT [dbo].[rawmaterialintake] ([batchnumber], [rawmaterialid], [incomingrawmaterialid], [weightingram]) VALUES (5, 10, 2, 30000)
INSERT [dbo].[rawmaterialintake] ([batchnumber], [rawmaterialid], [incomingrawmaterialid], [weightingram]) VALUES (5, 11, 2, 40000)
INSERT [dbo].[rawmaterialintake] ([batchnumber], [rawmaterialid], [incomingrawmaterialid], [weightingram]) VALUES (5, 12, 2, 33000)
INSERT [dbo].[rawmaterialintake] ([batchnumber], [rawmaterialid], [incomingrawmaterialid], [weightingram]) VALUES (5, 13, 2, 60000)
INSERT [dbo].[rawmaterialintake] ([batchnumber], [rawmaterialid], [incomingrawmaterialid], [weightingram]) VALUES (5, 14, 2, 64000)
INSERT [dbo].[rawmaterialintake] ([batchnumber], [rawmaterialid], [incomingrawmaterialid], [weightingram]) VALUES (5, 15, 2, 50000)
INSERT [dbo].[rawmaterialintake] ([batchnumber], [rawmaterialid], [incomingrawmaterialid], [weightingram]) VALUES (6, 1, 2, 40000)
INSERT [dbo].[rawmaterialintake] ([batchnumber], [rawmaterialid], [incomingrawmaterialid], [weightingram]) VALUES (6, 2, 2, 50000)
INSERT [dbo].[rawmaterialintake] ([batchnumber], [rawmaterialid], [incomingrawmaterialid], [weightingram]) VALUES (6, 3, 2, 40000)
INSERT [dbo].[rawmaterialintake] ([batchnumber], [rawmaterialid], [incomingrawmaterialid], [weightingram]) VALUES (6, 4, 2, 50000)
INSERT [dbo].[rawmaterialintake] ([batchnumber], [rawmaterialid], [incomingrawmaterialid], [weightingram]) VALUES (6, 5, 2, 25000)
INSERT [dbo].[rawmaterialintake] ([batchnumber], [rawmaterialid], [incomingrawmaterialid], [weightingram]) VALUES (6, 6, 2, 30000)
INSERT [dbo].[rawmaterialintake] ([batchnumber], [rawmaterialid], [incomingrawmaterialid], [weightingram]) VALUES (6, 7, 2, 37000)
INSERT [dbo].[rawmaterialintake] ([batchnumber], [rawmaterialid], [incomingrawmaterialid], [weightingram]) VALUES (6, 8, 2, 30000)
INSERT [dbo].[rawmaterialintake] ([batchnumber], [rawmaterialid], [incomingrawmaterialid], [weightingram]) VALUES (6, 9, 2, 29000)
INSERT [dbo].[rawmaterialintake] ([batchnumber], [rawmaterialid], [incomingrawmaterialid], [weightingram]) VALUES (6, 10, 2, 30000)
INSERT [dbo].[rawmaterialintake] ([batchnumber], [rawmaterialid], [incomingrawmaterialid], [weightingram]) VALUES (6, 11, 2, 40000)
INSERT [dbo].[rawmaterialintake] ([batchnumber], [rawmaterialid], [incomingrawmaterialid], [weightingram]) VALUES (6, 12, 2, 33000)
INSERT [dbo].[rawmaterialintake] ([batchnumber], [rawmaterialid], [incomingrawmaterialid], [weightingram]) VALUES (6, 13, 2, 60000)
INSERT [dbo].[rawmaterialintake] ([batchnumber], [rawmaterialid], [incomingrawmaterialid], [weightingram]) VALUES (6, 14, 2, 64000)
INSERT [dbo].[rawmaterialintake] ([batchnumber], [rawmaterialid], [incomingrawmaterialid], [weightingram]) VALUES (6, 15, 2, 50000)
INSERT [dbo].[rawmaterialintake] ([batchnumber], [rawmaterialid], [incomingrawmaterialid], [weightingram]) VALUES (7, 1, 3, 40000)
INSERT [dbo].[rawmaterialintake] ([batchnumber], [rawmaterialid], [incomingrawmaterialid], [weightingram]) VALUES (7, 2, 3, 50000)
INSERT [dbo].[rawmaterialintake] ([batchnumber], [rawmaterialid], [incomingrawmaterialid], [weightingram]) VALUES (7, 3, 3, 40000)
INSERT [dbo].[rawmaterialintake] ([batchnumber], [rawmaterialid], [incomingrawmaterialid], [weightingram]) VALUES (7, 4, 3, 50000)
INSERT [dbo].[rawmaterialintake] ([batchnumber], [rawmaterialid], [incomingrawmaterialid], [weightingram]) VALUES (7, 5, 3, 25000)
INSERT [dbo].[rawmaterialintake] ([batchnumber], [rawmaterialid], [incomingrawmaterialid], [weightingram]) VALUES (7, 6, 3, 30000)
INSERT [dbo].[rawmaterialintake] ([batchnumber], [rawmaterialid], [incomingrawmaterialid], [weightingram]) VALUES (7, 7, 3, 37000)
INSERT [dbo].[rawmaterialintake] ([batchnumber], [rawmaterialid], [incomingrawmaterialid], [weightingram]) VALUES (7, 8, 3, 30000)
INSERT [dbo].[rawmaterialintake] ([batchnumber], [rawmaterialid], [incomingrawmaterialid], [weightingram]) VALUES (7, 9, 3, 29000)
INSERT [dbo].[rawmaterialintake] ([batchnumber], [rawmaterialid], [incomingrawmaterialid], [weightingram]) VALUES (7, 10, 3, 30000)
GO
INSERT [dbo].[rawmaterialintake] ([batchnumber], [rawmaterialid], [incomingrawmaterialid], [weightingram]) VALUES (7, 11, 3, 40000)
INSERT [dbo].[rawmaterialintake] ([batchnumber], [rawmaterialid], [incomingrawmaterialid], [weightingram]) VALUES (7, 12, 3, 33000)
INSERT [dbo].[rawmaterialintake] ([batchnumber], [rawmaterialid], [incomingrawmaterialid], [weightingram]) VALUES (7, 13, 3, 60000)
INSERT [dbo].[rawmaterialintake] ([batchnumber], [rawmaterialid], [incomingrawmaterialid], [weightingram]) VALUES (7, 14, 3, 64000)
INSERT [dbo].[rawmaterialintake] ([batchnumber], [rawmaterialid], [incomingrawmaterialid], [weightingram]) VALUES (7, 15, 3, 50000)
INSERT [dbo].[rawmaterialintake] ([batchnumber], [rawmaterialid], [incomingrawmaterialid], [weightingram]) VALUES (8, 1, 3, 40000)
INSERT [dbo].[rawmaterialintake] ([batchnumber], [rawmaterialid], [incomingrawmaterialid], [weightingram]) VALUES (8, 2, 3, 50000)
INSERT [dbo].[rawmaterialintake] ([batchnumber], [rawmaterialid], [incomingrawmaterialid], [weightingram]) VALUES (8, 3, 3, 40000)
INSERT [dbo].[rawmaterialintake] ([batchnumber], [rawmaterialid], [incomingrawmaterialid], [weightingram]) VALUES (8, 4, 3, 50000)
INSERT [dbo].[rawmaterialintake] ([batchnumber], [rawmaterialid], [incomingrawmaterialid], [weightingram]) VALUES (8, 5, 3, 25000)
INSERT [dbo].[rawmaterialintake] ([batchnumber], [rawmaterialid], [incomingrawmaterialid], [weightingram]) VALUES (8, 6, 3, 30000)
INSERT [dbo].[rawmaterialintake] ([batchnumber], [rawmaterialid], [incomingrawmaterialid], [weightingram]) VALUES (8, 7, 3, 37000)
INSERT [dbo].[rawmaterialintake] ([batchnumber], [rawmaterialid], [incomingrawmaterialid], [weightingram]) VALUES (8, 8, 3, 30000)
INSERT [dbo].[rawmaterialintake] ([batchnumber], [rawmaterialid], [incomingrawmaterialid], [weightingram]) VALUES (8, 9, 3, 29000)
INSERT [dbo].[rawmaterialintake] ([batchnumber], [rawmaterialid], [incomingrawmaterialid], [weightingram]) VALUES (8, 10, 3, 30000)
INSERT [dbo].[rawmaterialintake] ([batchnumber], [rawmaterialid], [incomingrawmaterialid], [weightingram]) VALUES (8, 11, 3, 40000)
INSERT [dbo].[rawmaterialintake] ([batchnumber], [rawmaterialid], [incomingrawmaterialid], [weightingram]) VALUES (8, 12, 3, 33000)
INSERT [dbo].[rawmaterialintake] ([batchnumber], [rawmaterialid], [incomingrawmaterialid], [weightingram]) VALUES (8, 13, 3, 60000)
INSERT [dbo].[rawmaterialintake] ([batchnumber], [rawmaterialid], [incomingrawmaterialid], [weightingram]) VALUES (8, 14, 3, 64000)
INSERT [dbo].[rawmaterialintake] ([batchnumber], [rawmaterialid], [incomingrawmaterialid], [weightingram]) VALUES (8, 15, 3, 50000)
INSERT [dbo].[rawmaterialintake] ([batchnumber], [rawmaterialid], [incomingrawmaterialid], [weightingram]) VALUES (9, 1, 4, 1825)
INSERT [dbo].[rawmaterialintake] ([batchnumber], [rawmaterialid], [incomingrawmaterialid], [weightingram]) VALUES (10, 2, 1, 3000)
INSERT [dbo].[rawmaterialintake] ([batchnumber], [rawmaterialid], [incomingrawmaterialid], [weightingram]) VALUES (11, 3, 1, 500)
INSERT [dbo].[rawmaterialintake] ([batchnumber], [rawmaterialid], [incomingrawmaterialid], [weightingram]) VALUES (12, 4, 1, 500)
INSERT [dbo].[rawmaterialintake] ([batchnumber], [rawmaterialid], [incomingrawmaterialid], [weightingram]) VALUES (13, 6, 2, 800)
INSERT [dbo].[rawmaterialintake] ([batchnumber], [rawmaterialid], [incomingrawmaterialid], [weightingram]) VALUES (14, 9, 2, 34)
INSERT [dbo].[rawmaterialintake] ([batchnumber], [rawmaterialid], [incomingrawmaterialid], [weightingram]) VALUES (15, 1, 4, 1933)
INSERT [dbo].[rawmaterialintake] ([batchnumber], [rawmaterialid], [incomingrawmaterialid], [weightingram]) VALUES (15, 2, 1, 3000)
INSERT [dbo].[rawmaterialintake] ([batchnumber], [rawmaterialid], [incomingrawmaterialid], [weightingram]) VALUES (15, 3, 1, 500)
INSERT [dbo].[rawmaterialintake] ([batchnumber], [rawmaterialid], [incomingrawmaterialid], [weightingram]) VALUES (15, 4, 1, 500)
INSERT [dbo].[rawmaterialintake] ([batchnumber], [rawmaterialid], [incomingrawmaterialid], [weightingram]) VALUES (15, 6, 2, 800)
INSERT [dbo].[rawmaterialintake] ([batchnumber], [rawmaterialid], [incomingrawmaterialid], [weightingram]) VALUES (15, 9, 2, 34)
INSERT [dbo].[rawmaterialintake] ([batchnumber], [rawmaterialid], [incomingrawmaterialid], [weightingram]) VALUES (15, 12, 3, 700)
INSERT [dbo].[recipedetail] ([recipeid], [rawmaterialid], [weightingram]) VALUES (1, 1, 1600)
INSERT [dbo].[recipedetail] ([recipeid], [rawmaterialid], [weightingram]) VALUES (1, 2, 3000)
INSERT [dbo].[recipedetail] ([recipeid], [rawmaterialid], [weightingram]) VALUES (1, 3, 500)
INSERT [dbo].[recipedetail] ([recipeid], [rawmaterialid], [weightingram]) VALUES (1, 4, 500)
INSERT [dbo].[recipedetail] ([recipeid], [rawmaterialid], [weightingram]) VALUES (1, 6, 800)
INSERT [dbo].[recipedetail] ([recipeid], [rawmaterialid], [weightingram]) VALUES (1, 9, 111)
INSERT [dbo].[recipedetail] ([recipeid], [rawmaterialid], [weightingram]) VALUES (1, 12, 750)
INSERT [dbo].[recipedetail] ([recipeid], [rawmaterialid], [weightingram]) VALUES (2, 1, 1500)
INSERT [dbo].[recipedetail] ([recipeid], [rawmaterialid], [weightingram]) VALUES (2, 2, 2750)
INSERT [dbo].[recipedetail] ([recipeid], [rawmaterialid], [weightingram]) VALUES (2, 3, 500)
INSERT [dbo].[recipedetail] ([recipeid], [rawmaterialid], [weightingram]) VALUES (2, 4, 500)
INSERT [dbo].[recipedetail] ([recipeid], [rawmaterialid], [weightingram]) VALUES (2, 5, 800)
INSERT [dbo].[recipedetail] ([recipeid], [rawmaterialid], [weightingram]) VALUES (2, 14, 800)
INSERT [dbo].[recipedetail] ([recipeid], [rawmaterialid], [weightingram]) VALUES (3, 1, 1500)
INSERT [dbo].[recipedetail] ([recipeid], [rawmaterialid], [weightingram]) VALUES (3, 2, 2750)
INSERT [dbo].[recipedetail] ([recipeid], [rawmaterialid], [weightingram]) VALUES (3, 3, 500)
INSERT [dbo].[recipedetail] ([recipeid], [rawmaterialid], [weightingram]) VALUES (3, 4, 500)
INSERT [dbo].[recipedetail] ([recipeid], [rawmaterialid], [weightingram]) VALUES (3, 5, 800)
INSERT [dbo].[recipedetail] ([recipeid], [rawmaterialid], [weightingram]) VALUES (3, 13, 800)
INSERT [dbo].[recipedetail] ([recipeid], [rawmaterialid], [weightingram]) VALUES (4, 1, 1750)
INSERT [dbo].[recipedetail] ([recipeid], [rawmaterialid], [weightingram]) VALUES (4, 2, 3000)
INSERT [dbo].[recipedetail] ([recipeid], [rawmaterialid], [weightingram]) VALUES (4, 3, 500)
INSERT [dbo].[recipedetail] ([recipeid], [rawmaterialid], [weightingram]) VALUES (4, 5, 800)
INSERT [dbo].[recipedetail] ([recipeid], [rawmaterialid], [weightingram]) VALUES (4, 7, 1500)
INSERT [dbo].[recipedetail] ([recipeid], [rawmaterialid], [weightingram]) VALUES (4, 8, 1000)
INSERT [dbo].[recipedetail] ([recipeid], [rawmaterialid], [weightingram]) VALUES (4, 15, 500)
INSERT [dbo].[recipedetail] ([recipeid], [rawmaterialid], [weightingram]) VALUES (5, 1, 1750)
INSERT [dbo].[recipedetail] ([recipeid], [rawmaterialid], [weightingram]) VALUES (5, 2, 3000)
INSERT [dbo].[recipedetail] ([recipeid], [rawmaterialid], [weightingram]) VALUES (5, 3, 500)
INSERT [dbo].[recipedetail] ([recipeid], [rawmaterialid], [weightingram]) VALUES (5, 5, 800)
INSERT [dbo].[recipedetail] ([recipeid], [rawmaterialid], [weightingram]) VALUES (5, 7, 1750)
INSERT [dbo].[recipedetail] ([recipeid], [rawmaterialid], [weightingram]) VALUES (5, 8, 1500)
INSERT [dbo].[recipedetail] ([recipeid], [rawmaterialid], [weightingram]) VALUES (5, 9, 750)
INSERT [dbo].[recipedetail] ([recipeid], [rawmaterialid], [weightingram]) VALUES (5, 10, 750)
INSERT [dbo].[recipedetail] ([recipeid], [rawmaterialid], [weightingram]) VALUES (5, 11, 750)
INSERT [dbo].[recipedetail] ([recipeid], [rawmaterialid], [weightingram]) VALUES (6, 1, 1750)
INSERT [dbo].[recipedetail] ([recipeid], [rawmaterialid], [weightingram]) VALUES (6, 2, 3000)
INSERT [dbo].[recipedetail] ([recipeid], [rawmaterialid], [weightingram]) VALUES (6, 3, 500)
INSERT [dbo].[recipedetail] ([recipeid], [rawmaterialid], [weightingram]) VALUES (6, 5, 800)
INSERT [dbo].[recipedetail] ([recipeid], [rawmaterialid], [weightingram]) VALUES (6, 7, 1750)
INSERT [dbo].[recipedetail] ([recipeid], [rawmaterialid], [weightingram]) VALUES (6, 8, 3000)
INSERT [dbo].[recipedetail] ([recipeid], [rawmaterialid], [weightingram]) VALUES (6, 9, 750)
INSERT [dbo].[recipedetail] ([recipeid], [rawmaterialid], [weightingram]) VALUES (6, 10, 750)
INSERT [dbo].[recipedetail] ([recipeid], [rawmaterialid], [weightingram]) VALUES (6, 11, 750)
SET IDENTITY_INSERT [dbo].[recipeheader] ON 

INSERT [dbo].[recipeheader] ([recipeid], [foodid], [outputunitinpieces], [description], [employeeid], [createddate], [status]) VALUES (1, 1, 100, N'Production of Chocolate Bread
', 1, CAST(N'2016-12-22 14:41:18.653' AS DateTime), N'A')
INSERT [dbo].[recipeheader] ([recipeid], [foodid], [outputunitinpieces], [description], [employeeid], [createddate], [status]) VALUES (2, 2, 80, N'Production of Cheese Bread
', 2, CAST(N'2016-12-22 14:41:18.683' AS DateTime), N'A')
INSERT [dbo].[recipeheader] ([recipeid], [foodid], [outputunitinpieces], [description], [employeeid], [createddate], [status]) VALUES (3, 3, 80, N'Production of Cream Cheese Bread
', 3, CAST(N'2016-12-22 14:41:18.700' AS DateTime), N'A')
INSERT [dbo].[recipeheader] ([recipeid], [foodid], [outputunitinpieces], [description], [employeeid], [createddate], [status]) VALUES (4, 4, 70, N'Production of Pizza Bread
', 4, CAST(N'2016-12-22 14:41:18.717' AS DateTime), N'A')
INSERT [dbo].[recipeheader] ([recipeid], [foodid], [outputunitinpieces], [description], [employeeid], [createddate], [status]) VALUES (5, 5, 70, N'Production of Cheese Burger
', 1, CAST(N'2016-12-22 14:41:18.730' AS DateTime), N'A')
INSERT [dbo].[recipeheader] ([recipeid], [foodid], [outputunitinpieces], [description], [employeeid], [createddate], [status]) VALUES (6, 6, 70, N'Production of Double Cheese Burger
', 2, CAST(N'2016-12-22 14:41:18.730' AS DateTime), N'A')
SET IDENTITY_INSERT [dbo].[recipeheader] OFF
INSERT [dbo].[sellingdetail] ([sellingid], [foodid], [batchnumber], [qty], [price]) VALUES (1, 1, 1, 10, 7000)
INSERT [dbo].[sellingdetail] ([sellingid], [foodid], [batchnumber], [qty], [price]) VALUES (1, 2, 1, 8, 7500)
INSERT [dbo].[sellingdetail] ([sellingid], [foodid], [batchnumber], [qty], [price]) VALUES (1, 3, 1, 7, 8000)
INSERT [dbo].[sellingdetail] ([sellingid], [foodid], [batchnumber], [qty], [price]) VALUES (2, 4, 1, 5, 11000)
INSERT [dbo].[sellingdetail] ([sellingid], [foodid], [batchnumber], [qty], [price]) VALUES (2, 5, 1, 2, 13000)
INSERT [dbo].[sellingdetail] ([sellingid], [foodid], [batchnumber], [qty], [price]) VALUES (3, 1, 1, 8, 7000)
INSERT [dbo].[sellingdetail] ([sellingid], [foodid], [batchnumber], [qty], [price]) VALUES (3, 2, 1, 12, 7500)
INSERT [dbo].[sellingdetail] ([sellingid], [foodid], [batchnumber], [qty], [price]) VALUES (3, 6, 1, 3, 15000)
INSERT [dbo].[sellingdetail] ([sellingid], [foodid], [batchnumber], [qty], [price]) VALUES (4, 3, 1, 10, 8000)
INSERT [dbo].[sellingdetail] ([sellingid], [foodid], [batchnumber], [qty], [price]) VALUES (4, 4, 1, 8, 11000)
INSERT [dbo].[sellingdetail] ([sellingid], [foodid], [batchnumber], [qty], [price]) VALUES (5, 1, 2, 5, 7000)
INSERT [dbo].[sellingdetail] ([sellingid], [foodid], [batchnumber], [qty], [price]) VALUES (5, 2, 2, 4, 7500)
INSERT [dbo].[sellingdetail] ([sellingid], [foodid], [batchnumber], [qty], [price]) VALUES (5, 5, 1, 2, 13000)
INSERT [dbo].[sellingdetail] ([sellingid], [foodid], [batchnumber], [qty], [price]) VALUES (5, 6, 1, 7, 15000)
INSERT [dbo].[sellingdetail] ([sellingid], [foodid], [batchnumber], [qty], [price]) VALUES (6, 3, 2, 3, 8000)
INSERT [dbo].[sellingdetail] ([sellingid], [foodid], [batchnumber], [qty], [price]) VALUES (6, 4, 2, 6, 11000)
INSERT [dbo].[sellingdetail] ([sellingid], [foodid], [batchnumber], [qty], [price]) VALUES (7, 5, 2, 7, 13000)
INSERT [dbo].[sellingdetail] ([sellingid], [foodid], [batchnumber], [qty], [price]) VALUES (7, 6, 2, 9, 15000)
INSERT [dbo].[sellingdetail] ([sellingid], [foodid], [batchnumber], [qty], [price]) VALUES (8, 1, 2, 8, 7000)
INSERT [dbo].[sellingdetail] ([sellingid], [foodid], [batchnumber], [qty], [price]) VALUES (8, 2, 2, 7, 7500)
INSERT [dbo].[sellingdetail] ([sellingid], [foodid], [batchnumber], [qty], [price]) VALUES (9, 3, 2, 5, 8000)
INSERT [dbo].[sellingdetail] ([sellingid], [foodid], [batchnumber], [qty], [price]) VALUES (9, 4, 2, 6, 11000)
INSERT [dbo].[sellingdetail] ([sellingid], [foodid], [batchnumber], [qty], [price]) VALUES (9, 5, 2, 7, 13000)
INSERT [dbo].[sellingdetail] ([sellingid], [foodid], [batchnumber], [qty], [price]) VALUES (9, 6, 2, 8, 15000)
INSERT [dbo].[sellingdetail] ([sellingid], [foodid], [batchnumber], [qty], [price]) VALUES (22, 1, 1, 101, 707000)
INSERT [dbo].[sellingdetail] ([sellingid], [foodid], [batchnumber], [qty], [price]) VALUES (22, 1, 3, 101, 707000)
INSERT [dbo].[sellingdetail] ([sellingid], [foodid], [batchnumber], [qty], [price]) VALUES (23, 1, 1, 0, 0)
INSERT [dbo].[sellingdetail] ([sellingid], [foodid], [batchnumber], [qty], [price]) VALUES (23, 1, 3, 78, 546000)
INSERT [dbo].[sellingdetail] ([sellingid], [foodid], [batchnumber], [qty], [price]) VALUES (24, 1, 1, 0, 0)
INSERT [dbo].[sellingdetail] ([sellingid], [foodid], [batchnumber], [qty], [price]) VALUES (24, 1, 3, 77, 539000)
INSERT [dbo].[sellingdetail] ([sellingid], [foodid], [batchnumber], [qty], [price]) VALUES (27, 1, 1, 100, 700000)
INSERT [dbo].[sellingdetail] ([sellingid], [foodid], [batchnumber], [qty], [price]) VALUES (27, 1, 3, 1, 7000)
INSERT [dbo].[sellingdetail] ([sellingid], [foodid], [batchnumber], [qty], [price]) VALUES (28, 1, 3, 99, 693000)
INSERT [dbo].[sellingdetail] ([sellingid], [foodid], [batchnumber], [qty], [price]) VALUES (28, 1, 5, 1, 7000)
SET IDENTITY_INSERT [dbo].[sellingheader] ON 

INSERT [dbo].[sellingheader] ([sellingid], [sellingdate], [discount], [employeeid]) VALUES (1, CAST(N'2017-10-01 00:00:00.000' AS DateTime), 5, 1)
INSERT [dbo].[sellingheader] ([sellingid], [sellingdate], [discount], [employeeid]) VALUES (2, CAST(N'2017-10-01 00:00:00.000' AS DateTime), 5, 2)
INSERT [dbo].[sellingheader] ([sellingid], [sellingdate], [discount], [employeeid]) VALUES (3, CAST(N'2017-10-02 00:00:00.000' AS DateTime), 5, 3)
INSERT [dbo].[sellingheader] ([sellingid], [sellingdate], [discount], [employeeid]) VALUES (4, CAST(N'2017-10-02 00:00:00.000' AS DateTime), 5, 4)
INSERT [dbo].[sellingheader] ([sellingid], [sellingdate], [discount], [employeeid]) VALUES (5, CAST(N'2017-10-03 00:00:00.000' AS DateTime), 5, 1)
INSERT [dbo].[sellingheader] ([sellingid], [sellingdate], [discount], [employeeid]) VALUES (6, CAST(N'2017-10-03 00:00:00.000' AS DateTime), 5, 2)
INSERT [dbo].[sellingheader] ([sellingid], [sellingdate], [discount], [employeeid]) VALUES (7, CAST(N'2017-10-03 00:00:00.000' AS DateTime), 5, 3)
INSERT [dbo].[sellingheader] ([sellingid], [sellingdate], [discount], [employeeid]) VALUES (8, CAST(N'2017-10-04 00:00:00.000' AS DateTime), 5, 4)
INSERT [dbo].[sellingheader] ([sellingid], [sellingdate], [discount], [employeeid]) VALUES (9, CAST(N'2017-10-04 00:00:00.000' AS DateTime), 5, 1)
INSERT [dbo].[sellingheader] ([sellingid], [sellingdate], [discount], [employeeid]) VALUES (10, CAST(N'2016-12-22 15:58:35.777' AS DateTime), 5, 1)
INSERT [dbo].[sellingheader] ([sellingid], [sellingdate], [discount], [employeeid]) VALUES (11, CAST(N'2016-12-22 15:59:16.900' AS DateTime), 5, 1)
INSERT [dbo].[sellingheader] ([sellingid], [sellingdate], [discount], [employeeid]) VALUES (12, CAST(N'2016-12-22 16:02:43.473' AS DateTime), 5, 1)
INSERT [dbo].[sellingheader] ([sellingid], [sellingdate], [discount], [employeeid]) VALUES (13, CAST(N'2016-12-22 16:05:43.237' AS DateTime), 5, 1)
INSERT [dbo].[sellingheader] ([sellingid], [sellingdate], [discount], [employeeid]) VALUES (14, CAST(N'2016-12-22 16:06:30.420' AS DateTime), 5, 1)
INSERT [dbo].[sellingheader] ([sellingid], [sellingdate], [discount], [employeeid]) VALUES (15, CAST(N'2016-12-22 16:07:24.310' AS DateTime), 5, 1)
INSERT [dbo].[sellingheader] ([sellingid], [sellingdate], [discount], [employeeid]) VALUES (16, CAST(N'2016-12-22 16:08:00.373' AS DateTime), 4, 1)
INSERT [dbo].[sellingheader] ([sellingid], [sellingdate], [discount], [employeeid]) VALUES (17, CAST(N'2016-12-22 16:08:20.993' AS DateTime), 5, 1)
INSERT [dbo].[sellingheader] ([sellingid], [sellingdate], [discount], [employeeid]) VALUES (18, CAST(N'2016-12-22 16:10:10.377' AS DateTime), 5, 1)
INSERT [dbo].[sellingheader] ([sellingid], [sellingdate], [discount], [employeeid]) VALUES (19, CAST(N'2016-12-22 16:10:55.093' AS DateTime), 5, 1)
INSERT [dbo].[sellingheader] ([sellingid], [sellingdate], [discount], [employeeid]) VALUES (20, CAST(N'2016-12-22 16:12:21.867' AS DateTime), 5, 1)
INSERT [dbo].[sellingheader] ([sellingid], [sellingdate], [discount], [employeeid]) VALUES (21, CAST(N'2016-12-22 16:12:57.327' AS DateTime), 10, 1)
INSERT [dbo].[sellingheader] ([sellingid], [sellingdate], [discount], [employeeid]) VALUES (22, CAST(N'2017-10-05 00:00:00.000' AS DateTime), 20, 1)
INSERT [dbo].[sellingheader] ([sellingid], [sellingdate], [discount], [employeeid]) VALUES (23, CAST(N'2017-10-06 00:00:00.000' AS DateTime), 15, 1)
INSERT [dbo].[sellingheader] ([sellingid], [sellingdate], [discount], [employeeid]) VALUES (24, CAST(N'2017-10-07 00:00:00.000' AS DateTime), 12, 1)
INSERT [dbo].[sellingheader] ([sellingid], [sellingdate], [discount], [employeeid]) VALUES (25, CAST(N'2017-10-08 00:00:00.000' AS DateTime), 13, 1)
INSERT [dbo].[sellingheader] ([sellingid], [sellingdate], [discount], [employeeid]) VALUES (26, CAST(N'2017-10-09 00:00:00.000' AS DateTime), 13, 1)
INSERT [dbo].[sellingheader] ([sellingid], [sellingdate], [discount], [employeeid]) VALUES (27, CAST(N'2017-10-10 00:00:00.000' AS DateTime), 14, 1)
INSERT [dbo].[sellingheader] ([sellingid], [sellingdate], [discount], [employeeid]) VALUES (28, CAST(N'2017-10-11 00:00:00.000' AS DateTime), 16, 1)
SET IDENTITY_INSERT [dbo].[sellingheader] OFF
ALTER TABLE [dbo].[incomingrawmaterialdetail]  WITH CHECK ADD  CONSTRAINT [FK_incomingrawmaterialdetail_incomingrawmaterialheader] FOREIGN KEY([incomingrawmaterialid])
REFERENCES [dbo].[incomingrawmaterialheader] ([incomingrawmaterialid])
GO
ALTER TABLE [dbo].[incomingrawmaterialdetail] CHECK CONSTRAINT [FK_incomingrawmaterialdetail_incomingrawmaterialheader]
GO
ALTER TABLE [dbo].[incomingrawmaterialdetail]  WITH CHECK ADD  CONSTRAINT [FK_incomingrawmaterialdetail_rawmaterial] FOREIGN KEY([rawmaterialid])
REFERENCES [dbo].[rawmaterial] ([rawmaterialid])
GO
ALTER TABLE [dbo].[incomingrawmaterialdetail] CHECK CONSTRAINT [FK_incomingrawmaterialdetail_rawmaterial]
GO
ALTER TABLE [dbo].[incomingrawmaterialheader]  WITH CHECK ADD  CONSTRAINT [FK__incomingr__emplo__239E4DCF] FOREIGN KEY([employeeid])
REFERENCES [dbo].[employee] ([employeeid])
GO
ALTER TABLE [dbo].[incomingrawmaterialheader] CHECK CONSTRAINT [FK__incomingr__emplo__239E4DCF]
GO
ALTER TABLE [dbo].[productiondetail]  WITH CHECK ADD  CONSTRAINT [FK__productio__foodi__20C1E124] FOREIGN KEY([foodid])
REFERENCES [dbo].[food] ([foodid])
GO
ALTER TABLE [dbo].[productiondetail] CHECK CONSTRAINT [FK__productio__foodi__20C1E124]
GO
ALTER TABLE [dbo].[productiondetail]  WITH CHECK ADD  CONSTRAINT [FK__productio__produ__1FCDBCEB] FOREIGN KEY([productionid])
REFERENCES [dbo].[productionheader] ([productionid])
GO
ALTER TABLE [dbo].[productiondetail] CHECK CONSTRAINT [FK__productio__produ__1FCDBCEB]
GO
ALTER TABLE [dbo].[productionheader]  WITH CHECK ADD  CONSTRAINT [FK__productio__emplo__1CF15040] FOREIGN KEY([employeeid])
REFERENCES [dbo].[employee] ([employeeid])
GO
ALTER TABLE [dbo].[productionheader] CHECK CONSTRAINT [FK__productio__emplo__1CF15040]
GO
ALTER TABLE [dbo].[rawmaterial]  WITH CHECK ADD  CONSTRAINT [FK__rawmateri__emplo__145C0A3F] FOREIGN KEY([employeeid])
REFERENCES [dbo].[employee] ([employeeid])
GO
ALTER TABLE [dbo].[rawmaterial] CHECK CONSTRAINT [FK__rawmateri__emplo__145C0A3F]
GO
ALTER TABLE [dbo].[rawmaterialintake]  WITH CHECK ADD  CONSTRAINT [FK_rawmaterialintake_incomingrawmaterialheader] FOREIGN KEY([incomingrawmaterialid])
REFERENCES [dbo].[incomingrawmaterialheader] ([incomingrawmaterialid])
GO
ALTER TABLE [dbo].[rawmaterialintake] CHECK CONSTRAINT [FK_rawmaterialintake_incomingrawmaterialheader]
GO
ALTER TABLE [dbo].[rawmaterialintake]  WITH CHECK ADD  CONSTRAINT [FK_rawmaterialintake_rawmaterial] FOREIGN KEY([rawmaterialid])
REFERENCES [dbo].[rawmaterial] ([rawmaterialid])
GO
ALTER TABLE [dbo].[rawmaterialintake] CHECK CONSTRAINT [FK_rawmaterialintake_rawmaterial]
GO
ALTER TABLE [dbo].[recipedetail]  WITH CHECK ADD  CONSTRAINT [FK_recipedetail_rawmaterial] FOREIGN KEY([rawmaterialid])
REFERENCES [dbo].[rawmaterial] ([rawmaterialid])
GO
ALTER TABLE [dbo].[recipedetail] CHECK CONSTRAINT [FK_recipedetail_rawmaterial]
GO
ALTER TABLE [dbo].[recipedetail]  WITH CHECK ADD  CONSTRAINT [FK_recipedetail_recipeheader] FOREIGN KEY([recipeid])
REFERENCES [dbo].[recipeheader] ([recipeid])
GO
ALTER TABLE [dbo].[recipedetail] CHECK CONSTRAINT [FK_recipedetail_recipeheader]
GO
ALTER TABLE [dbo].[recipeheader]  WITH CHECK ADD  CONSTRAINT [FK__recipehea__emplo__182C9B23] FOREIGN KEY([employeeid])
REFERENCES [dbo].[employee] ([employeeid])
GO
ALTER TABLE [dbo].[recipeheader] CHECK CONSTRAINT [FK__recipehea__emplo__182C9B23]
GO
ALTER TABLE [dbo].[recipeheader]  WITH CHECK ADD  CONSTRAINT [FK__recipehea__foodi__173876EA] FOREIGN KEY([foodid])
REFERENCES [dbo].[food] ([foodid])
GO
ALTER TABLE [dbo].[recipeheader] CHECK CONSTRAINT [FK__recipehea__foodi__173876EA]
GO
ALTER TABLE [dbo].[sellingdetail]  WITH CHECK ADD  CONSTRAINT [FK__sellingde__foodi__31EC6D26] FOREIGN KEY([foodid])
REFERENCES [dbo].[food] ([foodid])
GO
ALTER TABLE [dbo].[sellingdetail] CHECK CONSTRAINT [FK__sellingde__foodi__31EC6D26]
GO
ALTER TABLE [dbo].[sellingdetail]  WITH CHECK ADD  CONSTRAINT [FK__sellingde__selli__30F848ED] FOREIGN KEY([sellingid])
REFERENCES [dbo].[sellingheader] ([sellingid])
GO
ALTER TABLE [dbo].[sellingdetail] CHECK CONSTRAINT [FK__sellingde__selli__30F848ED]
GO
ALTER TABLE [dbo].[sellingheader]  WITH CHECK ADD  CONSTRAINT [FK__sellinghe__emplo__2E1BDC42] FOREIGN KEY([employeeid])
REFERENCES [dbo].[employee] ([employeeid])
GO
ALTER TABLE [dbo].[sellingheader] CHECK CONSTRAINT [FK__sellinghe__emplo__2E1BDC42]
GO
USE [master]
GO
ALTER DATABASE [selectiontestwsc2017] SET  READ_WRITE 
GO
