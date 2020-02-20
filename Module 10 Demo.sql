-- Demo Module 10 
USE TSQL 
GO 

-- Subquery 
SELECT custid, orderid
FROM Sales.orders
WHERE custid IN (
	SELECT custid
	FROM Sales.Customers
	WHERE country =N'Mexico');


-- Written as Join
SELECT c.custid, o.orderid
FROM Sales.Customers AS c JOIN Sales.Orders AS o
	ON c.custid = o.custid
WHERE c.country = N'Mexico';

-- Correlated Subquery	
SELECT orderid, empid, orderdate
FROM Sales.Orders AS O1
WHERE orderdate =
		(SELECT MAX(orderdate)
		 FROM Sales.Orders AS O2  
		 WHERE O2.empid = O1.empid) -- notice alias name from outer query
ORDER BY empid, orderdate;
 

-- Testing for Existance 
SELECT empid, lastname
FROM HR.Employees AS e
WHERE EXISTS(SELECT * 
		FROM Sales.Orders AS O
		WHERE O.empid = e.empid);

-- Test where inner query returns no rows
SELECT empid, lastname
FROM HR.Employees AS e
WHERE EXISTS(SELECT * 
		FROM Sales.Orders AS O
		WHERE O.empid = 10);

 





