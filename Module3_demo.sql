USE TSQL;

-- Create test table to show table or column name can have a space
-- Use brackets or double quotes as a delimitor
CREATE TABLE dbo.[My Table] ([My Column] int);
GO
INSERT INTO dbo."My Table" values (1);
GO

SELECT "My Column" FROM dbo."My Table";
GO
SELECT [My Column] FROM dbo.[My Table];
-- Clean up 
DROP TABLE dbo.[My Table];

--  Find a list of different orderdates
SELECT orderdate from Sales.Orders;
SELECT DISTINCT orderdate FROM Sales.Orders;

-- Using Group BY HAVING clause
SELECT orderdate FROM Sales.Orders
GROUP BY orderdate

SELECT orderdate FROM Sales.Orders --you can't use HAVING without GROUP BY
HAVING orderdate > '2008-01-01';

SELECT orderdate FROM Sales.Orders
GROUP BY orderdate
HAVING orderdate > '2008-01-01';

SELECT orderdate FROM Sales.Orders
GROUP BY orderdate
HAVING orderdate > YEAR(2008-01-01); --????

-- Column and table alias
SELECT OD.orderdate as OrdDate FROM Sales.Orders AS OD;

-- Alias Issues
SELECT orderid, unitprice, qty AS quantity
FROM Sales.OrderDetails
WHERE quantity > 10; 

SELECT orderid, unitprice, qty AS quantity
FROM Sales.OrderDetails
WHERE qty > 10; 

SELECT orderid, unitprice, qty AS quantity
FROM Sales.OrderDetails
WHERE qty> 10
ORDER BY quantity; 

-- Case Statement
SELECT productid, productname, categoryid
FROM Production.Products;

-- Simple CASE
SELECT productid, productname, categoryid,
        CASE categoryid
	WHEN 1 THEN 'Beverages'
	WHEN 2 THEN 'Condiments'
	WHEN 3 THEN 'Confections'
	ELSE 'Unknown Category'
       END AS categoryname
FROM Production.Products;

-- Searched CASE
SELECT productid, productname, categoryid,
    CASE  
	WHEN categoryid = 1 THEN 'Beverages'
	WHEN categoryid = 2 THEN 'Condiments'
	WHEN categoryid = 3 THEN 'Confections'
	ELSE 'Unknown Category'
       END AS categoryname
FROM Production.Products;

 




 