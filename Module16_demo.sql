-- Demo Module 16 
-- 
-- Syntax error that continues on
SELECT 'This line is fine';
SELECT 1/0; -- divide by zero is a runtime error
SELECT 'Another ok line';
GO

-- Syntax error that does not continue on
DECLARE @I INT = 1;
SELECT 'This line is fine';
SELECT 'This line gets an error' + @I -- syntax error on this line
SELECT 'Another ok line';
GO
-- Declare variable
DECLARE @I int = 1; 
SELECT @I;
GO
-- @I is now out of scope because this is a new batch
SELECT @I;
GO

-- Assigning variable value
-- Default when variable declared
DECLARE @I int = 1;
SELECT @I;
-- Using A SET statement 
SET @I = 2;
SELECT @I;
-- Using a SELECT statement 
SELECT TOP 1 @I = orderid from TSQL.Sales.Orders;
SELECT @I
GO

-- If multiple values are returned the variable is set to the last 
-- one returned: 
SELECT OrderID FROM TSQL.Sales.Orders
ORDER BY OrderID ASC;
GO
DECLARE @I INT;
SELECT @I = OrderID FROM TSQL.Sales.Orders
ORDER BY OrderID ASC;
SELECT @I;
GO


-- IF then else
IF 1 = 1 
  SELECT 'Equal';
ELSE 
  SELECT 'Not Equal';
GO
IF 1 = 2
  SELECT 'Equal';
ELSE 
  SELECT 'Not Equal';
GO

-- if you want to execute more that a single statement 
-- use begin and end 
IF 1 = 1
BEGIN 
 SELECT 'One is';
 SELECT 'Equal to';
 SELECT 'One';
END
ELSE
BEGIN
 SELECT 'One is';
 SELECT 'Not Equal to';
 SELECT 'One';
END
GO

-- While loop 
DECLARE @I int = 0;
WHILE @I < 10 -- execute while expression is equal to 10
BEGIN 
	SELECT @I;
	SET @I += 1;
END 
GO
