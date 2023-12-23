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
    [Date]                  datetime,
    [Time]                  datetime,
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
