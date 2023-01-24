-- Munculkanlah lokasi-lokasi yang berbeda-beda tanpa ada duplikasi data untuk lokasi yang terdapat pada
-- employee tetapi tidak terdapat di customer?
select country, region, city from HR.Employees
except 
select country, region, city from Sales.Customers

-- Munculkanlah lokasi-lokasi yang berbeda-beda tanpa ada duplikasi data untuk lokasi yang terdapat pada
-- customer tetapi tidak terdapat di employee?
select country, region, city from Sales.Customers
except 
select country, region, city from HR.Employees

-- Munculkanlah lokasi-lokasi yang berbeda-beda tanpa ada duplikasi data untuk lokasi yang terdapat pada
-- supplier tetapi tidak tedapat pada customer dan employee?
select country, region, city from Production.Suppliers
except
select country, region, city from Sales.Customers
intersect 
select country, region, city from HR.Employees

-- Munculkanlah data negara dan jumlah employee dan customer yang tunggal didalamnya?
select country, count(*) as numlocations 
from (select country, region, city from HR.Employees
        union
        select country, region, city from Sales.Customers) as U  
group by country

-- Munculkanlah dua order terbaru yang dilakukan oleh employee id 3 dan 5 ?
select empid, orderid, orderdate 
from (select top(2) empid, orderid, orderdate from Sales.Orders
        where empid = 3
        order by orderdate desc, orderid desc) as D1
union all 
select empid, orderid, orderdate 
from (select top(2) empid, orderid, orderdate from Sales.Orders
        where empid = 5
        order by orderdate desc, orderid desc) as D2 