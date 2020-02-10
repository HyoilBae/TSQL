-- Module 8 Using Built-In Functions

-- CAST		
SELECT GETDATE()
SELECT CAST(GETDATE() as time);
SELECT CAST(GETDATE() as date);
SELECT CAST(GETDATE() as varchar(100));

-- when you want a specific STYLE use convert
SELECT CONVERT(varchar(100),getdate(),10); -- mm-dd-yy
SELECT CONVERT(varchar(100),getdate(),110); -- mm-dd-yyyy
SELECT CONVERT(varchar(100),getdate(),111); -- yyyy/mm/dd

-- Strings might need to be converted to date/time prior to using a particular format
-- display in mon dd yyyy hh:mm:ddPMformat
DECLARE @D varchar(100) = '2013/01/11 18:41:19';
SELECT CONVERT(CHAR(100),@D,100);
SELECT CONVERT(CHAR(100),CAST(@D AS DATETIME),100);

-- Sometime casted values will be truncated
SELECT CAST('This is my string' as varchar(10));
SELECT GETDATE();
SELECT CAST (GETDATE() as varchar(11));

-- windowing functions
SELECT productid, productname, unitprice,
	RANK() OVER(ORDER BY unitprice DESC) AS rankbyprice,
	DENSE_RANK() OVER(ORDER BY unitprice DESC) AS denserankbyprice
FROM Production.Products
WHERE  unitprice > 35 and unitprice < 55 
ORDER BY rankbyprice;


-- PARSE 
SELECT CAST('Friday, 20 July 2018' as DATE); -- cannot cast  
SELECT CONVERT(DATE,'Friday, 20 July 2018'); -- cannot convert
SELECT PARSE('Friday, 20 July 2018' as DATE USING 'en-US'); -- PARSE supports converting to date
SELECT PARSE('Friday, 20 July 2018' as DATE);
SELECT PARSE('€345,98' AS money USING 'de-DE') AS Result; -- convert Euro money to German   
 
--TRY_CONVERT  and TRY_PARSE
SELECT CONVERT(DATE,'Friday, 20 July 2018'); -- gets error, nothing returned
SELECT TRY_CONVERT(DATE,'Friday, 20 July 2018'); -- no error, returns NULL
SELECT PARSE('29 Feb 2018' as DATEtime2 USING 'en-US'); -- gets error, nothing returned
SELECT TRY_PARSE('29 Feb 2018' as DATEtime2 USING 'en-US'); --no error returns NULL

-- Test for Numeric
SELECT ISNUMERIC('1');
SELECT ISNUMERIC('A');

-- IFF verses CASE
SELECT IIF(1=1,'Equal to 1','Not Equal to 1');
SELECT IIF(1=0,'Equal to 1','Not Equal to 1');
SELECT CASE WHEN 1=1 THEN 'Equal to 1' ELSE 'Not Equal to 1' END;
SELECT CASE WHEN 1=0 THEN 'Equal to 1' ELSE 'Not Equal to 1' END;

-- Using CHOOSE
SELECT CHOOSE(1,'Opinion', 'No Opinion', 'N/A');
SELECT CHOOSE(2,'Opinion', 'No Opinion', 'N/A');
SELECT CHOOSE(3,'Opinion', 'No Opinion', 'N/A');

-- Testing for null
DECLARE @I char(10);
SELECT ISNULL (@I,'I is NULL');
SET @I='ABCDEFGHIJ';
SELECT ISNULL (@I,'I is NULL');

-- Using Coelesce


-- Returns first non-null value
DECLARE @A VARCHAR(20), 
        @B VARCHAR(20), 
		@C VARCHAR(20) = 'Value';
SELECT COALESCE(@A, @B, @C); 
GO
-- If all null then null is returned
DECLARE @A VARCHAR(20), 
        @B VARCHAR(20), 
		@C VARCHAR(20);
SELECT COALESCE(@A, @B, @C); 
GO
-- NULLIF returns null if both values equal
DECLARE @A CHAR(1) = 'A', 
        @B CHAR(1) = 'A';
SELECT NULLIF(@A, @B);
GO
-- First value if both values are not equal
DECLARE @A CHAR(1) = 'A', 
        @B CHAR(1) = 'B';
SELECT NULLIF(@A, @B);








