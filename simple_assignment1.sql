--Write a query to get a Product list (id, name, unit price) where current products cost less than $20.SELECT  ProductID,ProductName,UnitPrice FROM Products 
WHERE UnitPrice<20

--Write a query to get Product list (id, name, unit price) where products cost between $15 and $25

SELECT ProductID,ProductName,UnitPrice FROM Products
WHERE UnitPrice BETWEEN 15 AND 25

--Write a query to get Product list (name, unit price) of above average price

SELECT ProductID,ProductName,UnitPrice FROM Products
WHERE UnitPrice>(SELECT AVG(UnitPrice) FROM Products) 
ORDER BY UnitPrice DESC

--Write a query to get Product list (name, unit price) of ten most expensive products
SELECT TOP 10  ProductID,ProductName,UnitPrice FROM Products
ORDER BY UnitPrice DESC 

--Write a query to count current and discontinued products
SELECT COUNT(ProductName) AS TyepsOfProducts FROM Products
GROUP BY discontinued


--Write a query to get Product list (name, units on order , units in stock) of stock is less  than the quantity on order
SELECT ProductName,UnitsInStock,UnitsOnOrder FROM Products
WHERE  UnitsInStock < UnitsOnOrder