-- Statement 4
USE NordicSheetMusic;
GO

-- Indsættelse af nyt musikværk
DECLARE @publisherTable TABLE(Id INT IDENTITY(1,1),PublisherName NVARCHAR(50));
DECLARE @genreTable TABLE(GenreName NVARCHAR(50));
DECLARE @instrumentTable TABLE(Id INT IDENTITY(1,1),InstrumentName NVARCHAR(50));
DECLARE @NumberOfInstrumentsTable TABLE(Id INT IDENTITY(1,1),NumOfIstruments INT);
DECLARE @contributorTable TABLE(Id INT IDENTITY(1,1),ContributorName NVARCHAR(150));
DECLARE @contributorTypeTable TABLE(Id INT IDENTITY(1,1),ContributorType NVARCHAR(50));
DECLARE @contributorDobTodTable TABLE(Id INT IDENTITY(1,1),ContributorDobTod NVARCHAR(50));

DECLARE @title NVARCHAR(100) = N'Nyt værk',
        @duration VARCHAR(8) = '00:00:00',
        @compositionYear INT = 2022,
        @opusNumber INT = 33,
        @originalComposition BIT = 1,
        @publisherList NVARCHAR(2000) = N'Bärenreiter,Kensington',
        @genreList NVARCHAR(200) = N'Classical',
        @instrumentList NVARCHAR(2000) = N'Trumpet,Trombone',
        @numberOfInstrumentsList NVARCHAR(200) = N'2,3',
        @contributorList NVARCHAR(2000) = N'Carl;August;Nielsen,Jesper;;Riis,Wolfgang;Amadeus;Mozart',
        @contributorTypeList NVARCHAR(200) = N'Composer,Arranger,Composer',
        @contributorDobTodList NVARCHAR(100) = N'1950;2020,1952;,1756;1791';

INSERT INTO @publisherTable
SELECT * FROM string_split(@publisherList,',');

INSERT INTO @genreTable
SELECT * FROM string_split(@genreList,',');

INSERT INTO @instrumentTable
SELECT * FROM string_split(@instrumentList,',');

INSERT INTO @NumberOfInstrumentsTable
SELECT * FROM string_split(@numberOfInstrumentsList,',');

INSERT INTO @contributorTable
SELECT * FROM string_split(@contributorList,',');

INSERT INTO @contributorTypeTable
SELECT * FROM string_split(@contributorTypeList,',');

INSERT INTO @contributorDobTodTable
SELECT * FROM string_split(@contributorDobTodList,',');

BEGIN TRY
    BEGIN TRAN
        
        -- Værdier til selvstændige tabeller 
        INSERT INTO Publisher(PublisherName)
        SELECT PublisherName 
        FROM @publisherTable 
        WHERE PublisherName NOT IN (SELECT PublisherName FROM Publisher);

        INSERT INTO Genre
        SELECT GenreName 
        FROM @genreTable 
        WHERE GenreName NOT IN (SELECT GenreName FROM Genre);

        INSERT INTO Instrument(InstrumentName)
        SELECT InstrumentName 
        FROM @instrumentTable 
        WHERE InstrumentName NOT IN (SELECT InstrumentName FROM Instrument);

        INSERT INTO Contributor(ContributorType)
        SELECT ContributorType 
        FROM @contributorTypeTable 
        WHERE ContributorType NOT IN (SELECT ContributorType FROM Contributor);

        INSERT INTO Person(FirstName,MiddleName,LastName,DateOfBirth,TimeOfDeath)
        SELECT 
            (PARSENAME(REPLACE(ContributorName, ';','.'),3)) AS FirstName,
            (PARSENAME(REPLACE(ContributorName, ';','.'),2)) AS MiddleName,
            (PARSENAME(REPLACE(ContributorName, ';','.'),1)) AS LastName,
            ISNULL(NULLIF(LEFT(ContributorDobTod, CHARINDEX(';', cdtt.ContributorDobTod) - 1),''), NULL),
            ISNULL(NULLIF(RIGHT(ContributorDobTod, CHARINDEX(';', REVERSE(ContributorDobTod)) - 1),''), NULL)
            FROM @contributorTable AS ct
            JOIN @contributorDobTodTable as cdtt ON ct.Id = cdtt.Id
            WHERE (PARSENAME(REPLACE(ContributorName, ';','.'),3)) + 
                ISNULL(' ' + (PARSENAME(REPLACE(ContributorName, ';','.'),2)),'') + ' ' + 
                (PARSENAME(REPLACE(ContributorName, ';','.'),1)) NOT IN 
                    (
                    SELECT (p.FirstName + ISNULL(' ' + p.MIddleName,'') + ' ' + p.LastName) FROM Person as p);

        INSERT INTO SheetMusic(Title,Duration,CompositionYear,OpusNumber,OriginalComposition)
        SELECT @title, @duration, @compositionYear, @opusNumber, @originalComposition; 

        -- Værdier til afhængige tabeller
        DECLARE @SheetMusicId VARCHAR(50) = (SELECT Id FROM SheetMusic WHERE Title = @title);

        INSERT INTO SheetMusicInstrumentRelation
        SELECT @SheetMusicId, i.Id, noi.NumOfIstruments
        FROM Instrument AS i
        JOIN @instrumentTable AS it ON it.InstrumentName = i.InstrumentName
        JOIN @NumberOfInstrumentsTable AS noi ON it.Id = noi.Id;

        INSERT INTO SheetMusicPersonRelation
        SELECT @SheetMusicId, p.Id
        FROM Person AS p
        JOIN @contributorTable AS c ON (p.FirstName + ISNULL(' ' + p.MiddleName,'') + ' ' + p.LastName) = 
            (PARSENAME(REPLACE(c.ContributorName, ';','.'),3)) + 
            ISNULL(' ' + (PARSENAME(REPLACE(c.ContributorName, ';','.'),2)),'') + ' ' + 
            (PARSENAME(REPLACE(c.ContributorName, ';','.'),1)); 
        
        INSERT INTO SheetMusicGenreRelation
        SELECT @SheetMusicId, g.GenreName
        FROM Genre AS g
        JOIN @genreTable AS gt ON g.GenreName = gt.GenreName;
        
        INSERT INTO PersonContributorRelation
        SELECT p.Id, c.Id
        FROM Person AS p
        JOIN @contributorTable AS ct ON (p.FirstName + ISNULL(' ' + p.MiddleName,'') + ' ' + p.LastName) = 
                (PARSENAME(REPLACE(ct.ContributorName, ';','.'),3)) + 
                ISNULL(' ' + (PARSENAME(REPLACE(ct.ContributorName, ';','.'),2)),'') + ' ' + 
                (PARSENAME(REPLACE(ct.ContributorName, ';','.'),1))
        JOIN @contributorTypeTable AS ctt ON ct.Id = ctt.Id
        JOIN Contributor AS c ON ctt.ContributorType = c.ContributorType
        WHERE NOT EXISTS(
            SELECT * FROM PersonContributorRelation AS pcr 
            WHERE (p.Id = pcr.PersonId AND c.Id = pcr.ContributorId));

        INSERT INTO SheetMusicPublisherRelation
        SELECT @SheetMusicId, p.Id
        FROM Publisher AS p 
        JOIN @publisherTable AS pt ON p.PublisherName = pt.PublisherName;
    
    COMMIT TRAN
END TRY
BEGIN CATCH
    PRINT ERROR_MESSAGE();
    ROLLBACK TRAN
END CATCH;