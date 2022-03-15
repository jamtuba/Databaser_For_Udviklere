-- Create a new table called '[Author]' in schema '[dbo]'
-- Drop the table if it already exists
IF OBJECT_ID('[dbo].[Author]', 'U') IS NOT NULL
DROP TABLE [dbo].[Author]
GO
-- Create the table in the specified schema
CREATE TABLE [dbo].[Author]
(
    [Id] INT IDENTITY (1,1) NOT NULL PRIMARY KEY, -- Primary Key column
    [FirstName] NVARCHAR(50) NOT NULL,
    [MiddleName] NVARCHAR(50),
    [LastName] NVARCHAR(50) NOT NULL,
    [EmailAddress] NVARCHAR(100) UNIQUE NOT NULL
);
GO