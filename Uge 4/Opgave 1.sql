SELECT DISTINCT TerritoryID TerrID, 
    COUNT(*) OVER() NumOfSales,
    SUM(SalesLastYear) OVER(PARTITION BY TerritoryID) SumOfAllSales,
    AVG(SalesLastYear) OVER() AVGOfSales,
    MIN(SalesLastYear) OVER() MINOfSales,
    MAX(SalesLastYear) OVER() MAXOfSales
FROM Sales.SalesPerson
WHERE SalesLastYear > 1000000
ORDER BY TerritoryID;


SELECT TOP(100) SalesLastYear, TerritoryID
FROM Sales.SalesPerson
ORDER BY SalesLastYear DESC;
