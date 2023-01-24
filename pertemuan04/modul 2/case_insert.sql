--melakukan pengecekan jika tabel yang dicari ada maka table tersebut akan dihapus
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

-- Masukan data dari hasil query pada table sales.orders dimana table mengembalikan nilai berdasarkan
-- pengapalan ke inggris (United Kingdom)?
insert into dbo.Orders(orderid, orderdate, empid, custid)
select orderid, orderdate, empid, custid 
from Sales.Orders
where shipcountry = 'UK'

-- Buatlah code untuk membuat table baru yang bernama dbo.orders, dan berisikan semua data pada table
-- sales.orders?

-- (melakukan pengcekan jika ada table bernama order maka akan dihapus dalam basis
-- data)
if OBJECT_ID('dbo.Orders', 'U') is not null drop table dbo.Orders;

select orderid, orderdate, empid, custid 
into dbo.Orders 
from Sales.Orders

-- Masukanlah data yang beada dalam file c:\orders.txt kedalam table dbo.Orders dan menentukan jenis file
-- data diatas adalah char, pembatas field pada data di file adalah koma, dan pembatas baris pada file
-- adalah baris baru?
bulk insert dbo.Orders from 'c:\\Users\\Lutfi\\Documents\\orders.txt'
with (
    datafiletype = 'char',
    fieldterminator = ',',
    rowterminator = '\n'
);
