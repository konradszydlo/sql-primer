# Preliminaries


## What tables are involved?

Find all the men who have entered a Leeston tournament.

Nouns are often a clue to what tables or fields we are going to need. Verbs often help us find relationships.

Nouns:

Leeston tournament - `Tournaments` table

men - `Members` table with gender field

Verbs:

entered - `Entries` table connects members and tournaments.

## Look at Some Data Values

Do some simple queries on target tables to get a feel what data are held in each table.

This might tell us how `men` are marked in the `Members` table.

It is often a good idea to ask why this information is required. Do we just want to find which men have ever been
to Leeston (because we want to ask one of them some questions about the golf course), or do we want to know
how many times our male club members have entered Leeston tournaments (because we are interested in how popular
the tournament is with the members of the club)?

# Methods

## The Big Picture Method

Combine all the tables you’ll need and retain all the columns, so you can see what is happening.

### Combine the tables

Start with joining the tables. Using joins is a good start. Experiment with simple queries first.

```sql
SELECT * FROM Tournaments t JOIN Entries e ON t.id = e.tour_id;
```

When you run this query you can see that `member_id` field is returned. Next question is how to get more information
about members using `member_id`.

```sql
SELECT * FROM
    (Tournaments t JOIN Entries e ON t.id = e.tour_id)
    JOIN
    Members m ON m.id = e.member_id;
```

### Find the Subset of Rows

After running the above query we can see that the rows that we want to retain from the result of the join are where
the `gender` field has the value `M` and the `Tournaments.name` field has the value `Leeston`.
We can select these rows by adding an appropriate `WHERE` clause to the previous query:

```sql
SELECT * FROM
    (Tournaments t JOIN Entries e ON t.id = e.tour_id)
    JOIN
    Members m ON m.id = e.member_id
WHERE m.gender = 'M' AND t.name = 'Leeston';
```

This query will return us duplicated members if they entered the Leeston tournament in different years.
It's important to understand if we want to remove duplicates or we want to retain them and know how many times
some members entered this tournament.

### Retain the Appropriate Columns

Retain just the columns we require by amending the `SELECT` clause.

```sql

SELECT DISTINCT m.id, m.lastname, m.firstname
FROM (Tournaments t JOIN Entries e ON t.id = e.tour_id)
    JOIN
    Members m ON m.id = e.member_id
WHERE m.gender = 'M' AND t.name = 'Leeston';
```

# Spotting Keywords in Questions

Some keywords often appear in questions and they can provide a clue about which relational operations are needed.

## And, Both, Also

`And` and `also` are words that can be misleading when it comes to interpreting queries.

Queries that require two conditions to be met fall into two categories:
* those that can be carried out with a simple `WHERE` clause containing a Boolean `AND` operator
* those that require an intersection or self `join`

To decide if a query really needs two conditions to be met, look at a natural language statement
and see if you can reword it with the word both connecting the conditions. Consider these examples:

* Find the junior boys. (Both a male and a junior? Yes.)
* Find those members who entered tournaments 24 and 38. (Both tournaments? Yes.)
* Find the women and children. (Both a female and a child? No.)

The last query looks rather some anyone who is `either` female `or` child.

When two conditions must be met, we are looking at the intersection of two groups of data.

### Single row check?

Do I need to look at more than one row to decide if both conditions are satisfied?

Q: Can we look at a single row and determine if the member is both a junior and a boy?

```sql
SELECT * FROM Members m
WHERE m.gender = 'M' AND m.membership_type = 'Junior';
```

### Multiple rows check?

Where we need to satisfy both of two conditions and we need to look at more than one row in the table,
we can either use a self join (discussed in Chapter 5) or an intersection (discussed in Chapter 7).

Q: Find the members who have entered both tournaments 24 and 36?

```sql
SELECT DISTINCT e1.member_id
FROM Entries e1 JOIN Entries e2 ON e1.member_id = e2.member_id
WHERE e1.tour_id = 24 AND e2.tour_id = 36;
```

A query producing the same output but using the INTERSECT keyword is:
```sql
SELECT member_id FROM Entries WHERE tour_id = 24
INTERSECT
SELECT member_id FROM Entries WHERE tour_id = 36;
```

## Not, Never

* Find the members who are not seniors.
* Find members who are not in a team.
* Find members who have never entered a tournament.

Often when people see not in a description of a query, they immediately think of using a Boolean NOT or a <> operator
in a WHERE clause. This is fine for some queries, but will fail for others.

### Single row check?

Do I need to look at more than one row to decide if a condition is not true?

For the first two queries in the preceding bulleted list, we can look at a single row
in the `Members` table and decide whether that member satisfies the condition.

```sql
SELECT * FROM Members
WHERE membership_type <> 'Senior';
-- WHERE NOT membership_type = 'Senior' -- Alternative way to write NOT
```

To find members who are not in a team, we want the Team field to be empty.

```sql
SELECT * FROM Members WHERE team_id IS NULL;
```

To find the members who have never entered a tournament, what tables do we need?
We are certainly going to need the `Entres` table. We can decide if a member has entered a tournament
by finding just one row with his or her value of `member_id`. To see if he or she has not entered a tournament,
we need to look at every row in the `Entries` table. We also must look at the `Members` table,
because those members who have not entered a tournament will not appear in the `Entries` table at all.

```sql
SELECT id FROM Members
EXCEPT
SELECT member_id FROM Entries;
```

```sql
SELECT m.id FROM Members m
WHERE m.id NOT IN (SELECT e.member_id FROM Entries e);
```

## All, Every

Wherever you see the words all or every in a description of a query you should immediately think of the division operator.

* Find members who have entered every open tournament.
* Has anyone coached all the juniors?

See chapter 7 for examples.

```sql
SELECT m.lastname, m.firstname, m.id FROM Members m
WHERE NOT EXISTS
    (SELECT * FROM Tournaments t
     WHERE t.type = 'Open'
       AND NOT EXISTS
         (SELECT * FROM Entries e
          WHERE e.member_id = m.id AND e.tour_id = t.id));
```

# No idea where to start?

Open the tables you think will be needed to answer the question and look at some of the data.
Try to find examples that should be retrieved by the query.
Then try to write down the conditions that make that particular data acceptable.

## Q: Which teams have a coach as their manager?

### Find some helpful tables

We have the nouns “team,” “coach,” and “manager.” We have a table called Teams. `coach` is a filed in `Members` table.

`manager_id` is a field in Teams table.

### Try to Answer the Question by Hand

Take a look at the data in the tables and see how you would decide if a team had a coach as a manager.

We can find the IDs of the team managers easily enough. They are the values in the `manager_id` column of the Teams table.
Now, how do we check if these members are coaches? Looking at the `Members` table, we see that the coaches are
in the `coach` column. We need to check if either of our managers appears in the `coach` column.

I’ll write out the TeamName from row t in the Teams table, if there exists a row m in the Members table
where the value of coach m.coach is the same as the manager of the team t.manager_id.

```sql
SELECT * from Teams t
WHERE EXISTS
(SELECT * FROM Members m WHERE m.coach = t.manager_id);
```

### Are There Alternatives?

First attempts at queries aren’t necessarily the most elegant.
An inelegant SQL statement might be difficult for you and others to understand at a later time.

Having made a first attempt at the query described in the previous section,
we might realize that we could have thought of it this way:

“The manager just has to be in the set of coaches.”

```sql
SELECT t.name FROM Teams t
WHERE t.manager_id IN
(SELECT m.coach FROM Members m);

SELECT t.name FROM Teams t, Members m
WHERE t.manager_id = m.coach;

SELECT t.name
FROM Teams t INNER JOIN Members m ON t.manager_id = m.coach;
```

# Checking Queries

Attempts at a query may not be elegant, neither may they be correct.

Check that you do not have extra, incorrect rows in your result and check that you aren’t missing any rows.

## Check a Row That Should Be Returned

It is a good idea to have a rough idea of how many rows should be returned by your query: none, one, a few, or lots.

## Check a Row That Should Not Be Returned

It is a good idea to use some dummy data to check this if the real data does not cover all eventualities.

## Check Boundary Conditions

Q: Find people who have been members of our club for more than ten years.

* someone who is a member for less than ten years (e.g. 8 years)
* someone who is a member to more than ten years (e.g. 12 years)
* someone who is a member for exactly ten years

Q: Does “more than ten years” include people who joined in the season exactly ten years ago?

Most probably yes but check with business if that's what they want.

## Check Null Values

Null values can be tricky in queries (see chapter 2).

Trying to find members what did not enter some tournaments could miss members that have never entered any tournaments.