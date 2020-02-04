-- One Part Name
SELECT * FROM Nums;

-- Two Part Name
SELECT * FROM dbo.Nums;

-- Three Part Name
SELECT * FROM TSQL.dbo.Nums;

-- Four Part Name 
SELECT * FROM [MSI\SQL2019].TSQL.DBO.Nums;

 -- Default Schema (DBO)
SELECT * FROM Employees;

-- With schema name
SELECT * FROM HR.Employees;
 
-- Single Batch with Single Statement
SELECT TOP 5 * FROM Sales.Orders;
GO
SELECT TOP 1 * From Sales.Shippers;
GO

-- Single Batch with multiple statements
SELECT TOP 5 * FROM Sales.Orders;
SELECT TOP 1 * From Sales.Shippers;
GO

/* Object Explorer 
	Right Click Context Menus
	Bring up Query Window 
	Script a Table
*/

/* Query Window
	Database Context
	USE command
*/
USE master; 
GO

-- Show how to create a new project/solution
-- Documentation and Help

 
 
