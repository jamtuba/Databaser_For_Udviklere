-- Statement 3
USE NordicSheetMusic;
GO

-- Opdatering af Sheetmusic, tilføjelse af junction tabal mellem SheetMusic og Publisher
DROP TABLE IF EXISTS [dbo].[SheetMusicPublisherRelation];
GO

BEGIN TRY
    BEGIN TRAN

        -- Kopierer kolonner ind i en ny tabel der samtidig oprettes
        SELECT Id, PublisherId
        INTO SheetMusicPublisherRelation
        FROM SheetMusic;
        
        EXEC sp_rename 'SheetMusicPublisherRelation.Id','SheetMusicId'; -- her omdøber jeg kolonnen
        -- Der tilføjes CONSTRAINTS til og oprettes PRIMARY OG FOREIGN KEYs
        ALTER TABLE SheetMusicPublisherRelation ADD CONSTRAINT PK_Sheet_Publish PRIMARY KEY CLUSTERED(SheetMusicId,PublisherId);
        ALTER TABLE SheetMusicPublisherRelation ADD 
            CONSTRAINT FK_Sheet_Publish_SheetMusic FOREIGN KEY (SheetMusicId) REFERENCES SheetMusic (Id) ON DELETE CASCADE,
            CONSTRAINT FK_Sheet_Publish_Publisher FOREIGN KEY (PublisherId) REFERENCES Publisher (Id) ON DELETE CASCADE;

        ALTER TABLE SheetMusic DROP CONSTRAINT FK_Sheet_Publish_Pub; -- CONSTRAINT fjernes
        ALTER TABLE SheetMusic DROP COLUMN PublisherId; -- kolonnen slettes

    COMMIT TRAN
END TRY
BEGIN CATCH
    PRINT ERROR_MESSAGE();
    ROLLBACK TRAN
END CATCH;