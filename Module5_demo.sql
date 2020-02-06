USE TSQL;
GO 
-- Using Default sort order, which is ASC
SELECT [custid],[orderid]
FROM [Sales].[Orders] 
ORDER BY [custid],[orderid];

-- Same as DEFAULT
SELECT [custid],[orderid]
FROM [Sales].[Orders] 
ORDER BY [custid] ASC, [orderid] ASC;

-- Can change sort order by using ASC, or DESC
SELECT [custid],[orderid]
FROM [Sales].[Orders] 
ORDER BY [custid] ASC,[orderid] DESC;

-- Sort by ordinal position'
SELECT [custid],[orderid]
FROM [Sales].[Orders] 
ORDER BY 1 ASC,2 DESC;

-- Column alias can be used because ORDER BY is processed after SELECT clause
SELECT [custid] AS [Customer ID], [orderid] AS [Order ID]
FROM [Sales].[Orders] 
ORDER BY [Customer ID] ASC,[Order ID] DESC;

-- Filtering data using WHERE clause
SELECT [custid] AS [Customer ID], [orderid] AS [Order ID]
FROM [Sales].[Orders] 
WHERE [CustID] > 15
ORDER BY [Customer ID] ASC,[Order ID] DESC;

-- Filtering data can not use column alias
SELECT [custid] AS [Customer ID], [orderid] AS [Order ID]
FROM [Sales].[Orders] 
WHERE [Customer ID] > 15
ORDER BY [Customer ID] ASC,[Order ID] DESC;

-- Using TOP clause
SELECT TOP (5) [custid] AS [Customer ID], [orderid] AS [Order ID]
FROM [Sales].[Orders] 
WHERE [CustID] > 15
ORDER BY [Customer ID];

-- Using TOP clause with Percent
SELECT TOP (5) PERCENT [custid] AS [Customer ID], [orderid] AS [Order ID]
FROM [Sales].[Orders] 
WHERE [CustID] > 15
ORDER BY [Customer ID];


-- Using TOP clause with TIES
SELECT TOP (5) WITH TIES [custid] AS [Customer ID], [orderid] AS [Order ID]
FROM [Sales].[Orders] 
WHERE [CustID] > 15
ORDER BY [Customer ID];

--Using TOP without ORDER BY clause
CREATE TABLE #T1 (C1 INT);
INSERT INTO #T1 VALUES (1), (2), (3), (4), (3);
-- Fails when TOP is used without ORDER BY clause
SELECT TOP (3) WITH TIES C1 FROM #T1;
-- works with order by clause
SELECT TOP (5) WITH TIES C1 FROM #T1
ORDER BY C1;

SELECT DISTINCT TOP (5) WITH TIES C1 FROM #T1
ORDER BY C1;

SELECT TOP (3) C1 FROM #T1
ORDER BY C1;
-- Clean up 
DROP TABLE #T1;

-- Review the number table 
SELECT TOP 100 [n]
FROM [dbo].[Nums] 
ORDER BY [n];


-- USING Fetch Offset for Paging
SELECT [n] 
FROM [dbo].[Nums] 
ORDER BY [n] 
OFFSET 0 ROWS FETCH NEXT 4 ROWS ONLY;
GO
-- USING Fetch Offset for Paging
SELECT [n] 
FROM [dbo].[Nums] 
ORDER BY [n] 
OFFSET 1 ROWS FETCH NEXT 4 ROWS ONLY;

SELECT [n] 
FROM [dbo].[Nums] 
ORDER BY [n] 
OFFSET 1 ROWS FETCH FIRST 4 ROWS ONLY;


-- First Page
SELECT [n] 
FROM [dbo].[Nums] 
ORDER BY [n] 
OFFSET 0 ROWS FETCH NEXT 4 ROWS ONLY;

-- Second Page
SELECT [n] 
FROM [dbo].[Nums] 
ORDER BY [n] 
OFFSET 4 ROWS FETCH NEXT 4 ROWS ONLY;
 

 -- Understanding NULLS 
SELECT [shipregion] FROM [Sales].[Orders];

 -- IS NULL EQUAL to NULL?
SELECT [shipregion] FROM [Sales].[Orders]
WHERE [shipregion] = NULL;

-- Do not use "= NULL" instead use "IS NULL"
SELECT [shipregion] FROM [Sales].[Orders]
WHERE [shipregion] IS NULL;



















