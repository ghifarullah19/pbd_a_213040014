SELECT Production.Products.productid, Production.Products.productname, Production.Products.categoryid, categoryname
FROM Production.Products INNER JOIN Production.Categories
ON Production.Products.productid = Production.Categories.categoryid