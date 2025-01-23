/* 20. ORDER BY */
SELECT *
FROM customer
ORDER BY first_name DESC;

SELECT *
FROM customer
ORDER BY store_id, first_name DESC;

SELECT store_id, first_name, last_name
FROM customer
ORDER BY store_id, first_name DESC;

/* Different columns, different order direction */
SELECT store_id, first_name, last_name
FROM customer
ORDER BY store_id DESC, first_name ASC;

/* Sort by columns that are not printed */
SELECT first_name, last_name
FROM customer
ORDER BY store_id DESC, first_name ASC;
/* However, the results will not be as visually clear without that column */


/* 21. LIMIT */
SELECT *
FROM payment;

/* Give a look at table, data types */
SELECT *
FROM payment
LIMIT 1;

/* Order by date */
SELECT *
FROM payment
ORDER BY payment_date DESC;

/* Only the last five payments */
SELECT *
FROM payment
ORDER BY payment_date DESC
LIMIT 5;

/* How many payment dates? */ 
SELECT COUNT (*)
FROM payment;

SELECT COUNT (DISTINCT (payment_date))
FROM payment;

/* Only the last five payments that were not zero in amount */
SELECT *
FROM payment
WHERE amount != 0
ORDER BY payment_date DESC
LIMIT 5;


/* 22. Challenge: ORDER BY */
/* 1. Business question: we want to reward the */
/* first ten customers who made a payment. */
SELECT payment_date, customer_id
FROM payment
ORDER BY payment_date ASC
LIMIT 10;

/* 2. Business question: a customer wants to rent a */
/* short video, and we want to suggest the shortest five. */
SELECT title, length
FROM film
ORDER BY length ASC
LIMIT 5;

/* 3. BONUS Business question: the customer from (2) indicates that */
/* they could watch movies that are 50 minutes or shorter. */
/* How many options would they have? */
SELECT COUNT (length)
FROM film
WHERE length <= 50;


/* 23. BETWEEN */
SELECT *
FROM payment
LIMIT 1;

/* How many payments with amounts between USD 8 and 9? */
SELECT COUNT (*)
FROM payment
WHERE amount
	BETWEEN 8 AND 9;

/* Opposite condition */
SELECT COUNT (*)
FROM payment
WHERE amount
	NOT BETWEEN 8 AND 9;

/* Payments during first half of February */
SELECT payment_date, payment_id
FROM payment
WHERE payment_date
	BETWEEN '2007-02-01'
		AND '2007-02-15'; /* Use 14 and get no result !!!! */
/* 14 gives no result because: all payments were done on the 14th. */
/* However, because no time is entered for BETWEEN ... AND ... */
/* the results only include payments up to 2007-02-14 00:00:00.000000 */


/* 24. IN */
SELECT *
FROM payment
LIMIT 1;

/* What values are charged? */
SELECT DISTINCT (amount)
FROM payment;

SELECT DISTINCT (amount)
FROM payment
ORDER BY amount DESC;

/* Payments with amounts 0.99, 1.98, 1.99 */
SELECT *
FROM payment
WHERE amount
	IN (0.99, 1.98, 1.99);

/* Counting them */
SELECT COUNT (*)
FROM payment
WHERE amount
	IN (0.99, 1.98, 1.99);

/* Counting the opposite */
SELECT COUNT (*)
FROM payment
WHERE amount
	NOT IN (0.99, 1.98, 1.99);

/* With strings */
SELECT *
FROM customer
WHERE first_name
	IN ('John', 'Jake', 'Julie');

/* The opposite */
SELECT *
FROM customer
WHERE first_name
	NOT IN ('John', 'Jake', 'Julie');


/* 25. LIKE and ILIKE */
/* Customers with first name starting with J */
SELECT *
FROM customer
WHERE first_name LIKE 'J%';

/* How many? */
SELECT COUNT (*)
FROM customer
WHERE first_name LIKE 'J%';

/* Customers with first name starting with J and last name with S */
SELECT *
FROM customer
WHERE first_name LIKE 'J%'
	AND last_name LIKE 'S%';

/* The same, but case-insensitive */
SELECT *
FROM customer
WHERE first_name ILIKE 'j%'
	AND last_name ILIKE 's%';

/* Combinations of wildcard characters */
SELECT *
FROM customer
WHERE first_name ILIKE '%er%';

SELECT *
FROM customer
WHERE first_name LIKE '%her%'; /* This does not allow names starting with Her */

SELECT *
FROM customer
WHERE first_name ILIKE '%her%'; /* This allows names starting with Her */

/* Combinable with AND and NOT operators */
SELECT *
FROM customer
WHERE first_name NOT ILIKE '%her%';

SELECT *
FROM customer
WHERE first_name LIKE 'A%'
	AND last_name NOT LIKE 'B%'
ORDER BY last_name;