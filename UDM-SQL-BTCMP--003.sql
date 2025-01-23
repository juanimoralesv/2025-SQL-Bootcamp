/* 26. General Challenge 1 */
/* 1. How many transactions were greater than USD 5.00? */
SELECT COUNT(*)
FROM payment
WHERE amount > 5.00;


/* 2. How many actors have a first name that starts with a letter P? */
/* I'm assuming case-sensitive. */
SELECT COUNT(*)
FROM actor
WHERE first_name LIKE 'P%';


/* 3. How many unique districts are our customers from? */
SELECT COUNT(DISTINCT district)
FROM address;


/* 4. The names of those distinct districts */
SELECT DISTINCT district
FROM address;


/* 5. How many films have a rating of R and a */
/* replacement cost between USD 5 and USD 15? */
SELECT COUNT(*)
FROM film
WHERE rating = 'R'
	AND replacement_cost BETWEEN 5 AND 15;


/* 6. How many films have the word Truman somewhere in title? */
/* I assume case-insensitive */
SELECT COUNT(*)
FROM film
WHERE title ILIKE '%Truman%';

/* Bonus by me */
SELECT title
FROM film
WHERE title ILIKE '%Truman%';


/* 27. Introduction to GROUP BY */
/* Blank/Notes */


/* 28. Aggregation functions */
SELECT *
FROM film
LIMIT 1;

/* Minimum film replacement cost*/
SELECT MIN(replacement_cost)
FROM film;

/* Maximum film replacement cost*/
SELECT MAX(replacement_cost)
FROM film;

/* Multiple agg functions can be called together, but not a full column */
SELECT MIN(replacement_cost), MAX(replacement_cost), ROUND(AVG(replacement_cost), 4)
FROM film;

/* Another little twist */
SELECT 
	MIN(replacement_cost) AS Minimum,
	MAX(replacement_cost) AS Maximum,
	ROUND(AVG(replacement_cost), 4) AS Average
FROM film;

/* Replacement cost of the entire store */
SELECT SUM(replacement_cost)
FROM film;


/* 29. GROUP BY pt. 1 */
/* Blank/Notes */