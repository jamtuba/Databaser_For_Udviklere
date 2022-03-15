SELECT Title, Summary, Price, ISBN, a.FirstName + ISNULL(NULLIF(' ' + MiddleName,' '), '') + ' ' + LastName AS AuthorName
FROM Book AS b
JOIN AuthorBookRelation AS ab ON  b.Id = ab.BookId
JOIN Author AS a ON ab.AuthorId = a.Id
ORDER BY a.MiddleName DESC

SELECT Title
FROM Author AS a
JOIN AuthorBookRelation AS ab ON ab.AuthorId = a.Id
JOIN Book AS b ON b.Id = ab.BookId
WHERE a.MiddleName = 'Åge'