SELECT Title AS 'Books with a price'
FROM Book b 
WHERE EXISTS(
    SELECT PriceId FROM BookPriceRelation as bpr
    WHERE b.Id = bpr.BookId);
