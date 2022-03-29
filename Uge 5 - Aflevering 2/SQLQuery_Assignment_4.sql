SELECT Title, FirstName + ' ' + LastName AS Fullname, ISBN, Price, PriceDate
FROM Book as b 
JOIN AuthorBookRelation abr on abr.BookId = b.Id
JOIN Author a on a.Id = abr.AuthorId
JOIN BookPriceRelation bpr on bpr.BookId = b.Id
JOIN Price p on p.Id = bpr.PriceId
WHERE Price > 40 AND PriceDate = '2022-03-28' AND Title LIKE '%C%#%';