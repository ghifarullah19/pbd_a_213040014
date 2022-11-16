-- Munculkanlah lokasi-lokasi yang berbeda-beda tanpa ada duplikasi data untuk lokasi yang terdapat pada
-- employee dan customer?
select country, region, city from hr.Employees
INTERSECT
select country, region, city from Sales.Customers

