-- Comparison operators

SELECT * FROM Members WHERE gender = 'F';

SELECT * FROM Members WHERE gender <> 'M';
SELECT * FROM Members WHERE gender != 'M';

SELECT * FROM Members WHERE handicap > 5;

SELECT * FROM Members WHERE join_date <= '2020-01-01';

-- Logical operators

SELECT * FROM Members WHERE gender = 'F' AND handicap <> 4;

SELECT * FROM Members WHERE gender = 'M' OR handicap != 4;

SELECT * FROM Members WHERE NOT handicap = 5;

-- Comparison predicates

SELECT * FROM Members WHERE handicap BETWEEN 4 and 6;

SELECT * FROM Members WHERE handicap NOT BETWEEN 1 AND 3;

SELECT * FROM Members WHERE gender IS NULL;

SELECT * FROM Members WHERE gender IS NOT  NULL;

-- not equal, treating null like an ordinary value
SELECT * FROM Members WHERE handicap IS DISTINCT FROM 6;

-- equal, treating null like an ordinary value
SELECT * FROM Members WHERE handicap IS NOT DISTINCT FROM 6;

select count(DISTINCT firstname) from members;
