-- Query 7
USE NordicSheetMusic;
GO

-- Query 7.1
-- Vælger titel, varighed, kompositionsår, opusnummer, hele bidragsyderens navn, fødselsår, dødsår og hvad der er bidraget med
SELECT sm.Title, sm.Duration, sm.CompositionYear, sm.OpusNumber, 
    p.FirstName + ISNULL(' ' + MiddleName,'') + ' ' + p.LastName AS FullName, 
    YEAR(p.DateOfBirth) AS DOB, YEAR(p.TimeOfDeath) AS TOD, c.ContributorType
FROM dbo.SheetMusic sm 
JOIN dbo.SheetMusicPersonRelation smpr ON smpr.SheetMusicId = sm.Id
JOIN dbo.Person p ON p.Id = smpr.PersonId
JOIN dbo.PersonContributorRelation pctr ON pctr.PersonId = p.Id
JOIN dbo.Contributor c ON c.Id = pctr.ContributorId
ORDER BY Title; 

-- Query 7.2
-- Viser det samlede antal af hvert instrument i alle stykker i mine tabeller
SELECT DISTINCT InstrumentName, 
    SUM(InstrumentCount) OVER(PARTITION BY InstrumentName) AS InstrumentCount
FROM SheetMusic sm 
JOIN SheetMusicInstrumentRelation smir ON sm.Id = smir.SheetMusicId
JOIN Instrument i ON i.Id = smir.InstrumentId;

-- Query 7.3
-- Finder alle komponister
SELECT p.FirstName + ISNULL(' ' + MiddleName,'') + ' ' + p.LastName AS FullName
FROM Person p 
JOIN PersonContributorRelation pcr ON p.Id = pcr.PersonId
JOIN Contributor c ON pcr.ContributorId = c.Id
WHERE c.ContributorType = N'Composer';

-- Query 7.4
-- Finder alle instrumenter med mere end 10 bogstaver
SELECT InstrumentName
FROM Instrument
WHERE InstrumentName LIKE '%n%'
GROUP BY InstrumentName
HAVING LEN(InstrumentName) > 10;