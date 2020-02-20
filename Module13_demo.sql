-- Module 13 Demo
USE TSQL;
GO
select custid, freight, 
sum(freight) over (partition by custid) as totalcustid
from sales.orders;
GO

USE tempdb;
GO
-- Demo Table 
CREATE TABLE MyTable (ID INT IDENTITY, I1 INT, C1 CHAR(1));
INSERT INTO MyTable VALUES 
(1,'A'),
(1, 'A'),
(4, 'A'),
(5, 'B'), 
(2,'B'), 
(1, 'B'),
(3,'C'),
(4,'C');

SELECT * FROM MyTable;

-- Using OVER as without any restrictions passes all rows of set to function
SELECT I1, C1, SUM(I1) OVER() AS X
FROM MyTable;


-- To slice up set into chucks use partition
SELECT I1, C1, SUM(I1) OVER(PARTITION BY C1) AS Total_By_C1
FROM MyTable;

-- Calculate running total, using to OVER clauses, and setting a boundary
SELECT I1, C1, 
    SUM(I1) OVER (PARTITION BY C1) AS Total_By_C1,
	SUM(I1) OVER (PARTITION BY C1 ORDER BY I1 ASC
		ROWS BETWEEN UNBOUNDED PRECEDING
		AND CURRENT ROW) AS Running_Total_For_Partition,
	SUM(I1) OVER (PARTITION BY C1 ORDER BY I1 ASC
	    ROWS BETWEEN 1 PRECEDING and CURRENT ROW) AS Running_Total_For_Current_Plus_Preceeding
FROM MyTable
ORDER BY C1, I1;

-- Using FOLLOWING
SELECT ID, I1, C1, 
	MIN(I1) OVER (PARTITION BY C1 ORDER BY I1 ASC
		ROWS BETWEEN CURRENT ROW AND UNBOUNDED FOLLOWING
		) AS Running_Total_For_Min,
	MAX(I1) OVER (PARTITION BY C1 ORDER BY I1 ASC
		ROWS BETWEEN CURRENT ROW AND 1 FOLLOWING
		) AS Running_Total_For_Max2  
FROM MyTable
ORDER BY C1, I1;



-- Ranking function
SELECT ID,I1, C1, 
   RANK() OVER (PARTITION BY C1 ORDER BY ID) AS rnk
FROM MyTable;

SELECT ID,I1, C1, 
   RANK() OVER (PARTITION BY C1 ORDER BY I1) AS Rnk
FROM MyTable;

-- DENSE RANK
SELECT ID,I1, C1, 
   DENSE_RANK() OVER (PARTITION BY C1 ORDER BY I1) AS DenseRnk
FROM MyTable;

-- ROW_NUMBER
SELECT ID,I1, C1, 
   ROW_NUMBER() OVER (PARTITION BY C1 ORDER BY I1) AS RowNUm
FROM MyTable;

--Use NTILE to create 1 group per partition
SELECT ID,I1, C1, 
   NTILE(1) OVER (PARTITION BY C1 ORDER BY I1) AS RowNUm
FROM MyTable;

--Use NTILE to create 2 group per partition
SELECT ID,I1, C1, 
   NTILE(2) OVER (PARTITION BY C1 ORDER BY I1) AS RowNUm
FROM MyTable;

-- Using offset functions
SELECT ID, I1, C1,
    LAG(I1,1,0 /* DEFAULT */) OVER (PARTITION BY C1 ORDER BY I1) As prior_I1Value
FROM MyTable;

SELECT ID, I1, C1,
    LEAD(I1,1,0 /* DEFAULT */) OVER (PARTITION BY C1 ORDER BY I1) As Next_I1Value
FROM MyTable;

SELECT ID, I1, C1,
    FIRST_VALUE(I1) OVER (PARTITION BY C1 ORDER BY C1) As First_I1Value
FROM MyTable;

SELECT ID, I1, C1,
    LAST_VALUE(I1) OVER (PARTITION BY C1 ORDER BY C1) As Last_I1Value
FROM MyTable;


-- Clean up 
DROP TABLE MyTable;



