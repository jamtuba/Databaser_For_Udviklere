SELECT p.Name, COUNT(*) NumberOfproducts
FROM Sales.SalesOrderHeader soh
JOIN Sales.SalesOrderDetail sod ON sod.SalesOrderID = soh.SalesOrderID
JOIN Production.Product p ON p.ProductID = sod.ProductID
GROUP BY p.Name
ORDER BY p.Name;

SELECT soh.OrderDate, COUNT(*) NumberOfproducts
FROM Sales.SalesOrderHeader soh
JOIN Sales.SalesOrderDetail sod ON sod.SalesOrderID = soh.SalesOrderID
JOIN Production.Product p ON p.ProductID = sod.ProductID
GROUP BY soh.OrderDate
ORDER BY soh.OrderDate;
