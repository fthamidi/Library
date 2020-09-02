USE MyLibrary;
GO
DROP PROCEDURE IF EXISTS dbo.Borrowed_Book;  
GO
CREATE FUNCTION dbo.Borrowed_Book
(@member INT, 
 @month  INT
)
RETURNS INT
AS
     BEGIN
         DECLARE @returnval INT;
         SELECT @returnval = COUNT(member_id)
         FROM [dbo].[loaned_book]
         WHERE member_id = @member
               AND CAST(MONTH(CAST(date_loaned AS DATE)) AS INT) = @month
         GROUP BY member_id, 
                  MONTH(CAST(date_loaned AS DATE));
         RETURN @returnval;
     END;
GO
SELECT dbo.Borrowed_Book(1, 8);