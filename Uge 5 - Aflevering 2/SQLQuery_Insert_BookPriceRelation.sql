INSERT INTO [dbo].[BookPriceRelation]
    (BookId, PriceId)
VALUES
    (2,6),
    (3,4),
    (4,5);
GO

INSERT INTO [dbo].[BookPriceRelation]
    (BookId, PriceId, PriceDate)
VALUES
    (2,8,'2020-02-02'),
    (4,6,'2020-03-03'),
    (7,9,'2021-12-31');
GO