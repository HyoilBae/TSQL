-- Module 14 demo
USE TSQL;
go
-- Pivoting data on Category and display orderyear as different columns 
-- review the row data first:

SELECT  C.categoryname, SUM(od.qty), YEAR(O.orderdate) AS OrderYear
FROM Sales.Orders O 
JOIN Sales.OrderDetails AS OD
ON O.orderid = OD.orderid
JOIN Production.Products P
ON OD.productid = P.productid
JOIN Production.Categories C
ON P.categoryid = C.categoryid
GROUP BY C.categoryname, YEAR(O.orderdate);
 
-- turn row oriented data into column oriented data 
SELECT  categoryname, [2006],[2007],[2008]
FROM  ( SELECT  C.categoryname, SUM(od.qty) as qty, YEAR(O.orderdate) AS OrderYear
FROM Sales.Orders O 
JOIN Sales.OrderDetails AS OD
ON O.orderid = OD.orderid
JOIN Production.Products P
ON OD.productid = P.productid
JOIN Production.Categories C
ON P.categoryid = C.categoryid
GROUP BY C.categoryname, YEAR(O.orderdate)) AS D 
PIVOT(SUM(qty) FOR orderyear IN ([2006],[2007],[2008])) AS pvt;

-- Create column oriented data in table
SELECT * INTO #T FROM (
SELECT  categoryname, [2006],[2007],[2008]
FROM  ( SELECT  C.categoryname, SUM(od.qty) as qty, YEAR(O.orderdate) AS OrderYear
FROM Sales.Orders O 
JOIN Sales.OrderDetails AS OD
ON O.orderid = OD.orderid
JOIN Production.Products P
ON OD.productid = P.productid
JOIN Production.Categories C
ON P.categoryid = C.categoryid
GROUP BY C.categoryname, YEAR(O.orderdate)) AS D 
PIVOT(SUM(qty) FOR orderyear IN ([2006],[2007],[2008])) AS pvt) A;

-- Review table 
SELECT * FROM #T;

-- UNPIVOT to turn column oriented data in to row oriented data
SELECT categoryname, qty, orderyear
FROM #T
UNPIVOT(qty FOR orderyear IN([2008],[2007],[2006])) AS unpvt;

-- Could have come from the actual data via a PIVOT command
SELECT categoryname, qty, orderyear
FROM 
(
SELECT  categoryname, [2006],[2007],[2008]
FROM  ( SELECT  C.categoryname, SUM(od.qty) as qty, YEAR(O.orderdate) AS OrderYear
FROM Sales.Orders O 
JOIN Sales.OrderDetails AS OD
ON O.orderid = OD.orderid
JOIN Production.Products P
ON OD.productid = P.productid
JOIN Production.Categories C
ON P.categoryid = C.categoryid
GROUP BY C.categoryname, YEAR(O.orderdate)) AS D 
PIVOT(SUM(qty) FOR orderyear IN ([2006],[2007],[2008])) AS pvt) AS A
UNPIVOT(qty FOR orderyear IN([2006],[2007],[2008])) AS unpvt;

-- Do not need to specify all order years
SELECT categoryname, qty, orderyear
FROM #T
UNPIVOT(qty FOR orderyear IN([2006])) AS unpvt;

-- Using no aggragation
CREATE TABLE #y (Categoryname varchar(10),qty int, orderyear int)
INSERT INTO #y values 
('Beverage',1,2006),
('Beverage',4,2007),
('Beverage',5,2008),
('Condiments',1,2006),
('Condiments',2,2007),
('Condiments',3,2008);

SELECT Categoryname, [2006],[2007],[2008]
FROM (SELECT Categoryname,qty, orderyear FROM #Y)  AS D 
PIVOT(avg(D.qty) FOR orderyear IN ([2006],[2007],[2008])) AS pvt;   
  
-- Using GROUPING SETS
SELECT O.orderid,O.custid, SUM(Qty) AS TotalQty
FROM Sales.Orders O
JOIN Sales.OrderDetails OD
ON O.OrderID = OD.OrderID
GROUP BY GROUPING SETS(O.orderid,O.custid,())
ORDER BY O.orderid, O.custid;

SELECT O.orderid,O.custid, SUM(Qty) AS TotalQty
FROM Sales.Orders O
JOIN Sales.OrderDetails OD
ON O.OrderID = OD.OrderID
GROUP BY GROUPING SETS(O.orderid,O.custid)
ORDER BY O.orderid, O.custid;


-- Replacing Nulls with something meaningfull, plus adding a grouping for the entire set
SELECT IIF (O.orderid is NULL 
         AND O.custid IS NULL, '', 
		     IIF (O.orderid is Null, 'custid subtotal', CAST(O.orderid as VARCHAR(15)))) AS orderid, 
	   IIF(O.orderid is NULL 
         AND O.custid IS NULL, 'Grand Total', 
		     IIF (O.custid is NULL, 'orderid subtotal', CAST(O.custid AS VARCHAR(16)))) AS custid, 
		 SUM(Qty) AS TotalQty
FROM Sales.Orders O
JOIN Sales.OrderDetails OD
ON O.OrderID = OD.OrderID
GROUP BY GROUPING SETS(O.orderid,O.custid,())
ORDER BY O.orderid, O.custid;

-- Using CUBE to calculate all possible values.
SELECT O.orderid,O.custid, SUM(Qty) AS TotalQty
FROM Sales.Orders O
JOIN Sales.OrderDetails OD
ON O.OrderID = OD.OrderID
GROUP BY CUBE(O.orderid,O.custid)
ORDER BY O.orderid, O.custid;

-- Using Rollup orders by productid
SELECT O.orderid,OD.productid, SUM(Qty) AS TotalQty
FROM Sales.Orders O
JOIN Sales.OrderDetails OD
ON O.OrderID = OD.OrderID
GROUP BY ROLLUP(O.orderid,OD.productid);


-- Grouping Set with NULL
SELECT O.orderid,O.custid, SUM(Qty) AS TotalQty
FROM Sales.Orders O
JOIN Sales.OrderDetails OD
ON O.OrderID = OD.OrderID
GROUP BY GROUPING SETS(O.orderid,O.custid, ())
ORDER BY O.orderid, O.custid;
 
-- Using GROUPING_ID
SELECT GROUPING_ID (O.orderid), GROUPING_ID(O.custid),
       O.orderid,O.custid, SUM(Qty) AS TotalQty
FROM Sales.Orders O
JOIN Sales.OrderDetails OD
ON O.OrderID = OD.OrderID
GROUP BY GROUPING SETS(O.orderid,O.custid,())
ORDER BY O.orderid, O.custid;

-- CLEAN UP 
DROP TABLE #T;

 

