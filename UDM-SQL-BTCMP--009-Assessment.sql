/* 70. Assessment Test 3

Welcome to your final assessment test! This will test your knowledge of the
previous section, focused on creating databases and table operations.
This test will actually consist of a more open-ended assignment below:

Complete the following task:
Create a new database called "School" this database should have two tables:
teachers and students.

The students table should have columns for student_id, first_name, last_name,
homeroom_number, phone,email, and graduation year.

The teachers table should have columns for teacher_id, first_name, last_name,
homeroom_number, department, email, and phone.

The constraints are mostly up to you, but your table constraints
do have to consider the following:
- We must have a phone number to contact students in case of an emergency.
- We must have ids as the primary key of the tables.
- Phone numbers and emails must be unique to the individual.

Once you've made the tables, insert a student named Mark Watney (student_id=1)
who has a phone number of 777-555-1234 and doesn't have an email.
He graduates in 2035 and has 5 as a homeroom number.

Then insert a teacher names Jonas Salk (teacher_id = 1) who as a homeroom number
of 5 and is from the Biology department. His contact info is:
jsalk@school.org and a phone number of 777-555-4321.

Keep in mind that these insert tasks may affect your constraints. */


/* SOLUTION */

/* Table creation: teachers, students */
CREATE TABLE teachers(
	teacher_id SERIAL PRIMARY KEY,
	first_name VARCHAR(100) NOT NULL,
	last_name VARCHAR(100) NOT NULL,
	homeroom_number INTEGER NOT NULL,
	department VARCHAR(50) NOT NULL,
	phone VARCHAR(50) UNIQUE,
	email VARCHAR(100) UNIQUE
);

CREATE TABLE students(
	student_id SERIAL PRIMARY KEY,
	first_name VARCHAR(100) NOT NULL,
	last_name VARCHAR(100) NOT NULL,
	homeroom_number INTEGER NOT NULL,
	phone VARCHAR(50) NOT NULL UNIQUE,
	email VARCHAR(100) UNIQUE,
	grad_year INTEGER
);

/* Student register insertion */
INSERT INTO students(
	first_name,
	last_name,
	homeroom_number,
	phone,
	grad_year
)
VALUES(
	'Mark',
	'Watney',
	5,
	'777-555-1234',
	2035
);

/* Verification */
SELECT *
FROM students;

/* Teacher register insertion */
INSERT INTO teachers(
	first_name,
	last_name,
	homeroom_number,
	department,
	phone,
	email
)
VALUES(
	'Jonas',
	'Salk',
	5,
	'Biology',
	'777-555-4321',
	'jsalk@school.org'
);

/* Verification */
SELECT *
FROM teachers;