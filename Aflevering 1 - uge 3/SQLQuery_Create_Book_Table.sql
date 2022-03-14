-- Create a new table called '[Book]' in schema '[dbo]'
-- Drop the table if it already exists
IF OBJECT_ID('[dbo].[Book]', 'U') IS NOT NULL
DROP TABLE [dbo].[Book]
GO
-- Create the table in the specified schema
CREATE TABLE [dbo].[Book]
(
    [Id] INT IDENTITY (1,1) NOT NULL PRIMARY KEY, -- Primary Key column
    [Title] NVARCHAR(100) NOT NULL,
    [Summary] NVARCHAR(300) NOT NULL,
    [Price] DECIMAL,
    [ISBN] NVARCHAR(17) UNIQUE NOT NULL -- Including the hyphens
    -- Specify more columns here
);
GO