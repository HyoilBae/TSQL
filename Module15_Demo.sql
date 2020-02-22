USE TSQL;
GO
-- Executing a stored procedure	
CREATE PROC USP_GetOrder (@orderid int = NULL)
AS 
BEGIN
IF @orderid is null 
   SELECT * FROM Sales.Orders 
ELSE
   SELECT * FROM Sales.Orders
   WHERE orderid = @orderid;
END
GO

-- EXEC and PASS Parameter to Stored Procedure
EXEC USP_GetOrder 11012;
EXECUTE USP_GetOrder @orderid = 11012;
EXECUTE USP_GetOrder;
GO
-- Creating a stored procedure that will pass output back to calling application 
CREATE PROC dbo.USP_GetCustID (@orderid int,
                           @custid int OUTPUT)
AS 
BEGIN
   SELECT @custid=custid FROM Sales.Orders
   WHERE orderid= @orderid; 
END
GO
 
-- Get cust id for order 
DECLARE @custid_output int = null;
SELECT @custid_output;
EXEC dbo.USP_GetCustID @orderid = 11012, @custid = @custid_output OUTPUT;
SELECT @custid_output;
GO

-- Must identify parameter as output or results will be null
DECLARE @custid_output int = null;
SELECT @custid_output;
EXEC dbo.USP_GetCustID @orderid = 11012, @custid = @custid_output;
SELECT @custid_output;
GO
-- To change an existing stored procedure you can use the ALTER Statement
-- Creating a stored procedure that will pass output back to calling application 
ALTER PROC dbo.USP_GetCustID (@orderid int,
                           @custid int OUTPUT)
AS 
BEGIN
   -- Here is the order id that was passed.
   SELECT 'Here is the orderid that was passed = ' + cast(@orderid as varchar(max));
   SELECT @custid=custid FROM Sales.Orders
   WHERE orderid= @orderid; 
   
END
GO

-- CREATE OR ALTER
CREATE OR ALTER PROC dbo.USP_GetCustID (@orderid int,
                           @custid int OUTPUT)
AS 
BEGIN
   -- Here is the order id that was passed.
   SELECT 'Here is the orderid that was passed = ' + cast(@orderid as varchar(max));
   SELECT @custid=custid FROM Sales.Orders
   WHERE orderid= @orderid; 
   
END
GO

-- Execute altered SP.
DECLARE @custid_output int = null;
SELECT @custid_output;
EXEC dbo.USP_GetCustID @orderid = 11012, @custid = @custid_output OUTPUT;
SELECT @custid_output;

-- Running dynamic SQL 
DECLARE @sqlstring AS VARCHAR(1000);
SET @sqlstring='SELECT empid,' + ' lastname '+' FROM HR.employees;';
SELECT @sqlstring;
EXEC(@sqlstring);
GO

-- Tryinng to pass parameters

-- this gets and error
DECLARE @sqlstring AS VARCHAR(1000);
DECLARE @empid as varchar(100) = '5';
SET @sqlstring='SELECT empid,' + ' lastname '+' FROM HR.employees '+
               'WHERE empid = @empid';
SELECT @sqlstring;
EXEC(@sqlstring);
GO
-- this works because I converted the value of @empid to actual string value
DECLARE @sqlstring AS VARCHAR(1000);
DECLARE @empid as varchar(100) = '5';
SET @sqlstring='SELECT empid,' + ' lastname '+' FROM HR.employees '+
               'WHERE empid = ' + @empid + ';';
SELECT @sqlstring;
EXEC(@sqlstring);
GO


-- passing a parameter using sp_executesql 
DECLARE @sqlstring AS NVARCHAR(1000);
DECLARE @empid AS INT;
SET @sqlstring=N'SELECT empid, lastname FROM HR.employees WHERE empid=@empid;'
SELECT @sqlstring;
EXEC sp_executesql @statement = @sqlstring, @params=N'@empid AS INT',
	@empid = 5;
GO



--Cleanup 
DROP PROC USP_GetOrder;
DROP PROC USP_GetCustID;