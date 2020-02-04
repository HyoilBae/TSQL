USE TSQL;
GO

-- Using a WHERE Clause
SELECT TOP 10 * FROM Sales.Orders
WHERE orderdate > '2008-02-07'
AND shipperid > 2;


-- Variables 
DECLARE @I INT = 0;
SELECT @I;
GO
SET @I = 1;
SELECT @I;

-- Using an expression
SELECT * FROM Sales.Orders
WHERE orderdate = /*'2008-02-05';*/ '2008' + '-' + '02' + '-' + '05';

-- Precedence 
SELECT 2 / 1+1;
SELECT 2 / (1+1);
 
-- Grouping and counting
SELECT * FROM Sales.Orders; 

-- Should all the rows for CustID = 71
SELECT * FROM Sales.Orders
WHERE CustID = 71;

SELECT * FROM Sales.Orders
WHERE CustID = 71
ORDER BY empid;
GO

-- When grouping data need to only return appropriate columns
SELECT * FROM Sales.Orders -- why this doesn't work?
WHERE CustId = 71
GROUP BY EmpId;

SELECT * FROM Sales.Orders -- why this doesn't work?
WHERE CustId = 71
GROUP BY EmpId, YEAR(OrderDate);

SELECT * FROM Sales.Orders -- why this doesn't wokr?
WHERE CustId = 71
GROUP BY EmpId, orderdate;

SELECT COUNT(*) FROM Sales.Orders
WHERE CustId = 71
GROUP BY EmpId;

-- Only show CustID = 71 records
SELECT EmpID, YEAR(OrderDate) as OrderYear FROM Sales.Orders
WHERE CustId = 71
GROUP BY EmpId, YEAR(OrderDate);
GO

SELECT EmpID, YEAR(OrderDate) as OrderYear, COUNT(*) as Number FROM Sales.Orders
WHERE CustId = 71
GROUP BY EmpId, YEAR(OrderDate);

SELECT EmpID, OrderDate /*as OrderYear*/, COUNT(*) as Number FROM Sales.Orders
WHERE CustId = 71
GROUP BY EmpId, OrderDate;


-- Removing rows using HAVING
SELECT EmpID, YEAR(OrderDate) as OrderYear, COUNT(*) as Number FROM Sales.Orders
WHERE CustId = 71
GROUP BY EmpId, YEAR(OrderDate)
HAVING COUNT(*) > 1;

-- Sorting with ORDER BY
-- A set is not ordered unless a SELECT statement has an ORDER BY clause, even if it looks like the 
-- results are ordered
SELECT EmpID, YEAR(OrderDate) as OrderYear, COUNT(*) as Number FROM Sales.Orders
WHERE CustId = 71
GROUP BY EmpId, YEAR(OrderDate)
HAVING COUNT(*) > 1
ORDER BY EmpId, YEAR(OrderDate);





