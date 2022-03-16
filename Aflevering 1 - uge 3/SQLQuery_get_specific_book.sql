SELECT Title, CategoryName, a.FirstName + ISNULL(NULLIF(' ' + MiddleName,' '), '') + ' ' + LastName AS AuthorName, ISBN, Summary, Price
FROM Book AS b
JOIN BookCategoryRelation AS bc ON b.Id = bc.BookId
JOIN Category AS c ON bc.CategoryId = c.Id
JOIN AuthorBookRelation AS ab ON b.Id = ab.BookId
JOIN Author AS a ON a.Id = ab.AuthorId
WHERE b.Title = 'Pro C# 7';