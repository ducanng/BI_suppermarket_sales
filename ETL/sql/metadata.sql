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

-- Initial CET, LSET
insert into DataFLow (id, name, LSET, CET)
values (11, 'dds_product', '2023-12-15', '2023-12-15')

insert into DataFLow (id, name, status, LSET, CET)
values (12, 'dds_invoice', '2023-12-15', '2023-12-15')

insert into DataFLow (id, name, status, LSET, CET)
values (13, 'dds_branch', '2023-12-15', '2023-12-15')

insert into DataFLow (id, name, status, LSET, CET)
values (14, 'dds_product_sales', '2023-12-15', '2023-12-15')
-- Creating database