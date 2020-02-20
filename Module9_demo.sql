USE TSQL;
GO 

CREATE TABLE T (I INT IDENTITY(1,1), N int, C INT);

INSERT INTO T 
VALUES (1,4),(1,null),(2,4), (3,4);

SELECT * FROM T;

SELECT I FROM T ORDER BY I;

SELECT AVG(C) FROM T;
SELECT AVG(ISNULL(C,0)) FROM T;

SELECT SUM(C) FROM T;

SELECT COUNT(*) FROM T;

SELECT COUNT(*),COUNT(C) FROM T;

SELECT I, AVG(C),COUNT(*),COUNT(C) FROM T 
GROUP BY I;

SELECT N, AVG(C),SUM(C), COUNT(*), SUM(C)/COUNT(*),SUM(C)*1.0/COUNT(*) FROM T 
GROUP BY N;

 

DROP TABLE T;


-- Using DISTINCT in COUNT Function to remove duplicates prior 
-- to counting
SELECT COUNT(custid), COUNT(DISTINCT custid) 
FROM Sales.Orders;


-- Missing columns in SELECT clause gets errors
SELECT empid, orderdate, COUNT(*) AS cnt
FROM Sales.Orders
GROUP BY empid;

-- fix must either add orderdate to the group by clause 
-- or the orderdate need to be used in aggragate function
SELECT empid, orderdate, COUNT(*) AS cnt
FROM Sales.Orders
GROUP BY empid, orderdate;

-- Show the number orders by Customer per order date
SELECT custid, orderdate, COUNT(*) AS cnt
FROM Sales.Orders
GROUP BY custid, orderdate
ORDER BY custid;
 

-- Using HAVING clause to return those customers that have more than 1 order in a given date
SELECT custid, orderdate, COUNT(*) AS cnt
FROM Sales.Orders
GROUP BY custid, orderdate
HAVING COUNT(*) > 1;
GO

SELECT empid, YEAR(orderdate)
FROM Sales.Orders
WHERE custid = 71
GROUP BY empid, YEAR(orderdate)
ORDER BY empid ASC, YEAR(orderdate);

SELECT empid, YEAR(orderdate)
FROM Sales.Orders
WHERE custid = 71
GROUP BY empid, YEAR(orderdate)
ORDER BY empid ASC;

SELECT empid, YEAR(orderdate)
FROM Sales.Orders
WHERE custid = 71
GROUP BY empid, YEAR(orderdate)
HAVING COUNT(YEAR(orderdate)) > 1
ORDER BY empid ASC, YEAR(orderdate);

SELECT empid, YEAR(orderdate)
FROM Sales.Orders
WHERE custid = 71
GROUP BY empid, YEAR(orderdate)
--HAVING COUNT(YEAR(orderdate)) > 1
ORDER BY empid ASC;



--SELECT p.ProductName, COUNT(*) AS OrderCount
--FROM Sales.Products AS p
--JOIN Sales.OrderItems AS o
--ON p.ProductID = o.ProductID
--GROUP BY p.ProductName;


