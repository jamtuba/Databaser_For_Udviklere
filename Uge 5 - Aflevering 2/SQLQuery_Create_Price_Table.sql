IF OBJECT_ID('[dbo].[Price]', 'U') IS NOT NULL
DROP TABLE [dbo].[Price]
GO

CREATE TABLE [dbo].[Price](
    [Id] INT IDENTITY (1,1) NOT NULL PRIMARY KEY, -- Primary Key column
    [Price] DECIMAL(6,2) NOT NULL
);
GO