SELECT * FROM actor;

SELECT first_name, last_name FROM actor;


/* 13. Challenge: SELECT */
SELECT first_name, last_name, email FROM customer;

/* #################################### */
/* -- Extra something: */

SELECT first_name, last_name, email 
FROM customer
LIMIT 5;

/* That's useful to give a look at what a table looks like. */
/* More like this: */

SELECT *
FROM customer
LIMIT 5;

/* #################################### */


/* 14. SELECT DISTINCT */
SELECT DISTINCT (release_year)
FROM film;

SELECT DISTINCT (rental_rate)
FROM film;


/* 15. Challenge: SELECT DISTINCT */
SELECT DISTINCT (rating)
FROM film;


/* 16. COUNT */
SELECT COUNT * FROM film; /* This is invalid syntax. Parenthesis! */

SELECT COUNT (*) FROM film;

/* Use a column name instead of *, because it might refresh memory on what */
/* question was trying to be answered (when revisiting the query at a later time) */

/* Combine with DISTINCT --> how many unique values. */

SELECT COUNT (DISTINCT (rating))
FROM film;

/* Examples from video */

SELECT * FROM payment;

SELECT COUNT (*) FROM payment;

SELECT COUNT (amount) FROM payment; /* same result as last line */

SELECT COUNT (DISTINCT (amount)) FROM payment;


/* 17. SELECT WHERE pt. 1 */

SELECT * FROM film LIMIT 1;

SELECT DISTINCT (rental_duration) FROM film;

/* EXAMPLE */

SELECT title, length, description
FROM film
WHERE rating = 'PG-13' AND rental_duration = 6;


/* 18. SELECT WHERE pt. 2 */
SELECT * FROM customer;

SELECT * FROM customer
WHERE first_name = 'Jared';

SELECT * FROM film
WHERE rental_rate > 4;

SELECT * FROM film
WHERE rental_rate > 4
	AND replacement_cost >= 19.99
	AND rating = 'R';

SELECT title FROM film
WHERE rental_rate > 4
	AND replacement_cost >= 19.99
	AND rating = 'R';

SELECT COUNT(title) FROM film /* or COUNT(*) */
WHERE rental_rate > 4
	AND replacement_cost >= 19.99
	AND rating = 'R';

SELECT COUNT(*) FROM film
WHERE rating = 'R' OR rating = 'PG-13';

SELECT * FROM film
WHERE rating != 'R';


/* 19. Challenge: SELECT WHERE */
/* 1. What is the email of the customer Nancy Thomas? */
SELECT first_name, last_name, email
FROM customer
WHERE first_name = 'Nancy'
	AND last_name = 'Thomas';

/* 2. What is the description of the movie Outlaw Hanky? */
SELECT title, description
FROM film
WHERE title = 'Outlaw Hanky';

/* 3. Get the phone number for the address 259 Ipoh Drive. */
SELECT phone
FROM address
WHERE address = '259 Ipoh Drive';