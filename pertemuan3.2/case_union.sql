-- Gunakan union all untuk menyatukan lokasi dari pegawai dan pelanggan
select country, region, city from HR.Employees
UNION ALL
SELECT country, region, city from Sales.Customers

-- Gunakan union untuk menyatukan lokasi dari pegawai dan pelanggan yang berbeda-beda
-- dari salah satu pada kedua data tersebut
select country, region, city from HR.Employees
union 
select country, region, city from sales.customers