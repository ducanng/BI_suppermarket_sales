
-- Get CET
update DataFLow
set status = 3, CET = getdate()
where name = 'dds_product'


-- Initial CET, LSET
insert into DataFLow (id, name, status, LSET, CET)
values (11, 'dds_product', 0, '2023-12-15', '2023-12-15')

insert into DataFLow (id, name, status, LSET, CET)
values (12, 'dds_invoice', 0, '2023-12-15', '2023-12-15')

insert into DataFLow (id, name, status, LSET, CET)
values (13, 'dds_branch', 0, '2023-12-15', '2023-12-15')

insert into DataFLow (id, name, status, LSET, CET)
values (14, 'dds_product_sales', 0, '2023-12-15', '2023-12-15')
-- Creating database
create database dds
go
use dds
go

-- create table dbo.dimDate
-- (
--     dateID bigint not NULL
--     ,date  int not NULL
--     ,year int not NULL
--     ,quarter int not NULL
--     ,month int not NULL
--     ,day  int not NULL
--     ,sourceID  bigint
--     ,effectiveAt datetime not NULL
--     ,expiryAt datetime not NULL
--     ,CreatedAt datetime
--     ,UpdatedAt datetime
--     ,CONSTRAINT pk_dim_date
--     primary key (dateID)
-- )

create table dbo.dimProduct
(
    productID    bigint not NULL
    ,productNK nvarchar(255)
    ,productLine  nvarchar(255)
    ,unitPrice float
    ,sourceID  bigint
    ,effectiveAt datetime not NULL
    ,expiryAt datetime not NULL
    ,CreatedAt datetime
    ,UpdatedAt datetime
    ,CONSTRAINT pk_dim_product
    primary key (productID)
);

go

create table dbo.dimBranch
(
    branchID bigint not NULL
    ,branchNK nvarchar(255)
    ,city nvarchar(255)
    ,sourceID  bigint
    ,effectiveAt datetime not NULL
    ,expiryAt datetime not NULL
    ,CreatedAt datetime not NULL
    ,UpdatedAt datetime not NULL
    ,CONSTRAINT pk_dim_branch
    primary key (branchID)
)

go 

create table dbo.dimInvoice
(
    invoiceID bigint not NULL
    ,invoiceNK nvarchar(255)
    ,customerType nvarchar(255)
    ,gender nvarchar(255)
    ,time varchar(50)
    ,payment nvarchar(100)
    ,sourceID  bigint
    ,effectiveAt datetime not NULL
    ,expiryAt datetime not NULL
    ,CreatedAt datetime not NULL
    ,UpdatedAt datetime not NULL
    ,CONSTRAINT pk_dim_invoice
    primary key (invoiceID, effectiveAt)
)

go

create table dbo.factProductSales
(
    salesDateID bigint not NULL
    , productID bigint not NULL
    , branchID bigint not NULL
    , invoiceID bigint not NULL
    ,quantity int
    ,tax_5_percent float
    ,total float
    ,cogs float
    ,grossMarginPercentage float
    ,grossIncome float
    ,Rating float
    ,sourceID  bigint
    ,CreatedAt datetime not NULL
    ,UpdatedAt datetime not NULL
    ,CONSTRAINT pk_fact_product_sales
    primary key (invoiceID)
    ,CONSTRAINT fk_fact_product_sales_dim_date
    FOREIGN key (salesDateID)
    REFERENCES dimDate(dateID)
    ,CONSTRAINT fk_fact_product_sales_dim_product
    FOREIGN key (productID)
    REFERENCES dimProduct(productID)
    ,CONSTRAINT fk_fact_product_sales_dim_branch
    FOREIGN key (branchID)
    REFERENCES dimBranch(branchID)
    ,CONSTRAINT fk_fact_product_sales_dim_invoice
    FOREIGN key (invoiceID)
    REFERENCES dimInvoice(invoiceID)
)

use dds

create table dbo.dimDate 
(
    DateKey                 int not null,
    FullDate                date not null,
    DayNumberOfWeek         tinyint not null,
    DayNameOfWeek           nvarchar(10) not null,
    WeekDayType             nvarchar(7) not null,
    DayNumberOfMonth        tinyint not null,
    DayNumberOfYear         smallint not null,
    WeekNumberOfYear        tinyint not null,
    MonthNameOfYear         nvarchar(10) not null,
    MonthNumberOfYear       tinyint not null,
    QuarterNumberCalendar   tinyint not null,
    QuarterNameCalendar     nchar(2) not null,
    SemesterNumberCalendar  tinyint not null,
    SemesterNameCalendar    nvarchar(15) not null,
    YearCalendar            smallint not null,
    MonthNumberFiscal       tinyint not null,
    QuarterNumberFiscal     tinyint not null,
    QuarterNameFiscal       nchar(2) not null,
    SemesterNumberFiscal    tinyint not null,
    SemesterNameFiscal      nvarchar(15) not null,
    YearFiscal              smallint not null
 
    constraint PK_DimDate primary key clustered  
    (
        DateKey asc
    )
) 
go

declare @DateCalendarStart  datetime,
        @DateCalendarEnd    datetime,
        @FiscalCounter      datetime,
        @FiscalMonthOffset  int;
 
set @DateCalendarStart = '2005-01-01';
set @DateCalendarEnd = '2015-12-31';
 
-- Set this to the number of months to add or extract to the current date to get the beginning 
-- of the Fiscal Year. Example: If the Fiscal Year begins July 1, assign the value of 6 
-- to the @FiscalMonthOffset variable. Negative values are also allowed, thus if your 
-- 2012 Fiscal Year begins in July of 2011, assign a value of -6.
set @FiscalMonthOffset = 6;
 
with DateDimension  
as
(
    select  @DateCalendarStart as DateCalendarValue,
            dateadd(m, @FiscalMonthOffset, @DateCalendarStart) as FiscalCounter
                 
    union all
     
    select  DateCalendarValue + 1,
            dateadd(m, @FiscalMonthOffset, (DateCalendarValue + 1)) as FiscalCounter
    from    DateDimension 
    where   DateCalendarValue + 1 < = @DateCalendarEnd
)
 
insert into dbo.DimDate (DateKey, FullDate, DayNumberOfWeek, DayNameOfWeek, WeekDayType, 
                        DayNumberOfMonth, DayNumberOfYear, WeekNumberOfYear, MonthNameOfYear, 
                        MonthNumberOfYear, QuarterNumberCalendar, QuarterNameCalendar, SemesterNumberCalendar, 
                        SemesterNameCalendar, YearCalendar, MonthNumberFiscal, QuarterNumberFiscal, 
                        QuarterNameFiscal, SemesterNumberFiscal, SemesterNameFiscal, YearFiscal)
 
select  cast(convert(varchar(25), DateCalendarValue, 112) as int) as 'DateKey',
        cast(DateCalendarValue as date) as 'FullDate',
        datepart(weekday, DateCalendarValue) as 'DayNumberOfWeek',
        datename(weekday, DateCalendarValue) as 'DayNameOfWeek',
        case datename(dw, DateCalendarValue)
            when 'Saturday' then 'Weekend'
            when 'Sunday' then 'Weekend'
        else 'Weekday'
        end as 'WeekDayType',
        datepart(day, DateCalendarValue) as'DayNumberOfMonth',
        datepart(dayofyear, DateCalendarValue) as 'DayNumberOfYear',
        datepart(week, DateCalendarValue) as 'WeekNumberOfYear',
        datename(month, DateCalendarValue) as 'MonthNameOfYear',
        datepart(month, DateCalendarValue) as 'MonthNumberOfYear',
        datepart(quarter, DateCalendarValue) as 'QuarterNumberCalendar',
        'Q' + cast(datepart(quarter, DateCalendarValue) as nvarchar) as 'QuarterNameCalendar',
        case
            when datepart(month, DateCalendarValue) <= 6 then 1
            when datepart(month, DateCalendarValue) > 6 then 2
        end as 'SemesterNumberCalendar',
        case
            when datepart(month, DateCalendarValue) < = 6 then 'First Semester'
            when datepart(month, DateCalendarValue) > 6 then 'Second Semester' 
        end as 'SemesterNameCalendar',
        datepart(year, DateCalendarValue) as 'YearCalendar',
        datepart(month, FiscalCounter) as 'MonthNumberFiscal',
        datepart(quarter, FiscalCounter) as 'QuarterNumberFiscal',
        'Q' + cast(datepart(quarter, FiscalCounter) as nvarchar) as 'QuarterNameFiscal',  
        case
            when datepart(month, FiscalCounter) < = 6 then 1
            when datepart(month, FiscalCounter) > 6 then 2 
        end as 'SemesterNumberFiscal',  
        case
            when datepart(month, FiscalCounter) < = 6 then 'First Semester'
            when  datepart(month, FiscalCounter) > 6 then 'Second Semester'
        end as 'SemesterNameFiscal',            
        datepart(year, FiscalCounter) as 'YearFiscal'
from    DateDimension
order by
        DateCalendarValue
option (maxrecursion 0);