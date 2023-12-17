create database metadata
go
use metadata
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
create table dbo.nds_city
(
    CityID    bigint identity
        primary key,
    Branch    nvarchar(255),
    City      nvarchar(255),
    CreatedAt datetime,
    UpdatedAt datetime,
    sourceID  int
);
create table dbo.nds_product
(
    ProductID     bigint identity
        primary key,
    ProductNK     nvarchar(255)
        unique,
    ProductLineID bigint
        constraint nds_product_nds_productLine_ProductLineID_fk
            references dbo.nds_productLine,
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
create table dbo.nds_customer
(
    CustomerID   bigint identity
        primary key,
    CustomerType nvarchar(255),
    Gender       nvarchar(255),
    sourceID     bigint,
    CreatedAt    datetime,
    UpdatedAt    datetime,
    constraint nds_customer_pk
        unique (CustomerType, Gender)
);
create table dbo.nds_invoice
(
    InvoiceID  bigint identity
        primary key,
    InvoiceNK  nvarchar(255),
    CityID     bigint
        constraint nds_invoice_nds_city_CityID_fk
            references dbo.nds_city,
    CustomerID bigint
        constraint nds_invoice_nds_customer_CustomerID_fk
            references dbo.nds_customer,
    DTime      datetime,
    Payment    nvarchar(255),
    Rating     float,
    sourceID   int,
    CreatedAt  datetime,
    UpdatedAt  datetime
);
create table dbo.nds_invoiceDetail
(
    InvoiceDetailID       bigint identity
        primary key,
    InvoiceID             bigint
        constraint nds_invoiceDetail_nds_invoice_InvoiceID_fk
            references dbo.nds_invoice,
    ProductID             bigint
        constraint nds_invoiceDetail_nds_product_ProductID_fk
            references dbo.nds_product,
    Quantity              float,
    Tax                   float,
    Total                 float,
    Cogs                  float,
    GrossMarginPercentage float,
    GrossIncome           float,
    sourceID              bigint,
    CreatedAt             datetime,
    UpdatedAt             datetime
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
