IF OBJECT_ID('[dbo].[BookPriceRelation]', 'U') IS NOT NULL
DROP TABLE [dbo].[BookPriceRelation]
GO

CREATE TABLE [dbo].[BookPriceRelation](
    [Id] INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    [BookId]INT NOT NULL,
    [PriceId] INT NOT NULL, 
    [PriceDate] DATE NOT NULL,
    FOREIGN KEY (BookId) REFERENCES Book (Id),
    FOREIGN KEY (PriceId) REFERENCES Author (Id)
);
GO

ALTER TABLE [dbo].[BookPriceRelation] ADD CONSTRAINT [DF_BookPriceRelation_PriceDate]
    DEFAULT (GETDATE()) FOR [PriceDate];
GO