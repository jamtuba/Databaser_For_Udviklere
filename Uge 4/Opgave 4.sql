SELECT TerritoryID, Bonus, 
    LAG(Bonus) OVER(PARTITION BY TerritoryID ORDER BY ModifiedDate) PrevBonus,
    AVG(Bonus) OVER(PARTITION BY TerritoryID) AVGBonus,
    ModifiedDate
FROM Sales.SalesPerson
WHERE TerritoryID IS NOT NULL
ORDER BY TerritoryID;