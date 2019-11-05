--------------------------------------------------------------------------------------------------------------
--List the following details of each employee: employee number, last name, first name, gender, and salary
DROP TABLE IF EXISTS employee_detail;

CREATE TABLE employee_detail AS
SELECT employees.emp_no,
	employees.last_name,
	employees.first_name,
	employees.gender,
	salaries.salary
FROM employees
JOIN salaries ON
employees.emp_no = salaries.emp_no;

COPY employee_detail TO '/Users/peirangxu/Desktop/SQL-challenge/Output/employee_detail.csv' 
DELIMITER ',' CSV HEADER;
--------------------------------------------------------------------------------------------------------------
--List employees who were hired in 1986
DROP TABLE IF EXISTS employee_hired_1986;

CREATE TABLE employee_hired_1986 AS
SELECT last_name,first_name,hire_date
FROM employees
WHERE hire_date BETWEEN '1986-01-01' AND '1986-12-31';

COPY employee_hired_1986 TO '/Users/peirangxu/Desktop/SQL-challenge/Output/employee_hired_1986.csv' 
DELIMITER ',' CSV HEADER;
-----------------------------------------------------------------------------------------------------------------------------------
-- List the manager of each department with the following information: 
--department number, department name, the manager's employee number, last name, first name, and start and end employment dates	
DROP TABLE IF EXISTS dept_manager_info;

CREATE TABLE dept_manager_info AS
SELECT departments.dept_no,
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
dept_manager.emp_no = employees.emp_no;

COPY dept_manager_info TO '/Users/peirangxu/Desktop/SQL-challenge/Output/dept_manager_info.csv' 
DELIMITER ',' CSV HEADER;
-----------------------------------------------------------------------------------------------------------------------------
--List the department of each employee with the following information: employee number, last name, first name, and department name
DROP TABLE IF EXISTS employee_dept;

CREATE TABLE employee_dept AS
SELECT employees.emp_no,
	employees.last_name,
	employees.first_name,
	departments.dept_name
FROM departments
JOIN dept_emp ON 
	departments.dept_no = dept_emp.dept_no
JOIN employees ON
	dept_emp.emp_no = employees.emp_no;

COPY employee_dept TO '/Users/peirangxu/Desktop/SQL-challenge/Output/employee_dept.csv' 
DELIMITER ',' CSV HEADER;
-----------------------------------------------------------------------------------------------------------------------------
--List all employees whose first name is "Hercules" and last names begin with "B."
SELECT last_name, first_name
FROM employees
WHERE first_name = 'Hercules' AND last_name like 'B%';

-----------------------------------------------------------------------------------------------------------------------------
--List all employees in the Sales department, including their employee number, last name, first name, and department name
DROP TABLE IF EXISTS employee_sales;

CREATE TABLE employee_sales AS
SELECT employees.emp_no,
	employees.last_name,
	employees.first_name,
	departments.dept_name
FROM departments
JOIN dept_emp ON 
	departments.dept_no = dept_emp.dept_no
JOIN employees ON
	dept_emp.emp_no = employees.emp_no
WHERE departments.dept_name = 'Sales';

COPY employee_sales TO '/Users/peirangxu/Desktop/SQL-challenge/Output/employee_sales.csv' 
DELIMITER ',' CSV HEADER;
-----------------------------------------------------------------------------------------------------------------------------
--List all employees in the Sales and Development departments, including their employee number, last name, first name, and department name
DROP TABLE IF EXISTS employee_sales_development;

CREATE TABLE employee_sales_development AS
SELECT employees.emp_no,
	employees.last_name,
	employees.first_name,
	departments.dept_name
FROM departments
JOIN dept_emp ON 
	departments.dept_no = dept_emp.dept_no
JOIN employees ON
	dept_emp.emp_no = employees.emp_no
WHERE departments.dept_name = 'Sales' OR departments.dept_name = 'Developments';

COPY employee_sales_development TO '/Users/peirangxu/Desktop/SQL-challenge/Output/employee_sales_development.csv' 
DELIMITER ',' CSV HEADER;
-----------------------------------------------------------------------------------------------------------------------------
--In descending order, list the frequency count of employee last names, i.e., how many employees share each last name
DROP TABLE IF EXISTS last_name_freq;

CREATE TABLE last_name_freq AS
SELECT last_name,
	COUNT(last_name)
FROM employees
GROUP BY last_name
ORDER BY count DESC;

COPY last_name_freq TO '/Users/peirangxu/Desktop/SQL-challenge/Output/last_name_freq.csv' 
DELIMITER ',' CSV HEADER;
-----------------------------------------------------------------------------------------------------------------------------