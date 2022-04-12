-- Statement 2
USE NordicSheetMusic;
GO

-- Insert i selvstændige tabeller
INSERT INTO [dbo].[Contributor](ContributorType)
VALUES(N'Composer'),(N'Lyricist'),(N'Arranger'),(N'Performer');

INSERT INTO [dbo].[Publisher](PublisherName)
VALUES(N'Breitkopf und Härtel'),(N'Columbia Special Products'),(N'Kensington Music'),(N'Unknown');

INSERT INTO [dbo].[Instrument](InstrumentName)
VALUES(N'Flute'),(N'Oboe'),(N'Clarinet'),(N'Bassoon'),(N'Horn in F'),(N'Trumpet'),(N'Trombone'),
    (N'Bass Trombone'),(N'Tuba'),(N'Timpani'),(N'Violin'),(N'Viola'),(N'Cello'),(N'Bass'),(N'Piano'),
    (N'Vocal'),(N'Alto Saxophone'),(N'Tenor Saxophone'),(N'Baritone Saxophone'),(N'Guitar'),(N'Drums'),(N'Bass Guitar');

INSERT INTO [dbo].[Genre](GenreName)
VALUES(N'Symphony'),(N'Classical'),(N'Solo'),(N'Baroque'),(N'Big Band'),(N'Jazz'),(N'Chamber Music');

INSERT INTO [dbo].[Person](FirstName,MiddleName,LastName,DateOfBirth,TimeOfDeath)
VALUES(N'Jean',NULL,N'Sibelius','1865-12-08','1957-09-20'),
    (N'Johann',N'Sebastian',N'Bach','1685-03-21','1750-07-28'),
    (N'Frédéric',NULL,'Chopin','1810-03-01','1849-10-17'),
    (N'Frank',NULL,N'Sinatra','1915-12-12','1998-05-14'),
    (N'Bart',NULL,N'Howard','1915-06-01','2004-02-21'),
    (N'London',NULL,N'Orchestrations',NULL,NULL),
    (N'Carl',N'August',N'Nielsen','1865-06-09','1931-10-03'),
    (N'Herbert',N'Alfred',N'Bergstedt','1877-08-10','1965-09-19'),
    (N'Jesper',NULL,N'Riis','1969-01-01',NULL);
GO

-- Insert i afhængige tabeller
DECLARE @symphony NVARCHAR(50) = N'Symphony No. 2', @celloSuites NVARCHAR(50) = N'6 cello suites', 
    @nocturne2 NVARCHAR(50) = N'Nocturne no. 2. Sostenuto',@flyMeToTheMoon NVARCHAR(50) = N'Fly Me to the Moon',
    @solenErSoRed NVARCHAR(50) = N'Solen er så rød, mor';

INSERT INTO [dbo].[SheetMusic](Title,Duration,CompositionYear,OpusNumber,OriginalComposition,PublisherId)
VALUES(@symphony,'00:45:00',1901,43,1,(SELECT Id FROM [dbo].[Publisher] WHERE PublisherName = N'Breitkopf und Härtel')),
    (@celloSuites,'02:42:37',1717,NULL,1,(SELECT Id FROM [dbo].[Publisher] WHERE PublisherName = N'Breitkopf und Härtel')),
    (@nocturne2,'00:05:20',1836,27,1,(SELECT Id FROM [dbo].[Publisher] WHERE PublisherName = N'Columbia Special Products')),
    (@flyMeToTheMoon,'00:02:14',1954,NULL,1,(SELECT Id FROM [dbo].[Publisher] WHERE PublisherName = N'Kensington Music')),
    (@solenErSoRed,'00:05:00',2006,NULL,0,(SELECT Id FROM [dbo].[Publisher] WHERE PublisherName = N'Unknown'));

-- Insert i relationelle tabeller
DECLARE @symphonyId VARCHAR(50) = (SELECT Id FROM [dbo].[SheetMusic] WHERE Title = @symphony),
    @celloSuitesId VARCHAR(50) = (SELECT Id FROM [dbo].[SheetMusic] WHERE Title = @celloSuites),
    @nocturne2Id VARCHAR(50) = (SELECT Id FROM [dbo].[SheetMusic] WHERE Title = @nocturne2),
    @flyMeToTheMoonId VARCHAR(50) = (SELECT Id FROM [dbo].[SheetMusic] WHERE Title = @flyMeToTheMoon),
    @solenErSoRedId VARCHAR(50) = (SELECT Id FROM [dbo].[SheetMusic] WHERE Title = @solenErSoRed);

INSERT INTO[dbo].[SheetMusicInstrumentRelation](SheetMusicId,InstrumentId,InstrumentCount)
VALUES(@symphonyId,(SELECT Id FROM [dbo].[Instrument] WHERE InstrumentName = N'Flute'),2),
    (@symphonyId,(SELECT Id FROM [dbo].[Instrument] WHERE InstrumentName = N'Oboe'),2),
    (@symphonyId,(SELECT Id FROM [dbo].[Instrument] WHERE InstrumentName = N'Clarinet'),2),
    (@symphonyId,(SELECT Id FROM [dbo].[Instrument] WHERE InstrumentName = N'Bassoon'),2),
    (@symphonyId,(SELECT Id FROM [dbo].[Instrument] WHERE InstrumentName = N'Horn in F'),4),
    (@symphonyId,(SELECT Id FROM [dbo].[Instrument] WHERE InstrumentName = N'Trumpet'),3),
    (@symphonyId,(SELECT Id FROM [dbo].[Instrument] WHERE InstrumentName = N'Trombone'),3),
    (@symphonyId,(SELECT Id FROM [dbo].[Instrument] WHERE InstrumentName = N'Tuba'),1),
    (@symphonyId,(SELECT Id FROM [dbo].[Instrument] WHERE InstrumentName = N'Timpani'),1),
    (@symphonyId,(SELECT Id FROM [dbo].[Instrument] WHERE InstrumentName = N'Violin'),30),
    (@symphonyId,(SELECT Id FROM [dbo].[Instrument] WHERE InstrumentName = N'Viola'),12),
    (@symphonyId,(SELECT Id FROM [dbo].[Instrument] WHERE InstrumentName = N'Cello'),10),
    (@symphonyId,(SELECT Id FROM [dbo].[Instrument] WHERE InstrumentName = N'Bass'),8),
    (@celloSuitesId,(SELECT Id FROM [dbo].[Instrument] WHERE InstrumentName = N'Cello'),1),
    (@nocturne2Id,(SELECT Id FROM [dbo].[Instrument] WHERE InstrumentName = N'Piano'),1),
    (@flyMeToTheMoonId,(SELECT Id FROM [dbo].[Instrument] WHERE InstrumentName = N'Alto Saxophone'),2),
    (@flyMeToTheMoonId,(SELECT Id FROM [dbo].[Instrument] WHERE InstrumentName = N'Tenor Saxophone'),2),
    (@flyMeToTheMoonId,(SELECT Id FROM [dbo].[Instrument] WHERE InstrumentName = N'Baritone Saxophone'),1),
    (@flyMeToTheMoonId,(SELECT Id FROM [dbo].[Instrument] WHERE InstrumentName = N'Trumpet'),4),
    (@flyMeToTheMoonId,(SELECT Id FROM [dbo].[Instrument] WHERE InstrumentName = N'Trombone'),3),
    (@flyMeToTheMoonId,(SELECT Id FROM [dbo].[Instrument] WHERE InstrumentName = N'Bass Trombone'),1),
    (@flyMeToTheMoonId,(SELECT Id FROM [dbo].[Instrument] WHERE InstrumentName = N'Piano'),1),
    (@flyMeToTheMoonId,(SELECT Id FROM [dbo].[Instrument] WHERE InstrumentName = N'Guitar'),1),
    (@flyMeToTheMoonId,(SELECT Id FROM [dbo].[Instrument] WHERE InstrumentName = N'Bass Guitar'),1),
    (@flyMeToTheMoonId,(SELECT Id FROM [dbo].[Instrument] WHERE InstrumentName = N'Drums'),1),
    (@flyMeToTheMoonId,(SELECT Id FROM [dbo].[Instrument] WHERE InstrumentName = N'Vocal'),1),
    (@solenErSoRedId,(SELECT Id FROM [dbo].[Instrument] WHERE InstrumentName = N'Trumpet'),2),
    (@solenErSoRedId,(SELECT Id FROM [dbo].[Instrument] WHERE InstrumentName = N'Horn in F'),1),
    (@solenErSoRedId,(SELECT Id FROM [dbo].[Instrument] WHERE InstrumentName = N'Trombone'),1),
    (@solenErSoRedId,(SELECT Id FROM [dbo].[Instrument] WHERE InstrumentName = N'Tuba'),1);

DECLARE @JeanSibeliusId VARCHAR(50) = (SELECT Id FROM [dbo].[Person] WHERE FirstName = N'Jean' AND LastName = N'Sibelius'),
    @JohannSebastianBachId VARCHAR(50) = (SELECT Id FROM [dbo].[Person] WHERE FirstName = N'Johann' AND MiddleName = N'Sebastian' AND LastName = N'Bach'),
    @FredericChopinId VARCHAR(50) = (SELECT Id FROM [dbo].[Person] WHERE FirstName = N'Frédéric' AND LastName = N'Chopin'),
    @BartHowardId VARCHAR(50) = (SELECT Id FROM [dbo].[Person] WHERE FirstName = N'Bart' AND LastName = N'Howard'),
    @FrankSinatraId VARCHAR(50) = (SELECT Id FROM [dbo].[Person] WHERE FirstName = N'Frank' AND LastName = N'Sinatra'),
    @LondonOrchestrationsId VARCHAR(50) = (SELECT Id FROM [dbo].[Person] WHERE FirstName = N'London' AND LastName = N'Orchestrations'),
    @CarlNielsenId VARCHAR(50) = (SELECT Id FROM [dbo].[Person] WHERE FirstName = N'Carl' AND MiddleName = N'August' AND LastName = N'Nielsen'),
    @HerbertBergstedtId VARCHAR(50) = (SELECT Id FROM [dbo].[Person] WHERE FirstName = N'Herbert' AND MiddleName = N'Alfred' AND LastName = N'Bergstedt'),
    @JesperRiisId VARCHAR(50) = (SELECT Id FROM [dbo].[Person] WHERE FirstName = N'Jesper' AND LastName = N'Riis');

INSERT INTO[dbo].[SheetMusicPersonRelation](SheetMusicId,PersonId)
VALUES(@symphonyId,@JeanSibeliusId),
    (@celloSuitesId,@JohannSebastianBachId),
    (@nocturne2Id,@FredericChopinId),
    (@flyMeToTheMoonId,@BartHowardId),
    (@flyMeToTheMoonId,@FrankSinatraId),
    (@flyMeToTheMoonId,@LondonOrchestrationsId),
    (@solenErSoRedId,@CarlNielsenId),
    (@solenErSoRedId,@HerbertBergstedtId),
    (@solenErSoRedId,@JesperRiisId);

INSERT INTO[dbo].[SheetMusicGenreRelation](SheetMusicId,GenreName)
VALUES(@symphonyId,N'Symphony'),
    (@symphonyId,N'Classical'),
    (@celloSuitesId,N'Classical'),
    (@celloSuitesId,N'Solo'),
    (@celloSuitesId,N'Baroque'),
    (@nocturne2Id,N'Classical'),
    (@nocturne2Id,N'Solo'),
    (@flyMeToTheMoonId,N'Big Band'),
    (@flyMeToTheMoonId,N'Jazz'),
    (@solenErSoRedId,N'Chamber Music');

DECLARE @Composer INT = (SELECT Id FROM [dbo].[Contributor] WHERE ContributorType = N'Composer'),
    @Lyricist INT = (SELECT Id FROM [dbo].[Contributor] WHERE ContributorType = N'Lyricist'),
    @Arranger INT = (SELECT Id FROM [dbo].[Contributor] WHERE ContributorType = N'Arranger'),
    @Performer INT = (SELECT Id FROM [dbo].[Contributor] WHERE ContributorType = N'Performer');

INSERT INTO[dbo].[PersonContributorRelation](PersonId,ContributorId)
VALUES(@JeanSibeliusId,@Composer),
    (@JohannSebastianBachId,@Composer),
    (@FredericChopinId,@Composer),
    (@BartHowardId,@Composer),
    (@BartHowardId,@Lyricist),
    (@FrankSinatraId,@Performer),
    (@LondonOrchestrationsId,@Arranger),
    (@CarlNielsenId,@Composer),
    (@HerbertBergstedtId,@Lyricist),
    (@JesperRiisId,@Arranger);
GO