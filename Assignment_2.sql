--Assignment 2 create the three table salesman,order,customer
CREATE TABLE salesman(
salesman_id INT primary key,
[name] varchar(20) not null,
city varchar(20) not null,
commission INT not null
)
 
CREATE TABLE customer (
customer_id INT Primary Key NOT NULL,
cust_name VARCHAR(25) NOT NULL,
city VARCHAR(25) NOT NULL,
grade INT NOT NULL,
salesman_id INT  Foreign Key REFERENCES salesman(salesman_id) ON DELETE SET NULL
)

CREATE TABLE [order](
ord_num INT Primary key NOT NULL,
purch_amt INT NOT NULL,
ord_date DATE NOT NULL,
customer_id INT Foreign Key REFERENCES customer(customer_id) ON DELETE SET NULL,
salesman_id INT Foreign Key REFERENCES salesman(salesman_id) ON DELETE SET NULL
)

--Assignment 2 insert the data in three table
--salesman data insert
INSERT INTO salesman(salesman_id,[name],city,commission) 
VALUES (11,'Pranav','Karwar',200),(24,'Prasanna','Bengalore',300),(15,'Prokta','Mysore',200.2),
(39,'Lauson Hen','Kodagu',100), (40,'Prajwal','Kodagu',100)

--Customer data insert
INSERT INTO customer(customer_id,cust_name,city,grade,salesman_id) 
VALUES (101,'Bhargav','Mysore',1,15),(206,'Ramya','Bengalore',3,24),(225,'Rajesh','Hubli',2,39),
(324,'Ravi','Mangalore',5,11),(456,'Rajdeep','Belagavi',3,15),(501,'Raghu','Dharavad',4,39),
(300,'Bhavya','Bengalore',1,15)

--order data insert
INSERT INTO [order] (ord_num,purch_amt,ord_date,customer_id,salesman_id) 
VALUES (5,10000,CAST(N'2020-03-25'AS DATETIME),101,11),(10,5000,CAST(N'2020-03-25'AS DATETIME),456,15),
(7,9500,CAST(N'2020-04-30'AS DATETIME),225,40),(11,8700,CAST(N'2020-07-07'AS DATETIME),324,24),
(17,1500,CAST(N'2020-07-07'AS DATETIME),206,39)


--WRITE THE QUERY OF ASSIGNMENT-2 EXAMPLE

--1. write a SQL query to find the salesperson and customer who reside in the same city. Return Salesman, cust_name and city
SELECT salesman.[name] AS Salesman, customer.cust_name, customer.city  FROM salesman
JOIN customer
ON salesman.city = customer.city

--2. write a SQL query to find those orders where the order amount exists between 500 and 2000. Return ord_no, purch_amt, cust_name, city
SELECT [order].ord_num ,[order].purch_amt,customer.cust_name,customer.city FROM [order]
JOIN customer 
ON  [order].customer_id = customer.customer_id
WHERE [order].purch_amt BETWEEN 500 AND 2000 

--3. write a SQL query to find the salesperson(s) and the customer(s) he represents. Return Customer Name, city, Salesman, commission
SELECT customer.cust_name, customer.city, salesman.[name], salesman.commission FROM salesman
JOIN customer 
ON salesman.salesman_id = customer.salesman_id;


--4. write a SQL query to find salespeople who received commissions of more than 12 percent from the company. Return Customer Name,
--customer city, Salesman, commission.
SELECT c.cust_name AS Customer_Name, c.city AS Customer_City, s.name AS Salesman, s.commission FROM customer c
JOIN salesman s 
ON c.salesman_id = s.salesman_id
WHERE s.commission > 0.12;

--5. write a SQL query to locate those salespeople who do not live in the same city where their customers live and have received a 
--commission of more than 12% from the company. Return Customer Name, customer city, Salesman, salesman city, commission
SELECT c.cust_name AS Customer_Name, c.city AS Customer_City, s.name AS Salesman, s.city AS salesman_city, s.commission FROM customer c
JOIN salesman s 
ON c.salesman_id = s.salesman_id
WHERE s.commission > 0.12 AND s.city <> c.city

--6. write a SQL query to find the details of an order. Return ord_no, ord_date, purch_amt, Customer Name, grade, Salesman, commission
SELECT o.ord_num, o.ord_date, o.purch_amt, c.cust_name, c.grade, s.[name] AS Salesman, s.commission FROM [order] o
JOIN customer c ON o.customer_id = c.customer_id
JOIN salesman s ON o.salesman_id = s.salesman_id;

--7. Write a SQL statement to join the tables salesman, customer and orders so that the same column of each table appears once and 
--only the relational rows are returned.
SELECT s.salesman_id, s.[name] AS salesman_name, s.city AS salesman_city , s.commission, c.customer_id,
 c.cust_name AS customer_name, c.city AS customer_city, c.grade, o.ord_num, o.purch_amt, o.ord_date FROM salesman s
JOIN customer c ON s.salesman_id = c.salesman_id
JOIN [order] o ON c.customer_id = o.customer_id
ORDER BY s.salesman_id, c.customer_id, o.ord_num ;

--8. write a SQL query to display the customer name, customer city, grade, salesman, salesman city. The results should be sorted by ascending customer_id.
SELECT c.cust_name, c.city, c.grade, s.name AS salesman, s.city AS salesman_city
FROM customer c
JOIN salesman s on c.salesman_id = s.salesman_id
ORDER BY c.customer_id ASC

--9. write a SQL query to find those customers with a grade less than 300. Return cust_name, customer city, grade, Salesman, salesmancity. 
--The result should be ordered by ascending customer_id. 
SELECT c.cust_name, c.city AS customer_city, c.grade, s.name AS Salesman, s.city AS salesman_city
FROM customer c 
JOIN salesman s on c.salesman_id = s.salesman_id
WHERE c.grade < 300
ORDER BY c.customer_id ASC

--10. Write a SQL statement to make a report with customer name, city, order number, order date, and order amount in ascending order according to
--the order date to determine whether any of the existing customers have placed an order or not
SELECT  c.cust_name AS Customer_Name, c.city AS Customer_City, o.ord_num AS Order_Number, o.ord_date AS Order_Date, o.purch_amt AS Order_Amount
FROM customer c
LEFT JOIN [order] o ON c.customer_id = o.customer_id
ORDER BY  o.ord_date ASC;

--11. Write a SQL statement to generate a report with customer name, city, order number, order date, order amount, salesperson name, and 
--commission to determine if any of the existing customers have not placed order or if they have placed orders through their salesman or by themselves
SELECT c.cust_name AS Customer_Name, c.city AS Customer_City, o.ord_num AS Order_Number, o.ord_date AS Order_Date, o.purch_amt AS Order_Amount, s.name AS Salesperson_Name, s.commission AS Salesperson_Commission
FROM customer c
LEFT JOIN [order] o ON c.customer_id = o.customer_id
LEFT JOIN salesman s ON c.salesman_id = s.salesman_id
ORDER BY c.cust_name, o.ord_num;

--12. Write a SQL statement to generate a list in ascending order of salespersons who work either for one or more customers or 
--have not yet joined any of the customers
SELECT s.name AS Salesperson_Name, s.salesman_id  ,COUNT(s.name) AS Total
FROM salesman s
LEFT JOIN customer c ON s.salesman_id = c.salesman_id
GROUP BY s.name, s.salesman_id
ORDER BY COUNT(c.customer_id) ASC;

--13. write a SQL query to list all salespersons along with customer name, city, grade, order number, date, and amount.
SELECT s.[name] AS Salesperson_Name, c.cust_name AS Customer_Name, c.city AS Customer_City, c.grade, o.ord_num AS Order_Number, o.ord_date AS Order_Date, o.purch_amt AS Order_Amount
FROM salesman s
JOIN customer c ON s.salesman_id = c.salesman_id
JOIN [order] o ON c.customer_id = o.customer_id
ORDER BY s.name, c.cust_name, o.ord_num;

--14. Write a SQL statement to make a list for the salesmen who either work for one or more customers or yet to join any of the customers.The customer may 
--have placed, either one or more order on or above order amount 2000 and must have a grade, or he may not have placed any order to the associated supplier.

SELECT s.salesman_id, s.name AS Salesman_Name, s.city AS Salesman_City, s.commission,o.purch_amt as order_amount
FROM salesman s
LEFT JOIN customer c ON s.salesman_id = c.salesman_id
LEFT JOIN [order] o ON c.customer_id = o.customer_id
WHERE (o.purch_amt >= 2000 AND c.grade IS NOT NULL) OR o.customer_id IS NULL;



--15. Write a SQL statement to generate a list of all the salesmen who either work for one or more customers or have yet to join any of them.The customer may
-- have placed one or more orders at or above order amount 2000, and must have a grade, or he may not have placed any orders to the associated supplier.
SELECT s.name AS "Salesman"
FROM salesman s
LEFT JOIN customer c ON s.salesman_id = c.salesman_id
LEFT JOIN [order] o ON c.customer_id = o.customer_id
WHERE (o.purch_amt >= 2000 AND c.grade IS NOT NULL) OR o.purch_amt IS NULL;

--16. Write a SQL statement to generate a report with the customer name, city, order no. order date, purchase amount for only those customerson the list 
--who must have a grade and placed one or more orders or which order(s) have been placed by the customer who neither is on the list nor has a grade.
SELECT c.cust_name AS Customer_Name, c.city AS Customer_City, o.ord_num AS Order_Number, o.ord_date AS Order_Date,
o.purch_amt AS Purchase_Amount FROM customer c
LEFT JOIN [order] o ON c.customer_id = o.customer_id
WHERE (c.grade IS NOT NULL AND o.ord_num IS NOT NULL) OR (c.grade IS NULL AND o.ord_num IS NOT NULL)
ORDER BY c.cust_name, o.ord_num;

--17. Write a SQL query to combine each row of the salesman table with each row of the customer table
SELECT s.salesman_id, s.name AS Salesman_Name, s.city AS Salesman_City, s.commission, c.customer_id, c.cust_name AS Customer_Name, 
c.city AS Customer_City,c.grade FROM salesman s
INNER JOIN customer c ON s.salesman_id = c.salesman_id;


--18. Write a SQL statement to create a Cartesian product between salesperson and customer, i.e. each salesperson will appear for all customers and
--vice versa for that salesperson who belongs to that city
SELECT s.salesman_id, s.name AS Salesperson_Name, s.city AS Salesperson_City, s.commission, c.customer_id, c.cust_name AS Customer_Name, 
c.city AS Customer_City, c.grade FROM salesman s
CROSS JOIN customer c
WHERE s.city = c.city;

--19. Write a SQL statement to create a Cartesian product between salesperson and customer, i.e. each salesperson will appear for every customer and
--vice versa for those salesmen who belong to a city and customers who require a grade
SELECT s.salesman_id, s.name AS Salesperson_Name, s.city AS Salesperson_City, s.commission, c.customer_id, c.cust_name AS Customer_Name, 
c.city AS Customer_City, c.grade FROM salesman s
CROSS JOIN customer c
WHERE (s.city = c.city) AND (c.grade IS NOT NULL);

--20. Write a SQL statement to make a Cartesian product between salesman and customer i.e. each salesman will appear for all customers and
--vice versa for those salesmen who must belong to a city which is not the same as his customer and the customers should have their own grade
SELECT s.salesman_id, s.name AS Salesperson_Name, s.city AS Salesperson_City, s.commission,  c.customer_id, c.cust_name AS Customer_Name, 
c.city AS Customer_City, c.grade FROM salesman s
CROSS JOIN customer c
WHERE (s.city <> c.city) AND (c.grade IS NOT NULL);


