SELECT e.member_id
FROM Entries e
WHERE e.tour_id IN (1,4);

/* Find people playing 'Open' tournaments */

-- Outcome approach - 'what'

SELECT e.member_id
FROM Entries e
WHERE e.tour_id IN (
    SELECT t.id
    FROM Tournaments t
    WHERE t.type = 'Open');

-- Process approach - 'how'

SELECT e.member_id
FROM Entries e JOIN Tournaments t ON e.tour_id = t.id
WHERE t.type = 'Open';

/* Finding people NOT playing EVER in 'Open' tournament is more tricky */

-- What are the names of all members who have ever entered any tournament?

SELECT m.firstname, m.lastname
FROM Members m
WHERE EXISTS (SELECT * FROM Entries e WHERE e.member_id = m.id);

SELECT m.firstname, m.lastname
FROM Members m
WHERE m.id IN (SELECT e.member_id FROM Entries e WHERE e.member_id = m.id);

/* Queries with EXISTS are often equivalent of JOIN queries */

SELECT m.firstname, m.lastname
FROM Members m JOIN Entries e ON m.id = e.member_id;

-- What are the names of all members who have NEVER entered any tournament?

SELECT m.firstname, m.lastname
FROM Members m
WHERE NOT EXISTS (SELECT * FROM Entries e WHERE e.member_id = m.id);

/* Find people NOT playing 'Open' tournaments */

-- Outcome approach - 'what'

SELECT m.firstname, m.lastname
FROM Members m
WHERE NOT EXISTS (SELECT * FROM Entries e, Tournaments t
    WHERE m.id = e.member_id
    AND e.tour_id = t.id AND t.type = 'Open')
ORDER BY m.lastname;

-- Process approach - 'how'
-- Use Except set operator from chapter 7:

SELECT firstname, lastname FROM Members
EXCEPT
SELECT m.firstname, m.lastname
  FROM (Members m JOIN Entries e ON m.id = e.member_id)
  JOIN Tournaments t ON e.tour_id = t.id
  WHERE  t.type = 'Open'
ORDER BY lastname;

/* Different types of subqueries */

-- **** Inner Queries Returning a Single Value **** --

-- Find players having handicap smaller than Barbara's

SELECT * FROM Members m
WHERE m.handicap <
      (SELECT handicap FROM Members WHERE lastname = 'Olsen' AND firstname = 'Barbara');

-- Find players having handicap smaller than average

SELECT * FROM Members m
WHERE m.handicap <
      (SELECT avg(handicap) FROM Members);

-- Find any junior members that have a lower handicap than the average for seniors:

SELECT *
FROM Members m
WHERE m.membership_type = 'Junior' AND m.handicap < (
    SELECT avg(handicap)
    FROM Members
    WHERE membership_type = 'Senior');

-- **** Inner Queries Returning a Set of Values **** --

-- Find tournament entries for senior members

-- Process approach - 'what'

SELECT *
FROM Entries e
WHERE e.member_id IN (
    SELECT m.id
    FROM Members m
    WHERE m.membership_type = 'Senior');

-- Outcome approach - 'how'

SELECT *
FROM Entries e JOIN Members m ON m.id = e.member_id
WHERE m.membership_type = 'Senior';

-- **** Inner Queries Checking for Existence **** --

SELECT m.firstname, m.lastname
FROM Members m
WHERE EXISTS (SELECT * FROM Entries e WHERE e.member_id = m.id);

/* Queries with EXISTS are often equivalent of JOIN queries */

SELECT m.firstname, m.lastname
FROM Members m JOIN Entries e ON m.id = e.member_id;

/*
 The difference between the two queries is the number of rows that are returned.

 The first query inspects each row in the Members table just once and returns the last name
 if there exists at least one entry for that member in the Entries table.
 The last name for any member will be written out only once.

 The second query forms a join between the two tables that will consist of every combination of rows
 in Members and Entries with the same member_id.
 The name for a particular member will be written out as many times as the number of tournaments he or she entered.

 It’s a subtle difference, but an important one — especially if you are wanting to count the returned rows.

 Adding DISTINCT in the SELECT clause of the second example will make the results of the two queries the same.
 */

-- Using Subqueries for Updating


INSERT INTO Entries (member_id, tour_id, Year)
    -- create an entry in tournament 25, 2016 for each Junior
    SELECT id, 25, 2016
    FROM Members
    WHERE membership_type = 'Junior';


DELETE FROM Entries
WHERE tour_id = 25 AND Year = 2016 AND
        member_id IN
        (SELECT id FROM Members WHERE handicap < 20);


/* More examples */

-- **** A subquery returning a single value **** --

-- Find the tournaments that member Cooper has entered:

SELECT e.tour_id, e.year FROM Entries e WHERE e.member_id =
                                           (SELECT m.id FROM Members m
                                            WHERE m.lastname = 'Cooper');

-- An alternative way to write the preceding query is to use a join:

SELECT e.tour_id, e.year
FROM Entries e INNER JOIN Members m ON e.member_id = m.id
WHERE m.lastname = 'Cooper';

-- **** A subquery returning a set of single values **** --

-- Find all the entries for an Open tournament:

SELECT *
FROM Entries e
WHERE e.tour_id IN
      (SELECT t.id FROM Tournaments t
       WHERE t.type = 'Open');

-- The preceding query can be replaced with:

SELECT e.member_id, e.tour_id, e.year
FROM Entries e INNER JOIN Tournaments t ON e.tour_id = t.id
WHERE t.type = 'Open';

-- **** A subquery checking for existence **** --

-- Find the names of members that have entered any tournament:

SELECT m.lastname, m.firstname
FROM Members m
WHERE EXISTS
          (SELECT * FROM Entries e
           WHERE e.member_id = m.id);

-- This can be replaced with:

SELECT DISTINCT m.lastname, m.firstname
FROM Members m INNER JOIN Entries e ON e.member_id = m.id;

-- **** Examples of Different Uses for Subqueries **** --

-- Subqueries can be used in many situations, including the following:

-- Constructing queries with negatives
-- Find the names of members who have not entered a tournament:

SELECT * FROM Members m
WHERE NOT EXISTS
     (SELECT * FROM Entries e
     WHERE e.member_id = m.id);

-- Comparing values with the results of aggregates
-- Find the names of members with handicaps less than the average:

SELECT m.lastname, m.firstname FROM Members m WHERE m.Handicap <
     (SELECT AVG(Handicap) FROM Members);

-- Update data
-- Add a row in the Entries table for every junior for tournament 25 in 2016:

INSERT INTO Entries (member_id, tour_id, Year)
SELECT id, 5, '2020'
FROM Members WHERE membership_type = 'Junior';


-- find the names of the women who have never played in the Leeston tournament

SELECT m2.lastname, m2.firstname FROM
    (SELECT m.id FROM Members m
     WHERE gender = 'F'
         EXCEPT
     SELECT e.member_id
     FROM Entries e INNER JOIN Tournaments t on e.tour_id = t.id
     WHERE t.name = 'Leeston') AS leston_ladies
        INNER JOIN Members m2 ON m2.id = leston_ladies.id;

SELECT m.lastname, m.firstname
FROM Members m
WHERE gender = 'F'
  AND NOT EXISTS (
        SELECT *
        FROM Entries e
        WHERE m.id = e.member_id
          AND EXISTS
            (SELECT * FROM Tournaments t
             WHERE t.id = e.tour_id
               AND t.name = 'Leeston'));