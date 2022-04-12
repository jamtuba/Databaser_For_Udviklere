-- Statement / Query 5
USE NordicSheetMusic;
GO

DROP VIEW IF EXISTS TheTrumpetView;
GO
-- Laver et view til senere brug
CREATE VIEW TheTrumpetView AS 
SELECT sm.Title, i.InstrumentName, smir.InstrumentCount, sm.OpusNumber
FROM SheetMusicInstrumentRelation as smir
JOIN Instrument AS i ON smir.InstrumentId = i.Id
JOIN SheetMusic AS sm ON sm.Id = smir.SheetMusicId
WHERE i.InstrumentName = 'Trumpet';
GO

SELECT Title, OpusNumber
FROM TheTrumpetView;

-- Update allerede eksisterende data
UPDATE SheetMusic
SET OpusNumber = 0
WHERE OpusNumber IS NULL;

SELECT *
FROM TheTrumpetView;
GO

ALTER VIEW TheTrumpetView AS 
SELECT sm.Title, i.InstrumentName, smir.InstrumentCount, sm.OpusNumber
FROM SheetMusicInstrumentRelation as smir
JOIN Instrument AS i ON smir.InstrumentId = i.Id
JOIN SheetMusic AS sm ON sm.Id = smir.SheetMusicId
WHERE i.InstrumentName = 'Trumpet' AND Title = 'Nyt værk';
GO

SELECT Title, InstrumentName, InstrumentCount
FROM TheTrumpetView;

-- Update antal instrumenter i et værk
UPDATE SheetMusicInstrumentRelation
SET InstrumentCount = 4
FROM SheetMusicInstrumentRelation as smir 
JOIN SheetMusic as sm ON smir.sheetmusicId = sm.Id
JOIN Instrument AS i ON smir.InstrumentId = i.Id
WHERE Title = 'Nyt værk' AND i.InstrumentName = 'Trumpet';

SELECT InstrumentName, InstrumentCount
FROM TheTrumpetView;