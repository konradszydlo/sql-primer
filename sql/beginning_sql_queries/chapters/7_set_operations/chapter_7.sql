/* UNION */

SELECT * FROM Members m1
UNION
SELECT * FROM Members m2;

SELECT lastname, firstname FROM Members
UNION ALL
SELECT  lastname, firstname from Members;

SELECT member_id FROM Entries WHERE tour_id = 5
UNION
SELECT member_id FROM Entries WHERE tour_id = 4;

-- UNION is like FULL OUTER JOIN
SELECT * FROM Members LEFT JOIN MembershipTypes ON membership_type = type
UNION
SELECT * FROM Members RIGHT JOIN MembershipTypes ON membership_type = type;

/* INTERSECT */

-- Which members entered 'both' tournaments?

SELECT member_id FROM Entries WHERE tour_id = 4
INTERSECT
SELECT member_id FROM Entries WHERE tour_id = 5;

-- INTERSECTION is a process approach

-- Outcome approach

SELECT DISTINCT e1.member_id
FROM Entries e1, Entries e2
WHERE e1.member_id = e2.member_id
  AND e1.tour_id = 4 AND e2.tour_id = 5;


SELECT lastname, firstname
FROM Members m JOIN
    (SELECT e1.member_id FROM Entries e1 WHERE tour_id = 4
    INTERSECT
    SELECT e2.member_id FROM Entries e2 WHERE tour_id = 5) Members_table
ON m.id = Members_table.member_id;

SELECT lastname, firstname
FROM Members
WHERE id IN
      (SELECT e1.member_id FROM Entries e1 WHERE tour_id = 4
       INTERSECT
       SELECT e2.member_id FROM Entries e2 WHERE tour_id = 5);

-- members that entered both tournaments in the same year

SELECT member_id, year FROM Entries WHERE tour_id = 4
INTERSECT
SELECT member_id, year FROM Entries WHERE tour_id = 5;

SELECT e1.member_id, e1.year FROM Entries e1
WHERE e1.tour_id = 4 AND EXISTS
    (SELECT e2.member_id, e2.year
    FROM Entries e2
    WHERE e2.tour_id = 5 AND e1.member_id = e2.member_id AND e1.year = e2.year);

/* EXCEPT */

-- Find members who have not entered tournament 5.

SELECT id FROM Members
EXCEPT
SELECT member_id FROM Entries WHERE tour_id = 5;

SELECT m1.id FROM Members m1
WHERE NOT EXISTS
    (SELECT m2.id FROM Members m2 JOIN Entries e ON e.member_id = m2.id
    WHERE m2.id = m1.id AND e.tour_id = 5);

SELECT id, lastname, firstname FROM Members
EXCEPT
SELECT m.id, m.lastname, m.firstname
FROM Members m JOIN Entries e ON m.id = e.member_id
WHERE e.tour_id = 5;

/* DIVISION */

-- Division is not supported yet in SQL.

-- Find members that entered all tournaments
/*

Write out the value of m.lastname, m.firstname from rows m in the Members table
where for every row t in the Tournaments table there exists a row e in the Entries table
with e.member_id = m.id and e.tour_id = t.id

We have an SQL keyword for exists but not for every. We can get rid of the every word in the preceding statement
by using the following slightly mind-bending logic. The phrase:

    for every row t in the Tournaments table there exists a row e in the Entries table…

is equivalent to saying:

    there is no row t in the Tournaments table where there does not exist a row e in the Entries table…
*/

SELECT m.lastname, m.firstname, m.id FROM Members m
WHERE NOT EXISTS
    (SELECT * FROM Tournaments t
    WHERE NOT EXISTS
        (SELECT * FROM Entries e
        WHERE e.member_id = m.id AND e.tour_id = t.id));

-- Find members that entered all open tournaments

SELECT m.lastname, m.firstname, m.id FROM Members m
WHERE NOT EXISTS
    (SELECT * FROM Tournaments t
     WHERE t.type = 'Open'
       AND NOT EXISTS
         (SELECT * FROM Entries e
          WHERE e.member_id = m.id AND e.tour_id = t.id));

-- Find members that entered all tournaments in a given year

SELECT DISTINCT m.lastname, m.firstname, e1.year FROM Members m
JOIN Entries e1 on e1.member_id = m.id
WHERE NOT EXISTS
    (SELECT * FROM Tournaments t
     WHERE
       NOT EXISTS
         (SELECT * FROM Entries e
          WHERE e.member_id = m.id AND e.tour_id = t.id
            AND e.year = e1.year));

-- Has anyone coached all the social members?

SELECT firstname, lastname, coach, membership_type FROM Members WHERE membership_type = 'Social';

SELECT m.lastname, m.firstname, m.membership_type FROM members m
WHERE NOT EXISTS
    (SELECT * FROM Members social_members
    WHERE social_members.membership_type = 'Social'
    AND NOT EXISTS
    (SELECT * FROM members m3
        WHERE social_members.coach = m.id));