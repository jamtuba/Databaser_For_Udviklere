-- Insert rows into table 'Book' in schema '[dbo]'
INSERT INTO [dbo].[Book]
( -- Columns to insert data into
    Title, Summary, Price, ISBN
)
VALUES
( 
    'Beginning T-SQL', 'A Step-By-Step Approach', NULL, '978-1-4842-6605-2'
),
( 
    'C# 7.0', 'In a Nutshell', 79.99, '978-1-491-98765-0'
),
(
    'Pro C# 7', 'With .NET and .NET Core', 59.99, '978-1-4842-3017-6'
),
(
    'Unit Testing', 'Principles, Practices, and Patterns', 49.99, '978-1-61729-627-1'    
),
(
    'Fremtidsspejl', 'Spændende bog om en kronofysiker der forelsker sig i 2 piger på samme tid', NULL, '978-87-02-30420-6'
),
(
    'Mange sære ting for', 'Forrygende filosofisk spændingsroman om religion, sandhed og kampen for at få fat i den rette fortolkning', NULL, '978-87-02-08254-8'
),
(
    'The Institute', 'Spændings roman', NULL, '978-1-529-35541-3'
),
(
    'Blodtørst', 'Og andre fortællinger', NULL, '978-87-400-6521-3'
),
(
    'Natrium Chlorid', 'Spændingsroman af en af Danmarks bedste krimiforfattere', NULL, '978-87-400-451-30'
)
GO