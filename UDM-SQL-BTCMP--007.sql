/* 56. Setting up New Database for Assessment Exercises */
/* Explore the tables */
SELECT *
FROM cd.bookings;

SELECT *
FROM cd.facilities;

SELECT *
FROM cd.members;
/* All tables seem ok after having setted the bin path */


/* 57. Assessment Test 2 */
/* 58. Solutions to Assessment Test 2 */
/* a. All the information from the facilities table */
SELECT *
FROM cd.facilities;

/* b. Retrieve a list of only facility names and costs to members */
SELECT name, membercost
FROM cd.facilities;

/* c. Retrieve a list of facility names that charge a fee to members */
SELECT *
FROM cd.facilities
WHERE membercost > 0;

/* d. Retrieve a list of facility names that charge a fee to members */
/* and that fee is less than 1/50th of the monthly maintenance cost. */ 
/* Return the facid, facility name, member cost, and monthly */
/* maintenance of the facilities in question */
SELECT facid, name, membercost, monthlymaintenance
FROM cd.facilities
WHERE membercost > 0
	AND membercost < monthlymaintenance / 50;
/* From 58. NOTE: use 50.0 to get decimals in result */

/* e. Produce a list of all facilities with the word 'Tennis' in their name */
SELECT *
FROM cd.facilities
WHERE name LIKE '%Tennis%';

/* f. Retrieve the details of facilities with ID 1 and 5. */
/* Try to do it without using the OR operator */
SELECT *
FROM cd.facilities
WHERE facid IN (1, 5);
/* From 58., using OR */
SELECT * FROM cd.facilities WHERE facid = 1 OR facid = 5;

/* g. Produce a list of members who joined after the start of */
/* September 2012. Return the memid, surname, firstname, */
/* and joindate of the members in question. */
SELECT memid, surname, firstname, joindate
FROM cd.members
WHERE joindate > '2012-09-01';

/* h. Produce an ordered list of the first 10 surnames in */
/* the members table? The list must not contain duplicates. */
SELECT DISTINCT(surname)
FROM cd.members
ORDER BY surname ASC
LIMIT 10;

/* i. Get the signup date of your last member */
/* Exploration */
SELECT *
FROM cd.members;

/* Solution */
SELECT MAX(joindate)
FROM cd.members;

/* j. Produce a count of the number of facilities that have */
/* a cost to guests of 10 or more. */
/* Exploration */
SELECT *
FROM cd.facilities;

/* Solution */
SELECT COUNT(facid) AS fac_gcost_10
FROM cd.facilities
WHERE guestcost >= 10;

/* k. (11) Produce a list of the total number of slots booked per facility in */
/* the month of September 2012. Produce an output table consisting of */
/* facility id and slots, sorted by the number of slots. */
/* Exploration */
SELECT *
FROM cd.facilities;

SELECT *
FROM cd.bookings;

/* Solution */
SELECT fac.facid AS fac_id,
	SUM(boo.slots) AS total_slots
FROM cd.facilities AS fac
JOIN cd.bookings AS boo
	ON fac.facid = boo.facid
WHERE EXTRACT(YEAR FROM starttime) = '2012'
	AND EXTRACT(MONTH FROM starttime) = '9'
GROUP BY fac_id
ORDER BY total_slots;

/* Inspired from 58., simpler version */
SELECT facid, SUM(slots) AS total_slots
FROM cd.bookings
WHERE EXTRACT(YEAR FROM starttime) = '2012'
	AND EXTRACT(MONTH FROM starttime) = '9'
GROUP BY facid
ORDER BY SUM(slots);

/* l. (12) Produce a list of facilities with more than 1000 slots booked. */
/* Produce an output table consisting of facility id and total slots, */
/* sorted by facility id. */
SELECT facid, SUM(slots) AS total_slots
FROM cd.bookings
GROUP BY facid
HAVING SUM(slots) > 1000
ORDER BY facid ASC;

/* m. (13) Produce a list of the start times for bookings for tennis courts, */
/* for the date '2012-09-21'. Return a list of start time */
/* and facility name pairings, ordered by the time. */
/* Exploration */
SELECT *
FROM cd.bookings
LIMIT 1;

SELECT *
FROM cd.facilities
LIMIT 1;

/* Solution */
SELECT fac.name, boo.starttime
FROM cd.facilities AS fac
JOIN cd.bookings AS boo
	ON fac.facid = boo.facid
WHERE fac.name LIKE '%Tennis%'
	AND fac.name LIKE '%Court%'
	AND TO_CHAR(boo.starttime, 'yyyy-mm-dd') = '2012-09-21'
ORDER BY boo.starttime ASC;

/* n. Produce a list of the start times for bookings by */
/* members named 'David Farrell' */
/* Exploration */
SELECT *
FROM cd.members
LIMIT 1;

SELECT *
FROM cd.bookings
LIMIT 1;

/* Solution */
SELECT mem.firstname || ' ' || mem.surname AS member_name, boo.starttime
FROM cd.members AS mem
JOIN cd.bookings AS boo
	ON mem.memid = boo.memid
WHERE mem.firstname = 'David'
	AND mem.surname = 'Farrell';