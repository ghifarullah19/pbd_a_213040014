-- Modul 2
-- Jawaban case 1
select country, region, city from HR.Employees
UNION ALL
SELECT country, region, city from Sales.Customers

-- Jawaban case 2
select country, region, city from HR.Employees
union 
select country, region, city from sales.customers

-- Jawaban case 3
select country, region, city from hr.Employees
INTERSECT
select country, region, city from Sales.Customers

-- Jawaban case 4
select country, region, city from HR.Employees
except 
select country, region, city from Sales.Customers

-- Jawaban case 5
select country, region, city from Sales.Customers
except 
select country, region, city from HR.Employees

-- Jawaban case 6
select country, region, city from Production.Suppliers
except
select country, region, city from Sales.Customers
intersect 
select country, region, city from HR.Employees

-- Jawaban case 7
select country, count(*) as numlocations 
from (select country, region, city from HR.Employees
        union
        select country, region, city from Sales.Customers) as U  
group by country

-- Jawaban case 8
select empid, orderid, orderdate 
from (select top(2) empid, orderid, orderdate from Sales.Orders
        where empid = 3
        order by orderdate desc, orderid desc) as D1
union all 
select empid, orderid, orderdate 
from (select top(2) empid, orderid, orderdate from Sales.Orders
        where empid = 5
        order by orderdate desc, orderid desc) as D2 

-- INSERT INTO
IF OBJECT_ID('dbo.Orders', 'U') IS NOT NULL DROP TABLE dbo.Orders;
CREATE TABLE dbo.Orders
(
orderid INT NOT NULL
CONSTRAINT PK_Orders PRIMARY KEY,
orderdate DATE NOT NULL
CONSTRAINT DFT_orderdate DEFAULT(SYSDATETIME()),
empid INT NOT NULL,
custid VARCHAR(10) NOT NULL
)

-- Jawaban case 9
insert into dbo.Orders(orderid, orderdate, empid, custid)
select orderid, orderdate, empid, custid 
from Sales.Orders
where shipcountry = 'UK'

-- SELECT INTO & BULK INSERT
if OBJECT_ID('dbo.Orders', 'U') is not null drop table dbo.Orders;

-- Jawaban case 10
select orderid, orderdate, empid, custid 
into dbo.Orders 
from Sales.Orders

-- Jawaban case 11
bulk insert dbo.Orders from 'c:\\Users\\Lutfi\\Documents\\orders.txt'
with (
    datafiletype = 'char',
    fieldterminator = ',',
    rowterminator = '\n'
);

-- UPDATE
IF OBJECT_ID('dbo.OrderDetails', 'U') IS NOT NULL DROP TABLE dbo.OrderDetails;
IF OBJECT_ID('dbo.Orders', 'U') IS NOT NULL DROP TABLE dbo.Orders;
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
CONSTRAINT PK_Orders PRIMARY KEY(orderid)
);
CREATE TABLE dbo.OrderDetails
(
orderid INT NOT NULL,
productid INT NOT NULL,
unitprice MONEY NOT NULL
CONSTRAINT DFT_OrderDetails_unitprice DEFAULT(0),
qty SMALLINT NOT NULL
CONSTRAINT DFT_OrderDetails_qty DEFAULT(1),
discount NUMERIC(4, 3) NOT NULL
CONSTRAINT DFT_OrderDetails_discount DEFAULT(0),
CONSTRAINT PK_OrderDetails PRIMARY KEY(orderid, productid),
CONSTRAINT FK_OrderDetails_Orders FOREIGN KEY(orderid)
REFERENCES dbo.Orders(orderid),
CONSTRAINT CHK_discount CHECK (discount BETWEEN 0 AND 1),
CONSTRAINT CHK_qty CHECK (qty > 0),
CONSTRAINT CHK_unitprice CHECK (unitprice >= 0)
);
GO
INSERT INTO dbo.Orders SELECT * FROM Sales.Orders;
INSERT INTO dbo.OrderDetails SELECT * FROM Sales.OrderDetails;

-- Jawaban case 12
UPDATE dbo.OrderDetails
SET discount += 0.5
FROM dbo.OrderDetails 
JOIN dbo.Orders 
ON dbo.OrderDetails.orderid = dbo.Orders.orderid
WHERE dbo.Orders.custid = 1

--  atau 
UPDATE dbo.OrderDetails
SET discount += 0.05
WHERE EXISTS (
    SELECT * 
    FROM dbo.Orders
    WHERE dbo.Orders.orderid = dbo.OrderDetails.orderid 
    AND dbo.Orders.custid = 1
)

-- DELETE
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

-- Jawaban case 13
delete from dbo.Orders
where orderdate < '20070101'

-- Jawaban case 14
truncate table dbo.Customers

-- jawaban case 15
delete from O
from dbo.Orders as O
    join dbo.Customers as C 
    on O.custid = C.custid
where C.country = N'USA'
SELECT * FROM dbo.Customers

-- MERGE
IF OBJECT_ID('dbo.Customers', 'U') IS NOT NULL DROP TABLE dbo.Customers;
GO
CREATE TABLE dbo.Customers
(
custid INT NOT NULL,
companyname VARCHAR(25) NOT NULL,
phone VARCHAR(20) NOT NULL,
address VARCHAR(50) NOT NULL,
CONSTRAINT PK_Customers PRIMARY KEY(custid)
);
INSERT INTO dbo.Customers(custid, companyname, phone, address)
VALUES
(1, 'cust 1', '(111) 111-1111', 'address 1'),
(2, 'cust 2', '(222) 222-2222', 'address 2'),
(3, 'cust 3', '(333) 333-3333', 'address 3'),
(4, 'cust 4', '(444) 444-4444', 'address 4'),
(5, 'cust 5', '(555) 555-5555', 'address 5');
IF OBJECT_ID('dbo.CustomersStage', 'U') IS NOT NULL DROP TABLE dbo.
CustomersStage;
GO
CREATE TABLE dbo.CustomersStage
(
custid INT NOT NULL,
companyname VARCHAR(25) NOT NULL,
phone VARCHAR(20) NOT NULL,
address VARCHAR(50) NOT NULL,
CONSTRAINT PK_CustomersStage PRIMARY KEY(custid)
);
INSERT INTO dbo.CustomersStage(custid, companyname, phone, address)
VALUES
(2, 'AAAAA', '(222) 222-2222', 'address 2'),
(3, 'cust 3', '(333) 333-3333', 'address 3'),
(5, 'BBBBB', 'CCCCC', 'DDDDD'),
(6, 'cust 6 (new)', '(666) 666-6666', 'address 6'),
(7, 'cust 7 (new)', '(777) 777-7777', 'address 7');

-- Jawaban case 16
MERGE INTO dbo.Customers AS TGT 
USING dbo.CustomersStage AS SRC 
ON TGT.custid = SRC.custid
WHEN MATCHED THEN 
    UPDATE SET
    TGT.companyname = SRC.companyname,
    TGT.phone = SRC.phone,
    TGT.address = SRC.address
WHEN NOT MATCHED THEN
    INSERT (custid, companyname, phone, address)
    VALUES (SRC.custid, SRC.companyname, SRC.phone, SRC.address)
WHEN NOT MATCHED BY SOURCE THEN 
    DELETE;