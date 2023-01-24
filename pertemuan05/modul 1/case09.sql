SELECT contactname, address
FROM Sales.Customers
ORDER BY contactname
OFFSET 3 ROWS 
FETCH NEXT 3 ROWS ONLY