create database dds
go
use dds
go
drop table dbo.factProductSales
drop table dbo.dimDate

drop table dbo.dimProduct
drop table dbo.dimBranch
drop table dbo.dimInvoice



create table dbo.dimDate
(
    dateID bigint not NULL
    ,date  int not NULL
    ,year int not NULL
    ,quarter int not NULL
    ,month int not NULL
    ,day  int not NULL
    ,sourceID  bigint
    ,effectiveAt datetime 
    ,expiryAt datetime 
    ,CreatedAt datetime
    ,UpdatedAt datetime
    ,CONSTRAINT pk_dim_date
    primary key (dateID)
)

create table dbo.dimProduct
(
    productID    bigint not NULL
    ,productNK nvarchar(255)
    ,productLine  nvarchar(255)
    ,unitPrice float
    ,sourceID  bigint
    ,effectiveAt datetime 
    ,expiryAt datetime 
    ,CreatedAt datetime
    ,UpdatedAt datetime
    ,CONSTRAINT pk_dim_product
    primary key (productID, effectiveAt)
);

go

create table dbo.dimBranch
(
    branchID bigint not NULL
    ,branchNK nvarchar(255)
    ,city nvarchar(255)
    ,sourceID  bigint
    ,effectiveAt datetime 
    ,expiryAt datetime 
    ,CreatedAt datetime 
    ,UpdatedAt datetime 
    ,CONSTRAINT pk_dim_branch
    primary key (branchID, effectiveAt)
)

go 

create table dbo.dimInvoice
(
    invoiceID bigint not NULL
    ,invoiceNK nvarchar(255)
    ,customerType nvarchar(255)
    ,gender nvarchar(255)
    ,time time
    ,payment nvarchar(255)
    ,sourceID  bigint
    ,effectiveAt datetime 
    ,expiryAt datetime 
    ,CreatedAt datetime
    ,UpdatedAt datetime
    ,CONSTRAINT pk_dim_invoice
    primary key (invoiceID, effectiveAt)
)

go

create table dbo.factProductSales
(
    dateID bigint not NULL
    , productID bigint not NULL
    , branchID bigint not NULL
    , invoiceID bigint not NULL
    ,quantity int
    ,tax float
    ,total float
    ,cogs float
    ,grossMarginPercentage float
    ,grossIncome float
    ,Rating float
    ,sourceID  bigint
    ,CreatedAt datetime
    ,UpdatedAt datetime 
    ,CONSTRAINT pk_fact_product_sales
    primary key (invoiceID)
    
)


-- select ni.InvoiceID as invoiceID,
--     CONVERT(INT, CONVERT(VARCHAR(8), DTime      , 112)) as dateID,
--     CityID as branchID, 
--     nid.productID as productID, 
--     nid.Quantity as quantity, 
--     nid.Tax as tax, 
--     nid.Total as total, 
--     nid.Cogs  as cogs, 
--     nid.GrossMarginPercentage as grossMarginPercentage, 
--     nid.GrossIncome as grossIncome,
--     ni.Rating as rating,
--     ni.sourceID as sourceID,
--     getdate() as CreatedAt,
--     getdate() as UpdatedAt
-- from nds_invoice as ni
-- join nds_invoiceDetail as nid 
-- on ni.InvoiceID = nid.InvoiceID
-- where (CreatedAt >= ? and CreatedAt< ?)
-- or (UpdatedAt>= ? and UpdatedAt< ?)