/*Create the three table */

CREATE TABLE salesman(
salesman_id INT primary key,
[name] varchar(20) not null,
city varchar(20) not null,
commission INT not null
) 
CREATE TABLE customer (
    customer_id INT PRIMARY KEY NOT NULL,
    cust_name VARCHAR(25) NOT NULL,
    city VARCHAR(25) NOT NULL,
    grade INT NOT NULL,
    salesman_id INT,
    FOREIGN KEY (salesman_id) REFERENCES salesman(salesman_id) ON DELETE SET NULL
);
CREATE TABLE `order` (
    ord_no INT PRIMARY KEY NOT NULL,
    purch_amt INT NOT NULL,
    ord_date DATE NOT NULL,
    customer_id INT,
    FOREIGN KEY (customer_id) REFERENCES customer(customer_id) ON DELETE SET NULL,
    salesman_id INT,
    FOREIGN KEY (salesman_id) REFERENCES salesman(salesman_id) ON DELETE SET NULL
);


/* insert the Query  */

INSERT INTO salesman (salesman_id, name, city, commission)
VALUES  (11, 'Pranav', 'Karwar', 200), 
(24, 'Prasanna', 'Bengaluru', 300), 
(15, 'Prokta', 'Mysore', 200.2), 
(39, 'Lauson Hen', 'Kodagu', 100), 
(40, 'Prajwal', 'Kodagu', 100);

INSERT INTO customer (customer_id,cust_name,city,grade,salesman_id) 
VALUES (101,'Bhargav','Mysore',1,15),
(206,'Ramya','Bengalore',3,24),
(225,'Rajesh','Hubli',2,39),
(324,'Ravi','Mangalore',5,11), 
(456,'Rajdeep','Belagavi',3,15),
(501,'Raghu','Dharavad',4,39),
(300,'Bhavya','Bengalore',1,15),

INSERT INTO [order]  (ord_num,purch_amt,ord_date,customer_id,salesman_id) 
VALUES (5,10000,CAST(N'2020-03-25'AS DATETIME),101,11), 
(10,5000,CAST(N'2020-03-25'AS DATETIME),456,15),
(7,9500,CAST(N'2020-04-30'AS DATETIME),225,40), 
(11,8700,CAST(N'2020-07-07'AS DATETIME),324,24),
(17,1500,CAST(N'2020-07-07'AS DATETIME),206,39)
