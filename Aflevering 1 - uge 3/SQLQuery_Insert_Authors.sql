-- Insert rows into table 'Author' in schema '[dbo]'
INSERT INTO [dbo].[Author]
( -- Columns to insert data into
 [FirstName], MiddleName, LastName, EmailAddress
)
VALUES
(
    'Jussi', NULL, 'Adler-Olsen', 'Adler@Olsen.dk'
),
( 
    'Stephen', NULL, 'King', 'TheKing@Horror.com'
),
(
    'Svend', 'Åge', 'Madsen', 'svendaamadsen@mail.dk'
),
(
    'Vladimir', '', 'Khorikov', 'unit@testing.org'
),
(
    'Andrew', NULL, 'Troelsen', 'a@troelsen.com'
),
(
    'Philip', NULL, 'Japikse', 'japikse@gmail.com'
),
(
    'Joseph', '', 'Albahari', 'bigbrother@oreilly.com'
),
(
    'Ben', '', 'Albahari', 'littlebrother@oreilly.com'
),
(
    'Keith', '', 'Kellenberger','keller@hotmail.com'
),
(
    'Lee', 'mr T-SQL', 'Everest', 'sql@apress.com'
)

GO