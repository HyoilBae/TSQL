--Query 1: Using Functions
CREATE TABLE MyData 
(C1 varchar(max));
GO
INSERT INTO MyData VALUES (
'Four score and seven years ago our ' +
'fathers brought forth on this continent, ' + 
'a new nation, conceived in Liberty, and ' +
'dedicated to the proposition that ' + 
'all men are created equal.');
GO
--“For dedication to all nations.” 
SELECT LEFT (C1, 2)/*Fo*/ + 
       SUBSTRING(C1, 4, 1)/*r*/ + 
	   SUBSTRING(C1, CHARINDEX(' dedica', C1), 7)/*_dedica*/ +
	   SUBSTRING(C1, CHARINDEX('tion', C1), 4) /*tion*/ +
	   SUBSTRING(C1, CHARINDEX(' to ', C1), 4) /*_to_*/ +
	   SUBSTRING(C1, CHARINDEX('all ', C1), 4) /*all_*/ +
	   SUBSTRING(C1, CHARINDEX('nation', C1), 6) /*nation*/ +
	   SUBSTRING(C1, CHARINDEX('s', C1), 1) /*s*/ +
	   RIGHT (C1, 1)
	   AS '"For dedication to all nations."'
FROM MyData;
GO
--DROP TABLE MyData;





--Query 2: Displaying Dates is correct format using CAST, CONVERT, PARSE
--CAST, CONVERT, PARSE
DECLARE @D1 varchar(100) = '2019-10-09 09:10:10.123';
DECLARE @D2 varchar(100) = '09-10-19 09:10:10.123';
DECLARE @D3 varchar(100) = 'Wednesday, 09 October 2019'; 

-- Display @D1 in yyyy-mm-dd format
SELECT CAST (@D1 as DATE) AS [yyyy-mm-dd]; --2019-10-09

-- Display @D1 in mm/dd/yyyy format
SELECT @D1, CONVERT(varchar(30), CAST(@D1 as DATE), 101) AS [mm/dd/yyyy];  --10/09/2019

-- Display @D2 in mon dd yyyy hh:mmAM
SELECT @D2, CONVERT(varchar(30), CAST(@D2 as DATETIME), 100) AS [mon dd yyyy hh:mmAM]  --SEP 10 2019 09:10AM

-- Display @D2 in hh:mi:ss:mmmmmmmAM  format  
SELECT @D2, CONVERT(varchar(30), CAST(@D2 as TIME), 109) AS [hh:mi:ss:mmmmmmmAM] --09:10:10:123000AM

-- Display @D3 in YYYYMMDD format
SELECT @D3, CONVERT(varchar(30), PARSE(@D3 as date), 112)  AS [YYYYMMDD]; -- 20191009

-- Display @D3 in hh:mmAM
SELECT @D3, CONVERT(varchar(30), PARSE(@D3 as time), 100) AS [hh:mmAM];  --00:00AM
