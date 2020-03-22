

## Process Approach

One way to approach a query is to think in terms of the operations we need to carry out on the tables.
Let’s think about how we might to get a list of names for members who practice on a Monday.
We might imagine first retrieving just the rows from the `Teams` table that have Monday in the PracticeNight column.
We might then join those rows with the `Members` table (more about joins later) and then extract the names from the result.
We will call this the process approach, as it is a series of steps carried out in a particular order.

##  Outcome Approach

An alternative way to think about the query in the previous section is to examine all the rows in the `Members` table
and just return those that satisfy the criteria that the member is on a team that has Monday as a practice night.
The row `m` that we are considering in the `Members` table satisfies the condition about the team’s practice night,
so we should retrieve the names from that row.

## Outcome vs Process

The outcome approach describes what we want, the process approach describes how we want.

Older versions of SQL were purely based on relational calculus in that you described what you wanted to retrieve
rather than how. Modern implementations of SQL allow you to explicitly specify algebraic operations such as
joins, unions, and intersections on the tables as well.