--------------------------------------------------------------------------------------------------------------
--Import departments.csv
DROP TABLE IF EXISTS departments;

CREATE TABLE departments (
	dept_no VARCHAR Not Null Primary Key,
	dept_name VARCHAR Not Null);

COPY departments
FROM '/Users/peirangxu/Desktop/USC-LA-DATA-PT-08-2019-U-C/09-SQL/Homework/data/departments.csv'
DELIMITER ',' CSV HEADER;

SELECT * FROM departments;

--------------------------------------------------------------------------------------------------------------
-- Import employees.csv
DROP TABLE IF EXISTS employees;

CREATE TABLE employees (
	emp_no INT Not Null Primary Key,
	birth_date DATE Not Null,
	first_name VARCHAR Not Null,
	last_name VARCHAR Not Null,
	gender VARCHAR Not Null,
	hire_date DATE Not Null);

COPY employees
FROM '/Users/peirangxu/Desktop/USC-LA-DATA-PT-08-2019-U-C/09-SQL/Homework/data/employees.csv'
DELIMITER ',' CSV HEADER;

SELECT * FROM employees;

--------------------------------------------------------------------------------------------------------------
-- Import dept_emp.csv
DROP TABLE IF EXISTS dept_emp;

CREATE TABLE dept_emp (
	emp_no INT Not Null,
	dept_no VARCHAR Not Null,
	FOREIGN KEY(emp_no) REFERENCES employees(emp_no),
	FOREIGN KEY(dept_no) REFERENCES departments(dept_no),
	from_date DATE,
	to_date DATE,
	Primary Key (emp_no,dept_no));

COPY dept_emp
FROM '/Users/peirangxu/Desktop/USC-LA-DATA-PT-08-2019-U-C/09-SQL/Homework/data/dept_emp.csv'
DELIMITER ',' CSV HEADER;

SELECT * FROM dept_emp;

--------------------------------------------------------------------------------------------------------------
-- Import dept_manager.csv
DROP TABLE IF EXISTS dept_manager;

CREATE TABLE dept_manager (
	dept_no VARCHAR Not Null,
	emp_no INT Not Null,
	FOREIGN KEY(dept_no) REFERENCES departments(dept_no),
	FOREIGN KEY(emp_no) REFERENCES employees(emp_no),
	from_date DATE Not Null,
	to_date DATE Not Null,
	Primary Key (dept_no,emp_no));

COPY dept_manager
FROM '/Users/peirangxu/Desktop/USC-LA-DATA-PT-08-2019-U-C/09-SQL/Homework/data/dept_manager.csv'
DELIMITER ',' CSV HEADER;

SELECT * FROM dept_manager;

--------------------------------------------------------------------------------------------------------------
--Import salaries.csv
DROP TABLE IF EXISTS salaries;

CREATE TABLE salaries (
	emp_no INT Not Null Primary Key,
	FOREIGN KEY(emp_no) REFERENCES employees(emp_no),
	salary INT Not Null,
	from_date DATE Not Null,
	to_date DATE Not Null);

COPY salaries
FROM '/Users/peirangxu/Desktop/USC-LA-DATA-PT-08-2019-U-C/09-SQL/Homework/data/salaries.csv'
DELIMITER ',' CSV HEADER;

SELECT * FROM salaries;

--------------------------------------------------------------------------------------------------------------
-- Import titles.csv
DROP TABLE IF EXISTS titles;

CREATE TABLE titles (
	emp_no INT Not Null,
	FOREIGN KEY(emp_no) REFERENCES employees(emp_no),
	title VARCHAR Not Null,
	from_date DATE Not Null,
	to_date DATE Not Null);

COPY titles
FROM '/Users/peirangxu/Desktop/USC-LA-DATA-PT-08-2019-U-C/09-SQL/Homework/data/titles.csv'
DELIMITER ',' CSV HEADER;

SELECT * FROM titles;
