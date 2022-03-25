SELECT TerritoryID, Bonus, AVG(Bonus) OVER(PARTITION BY TerritoryID) AVGBonus
FROM Sales.SalesPerson
WHERE TerritoryID IS NOT NULL
ORDER BY TerritoryID, Bonus;