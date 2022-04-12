-- Statement / Query 6
USE NordicSheetMusic
GO

-- Slet en bestemt node
DECLARE @title NVARCHAR(50) = N'Nyt værk';

-- Query 6.1
-- Query på om det er det er det rigtige der skal slettes
SELECT *
FROM SheetMusic
WHERE Title = @title;

-- Statement 6.2
-- Statement til at slette den angivne titel
DELETE FROM SheetMusic
WHERE Title = @title;
GO

DECLARE @title NVARCHAR(50) = N'Nyt værk';
-- Query 6.3
-- Query på om det er det er det rigtige der skal slettes
SELECT *
FROM SheetMusic
WHERE Title = @title;