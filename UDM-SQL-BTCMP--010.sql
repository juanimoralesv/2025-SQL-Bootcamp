/* 72. Conditional Expressions and Procedures - Introduction */ 
/* Blank/In notes */

/* 73. CASE */
/* Exploration, table customer */
SELECT *
FROM customer
LIMIT 1;

/* General CASE */
/* Customer tiers: 1 to 100, Premium; 101 to 200, Plus; 201 and up, regular */
SELECT
	customer_id,
	CASE
		WHEN customer_id BETWEEN 1 AND 100 THEN 'Premium'
		WHEN customer_id BETWEEN 101 AND 200 THEN 'Plus'
		ELSE 'Regular'
	END AS customer_class
FROM customer
ORDER BY customer_id ASC;

/* CASE Expression */
/* Raffle where winner is customer_id = 2, and second place */
/* is customer_id = 5; the rest is normal */
SELECT
	customer_id,
	CASE customer_id
		WHEN 2 THEN 'Winner'
		WHEN 5 THEN 'Second Place'
		ELSE 'Normal'
	END AS raffle_result
FROM customer
ORDER BY customer_id ASC;

/* Exploration, film table */
SELECT *
FROM film
LIMIT 1;

/* Exploration, rental_rate unique valuse */
SELECT DISTINCT(rental_rate)
FROM film;

/* How many of each rental_rate? Using CASE */
/* First, explore 0.99 yes/no */
SELECT
	rental_rate,
	CASE rental_rate
		WHEN 0.99 THEN 1
		ELSE 0
	END AS something
FROM film;

/* Count 0.99 as bargain */
SELECT
	SUM(CASE rental_rate
		WHEN 0.99 THEN 1
		ELSE 0
	END) AS tot_qty_bargain
FROM film;

/* Count 2.99 as cheap */
SELECT
	SUM(CASE rental_rate
		WHEN 2.99 THEN 1
		ELSE 0
	END) AS tot_qty_cheap
FROM film;

/* Count 4.99 as costly */
SELECT
	SUM(CASE rental_rate
		WHEN 4.99 THEN 1
		ELSE 0
	END) AS tot_qty_costly
FROM film;

/* All of the three in only one query */
SELECT
	SUM(CASE rental_rate
		WHEN 0.99 THEN 1
		ELSE 0
	END) AS tot_qty_bargain,
	SUM(CASE rental_rate
		WHEN 2.99 THEN 1
		ELSE 0
	END) AS tot_qty_cheap,
	SUM(CASE rental_rate
		WHEN 4.99 THEN 1
		ELSE 0
	END) AS tot_qty_costly
FROM film;
/* It allows for results in columns, which is difficult to do */
/* using other tools previously learned. Also, it allows to */
/* apply functions on the results of the cases */


/* 74. Challenge: CASE */
/* a. How many films per film rating (limited to R, PG, and PG-13)? */
/* Explore film table */
SELECT *
FROM film
LIMIT 1;

/* Explore, unique ratings? */
SELECT DISTINCT(rating)
FROM film;

/* Count films per rating */
SELECT
	SUM(
		CASE rating
			WHEN 'PG-13' THEN 1
			ELSE 0
		END
	) AS "PG-13", -- Double quoutes, mandatory
	/*SUM(
		CASE rating
			WHEN 'NC-17' THEN 1
			ELSE 0
		END
	) AS "NC-17",*/
	SUM(
		CASE rating
			WHEN 'R' THEN 1
			ELSE 0
		END
	) AS "R",
	/*SUM(
		CASE rating
			WHEN 'G' THEN 1
			ELSE 0
		END
	) AS "G",*/
	SUM(
		CASE rating
			WHEN 'PG' THEN 1
			ELSE 0
		END
	) AS "PG"
FROM film;


/* 75. COALESCE */
/* Blank/In notes */


/* 76. CAST */
/* Function */
SELECT CAST('5' AS INTEGER);

/* PostgreSQL operator */
SELECT '5'::INTEGER;

/* Explore rental table */
SELECT *
FROM rental
LIMIT 1;

/* Count the number of digits in each inventory_id */
SELECT inventory_id, LENGTH(CAST(inventory_id AS VARCHAR))
FROM rental
LIMIT 15;


/* 77. NULLIF */
/* Blank/In notes */


/* 78. Views */
/* Explore customer, address tables */
SELECT *
FROM customer
LIMIT 1;

SELECT *
FROM address
LIMIT 1;

/* Join tables */
SELECT first_name, last_name, address
FROM customer cu
JOIN address ad
	ON cu.address_id = ad.address_id;

/* Assuming this query will be repeatedly used, sava as view */
CREATE VIEW customer_info AS
	SELECT first_name, last_name, address
	FROM customer cu
	JOIN address ad
		ON cu.address_id = ad.address_id;

/* Verify view creation, explore customer_info */
SELECT *
FROM customer_info
LIMIT 1;

/* Alter/update the view */
CREATE OR REPLACE VIEW customer_info AS
	SELECT cu.first_name, cu.last_name, ad.address, ad.district
	FROM customer cu
	JOIN address ad
		ON cu.address_id = ad.address_id;

/* Rename the view */
ALTER VIEW customer_info
RENAME TO c_info;

/* Verify new view name, explore c_info */
SELECT *
FROM c_info
LIMIT 1;

/* Drop the view */
/* DROP VIEW c_info; */
DROP VIEW IF EXISTS c_info;

