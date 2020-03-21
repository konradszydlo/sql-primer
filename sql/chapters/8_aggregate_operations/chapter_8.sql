SELECT count(*) FROM Members;

SELECT count(*) AS women_count FROM Members WHERE gender = 'F';

SELECT count(*) FROM Members WHERE gender <> 'F';

SELECT count(*) FROM Members WHERE gender IS NULL;

SELECT count(*) FROM Members WHERE coach IS NOT NULL;

-- How many people have a coach?
SELECT count(coach) FROM Members;

-- How many coaches are there?

SELECT count(DISTINCT coach) FROM Members;

SELECT count(coaches)
FROM (SELECT DISTINCT coach FROM Members WHERE coach IS NOT NULL) coaches;

-- How many tournament entries did members made in 2015?
SELECT count(tour_id)
FROM Entries WHERE year = '2015';

-- How many different tournaments were entered in 2015?
SELECT count(DISTINCT tour_id)
FROM Entries
WHERE year = '2015';

-- Find average handicap
SELECT avg(handicap) FROM Members;

-- Find members that don't have handicap
SELECT * FROM Members WHERE handicap IS NULL;

-- Find average including members without handicap. Implicitly treat them as handicap 0.
SELECT sum(handicap)/count(*) FROM Members;

SELECT round(avg(handicap), 2) FROM Members;

SELECT max(handicap), min(handicap) FROM Members;

SELECT member_id, count(*) AS entries_no
FROM Entries
GROUP BY member_id
ORDER BY count(*);

SELECT lastname, firstname, member_id, count(member_id) AS entries_no
FROM Entries e JOIN Members m on e.member_id = m.id
GROUP BY member_id, firstname, lastname;

-- Find number of entries for each tournament
SELECT tour_id, count(*)
FROM Entries e GROUP BY tour_id;

SELECT tour_id, year, count(*)
FROM Entries e GROUP BY tour_id, year;

SELECT tour_id, count(*)
FROM Entries
WHERE year = '2014'
GROUP BY tour_id;

-- statistics for genders
SELECT gender, min(handicap), round(avg(handicap), 1), max(handicap)
FROM Members
GROUP BY gender;

-- Which tournaments had two or more entries
SELECT tour_id, year, count(*)
FROM Entries
GROUP BY tour_id, year
HAVING count(*) >= 2;

-- Find members that entered three or more tournaments
SELECT member_id, count(*)
FROM Entries
GROUP BY member_id
HAVING count(*) >= 3;

-- Find members that entered more then three Open tournaments ever.
SELECT member_id, count(*)
FROM Entries e JOIN Tournaments t ON e.tour_id = t.id
WHERE t.type = 'Open'
GROUP BY member_id
HAVING count(*) >= 3;

-- Find members that entered EVERY tournament. This requires using division operation

-- Find number of unique/distinct tournaments.
SELECT count(DISTINCT id) FROM Tournaments;

SELECT member_id
FROM Entries
GROUP BY member_id
HAVING count(DISTINCT tour_id) = (SELECT count(DISTINCT id) FROM Tournaments);

-- Find members with handicap greater than the average
SELECT * FROM Members
WHERE handicap < (SELECT avg(handicap) FROM Members);

-- Which members have entered at least three tournaments.
SELECT * FROM Members m
WHERE (SELECT count(*) FROM Entries e WHERE e.member_id = m.id) >= 3;

-- Find the average number of tournaments entered by members
SELECT avg(member_entries.entries)
FROM (SELECT count(*) AS entries FROM Entries GROUP BY member_id) AS member_entries;

-- Find members that entered more than the average number of tournaments
SELECT * FROM Members m
WHERE
      (SELECT count(*) FROM Entries e WHERE member_id = m.id)
      >
      (SELECT avg(member_entries.entries)
       FROM (SELECT count(*) AS entries FROM Entries GROUP BY member_id) AS member_entries);