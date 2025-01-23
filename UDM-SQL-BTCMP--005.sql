/* 42. LEFT OUTER JOIN */
/* Exploring the tables */
SELECT *
FROM film
LIMIT 1;

SELECT *
FROM inventory
LIMIT 1;

/* Listing all films and showing which are in stock */
SELECT film.film_id, title, inventory_id, store_id
FROM film
LEFT JOIN inventory
	ON film.film_id = inventory.film_id;

/* Showing only those which are not in stock */
SELECT film.film_id, title, inventory_id, store_id
FROM film
LEFT JOIN inventory
	ON film.film_id = inventory.film_id
WHERE inventory.film_id IS NULL;


/* 43. RIGHT OUTER JOIN */
/* Blank/In notes */


/* 44. UNION */
(SELECT film_id, title
FROM film)
UNION
(SELECT inventory_id, store_id
FROM inventory); /* returns an error, non-matching types */

SELECT *
FROM customer
LIMIT 1;

/* Matching number of columns, and same/similar types */
(SELECT film_id, title
FROM film)
UNION
(SELECT customer_id, first_name
FROM customer);

/* Unmatching number of columns */
(SELECT film_id, title, rating
FROM film)
UNION
(SELECT customer_id, first_name
FROM customer); /* returns an error, non-matching quantity of columns */


/* 45. Challenge: JOIN */
/* 1. California sales tax laws have changed and we need to alert */
/* our customers to this through email. What are the emails of the */
/* customers who live in California? */
/* Explore the relevant tables */
SELECT *
FROM customer
LIMIT 1;

SELECT *
FROM address
LIMIT 1;

/* Verify that district contains 'California' values */
SELECT COUNT(address_id)
FROM address
WHERE district = 'California';

/* Obtain email addresses for customers from California */
SELECT first_name, last_name, email
FROM customer
JOIN address
	ON address.address_id = customer.address_id
WHERE address.district = 'California';

/* 2. A customer walks in and is a huge fan of the actor "Nick Wahlberg" */
/* and wants to know which movies he is in. Get a list of all the movies */
/* "Nick Wahlberg" has been in. */
/* Explore the relevant tables */
SELECT *
FROM film
LIMIT 1;
/* Useful variables: film_id, title */

SELECT *
FROM actor
LIMIT 1;
/* Useful variables: actor_id, first_name, last_name */

SELECT *
FROM film_actor
LIMIT 1;
/* Useful variables: actor_id, film_id */

/* Show all films where Nick Wahlberg starred */
SELECT title, release_year
FROM film
JOIN film_actor
	ON film.film_id = film_actor.film_id
JOIN actor
	ON actor.actor_id = film_actor.actor_id
WHERE first_name = 'Nick'
	AND last_name = 'Wahlberg'
ORDER BY title ASC;


/* Section 6 */

/* 46. Overview of Advanced SQL Commands */
/* Blank/In notes */