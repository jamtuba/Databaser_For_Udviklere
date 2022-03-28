SELECT 
    ISBN, 
    Title,
    p.Price AS 'CurrentPrice',
    CAST(AVG(p.Price) OVER(PARTITION BY b.Id) AS DECIMAL(6,2)) AS AverageBookPrice,
    LAG(p.Price) OVER(PARTITION BY b.Id ORDER BY p.price) AS PreviousPrice
FROM Book as b 
LEFT JOIN BookPriceRelation as bp on bp.BookId = b.Id
LEFT JOIN Price as p on p.Id = bp.PriceId
ORDER BY ISBN;