USE TSQL 
GO
-- Implicict conversion
DECLARE @TInt AS TINYINT = 101;
DECLARE @Int AS INT = 31231;
SELECT @TInt + @Int;

--Implicit
SELECT '101' + '31231';
SELECT '101' + 31231;
GO
DECLARE @VC AS VARCHAR(20) = 'My ';
DECLARE @C AS CHAR(100) = 'Data is here.';
SELECT @VC + @C, DATALENGTH(@VC + @C), LEN(@VC + @C);
GO
DECLARE @VC AS VARCHAR(20) = 'My ';
DECLARE @C AS CHAR(100) = 'Data is here.';
SELECT @VC + @C +'x', DATALENGTH(@VC + @C +'x'), LEN(@VC + @C);
GO

-- be careful with CHAR data 
DECLARE @C AS CHAR(20) = 'My ';
DECLARE @VC AS VARCHAR(100) = 'Data is here.';
SELECT @C + @VC, DATALENGTH(@C), LEN(@C);
GO

-- Case insensative collation
DECLARE @S1 VARCHAR(10) = 'xxx';
DECLARE @S2 CHAR(10) = 'XXX';
SELECT 'Equal' results 
WHERE @S1= @S2;
GO

-- Implicit Converstion 
DECLARE @S1 int = 1;
DECLARE @S2 CHAR(1) = '2';
SELECT @S1 + @S2;
GO

-- Implicit conversion can't be done
DECLARE @TodaysDate DATETIME = getdate();
DECLARE @Str varchar(max) = 'Today''s date/time is ';
SELECT @Str + @TodaysDate;
GO

-- Explicit Conversion using CAST function
-- Conversion failure
DECLARE @TodaysDate DATETIME = getdate();
DECLARE @Str varchar(max) = 'Today''s date/time is ';
SELECT @Str + cast(@TodaysDate as varchar(max));
GO

DECLARE @TodaysDate DATETIME = getdate()
SELECT @TodaysDate;
GO

DECLARE @TodaysDate DATETIME = getdate();
DECLARE @Str varchar(max) = 'Today''s date/time is ';
SELECT @Str + cast(@TodaysDate as varchar(6));
GO


-- collation  
CREATE TABLE C1
(C1 CHAR(3) COLLATE Latin1_General_CS_AS);
CREATE TABLE C2
(C2 CHAR(3));
INSERT INTO C1 values ('abc');
INSERT INTO C2 VALUES ('Abc');
GO
SELECT * FROM 
C1 JOIN C2 
ON C1.C1 = C2.C2;
GO
SELECT * FROM 
C1 JOIN C2 
ON C1.C1 COLLATE SQL_Latin1_General_CP1_CI_AS = C2.C2; 

DROP TABLE C1, C2;

-- FUNCTIONS
DECLARE @C VARCHAR(100) = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
-- SUBSTRING
SELECT SUBSTRING(@C,2,1);  -- returns B
SELECT SUBSTRING(@C,7,5);  -- returns GHIJK 
GO

-- Reversing a String
DECLARE @C VARCHAR(100) = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
SELECT REVERSE(@C);
GO

-- Characters from Left or right
DECLARE @C VARCHAR(100) = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
SELECT LEFT(@C,1); -- returns A
SELECT LEFT(@C,3); -- returns ABC
SELECT RIGHT(@C,1); -- returns Z
SELECT RIGHT(@C,3); -- returns XYZ
GO

-- finding a string within a string
DECLARE @C VARCHAR(100) = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
SELECT CHARINDEX('L',@C);  -- returns offset of L
SELECT CHARINDEX('LMN',@C);  -- returns offset of L
SELECT CHARINDEX('1',@C); -- return 0 if not found 
GO

-- USING SUBSTRING and CHARINDEX together
DECLARE @C VARCHAR(100) = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
SELECT SUBSTRING(@C,1,CHARINDEX('C',@C)); -- returns ABC

-- Seaching using like
SELECT contactname 
FROM Sales.Customers
WHERE contactname
LIKE '%tom%';  -- find anything that has "tom" in the name

SELECT contactname 
FROM Sales.Customers
WHERE contactname
LIKE '___e%'; -- has e as the forth character

SELECT contactname 
FROM Sales.Customers 
WHERE contactname LIKE 'Al[^a]%'  -- starts with Al and doesn't have an "a" as thrid character
GO

-- Searching for special characters with escape character
DECLARE @T TABLE (C varchar(10));
INSERT INTO @T VALUES ('10%'),('20%'),('30 percent');
SELECT * FROM @T WHERE C LIKE N'__!%' ESCAPE '!';
SELECT * FROM @T WHERE C LIKE N'__x%' ESCAPE 'x';

 -- date examples
 DECLARE @D DATE = '20111128';
 SELECT @D;
 GO
 
 DECLARE @D DATETIME = '20111128';
 SELECT @D; -- note time is midnight
 GO

 DECLARE @D DATETIME = '20111128 13:14';
 SELECT @D;
 GO

 DECLARE @D DATE = '20111128';
 SELECT DATEADD(DAY, 1, @D) GO;
 GO

 DECLARE @D DATE = '2011/11/28';
 SELECT DATEADD(DAY, 1, @D) GO;
 GO

 -- does not match format for
 DECLARE @D DATE = '2011/28/11';
 SELECT DATEADD(DAY, 1, @D) GO;

 -- CAST 
 SELECT CAST ('2019/11/28' as DATE);
 SELECT CAST ('Jan 22, 1926' as DATE);
 SELECT CAST ('Jan 22, 1926' as DATETIME);
 --SELECT CAST ('Wednesday, 09 Octover 2019' as DATE);
 GO
 GO
 -- CONVERT 
 --SELECT CONVERT(datetime, '2019/11/28', 100); --doesn't work
 SELECT CONVERT(datetime, CAST('2019/11/28' as DATE), 100);
 SELECT CONVERT(varchar(30), CAST('2019/11/28' as DATE), 109);
 SELECT CONVERT(varchar(30), CAST('2019/11/28' as DATE), 112);
 SELECT CONVERT(varchar(30), CAST('2019/11/28' as DATE), 12);
 SELECT CONVERT(varchar(30), CAST('2019/11/28' as DATETIME), 109);
 SELECT CONVERT(varchar(30), CAST('2019/11/28 13:05' as DATETIME), 109);
 -- Parse
 --SELECT PARSE('13/12/2019' AS datetime2 USING 'en-US'); 
 SELECT PARSE('12/13/2019' AS datetime2 USING 'en-US'); 
 SELECT PARSE('13/12/2019' AS datetime2 USING 'da-DK'); 
 SELECT PARSE('13/12/2019' AS date USING 'da-DK'); 
 SELECT PARSE('13/12/2019' AS time USING 'da-DK'); 


 SELECT PARSE('Wednesday, 09 October 2019' AS date);
 SELECT CAST('Wednesday, 09 October 2019' AS date);
 SELECT CAST('2019/11/28' AS date);

 DECLARE @D1 varchar(100) = '2019-10-09 09:10:10.123';
 SELECT @D1, CAST(@D1 as DATE) AS [mm/dd/yyyy]; 




 
 
 



