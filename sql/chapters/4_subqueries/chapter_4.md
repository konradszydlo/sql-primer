# Beware of NOT <>

We need to be careful when we want to tackle question with NOT.

We can ask for two different things:

a) people who have not entered an 'Open' tournament

b) people who entered a tournament that is not 'Open'

In b) are people who have entered something other than an Open tournament
(but not excluding those who may have entered an Open tournament as well).

To decide whether someone has entered an Open competition, we need to find just one matching entry.
To decide whether someone has not entered an Open competition,
we need to check all the Open entries to make sure that member does not appear.

TODO in chapter 7 we can use set operations and process approach to find such people
or use EXISTS keyword.

# Different types of subqueries

The inner part of the nested query can return
a) a single value (e.g, Barbara’s handicap),
b) a set of values (e.g., the IDs of Open tournaments),
c) or a set of rows (e.g., entries in Open tournaments).

Also, the inner and outer queries can be independent to some extent, or they can be correlated.

Ad) c:
Another type of inner query is the one we saw working with the EXISTS keyword.
A statement using EXISTS just looks to see whether any rows at all are returned by the inner query.
The actual values or numbers of rows returned are not important.