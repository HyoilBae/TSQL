USE TSQL;
GO
-- Inner Join 
SELECT 
* FROM Sales.Orders O 
JOIN 
Sales.OrderDetails OD
on O.orderid = OD.orderid;

SELECT 
* FROM Sales.Orders O 
INNER JOIN 
Sales.OrderDetails OD
on O.orderid = OD.orderid;

-- Multiple Join Criteria
SELECT *
FROM Sales.Customers AS c
JOIN HR.Employees AS e 
ON c.city = e.city AND c.country = e.country;

-- Show all Cities/Countries where Customer and Employee
-- are the same
SELECT DISTINCT e.city, e.country, c.city, c.country
FROM Sales.Customers AS c
JOIN HR.Employees AS e 
ON c.city = e.city AND c.country = e.country;




--Outer Join 
SELECT c.custid, c.companyname, o.orderid, o.orderdate
FROM Sales.Customers AS c
LEFT OUTER JOIN Sales.Orders AS o
ON c.custid =o.custid;

SELECT c.custid, c.companyname, o.orderid, o.orderdate
FROM Sales.Customers AS c
LEFT OUTER JOIN Sales.Orders AS o
ON c.custid =o.custid
WHERE o.orderdate = '2006-07-08 00:00:00.000';

SELECT c.custid, c.companyname, o.orderid, o.orderdate
FROM Sales.Customers AS c
LEFT OUTER JOIN Sales.Orders AS o
ON c.custid =o.custid
AND o.orderdate = '2006-07-08 00:00:00.000';

SELECT c.custid, c.companyname, o.orderid, o.orderdate
FROM Sales.Customers AS c
LEFT OUTER JOIN Sales.Orders AS o
ON c.custid =o.custid
AND o.orderdate = '2006-07-08 00:00:00.000'
WHERE o.orderdate = '2006-07-08 00:00:00.000';

-- Customers that have never placed order 
SELECT c.custid, c.companyname, o.orderid, o.orderdate
FROM Sales.Customers AS c
LEFT OUTER JOIN Sales.Orders AS o
ON c.custid =o.custid
WHERE o.orderid IS NULL;

USE tempdb;
GO
CREATE TABLE A (A int);
INSERT INTO A VALUES (1),(2),(3),(4),(3);
CREATE TABLE B (B int);
INSERT INTO B VALUES (3),(4), (5);

SELECT TOP (3) WITH TIES A FROM A
ORDER BY A;

-- Full JOIN
SELECT * FROM 
A FULL JOIN B
ON A.A = B.B;

-- FULL OUTER JOIN
SELECT * FROM 
A FULL OUTER JOIN B
ON A.A = B.B;

-- CROSS JOIN 
SELECT * FROM 
A CROSS JOIN B;

-- Self Join
SELECT * FROM 
A INNER JOIN A AS A2
ON A.A = A2.A;




-- Cleanup
DROP TABLE A,B;






 





