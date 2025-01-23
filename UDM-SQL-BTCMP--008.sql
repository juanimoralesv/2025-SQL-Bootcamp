/* 59. Introduction */
/* Blank/In notes */


/* 60. Data Types */
/* Blank/In notes */

/* 61. Primary Keys and Foreign Keys */
/* Blank/In notes */


/* 62. Constraints */ 
/* Blank/In notes */


/* 63. CREATE table */
/* Create the account table */
CREATE TABLE account(
	user_id SERIAL PRIMARY KEY,
	username VARCHAR(50) UNIQUE NOT NULL,
	password VARCHAR(50) NOT NULL,
	email VARCHAR(250) UNIQUE NOT NULL,
	created_on TIMESTAMP NOT NULL,
	last_login TIMESTAMP
);

/* Create the job table */
CREATE TABLE job(
	job_id SERIAL PRIMARY KEY,
	job_name VARCHAR(200) UNIQUE NOT NULL
);

/* Create intermediary table account <-> job */
CREATE TABLE account_job(
	user_id INTEGER REFERENCES account(user_id),
	job_id INTEGER REFERENCES job(job_id),
	hire_date TIMESTAMP
);


/* 64. INSERT */
/* Explore the account table */
SELECT *
FROM account;

/* Explore the job table */
SELECT *
FROM job;

/* Explore the account_job table */
SELECT *
FROM account_job;

/* Manual row insertion into account */
INSERT INTO account(username, password, email, created_on)
VALUES(
	'Jose', 'password', 'jose@mail.com', CURRENT_TIMESTAMP
);

/* Manual row insertion into job */
INSERT INTO job(job_name)
VALUES(
	'Astronaut'
);

INSERT INTO job(job_name)
VALUES(
	'President'
);

/* Manual row insertion into account_job */
INSERT INTO account_job(user_id, job_id, hire_date)
VALUES(
	1, 1, CURRENT_TIMESTAMP
);

INSERT INTO account_job(user_id, job_id, hire_date)
VALUES(
	10, 10, CURRENT_TIMESTAMP
);
/* This should return an error: these foreign keys don't exist on their */
/* parent tables as primary keys */


/* 65. UPDATE */
/* Set values using a condition */
UPDATE account
SET last_login = CURRENT_TIMESTAMP
WHERE last_login IS NULL;

/* Reset without condition */
UPDATE account
SET last_login = CURRENT_TIMESTAMP;

/* Based on another column */
UPDATE account
SET last_login = created_on;

/* Explore account, job, account_job tables */
SELECT *
FROM account;

SELECT *
FROM job;

SELECT *
FROM account_job;

/* Update from another table */
UPDATE account_job
SET hire_date = account.created_on
FROM account
WHERE account_job.user_id = account.user_id;

/* Use of RETURNING */
UPDATE account
SET last_login = CURRENT_TIMESTAMP
RETURNING email, created_on, last_login;


/* 66. DELETE */
/* Explore job */
SELECT *
FROM job;

/* Add a job */
INSERT INTO job(job_name)
VALUES(
	'Cowboy'
);

/* Remove a job */
DELETE FROM job
WHERE job_name = 'Cowboy'
RETURNING job_id, job_name;
/* If run again, returns nothing, because entry had been already deleted */
