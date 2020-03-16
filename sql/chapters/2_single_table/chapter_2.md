selecting a subset of rows

projecting a subset of columns

# Common mistakes

## 'Both'

`SELECT e.member_id
FROM Entry e
WHERE e.tour_id = 36 AND e.tour_id= 38`

This will not find a person that entered both tournament `36` and `38` as this query searches single row a time.

The problem requires looking at two rows at on time. See Chapter 5 for more details.

An Outcome Approach to Questions Involving “Both”

`SELECT e1.member_id
FROM Entries e1, Entries e2
WHERE e1.member_id = e2.member_id AND e1.tour_id = 5 AND e2.tour_id = 1;`

A Process Approach to Questions Involving “Both”

`SELECT e1.member_id
FROM Entries e1 INNER JOIN Entries e2 ON e1.member_id = e2.member_id
WHERE e1.tour_id = 5 AND e2.tour_id = 1;`

## 'Not'

Now let’s consider another common error. It is easy to find the people who have entered tournament 38 
with the condition `e.tour_id = 38`. It is tempting to try to retrieve the people who have not entered tournament `38`
by changing the condition slightly. Can you figure out what rows the following SQL query will retrieve?

`SELECT e.member_id
FROM Entry e
WHERE e.tour_id <> 38`

We might have a member that have a row where `tour_id = 38`. This query will list return the member regardless of further
rows where `tour_id` could be `38` indeed.
   
The query returns all the people who have entered some tournament that isn’t tournament `38`.

This is another type of question that can’t be answered with a simple WHERE clause that looks at independent rows in a table.
In fact, we can’t even answer this question with a query that involves only the Entry table. 
If a member doesn't even get a mention in the Entry table because he has never entered any tournaments at all.

We’ll see how to deal with questions like this in Chapter 7