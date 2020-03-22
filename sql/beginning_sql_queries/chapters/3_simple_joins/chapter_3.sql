
-- process approach - 'how'

SELECT * from Members m JOIN MembershipTypes t ON m.membership_type = t.type;

-- outcome approach - 'what'

SELECT * FROM Members m, MembershipTypes t WHERE  m.membership_type = t.type;


-- Find the names of everyone who entered the Leeston tournament in 2014:

-- Process approach - 'how'

SELECT firstname, lastname
FROM (Members m JOIN Entries e ON m.id = e.member_id)
JOIN Tournaments t ON e.tour_id = t.id
WHERE t.name = 'Leeston' AND e.year = '2014';

-- Outcome approach - 'what'

SELECT m.firstname, m.lastname
FROM Members m, Entries e, Tournaments t
WHERE m.id = e.member_id
     AND e.tour_id = t.id
     AND t.name = 'Leeston'AND e.year = '2014';

-- Join types

SELECT * FROM Members m LEFT JOIN Entries e ON m.id = e.member_id;

SELECT * FROM Members m LEFT OUTER JOIN Entries e ON m.id = e.member_id;

SELECT * FROM Members m RIGHT JOIN Entries e ON m.id = e.member_id;

SELECT * FROM Members m RIGHT OUTER JOIN Entries e ON m.id = e.member_id;

SELECT * FROM Members m FULL JOIN Entries e ON m.id = e.member_id;

SELECT * FROM Members m FULL OUTER JOIN Entries e ON m.id = e.member_id;