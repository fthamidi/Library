USE MyLibrary;
GO
DROP PROCEDURE IF EXISTS dbo.Top_Loaned_Author;  
GO
CREATE PROCEDURE Top_Loaned_Author(@Loan_Year CHAR(4))
AS
    BEGIN
        SET NOCOUNT ON;
        WITH cte
             AS (SELECT d.id, 
                        d.author_name, 
                        D.author_surname, 
                        YEAR(CAST(a.date_loaned AS DATE)) AS Date_Loaned, 
                        COUNT(d.id) OVER(PARTITION BY d.id
                        ORDER BY d.id DESC) AS loaned_num
                 FROM loaned_book A
                      JOIN book_item B ON a.book_item_id = b.id
                      JOIN book_authorship C ON b.isbn = c.book_id
                      JOIN author D ON c.author_id = d.id)
             SELECT DISTINCT TOP 5 *
             FROM cte;
    END;
GO
EXEC Top_Loaned_Author 
     @loan_year = '2020';