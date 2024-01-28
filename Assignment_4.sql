--1. Create a stored procedure in the Northwind database that will calculate the average value of Freight for a specified customer.
--Then, a business rule will be added that will  be triggered before every Update and Insert command in the Orders controller,
--and will use the stored procedure to verify that the Freight does not exceed the average
--freight. If it does, a message will be displayed and the command will be cancelled.

select * from Employees
select * from customers
select * from orders
select * from [Order Details]
select * from Categories
select * from Products

CREATE PROCEDURE spValidateFreight
  @CustomerID NCHAR(5)
AS
BEGIN

 SELECT AVG(Freight)
 FROM Orders
 WHERE CustomerID = @CustomerID GROUP BY CustomerID;

END;
 
EXEC spValidateFreight 'HANAR'



--2. write a SQL query to Create Stored procedure in the Northwind database to retrieve Employee Sales by Country

CREATE PROCEDURE GetEmployeeSalesByCountry
     @country nvarchar(15)
AS
BEGIN
    SELECT E.EmployeeID, E.FirstName  +' '+ E.LastName AS EmployeeName, C.Country,
        SUM(OD.UnitPrice * OD.Quantity * (1 - OD.Discount)) AS TotalSales  
		FROM Employees E
        INNER JOIN Orders O ON E.EmployeeID = O.EmployeeID
        INNER JOIN Customers C ON O.CustomerID = C.CustomerID
        INNER JOIN [Order Details] OD ON O.OrderID = OD.OrderID
		WHERE O.ShipCountry = @country
    GROUP BY E.EmployeeID, E.FirstName, E.LastName, C.Country
    ORDER BY E.EmployeeID, TotalSales DESC;
END;
EXEC GetEmployeeSalesByCountry @country='USA'
GO

--3. write a SQL query to Create Stored procedure in the Northwind database to retrieve Sales by Year
CREATE PROCEDURE GetSalesByYear
    @Year int
AS
BEGIN
    SELECT YEAR(OrderDate) AS OrderYear, SUM(Freight) AS TotalSales
    FROM Orders
    WHERE YEAR(OrderDate) = @Year
    GROUP BY YEAR(OrderDate)
END
EXEC GetSalesByYear @Year=1996;
GO


--4. write a SQL query to Create Stored procedure in the Northwind database to retrieve Sales By Category

CREATE PROCEDURE GetSalesByCategory
   @category int
AS
BEGIN
    SELECT  C.CategoryName, p.CategoryID, 
	SUM(OD.UnitPrice * OD.Quantity * (1 - OD.Discount)) AS TotalSales
    FROM  Categories C
    INNER JOIN Products P ON C.CategoryID = P.CategoryID
    INNER JOIN [Order Details] OD ON P.ProductID = OD.ProductID
	WHERE  p.CategoryID = @category
    GROUP BY C.CategoryName,p.CategoryID
    ORDER BY TotalSales DESC;
END;
EXEC GetSalesByCategory @category= 2;

GO

--5. write a SQL query to Create Stored procedure in the Northwind database to retrieve Ten Most Expensive Products
CREATE PROCEDURE Top10ExpensiveProducts
AS
BEGIN
  SELECT TOP 10 ProductID, ProductName, UnitPrice
  FROM Products
  ORDER BY UnitPrice DESC;
END
EXEC Top10ExpensiveProducts 
GO
    

--6. write a SQL query to Create Stored procedure in the Northwind database to insert  Customer Order Details
CREATE PROCEDURE insertOrderDetails
@OrderID_1 [int],
@ProductID_2 [int],
@UnitPrice_3 [money] = NULL,
@Quantity_4 [smallint],
@Discount_5 [real] = 0
AS
INSERT INTO [Order Details] ( [OrderID], [ProductID], [UnitPrice], [Quantity], [Discount])
VALUES ( @OrderID_1, @ProductID_2, @UnitPrice_3, @Quantity_4, @Discount_5)


EXEC insertOrderDetails @OrderID_1= 10625, @ProductID_2=61, @UnitPrice_3=35, @Quantity_4=10, @Discount_5=0.1
GO


--7. write a SQL query to Create Stored procedure in the Northwind database to update Customer Order Details
CREATE PROCEDURE  UpdateOrderDetails
 @OrderID_1 [int],
 @ProductID_2 [int],
 @NewQuantity_4 [smallint]= NULL,
 @NewUnitPrice_3 [money] = NULL,
 @NewDiscount_5 [real] = NULL
AS

BEGIN

UPDATE [Order Details]
SET [Quantity] = @NewQuantity_4, [UnitPrice] = @NewUnitPrice_3, [Discount] = @NewDiscount_5
WHERE [OrderID] = @OrderID_1 AND [ProductID] =  @ProductID_2
END

EXEC UpdateOrderDetails @OrderID_1=10248 , @ProductID_2=11 ,  @NewQuantity_4 = 13 , @NewUnitPrice_3 =15, @NewDiscount_5 =0.15  
GO