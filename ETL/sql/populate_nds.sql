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
    sourceID      int
);
create table dbo.nds_customer
(
    CustomerID   bigint identity
        primary key,
    CustomerType nvarchar(255),
    Gender       nvarchar(255),
    sourceID     int,
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
    sourceID              int,
    CreatedAt             datetime,
    UpdatedAt             datetime
);

CREATE TABLE dbo.nds_city (
    CityID bigint identity primary key,
    Branch NVARCHAR(255),
    City NVARCHAR(255),
    CreatedAt DATETIME,
    UpdatedAt DATETIME,
    sourceID INT
);

create table dbo.nds_customer
(
    CustomerID   bigint identity
        primary key,
    CustomerType nvarchar(255),
    Gender       nvarchar(255),
    sourceID     int,
    CreatedAt    datetime,
    UpdatedAt    datetime,
    constraint nds_customer_pk
        unique (CustomerType, Gender)
);