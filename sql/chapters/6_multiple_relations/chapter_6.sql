SELECT m.firstname, m.lastname, t.name, t.practice_night, t.manager_id
FROM Members m INNER JOIN Teams t ON m.team_id = t.id;

SELECT t.name, t.practice_night, m.firstname AS manager_first_name, m.lastname AS manager_last_name
FROM Teams t INNER JOIN Members m ON t.manager_id = m.id;

-- Show members that manage a team they are in:

SELECT t.name, t.practice_night, m.firstname, m.lastname
FROM Teams t INNER JOIN Members m ON t.id = m.team_id AND t.manager_id = m.id;

-- Find information about people that manage a team

SELECT t.name, t.practice_night, m2.firstname, m2.lastname
FROM (Members m1 INNER JOIN Teams t ON t.id = m1.team_id)
    INNER JOIN Members m2 ON t.manager_id = m2.id;

SELECT t.name, t.practice_night, m2.firstname, m2.lastname
FROM Members m1, Members m2, Teams t
WHERE m1.team_id = t.id AND t.manager_id = m2.id;

-- Finding teams whose managers are not members of any team

SELECT t.name, t.id AS team_id, t.manager_id AS manager_id, m.firstname, m.lastname, m.team_id
FROM Teams t, Members m
WHERE t.manager_id = m.id AND m.team_id <> t.id;

SELECT t.name, t.id AS team_id, t.manager_id AS manager_id, m.firstname, m.lastname, m.team_id
FROM Teams t INNER JOIN Members m ON t.manager_id = m.id
WHERE m.team_id <> t.id OR m.team_id IS NULL;