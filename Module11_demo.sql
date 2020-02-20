-- Module 11 Table Expressions
USE TSQL;
GO
-- Create a view to join orders and orderdetails

-- code that joins table
SELECT O.orderid,O.custid,OD.productid, OD.unitprice, OD.qty, OD.discount FROM Sales.Orders AS O
         JOIN Sales.OrderDetails OD
		 ON O.orderid = OD.orderid;
GO
 
-- CREATE View
CREATE VIEW OrderProductInfo AS 
SELECT O.orderid,O.custid,OD.productid, OD.unitprice, OD.qty, OD.discount FROM Sales.Orders AS O
         JOIN Sales.OrderDetails OD
		 ON O.orderid = OD.orderid;
GO
-- Use View 
SELECT * FROM OrderProductInfo;
GO
SELECT * From OrderProductInfo WHERE OrderID > 11000;
GO
-- Creating a TVF
CREATE FUNCTION CustOrders (@custid as int )
RETURNS TABLE
AS 
RETURN
SELECT O.orderid,O.custid,OD.productid, OD.unitprice, OD.qty, OD.discount FROM Sales.Orders AS O
         JOIN Sales.OrderDetails OD
		 ON O.orderid = OD.orderid
WHERE O.custid = @custid;
GO
-- Call TVF
SELECT * FROM CustOrders(85);
GO
-- multi-statemet Table Value function
-- Creating a TVF
CREATE FUNCTION CustOrders_MV (@custid as int )
RETURNS @Results TABLE 
(orderid int, Custid int, productid int)
AS 
BEGIN
INSERT into @Results
SELECT O.orderid,O.custid,OD.productid  FROM Sales.Orders AS O
         JOIN Sales.OrderDetails OD
		 ON O.orderid = OD.orderid
WHERE O.custid = @custid;
UPDATE @Results
	SET productid = 99999;
RETURN 
END
GO
-- Call Multi-Statement TVF
SELECT * FROM CustOrders_MV(85);
GO
 
-- using derived table PT
SELECT PT.orderid, PT.productid, PT.ProductSalesTotal FROM 
 (SELECT O.orderid, OD.productid, OD.unitprice * OD.qty AS ProductSalesTotal 
  FROM Sales.Orders O JOIN Sales.OrderDetails OD ON O.orderid = OD.orderid) PT;

-- Passing parameters to derived tables
DECLARE @orderid int = 10250;
SELECT PT.orderid, PT.productid, PT.ProductSalesTotal FROM 
 (SELECT O.orderid, OD.productid, OD.unitprice * OD.qty AS ProductSalesTotal 
  FROM Sales.Orders O JOIN Sales.OrderDetails OD ON O.orderid = OD.orderid
  WHERE O.orderid = 10250 @orderid) PT;

-- Using a CTE
-- Find the number of products ordered by customers
WITH CTE_CustProductInfo --name the CTE
AS 
(
	SELECT O.custid, OD.productid, OD.Qty 
	FROM Sales.Orders AS O JOIN Sales.OrderDetails AS OD
	ON O.orderid = OD.orderid
 
)
SELECT custid, productid, SUM(qty) as TotalOrders
FROM CTE_CustProductInfo
GROUP BY custid, productid
ORDER BY custid, productID;

-- Using Derived table instead of CTE  
SELECT custid, productid, SUM(qty) as TotalOrders
FROM(	SELECT O.custid, OD.productid, OD.Qty 
	FROM Sales.Orders AS O JOIN Sales.OrderDetails AS OD
	ON O.orderid = OD.orderid) as WithoutCTE
GROUP BY custid, productid
ORDER BY custid, productID;


--Note cannot use CTE for Second SELECT
WITH CTE_CustProductInfo --name the CTE
AS 
(
	SELECT O.custid, OD.productid, OD.Qty 
	FROM Sales.Orders AS O JOIN Sales.OrderDetails AS OD
	ON O.orderid = OD.orderid
 
)
SELECT custid, productid, SUM(qty) as TotalOrders
FROM CTE_CustProductInfo
GROUP BY custid, productid
ORDER BY custid, productID;

SELECT custid, productid, SUM(qty) as TotalOrders
FROM CTE_CustProductInfo
GROUP BY custid, productid
ORDER BY custid, productID;


-- clean up 
DROP VIEW OrderProductInfo;
DROP FUNCTION CustOrders;
DROP FUNCTION CustOrders_MV;






 
  