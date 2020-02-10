-- Module 7 demo 
USE TSQL;
GO
-- Creating table and populating it with Select into 
SELECT * INTO #T  
FROM Sales.Customers;
-- review results
SELECT * FROM #T;

-- Update example
-- review data
SELECT * FROM #T 
WHERE city = 'Buenos Aires';

UPDATE #T
SET region = 1
WHERE city = 'Buenos Aires';

SELECT * FROM #T 
WHERE city = 'Buenos Aires';


-- MERGE to remove region update

SELECT * FROM #T 
WHERE city = 'Buenos Aires';
SELECT custid, region from Sales.Customers
WHERE city = 'Buenos Aires';

MERGE INTO #T AS TargetTbl
    USING (SELECT custid, region from Sales.Customers) AS SourceTbl
    ON (TargetTbl.custid = SourceTbl.custid
	AND TargetTbl.city ='Buenos Aires')
    WHEN MATCHED THEN 
        UPDATE SET TargetTbl.region= SourceTbl.region;

SELECT * FROM #T 
WHERE city = 'Buenos Aires';

-- Identity Column 
CREATE TABLE #I 
(Id int identity (1, 1), 
 C char(10));
INSERT INTO #I VALUES ('A'),('B'),('C');
SELECT * FROM #I;




