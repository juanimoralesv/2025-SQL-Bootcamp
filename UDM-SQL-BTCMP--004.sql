/* 30. GROUP BY pt. 2 */
/* Explore the payment table */
SELECT *
FROM payment
LIMIT 5;
/* customer_id, staff_id, rental_id are integers, however */
/* they act as a categorical column. */

/* How much each customer spent. */
SELECT customer_id, SUM(amount)
FROM payment
GROUP BY customer_id
ORDER BY customer_id ASC;

/* Top 10 of customers who spent the most. */
SELECT customer_id, SUM(amount)
FROM payment
GROUP BY customer_id
ORDER BY SUM(amount) DESC
LIMIT 10;

/* Top 10 of customer with the most transactions */
SELECT customer_id, COUNT(amount)
FROM payment
GROUP BY customer_id
ORDER BY COUNT(amount) DESC
LIMIT 10;

/* Grouping by more than one variable; how many transactions? */
SELECT staff_id, customer_id, COUNT(amount)
FROM payment
GROUP BY staff_id, customer_id
ORDER BY staff_id ASC, customer_id ASC;

/* Grouping by a date column */
/* Need: conversion of timestamp to date */
SELECT DATE(payment_date)
FROM payment;

/* Dates with most amount of money spent */
SELECT DATE(payment_date), SUM(amount)
FROM payment
GROUP BY DATE(payment_date)
ORDER BY SUM(amount) DESC;


/* 31. Challenge: GROUP BY */
/* 1. Staff member with the most payments handled */
SELECT staff_id, COUNT(*)
FROM payment
GROUP BY staff_id
ORDER BY COUNT(*) DESC;

/* 2. Replacement cost per MPAA rating */
SELECT rating, ROUND(AVG(replacement_cost), 2)
FROM film
GROUP BY rating
ORDER BY AVG(replacement_cost);

/* 3. Top 5 customer who spent the most */
SELECT customer_id, SUM(amount)
FROM payment
GROUP BY customer_id
ORDER BY SUM(amount) DESC
LIMIT 5;


/* 32. HAVING */
/* Explore the payment table */
SELECT *
FROM payment
LIMIT 1;

/* Expenditure per customer, with filtered customers */
SELECT customer_id, SUM(amount)
FROM payment
WHERE customer_id NOT IN (184, 87, 477)
GROUP BY customer_id;

/* Adding filtering on expenditure */
SELECT customer_id, SUM(amount)
FROM payment
WHERE customer_id NOT IN (184, 87, 477)
GROUP BY customer_id
HAVING SUM(amount) > 100
ORDER BY SUM(amount) DESC;

/* Explore customer table */
SELECT *
FROM customer
LIMIT 1;

/* Number of customer associated to a store */
SELECT store_id, COUNT(*)
FROM customer
GROUP BY store_id
ORDER BY COUNT(*) DESC;

/* Filtering results to stores with a certain lower number of customers */
SELECT store_id, COUNT(customer_id)
FROM customer
GROUP BY store_id
HAVING COUNT(customer_id) > 300
ORDER BY COUNT(customer_id) DESC;


/* 33. Challenge: HAVING */
/* 1. Find the customers with 40 or more transactions */
SELECT *
FROM payment
LIMIT 1;

SELECT customer_id, COUNT(payment_id)
FROM payment
GROUP BY customer_id
HAVING COUNT(payment_id) >= 40
ORDER BY COUNT(payment_id) DESC;

/* 2. Which customers spent more than $100 in payments */
/* associated to staff member #2 */
SELECT customer_id, SUM(amount)
FROM payment
WHERE staff_id = 2
GROUP BY customer_id
HAVING SUM(amount) > 100
ORDER BY SUM(amount) DESC;


/* 34, 35, 36. Assessment Test 1 */
/* Complete the following tasks:
1. Return the customer IDs of customers who have spent at least $110 with the staff member who has an ID of 2.
The answer should be customers 187 and 148.

2. How many films begin with the letter J?
The answer should be 20.

3. What customer has the highest customer ID number whose name starts with an 'E' and has an address ID lower than 500?
The answer is Eddie Tomlin. */

/* Queries */
/* 1. Return the customer IDs of customers who have spent */
/* at least $110 with the staff member who has an ID of 2. */
SELECT customer_id, SUM(amount)
FROM payment
WHERE staff_id = 2
GROUP BY customer_id
HAVING SUM(amount) >= 110
ORDER BY SUM(amount) DESC;

/* 2. How many films begin with the letter J? */
SELECT *
FROM film
LIMIT 1;

SELECT COUNT(film_id)
FROM film
WHERE title ILIKE 'j%';

/* 3. What customer has the highest customer ID number whose */
/* name starts with an 'E' and has an address ID lower than 500? */
SELECT *
FROM customer;

SELECT first_name, last_name
FROM customer
WHERE first_name ILIKE 'e%'
	AND address_id < 500
ORDER BY customer_id DESC
LIMIT 1;


/* 37. Overview of JOINS */
/* Blank/in notes */


/* 38. Introduction to JOINs */
/* Blank/in notes */


/* 39. AS Statement */
SELECT amount AS rental_price
FROM payment;

SELECT SUM(amount) AS net_revenue
FROM payment;

/* Aliases do not allow usage for filtering */
SELECT COUNT(amount)
FROM payment;

SELECT COUNT(amount) AS num_transactions /* Alias added */
FROM payment;

SELECT customer_id, SUM(amount) /* Aggregation added, no alias */
FROM payment
GROUP BY customer_id; /* Grouping added */

SELECT customer_id, SUM(amount) AS total_spent /* Alias added */
FROM payment
GROUP BY customer_id;

SELECT customer_id, SUM(amount) /* Alias removed */
FROM payment
GROUP BY customer_id
HAVING SUM(amount) > 100; /* Added HAVING */

SELECT customer_id, SUM(amount) AS total_spent /* Alias added */
FROM payment
GROUP BY customer_id
HAVING SUM(amount) > 100;

/* The following should return error */
SELECT customer_id, SUM(amount) AS total_spent
FROM payment
GROUP BY customer_id
HAVING total_spent > 100; /* Erroneous filtering by alias */

/* Another erroneous query */
SELECT customer_id, amount AS new_name
FROM payment
WHERE new_name > 2;


/* 40. INNER JOIN */
SELECT *
FROM payment
LIMIT 1;

SELECT *
FROM customer
LIMIT 1;

SELECT *
FROM payment
INNER JOIN customer
	ON payment.customer_id = customer.customer_id;

SELECT payment_id, payment.customer_id, first_name /* Specific columns */
FROM payment
INNER JOIN customer
	ON payment.customer_id = customer.customer_id;


/* 41. FULL OUTER JOIN */
SELECT *
FROM payment
FULL OUTER JOIN customer
	ON payment.customer_id = customer.customer_id
WHERE customer.customer_id IS null
	OR payment.payment_id IS null;