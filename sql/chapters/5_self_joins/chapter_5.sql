
SELECT *
FROM Members m JOIN Members c ON m.coach = c.id;

-- What Are the Names of the Coaches?

SELECT DISTINCT c.firstname, c.lastname
FROM Members m JOIN Members c ON m.coach = c.id;

-- Who Is Being Coached by Someone with a Higher Handicap?

SELECT *
FROM Members m JOIN Members c ON m.coach = c.id
WHERE m.handicap < c.handicap;

-- List the Names of All Members and the Names of Their Coaches

SELECT m.lastname AS Member_Last, m.firstname AS Member_First, c.lastname AS Coach_Last, c.firstname AS Coach_First
FROM Members m LEFT JOIN Members c ON m.coach = c.id;

-- Who Coaches the Coaches?

SELECT m.lastname, m.firstname, m.coach, c.lastname, c.firstname, c.coach, cc.lastname, cc.firstname
FROM (Members m LEFT JOIN Members c ON m.coach = c.id)
     LEFT JOIN Members cc ON c.coach = cc.id;

/* Outcome - 'how' approach to self-joins */

SELECT c.firstname, c.lastname
FROM Members m, Members c
WHERE c.id = m.coach AND m.firstname = 'Sarah';

-- Who Is Being Coached by Someone with a Higher Handicap?

SELECT m.firstname, m.lastname, m.handicap, c.handicap
FROM Members m, Members c
WHERE c.id = m.coach AND m.handicap < c.handicap;

-- An Outcome Approach to Questions Involving “Both”

SELECT e1.member_id
FROM Entries e1, Entries e2
WHERE e1.member_id = e2.member_id AND e1.tour_id = 5 AND e2.tour_id = 1;

-- A Process Approach to Questions Involving “Both”

SELECT e1.member_id
FROM Entries e1 INNER JOIN Entries e2 ON e1.member_id = e2.member_id
WHERE e1.tour_id = 5 AND e2.tour_id = 1;
