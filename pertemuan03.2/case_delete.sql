--melakukan pengecekan jika tabel yang dicari ada maka table tersebut akan dihapus
if object_id('dbo.Orders', 'U') is not null drop table dbo.Orders;
if object_id('dbo.Customers', 'U') is not null drop table dbo.Customers;

--Membuat table customer dan orders
CREATE TABLE dbo.Customers (
custid INT NOT NULL,
companyname NVARCHAR(40) NOT NULL,
contactname NVARCHAR(30) NOT NULL,
contacttitle NVARCHAR(30) NOT NULL,
address NVARCHAR(60) NOT NULL,
city NVARCHAR(15) NOT NULL,
region NVARCHAR(15) NULL,
postalcode NVARCHAR(10) NULL,
country NVARCHAR(15) NOT NULL,
phone NVARCHAR(24) NOT NULL,
fax NVARCHAR(24) NULL,
CONSTRAINT PK_Customers PRIMARY KEY(custid)
);
CREATE TABLE dbo.Orders
(
orderid INT NOT NULL,
custid INT NULL,
empid INT NOT NULL,
orderdate DATETIME NOT NULL,
requireddate DATETIME NOT NULL,
shippeddate DATETIME NULL,
shipperid INT NOT NULL,
freight MONEY NOT NULL
CONSTRAINT DFT_Orders_freight DEFAULT(0),
shipname NVARCHAR(40) NOT NULL,
shipaddress NVARCHAR(60) NOT NULL,
shipcity NVARCHAR(15) NOT NULL,
shipregion NVARCHAR(15) NULL,
shippostalcode NVARCHAR(10) NULL,
shipcountry NVARCHAR(15) NOT NULL,
CONSTRAINT PK_Orders PRIMARY KEY(orderid),
CONSTRAINT FK_Orders_Customers FOREIGN KEY(custid)
REFERENCES dbo.Customers(custid)
);
GO
--membuat penyisimpan data berdasarkan pada
--data tabel yang sudah ada, yakni: customer dan orders di skema sales
INSERT INTO dbo.Customers SELECT * FROM Sales.Customers;
INSERT INTO dbo.Orders SELECT * FROM Sales.Orders;

-- Hapuslah data orders yang pernah dilakukan pada saat tanggal 01./01/2007?
delete from dbo.Orders
where orderdate < '20070101'

-- Hapuslah seluruh data customers?
truncate table dbo.Customers

-- seluruh data order yang dilakukan oleh customer yang tunggal di Amerika Serikat(United Stated)?
delete from O
from dbo.Orders as O
    join dbo.Customers as C 
    on O.custid = C.custid
where C.country = N'USA'