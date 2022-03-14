DROP TABLE IF EXISTS #DateTimeExample

CREATE TABLE #DateTimeExample(
    ID INT NOT NULL IDENTITY PRIMARY KEY,
    MyDate DATETIME2(0) NOT NULL,
    MyValue VARCHAR(25) NOT NULL
);
GO
INSERT #DateTimeExample (MyDate, MyValue)
VALUES ('2020-01-01 10:30', 'Bike'),
    ('2020-01-01 11:30', 'Bike'),
    ('2020-01-02 13:00', 'Trike'),
    ('2020-01-03 13:10', 'Bell'),
    ('2020-01-03 17:35', 'Seat'),
    ('2020-01-04 00:00', 'Bike')
