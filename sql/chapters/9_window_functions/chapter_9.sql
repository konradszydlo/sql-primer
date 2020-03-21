SELECT id, lastname, firstname, handicap,
   count(handicap) OVER() AS count,
   avg(handicap) OVER() AS average_handicap
FROM Members;

SELECT lastname, firstname, handicap,
       avg(handicap) OVER() AS average,
       handicap - avg(handicap) OVER() AS difference
FROM Members;

SELECT member_id, tour_id, year,
   count(*) OVER () AS count_all,
   count(*) OVER (PARTITION BY tour_id) AS count_tour,
   count(*) OVER (PARTITION BY tour_id, year) AS count_tour_year
FROM Entries;

SELECT member_id, tour_id, year,
       count(*) OVER (ORDER BY year) AS cumulative
FROM Entries;

SELECT id, handicap,
    sum(handicap) OVER (ORDER BY handicap) AS total_handicap
FROM Members;

SELECT id, handicap,
       rank() OVER (ORDER BY handicap) AS rank
FROM Members
WHERE handicap IS NOT NULL;

SELECT month, area, income,
       sum(income) OVER () AS total
FROM Incomes;

SELECT month, area, income,
       sum(income) OVER (ORDER BY month)
FROM Incomes;

SELECT month, area, income,
       sum(income) OVER (ORDER BY area)
FROM Incomes;

SELECT month, area, income,
       sum(income) OVER (
           PARTITION BY area
           ORDER BY month) AS area_running_total
FROM Incomes;

-- same as above but with ROWS written explicitly
SELECT month, area, income,
       sum(income) OVER (
           PARTITION BY area
           ORDER BY month
           ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW ) AS area_running_total
FROM Incomes;

-- Running three months average
SELECT month, area, income,
       avg(income) OVER (PARTITION BY area
           ORDER BY month
           ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW -- default if not explicitly written.
           ) AS area_running_average,
       avg(income) OVER (PARTITION BY area
           ORDER BY month
           ROWS BETWEEN 1 PRECEDING AND 1 FOLLOWING) AS area_3_months_running_average
FROM Incomes;