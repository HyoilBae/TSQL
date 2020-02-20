-- Module 12 demo 

USE tempdb;
GO 
CREATE TABLE MyTableA (ID int, A CHAR(1));
INSERT INTO	MyTableA VALUES (1, 'A'),(2,NULL),(3,'A');
CREATE TABLE MyTableB (ID int, B CHAR(1));
INSERT INTO	MyTableB VALUES (1,'A'),(2,NULL),(4,'B');

SELECT * FROM MyTableA;
SELECT * FROM MyTableB;

-- union A and B to get rid of dups
SELECT * FROM MyTableA
UNION 
SELECT * FROM MyTableB;

-- setting the column heading
SELECT ID AS C1, A AS C2 FROM MyTableA
UNION 
SELECT * FROM MyTableB;

-- column data types not same
SELECT ID FROM MyTableA
UNION 
SELECT B FROM MyTableB;

-- number of columns different
SELECT ID, A FROM MyTableA
UNION
SELECT ID FROM MyTableB;


-- union A and B
SELECT * FROM MyTableA
UNION 
SELECT * FROM MyTableB;

-- Union all A and B to keep dups
SELECT * FROM MyTableA
UNION ALL 
SELECT * FROM MyTableB;

-- Show performance hit that UNION causes by showing execution plan
SELECT * FROM MyTableA
UNION 
SELECT * FROM MyTableB;

SELECT * FROM MyTableA
UNION ALL 
SELECT * FROM MyTableB;

-- Intersection 
SELECT * FROM MyTableA
INTERSECT
SELECT * FROM MyTableB;


-- Which Customers placed order in 2006 and 2007
SELECT DISTINCT custid From TSQL.Sales.Orders WHERE YEAR(orderdate) = 2006
INTERSECT 
SELECT DISTINCT custid From TSQL.Sales.Orders WHERE YEAR(orderdate) = 2007;

-- IN MyTableA but not in MyTableB
SELECT * FROM MyTableA
EXCEPT
SELECT * FROM MyTableB;

-- Except IN MyTableB but not in MyTableA
SELECT * FROM MyTableB
EXCEPT
SELECT * FROM MyTableA;



-- Which Customers placed orders in 2006 but didn't in 2007
SELECT DISTINCT custid From TSQL.Sales.Orders WHERE YEAR(orderdate) = 2006
EXCEPT
SELECT DISTINCT custid From TSQL.Sales.Orders WHERE YEAR(orderdate) = 2007;

-- Which Customers placed orders in 2007 but didn't in 2006
SELECT DISTINCT custid From TSQL.Sales.Orders WHERE YEAR(orderdate) = 2007
EXCEPT
SELECT DISTINCT custid From TSQL.Sales.Orders WHERE YEAR(orderdate) = 2006;

-- Cross Apply
SELECT * FROM MyTableA;
SELECT * FROM MyTableB;


SELECT * FROM MyTableA
CROSS APPLY 
(SELECT * FROM MyTableB
WHERE MyTableA.ID = MyTableB.ID) AS A;

-- rewritten as join 
SELECT * FROM MyTableA
INNER JOIN MyTableB
ON MyTableA.ID = MyTableB.ID;

-- Outer Apply
SELECT * FROM MyTableA
OUTER  APPLY 
(SELECT * FROM MyTableB
WHERE MyTableA.ID = MyTableB.ID) AS A;

-- Left outer join
SELECT * FROM MyTableA
LEFT OUTER JOIN MyTableB
ON MyTableA.ID = MyTableB.ID;


USE TSQL;
GO
CREATE FUNCTION dbo.CustOrders(@custid int)
RETURNS TABLE 
AS 
RETURN (
SELECT * FROM TSQL.Sales.Orders 
WHERE custid = @custid);
GO
-- APPLY OPERATORS allow the right side to use TVF
-- Show product info for custid 11
SELECT * FROM TSQL.dbo.CustOrders(11);
SELECT * FROM TSQL.Sales.Customers WHERE custid = 11;

-- Show customer 11 orders
SELECT * FROM TSQL.Sales.Customers AS L
CROSS APPLY  TSQL.dbo.CustOrders(L.custid) R
WHERE L.custid = 11;

-- Show all customer that have not submitted orders
SELECT * FROM TSQL.Sales.Customers AS L
OUTER APPLY  TSQL.dbo.CustOrders(L.custid) R
WHERE R.orderid is null

-- Clean up 
DROP TABLE tempdb.dbo.MyTableA,tempdb.dbo.MyTableB;