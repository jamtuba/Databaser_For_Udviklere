SELECT Title, c.CategoryName, a.FirstName + ISNULL(NULLIF(' ' + MiddleName,' '), '') + ' ' + LastName AS AuthorName, ISBN
FROM Book AS b
JOIN AuthorBookRelation AS ab ON b.Id = ab.BookId
JOIN Author AS a ON ab.AuthorId = a.Id
JOIN BookCategoryRelation AS bc ON bc.BookId = b.Id
JOIN Category AS c ON bc.CategoryId = c.Id
ORDER BY Title;