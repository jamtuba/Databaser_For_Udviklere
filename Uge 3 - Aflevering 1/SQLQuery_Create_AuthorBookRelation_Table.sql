-- Create a new table called '[AuthorBookRelation]' in schema '[dbo]'
-- Drop the table if it already exists
IF OBJECT_ID('[dbo].[AuthorBookRelation]', 'U') IS NOT NULL
DROP TABLE [dbo].[AuthorBookRelation]
GO
-- Create the table in the specified schema
CREATE TABLE [dbo].[AuthorBookRelation]
(
    [AuthorId] INT NOT NULL, 
    [BookId]INT NOT NULL,
    PRIMARY KEY(AuthorId, BookId),
    FOREIGN KEY (AuthorId) REFERENCES Author (Id),
    FOREIGN KEY (BookId) REFERENCES Book (Id)
);
GO