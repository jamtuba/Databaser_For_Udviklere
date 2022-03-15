SELECT *
FROM Book AS b
JOIN BookCategoryRelation AS bc ON b.Id = bc.BookId
JOIN Category AS c ON bc.CategoryId = c.Id
WHERE c.CategoryName IN ('Teknologi','C#')