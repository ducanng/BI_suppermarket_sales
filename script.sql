create database metadata
go
use metadata
go
create table DataFlow
(
    id   bigint not null
        primary key,
    name varchar(64),
    LSET datetime,
    CET  datetime
)
go
create table dbo.DataFlow
(
    id   bigint not null
        primary key,
    name varchar(64),
    LSET datetime,
    CET  datetime
)
go

INSERT INTO metadata.dbo.DataFlow (id, name, LSET, CET) VALUES (1, N'invoice_stage', N'2023-12-12 17:08:12.237', N'2023-12-12 17:08:12.237');
INSERT INTO metadata.dbo.DataFlow (id, name, LSET, CET) VALUES (2, N'product_stage', N'2023-12-12 17:08:11.817', N'2023-12-12 17:08:11.817');
INSERT INTO metadata.dbo.DataFlow (id, name, LSET, CET) VALUES (3, N'productLine_stage', N'2023-12-12 17:08:07.943', N'2023-12-12 17:08:07.943');
INSERT INTO metadata.dbo.DataFlow (id, name, LSET, CET) VALUES (4, N'city_stage', N'2023-12-12 17:08:07.930', N'2023-12-12 17:08:07.930');
INSERT INTO metadata.dbo.DataFlow (id, name, LSET, CET) VALUES (5, N'nds_invoice', N'2023-12-11 01:33:16.000', N'2023-12-11 01:33:18.000');
INSERT INTO metadata.dbo.DataFlow (id, name, LSET, CET) VALUES (6, N'nds_invoiceDetail', N'2023-12-11 01:33:16.000', N'2023-12-11 01:33:18.000');
INSERT INTO metadata.dbo.DataFlow (id, name, LSET, CET) VALUES (7, N'nds_city', N'2023-12-11 01:33:16.000', N'2023-12-11 01:33:18.000');
INSERT INTO metadata.dbo.DataFlow (id, name, LSET, CET) VALUES (8, N'nds_customer', N'2023-12-11 01:33:16.000', N'2023-12-11 01:33:18.000');
INSERT INTO metadata.dbo.DataFlow (id, name, LSET, CET) VALUES (9, N'nds_product', N'2023-12-13 01:41:24.873', N'2023-12-13 01:41:24.873');
INSERT INTO metadata.dbo.DataFlow (id, name, LSET, CET) VALUES (10, N'nds_productLine', N'2023-12-13 00:53:44.373', N'2023-12-13 00:53:44.373');

create database nds
go
use nds
go
create table dbo.TB_TRANSACTION
(
    transaction_id        bigint,
    transaction_date      date,
    transaction_time      time,
    transaction_qty       varchar(50),
    store_id              bigint,
    product_id            bigint,
    unit_price            decimal(18, 2),
    product_category      varchar(50),
    product_type          varchar(50),
    product_detail        varchar(50),
    transaction_date_time datetime,
    product_cate_id       bigint,
    product_type_id       bigint
);

create table dbo.nds_product
(
    ProductID     bigint identity
        primary key,
    ProductNK     nvarchar(255)
        unique,
    ProductLineID bigint,
    UnitPrice     float,
    sourceID      int,
    CreatedAt     datetime,
    UpdatedAt     datetime
);

create table dbo.nds_productLine
(
    ProductLineID bigint identity
        primary key,
    ProductLineNK nvarchar(255)
        unique,
    ProductLine   nvarchar(255),
    CreatedAt     datetime,
    UpdatedAt     datetime,
    sourceID      bigint
);

CREATE TABLE [nds_city] (
    [CityID] bigint identity primary key,
    [Branch] NVARCHAR(255),
    [City] NVARCHAR(255),
    [CreatedAt] DATETIME,
    [UpdatedAt] DATETIME,
    [sourceID] INT
);

create database stage
go
use stage
go
create table dbo.city
(
    Branch    nvarchar(255),
    City      nvarchar(255),
    CreatedAt datetime,
    UpdatedAt datetime
);

create table dbo.invoice
(
    InvoiceID             nvarchar(255),
    Branch                nvarchar(255),
    [Customer type]       nvarchar(255),
    Gender                nvarchar(255),
    ProductID             nvarchar(255),
    Quantity              float,
    Tax                   float,
    Total                 float,
    Date                  datetime,
    Time                  datetime,
    Payment               nvarchar(255),
    Cogs                  float,
    GrossMarginPercentage float,
    GrossIncome           float,
    Rating                float,
    CreatedAt             datetime,
    UpdatedAt             datetime
);

create table dbo.product
(
    ProductID   nvarchar(255),
    UnitPrice   float,
    ProductLine nvarchar(255),
    CreatedAt   datetime,
    UpdatedAt   datetime
);

create table dbo.productLine
(
    [Product line] nvarchar(255),
    ProductLineID  nvarchar(255),
    CreatedAt      datetime,
    UpdatedAt      datetime
);
