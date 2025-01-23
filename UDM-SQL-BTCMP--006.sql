/* 46. Overview of Advanced SQL Commands */
/* Blank/In notes */


/* 47. Timestamps and Extract Pt. 1 */
SHOW ALL; /* Shows all paramenters and their present setting */

SHOW TIMEZONE; /* Shows the current timezone */

SELECT NOW(); /* Returns the currect timestamp with time zone */

SELECT TIMEOFDAY(); /* Similar, more readable */

SELECT CURRENT_TIME; /* Only the time part of NOW() */

SELECT CURRENT_DATE; /* Only the date part of NOW() */


/* 48. Timestamps and Extract Pt. 2 */
/* Explore the table */
SELECT *
FROM payment
LIMIT 1;

/* Extract payment year */
SELECT EXTRACT(YEAR FROM payment_date) AS payment_year
FROM payment;

/* Extract payment quarter */
SELECT EXTRACT(QUARTER FROM payment_date) AS payment_quarter
FROM payment;

/* Extract payment month */
SELECT EXTRACT(MONTH FROM payment_date) AS payment_month
FROM payment;

/* Extract payment week */
SELECT EXTRACT(WEEK FROM payment_date) AS payment_week
FROM payment;

/* Extract payment day */
SELECT EXTRACT(DAY FROM payment_date) AS payment_day
FROM payment;

/* Extract how long ago the payment took place */
SELECT payment_date, AGE(payment_date)
FROM payment;

/* Format time/date */
SELECT TO_CHAR(payment_date, 'mm-yyyy-dd')
FROM payment;

SELECT TO_CHAR(payment_date, 'Month-yyyy')
FROM payment;

SELECT TO_CHAR(payment_date, 'Mon-yyyy')
FROM payment;

SELECT TO_CHAR(payment_date, 'MONTH upalala! yyyy MI HH24')
FROM payment;

SELECT TO_CHAR(payment_date, 'yyyy - Month - dd | HH24:MI')
FROM payment;


/* 50. Challenge: Timestamps and Extract */
/* a. During which months did payments occur? */
/* Format your answer to return back the full month name. */
SELECT TO_CHAR(payment_date, 'Month') AS payment_month
FROM payment
GROUP BY TO_CHAR(payment_date, 'Month');

/* Or: */
SELECT DISTINCT(
	TO_CHAR(payment_date, 'Month')
) AS payment_month
FROM payment;

/* b. How many payments ocurred on a monday? */
SELECT TO_CHAR(payment_date, 'Day'), COUNT(payment_id)
FROM payment
GROUP BY TO_CHAR(payment_date, 'Day')
HAVING TO_CHAR(payment_date, 'Day') = 'Monday   ';

/* Or: */
SELECT COUNT(*)
FROM payment
WHERE EXTRACT(DOW FROM payment_date) = 1;


/* 51. Mathematical Functions and Operators */
/* https://www.postgresql.org/docs/current/functions-math.html */
/* Explore the film table */
SELECT *
FROM film
LIMIT 1;

/* Percentage of replacement_cost represented by rental_rate */
SELECT ROUND((rental_rate / replacement_cost) * 100, 2) AS percent_cost
FROM film;

/* Deposit for replacement (10 %) */
SELECT ROUND(0.1 * replacement_cost, 2) AS replacement_deposit
FROM film;


/* 52. String Functions and Operators */
/* https://www.postgresql.org/docs/17/functions-string.html */
/* Explore the customer table */
SELECT *
FROM customer
LIMIT 1;

/* Length of first name */
/* LENGTH(), CHAR_LENGTH(), CHARACTER_LENGTH() are the same thing */
SELECT LENGTH(first_name) AS name_length

/* Concatenation */
SELECT first_name || ' ' || last_name AS full_name
FROM customer;

/* With upper casing */
SELECT UPPER(first_name) || ' ' || UPPER(last_name) AS full_name
FROM customer;

/* Creation of email address */
SELECT LEFT(LOWER(first_name), 1) ||
	'.' ||
	LOWER(last_name) ||
	'@dvdrental_customer.com'
		AS customer_email
FROM customer;

/* Or: */
SELECT LOWER(
	LEFT(first_name, 1) ||
		'.' ||
		last_name ||
		'@dvdrental_customer.com'
) AS customer_email
FROM customer;


/* 53. Sub-Queries */
/* Explore the film table */
SELECT *
FROM film
LIMIT 1;

/* Search the films with higher rental_rate than the average rental_rate */
/* (Subquery returns a single value) */
SELECT title, rental_rate
FROM film
WHERE rental_rate > (
	SELECT AVG(rental_rate)
	FROM film
);

/* Explore the rental table */
SELECT *
FROM rental
LIMIT 1;

/* Explore the inventory table */
SELECT *
FROM inventory
LIMIT 1;

SELECT MAX(DATE(return_date))
FROM rental;

/* Find films that have been returned between certain dates */
SELECT title, return_date
FROM film
JOIN inventory
	ON film.film_id = inventory.film_id
JOIN rental
	ON inventory.inventory_id = rental.inventory_id
WHERE return_date BETWEEN '2005-05-29'
	AND '2005-05-30'
ORDER BY return_date ASC;

/* Or: */
SELECT film_id, title
FROM film
WHERE film_id IN (
	SELECT inventory.film_id
	FROM inventory
	JOIN rental
		ON rental.inventory_id = inventory.inventory_id
	WHERE return_date BETWEEN '2005-05-29'
		AND '2005-05-30'
ORDER BY return_date ASC
);
/* Different results, because the first includes the possibility for a */
/* film to be returned more than once. The second one considers the unique */
/* values in the subquery of returned films. */

/* First query used as subquery and counting by title */
SELECT title, COUNT(*) AS rental_count
FROM (
    SELECT title, return_date
    FROM film
    JOIN inventory ON film.film_id = inventory.film_id
    JOIN rental ON inventory.inventory_id = rental.inventory_id
    WHERE return_date BETWEEN '2005-05-29' AND '2005-05-30'
)
GROUP BY title
ORDER BY rental_count DESC;
/* There's a film that appears twice */

/* Second query used as subquery and counting by title */
SELECT title, COUNT(*) AS rental_count
FROM (
	SELECT film_id, title
	FROM film
	WHERE film_id IN (
		SELECT inventory.film_id
		FROM inventory
		JOIN rental
			ON rental.inventory_id = inventory.inventory_id
		WHERE return_date BETWEEN '2005-05-29'
			AND '2005-05-30'
	ORDER BY return_date ASC
	)
)
GROUP BY title
ORDER BY COUNT(*) DESC;
/* All films appear only once */

/* Find customers (first and last names) with at least */
/* one payment greater than 11 */
SELECT first_name, last_name
FROM customer AS c
WHERE EXISTS(
	SELECT *
	FROM payment AS p
	WHERE p.customer_id = c.customer_id
		AND amount > 11
);


/* 54. Self-join */
/* Find all the pairs of films that have the same length */
/* Explore the film table */
SELECT *
FROM film
LIMIT 1;

/* Query for the pairs */
SELECT tleft.length,
	tleft.title AS title_left,
	tright.title AS title_right
FROM film AS tleft
JOIN film AS tright
	ON tleft.length = tright.length
	AND tleft.film_id != tright.film_id
ORDER BY tleft.length, tleft.title ASC;