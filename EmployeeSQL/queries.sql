--List the following details of each employee: employee number, last name, first name, gender, and salary
COPY
(SELECT employees.emp_no,
	employees.last_name,
	employees.first_name,
	employees.gender,
	salaries.salary
FROM employees
JOIN salaries ON
employees.emp_no = salaries.emp_no
ORDER BY employees.emp_no)
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
	dept_emp.emp_no = employees.emp_no
ORDER BY employees.emp_no)
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
