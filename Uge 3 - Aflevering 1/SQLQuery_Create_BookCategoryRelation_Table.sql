-- Create a new table called '[BookCategoryRelation]' in schema '[dbo]'
-- Drop the table if it already exists
IF OBJECT_ID('[dbo].[BookCategoryRelation]', 'U') IS NOT NULL
DROP TABLE [dbo].[BookCategoryRelation]
GO
-- Create the table in the specified schema
CREATE TABLE [dbo].[BookCategoryRelation]
(
    [BookId]INT NOT NULL,
    [CategoryId] INT NOT NULL, 
    PRIMARY KEY(BookId, CategoryId),
    FOREIGN KEY (BookId) REFERENCES Book (Id),
    FOREIGN KEY (CategoryId) REFERENCES Category (Id)
);
GO