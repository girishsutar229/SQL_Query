--ASSIGNMENT-3 

--Create the two table
CREATE TABLE Department(
dept_id INT Primary Key NOT NULL,
dept_name  VARCHAR(55)
);

CREATE TABLE Employee(
emp_id INT Primary Key NOT NULL,
dept_id INT Foreign Key References Department(dept_id),
mngr_id INT  NULL,
emp_name VARCHAR(55) NOT NULL,
salary  MONEY NOT NULL
);

--Insert the values in table
INSERT INTO Department (dept_id, dept_name)
VALUES
(1, 'Sales'),
(2, 'Marketing'),
(3, 'IT'),
(4, 'Finance'),
(5, 'Human Resources'),
(6, 'Research & Development'),
(7, 'Operations'),
(8, 'Customer Service');


INSERT INTO Employee (emp_id, dept_id, mngr_id, emp_name, salary)
VALUES
(101, 1, NULL, 'Alice', 50000),
(102, 2, 101, 'Bob', 45000),
(103, 1, NULL, 'Charlie', 60000),
(104, 3, 103, 'David', 70000),
(105, 2, 102, 'Emily', 55000),
(106, 3, 105, 'Frank', 65000),
(107, 4, 104, 'Grace', 80000),
(108, 1, NULL, 'Henry', 52000);

--solve the assignment-3 examples
--1. write a SQL query to find Employees who have the biggest salary in their Department

SELECT d.dept_name, e.emp_name,  e.salary
FROM Employee e
INNER JOIN Department d ON e.dept_id = d.dept_id
WHERE e.salary = (
    SELECT MAX(salary) FROM Employee e2
    WHERE e2.dept_id = e.dept_id
    GROUP BY e2.dept_id
);

--2. write a SQL query to find Departments that have less than 3 people in it
SELECT d.dept_name FROM Department d
LEFT JOIN Employee e ON d.dept_id = e.dept_id
GROUP BY  d.dept_name
HAVING COUNT(e.emp_id) < 3;


--3. write a SQL query to find All Department along with the number of people there
SELECT d.dept_name, COUNT(d.dept_id)AS Number_Of_People  FROM  Department d 
LEFT JOIN Employee e ON d.dept_id=e.dept_id
GROUP BY dept_name,d.dept_id

 
--4. write a SQL query to find All Department along with the total salary there
SELECT d.dept_name,d.dept_id, SUM(e.salary) AS Dept_Total_Salary  FROM Department d 
LEFT JOIN Employee e ON d.dept_id=e.dept_id
GROUP BY dept_name  ,d.dept_id