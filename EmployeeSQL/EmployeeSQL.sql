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

--------------------------------------------------------------------------------------------------------------
--List the following details of each employee: employee number, last name, first name, gender, and salary
COPY
(SELECT employees.emp_no,
	employees.last_name,
	employees.first_name,
	employees.gender,
	salaries.salary
FROM employees
JOIN salaries ON
employees.emp_no = salaries.emp_no)
TO '/Users/peirangxu/Desktop/SQL-challenge/Output_CSV/employee_detail.csv' 
DELIMITER ',' CSV HEADER;
--------------------------------------------------------------------------------------------------------------
--List employees who were hired in 1986
COPY
(SELECT last_name,first_name,hire_date
FROM employees
WHERE hire_date BETWEEN '1986-01-01' AND '1986-12-31')
TO '/Users/peirangxu/Desktop/SQL-challenge/Output_CSV/employee_hired_1986.csv' 
DELIMITER ',' CSV HEADER;
-----------------------------------------------------------------------------------------------------------------------------------
-- List the manager of each department with the following information: 
--department number, department name, the manager's employee number, last name, first name, and start and end employment dates	
COPY
(SELECT departments.dept_no,
	departments.dept_name,
	dept_manager.emp_no,
	employees.last_name,
	employees.first_name,
	dept_manager.from_date,
	dept_manager.to_date
FROM departments
JOIN dept_manager ON 
departments.dept_no = dept_manager.dept_no
JOIN employees ON
dept_manager.emp_no = employees.emp_no)
TO '/Users/peirangxu/Desktop/SQL-challenge/Output_CSV/dept_manager_info.csv' 
DELIMITER ',' CSV HEADER;
-----------------------------------------------------------------------------------------------------------------------------
--List the department of each employee with the following information: employee number, last name, first name, and department name
COPY
(SELECT employees.emp_no,
	employees.last_name,
	employees.first_name,
	departments.dept_name
FROM departments
JOIN dept_emp ON 
	departments.dept_no = dept_emp.dept_no
JOIN employees ON
	dept_emp.emp_no = employees.emp_no)
TO '/Users/peirangxu/Desktop/SQL-challenge/Output_CSV/employee_dept.csv' 
DELIMITER ',' CSV HEADER;
-----------------------------------------------------------------------------------------------------------------------------
--List all employees whose first name is "Hercules" and last names begin with "B."
COPY(
SELECT last_name, first_name
FROM employees
WHERE first_name = 'Hercules' AND last_name like 'B%')
TO '/Users/peirangxu/Desktop/SQL-challenge/Output_CSV/Hercules_B_.csv' 
DELIMITER ',' CSV HEADER;
-----------------------------------------------------------------------------------------------------------------------------
--List all employees in the Sales department, including their employee number, last name, first name, and department name
COPY
(SELECT employees.emp_no,
	employees.last_name,
	employees.first_name,
	departments.dept_name
FROM departments
JOIN dept_emp ON 
	departments.dept_no = dept_emp.dept_no
JOIN employees ON
	dept_emp.emp_no = employees.emp_no
WHERE departments.dept_name = 'Sales')
TO '/Users/peirangxu/Desktop/SQL-challenge/Output_CSV/employee_sales.csv' 
DELIMITER ',' CSV HEADER;
-----------------------------------------------------------------------------------------------------------------------------
--List all employees in the Sales and Development departments, including their employee number, last name, first name, and department name
COPY
(SELECT employees.emp_no,
	employees.last_name,
	employees.first_name,
	departments.dept_name
FROM departments
JOIN dept_emp ON 
	departments.dept_no = dept_emp.dept_no
JOIN employees ON
	dept_emp.emp_no = employees.emp_no
WHERE departments.dept_name = 'Sales' OR departments.dept_name = 'Developments')
TO '/Users/peirangxu/Desktop/SQL-challenge/Output_CSV/employee_sales_development.csv' 
DELIMITER ',' CSV HEADER;
-----------------------------------------------------------------------------------------------------------------------------
--In descending order, list the frequency count of employee last names, i.e., how many employees share each last name
COPY
(SELECT last_name,
	COUNT(last_name)
FROM employees
GROUP BY last_name
ORDER BY count DESC)
TO '/Users/peirangxu/Desktop/SQL-challenge/Output_CSV/last_name_freq.csv' 
DELIMITER ',' CSV HEADER;
-----------------------------------------------------------------------------------------------------------------------------
