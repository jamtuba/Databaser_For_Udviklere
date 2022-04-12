-- Statement 1
USE master;
GO

-- Dropper databasen hvis den allerede findes
DROP DATABASE IF EXISTS [NordicSheetMusic];
GO

-- Database oprettelse
PRINT 'Database oprettelse.';
CREATE DATABASE [NordicSheetMusic];
GO

USE NordicSheetMusic;
GO

-- Selvstændige tabeller
PRINT 'Selvstændige tabeller.';
CREATE TABLE [dbo].[Publisher]
(
    [Id] UNIQUEIDENTIFIER NOT NULL PRIMARY KEY DEFAULT NEWID(),
    [PublisherName] NVARCHAR(100)
);
-- GO

CREATE TABLE [dbo].[Genre]
(
    [GenreName] NVARCHAR(100) NOT NULL PRIMARY KEY  -- Skal der et rigtigt Id på?
);


CREATE TABLE [dbo].[Instrument]
(
    [Id] UNIQUEIDENTIFIER NOT NULL PRIMARY KEY DEFAULT NEWID(),
    [InstrumentName] NVARCHAR(50) NOT NULL
);


CREATE TABLE [dbo].[Contributor]
(
    [Id] INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    [ContributorType] NVARCHAR(50) NOT NULL
);


CREATE TABLE [dbo].[Person]
(
    [Id] UNIQUEIDENTIFIER NOT NULL PRIMARY KEY DEFAULT NEWID(),
    [FirstName] NVARCHAR(50) NOT NULL,
    [MiddleName] NVARCHAR(50),
    [LastName] NVARCHAR(50) NOT NULL,
    [DateOfBirth] DATETIME2,
    [TimeOfDeath] DATETIME2
);
GO

-- Afhængige tabeller
PRINT 'Afhængige tabeller';
CREATE TABLE [dbo].[SheetMusic]
(
    [Id] UNIQUEIDENTIFIER NOT NULL PRIMARY KEY DEFAULT NEWID(),
    [Title] NVARCHAR(100) NOT NULL, 
    [Duration] VARCHAR(8) DEFAULT ('00:00:00'),
    [CompositionYear] INT, 
    [OpusNumber] INT,
    [OriginalComposition] BIT NOT NULL DEFAULT (1), -- 1 er en originalkomposition
    [PublisherId] UNIQUEIDENTIFIER NOT NULL,
    CONSTRAINT FK_Sheet_Publish_Pub FOREIGN KEY (PublisherId) REFERENCES Publisher(Id)
);
GO

-- Relationelle sammensatte (junction) tabeller
PRINT 'Relationelle sammensatte (junction) tabeller.'
CREATE TABLE [dbo].[SheetMusicInstrumentRelation]
(
    [SheetMusicId] UNIQUEIDENTIFIER NOT NULL, 
    [InstrumentId] UNIQUEIDENTIFIER NOT NULL,
    [InstrumentCount] INT NOT NULL DEFAULT (1),
    PRIMARY KEY(SheetMusicId, InstrumentId),
    CONSTRAINT FK_Sheet_Instrument_Sheet FOREIGN KEY (SheetMusicId) REFERENCES SheetMusic (Id) ON DELETE CASCADE,
    CONSTRAINT FK_Sheet_Instrument_Instr FOREIGN KEY (InstrumentId) REFERENCES Instrument (Id) ON DELETE CASCADE
);

CREATE TABLE [dbo].[SheetMusicPersonRelation]
(
    [SheetMusicId] UNIQUEIDENTIFIER NOT NULL, 
    [PersonId] UNIQUEIDENTIFIER NOT NULL,
    PRIMARY KEY(SheetMusicId, PersonId),
    CONSTRAINT FK_Sheet_Person_Sheet FOREIGN KEY (SheetMusicId) REFERENCES SheetMusic (Id) ON DELETE CASCADE,
    CONSTRAINT FK_Sheet_Person_Pers FOREIGN KEY (PersonId) REFERENCES Person (Id) ON DELETE CASCADE
);

CREATE TABLE [dbo].[SheetMusicGenreRelation]
(
    [SheetMusicId] UNIQUEIDENTIFIER NOT NULL, 
    [GenreName] NVARCHAR(100) NOT NULL,
    PRIMARY KEY(SheetMusicId, GenreName),
    CONSTRAINT FK_Sheet_Genre_Sheet FOREIGN KEY (SheetMusicId) REFERENCES SheetMusic (Id) ON DELETE CASCADE,
    CONSTRAINT FK_Sheet_Genre_Genre FOREIGN KEY (GenreName) REFERENCES Genre (GenreName) ON DELETE CASCADE
);

CREATE TABLE [dbo].[PersonContributorRelation]
(
    [PersonId] UNIQUEIDENTIFIER NOT NULL, 
    [ContributorId] INT NOT NULL,
    PRIMARY KEY(PersonId, ContributorId),
    CONSTRAINT FK_Person_Contr_Pers FOREIGN KEY (PersonId) REFERENCES Person (Id) ON DELETE CASCADE,
    CONSTRAINT FK_Person_Contr_Contr FOREIGN KEY (ContributorId) REFERENCES Contributor (Id) ON DELETE CASCADE
);
GO