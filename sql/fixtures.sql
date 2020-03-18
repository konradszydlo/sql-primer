INSERT INTO cities (name, postcode) VALUES ('Krosno', '30-400'),('Jasło', '38-200'),('Gorlice', '38-300');

INSERT INTO MembershipTypes (type, fee) VALUES ('Associate', 60), ('Junior', 150), ('Senior', 300), ('Social', 50);

INSERT INTO TournamentTypes (type) VALUES ('Social'), ('Open');

INSERT INTO Tournaments (id,name, type) VALUES (1,'Leeston', 'Social'), (2,'Kaipoi', 'Social'),
   (3,'West Coast', 'Open'), (4,'Centerbury', 'Open'), (5,'Otago', 'Open');

INSERT INTO Teams (id, name, practice_night) VALUES (1, 'A', 'Monday'), (2,'B', 'Tuesday'),(3,'C', 'Wednesday');

-- Chapter 3
INSERT INTO Members (id, firstname, lastname, phone, handicap, join_date, gender, team_id, membership_type, coach)
 VALUES
(1,'Melissa','McKenzie', '', 30, '2019-08-04', 'F', 1, 'Junior',NULL),
(2,'Michael','Stone','',30,'2009-05-30','M',3,'Senior',NULL),
(3,'Brenda','Nolan','',11,'2006-08-12','F',2,'Senior',NULL),
(4,'Helen','Branch','',NULL,'2011-11-06','F',3,'Social',2),
(5,'Sarah','Beck','',NULL,'2010-01-24','F',3,'Social',3),
(6,'Sandra','Burton','',26,'2008-07-09','F',3,'Junior',2),
(7,'William','Cooper','',14,'2008-03-05','M',2,'Senior',3),
(8,'Thomas','Spence','',10,'2006-06-22','M',3,'Senior',NULL),
(9,'Barbara','Olson','',16,'2013-07-29','F',3,'Senior',NULL),
(10,'Robert','Pollard','',19,'2013-08-13','M',2,'Junior',3),
(11,'Thomas','Sexton','',26,'2008-07-28','M',3,'Senior',2),
(12,'Daniel','Wilcox','',3,'2009-05-18','M',1,'Senior',8),
(13,'Robert','Reed','',3,'2005-11-05','M',1,'Senior',8),
(14,'William','Taylor','',7,'2007-11-27','M',1,'Senior',NULL),
(15,'Jane','Gilmore','',5,'2007-05-30','F',1,'Junior',7),
(16,'Thomas','Schmidt','',25,'2009-05-18','M',2,'Senior',2),
(17,'Deborah','Bridges','',12,'2007-03-27','F',NULL,'Senior',NULL),
(18,'Betty','Young','',21,'2009-04-17','F',2,'Senior',NULL),
(19,'Carolyn','Wills','',29,'2011-01-14','F',2,'Junior',7),
(20,'Susan','Kent','',NULL,'2010-10-07','F',1,'Social',7);

INSERT INTO Entries (member_id, tour_id, year) VALUES (1,1,'2014'),(6,1,'2015'),(6,2,'2015'),(6,3,'2015'),
(7,4,'2015'),(7,5,'2014'),(7,5,'2015'),(8,2,'2014'),(8,5,'2013'),(8,4,'2016'),(9,1,'2014'),(9,4,'2014'),(14,1,'2015'),
(14,2,'2013'),(14,3,'2014'),(14,3,'2015'),(14,4,'2013'),(14,4,'2015'),(14,5,'2013'),(14,5,'2014'),(14,5,'2015');

UPDATE Teams set manager_id = 3 WHERE id = 1;
UPDATE Teams set manager_id = 8 WHERE id = 2;
UPDATE Teams set manager_id = 9 WHERE id = 3;