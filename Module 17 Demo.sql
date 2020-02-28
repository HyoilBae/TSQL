-- Module 17 demo
-- Using Raise Error to display an error message
RAISERROR(N'An error was encountered %s %d',  
          10,  
		  1,   
		  N'Error Num = ',
		  999);

-- Using Variables
DECLARE @Num int = '999';
DECLARE @String varchar(20) = 'Error Num =';
RAISERROR(N'An error was encountered %s %d',
          10,
		  1, 
		  @String, 
		  @Num);


-- Using THROW to display error message
THROW 50000, 'An error was encountered', 1; -- with a state of 1

-- message number of throw has to be 50000 or grater
THROW 49999, 'An error was encountered', 1;  -- with a state of 1

-- Using THROW to display error message using a number greater than 50000
THROW 50123, 'An error was encountered', 1; -- with a state of 1

-- @@Error displays the error number of the last command
SELECT 1;
PRINT @@Error;
SELECT 1/0;
PRINT @@Error;
RAISERROR(N'An error was encountered %s %d',
          16, --@@ERROR = 50000 when Serverity >= 16
		  1, 
		  'Error Num = ', 
		  12345);
PRINT @@ERROR;
RAISERROR(N'An error was encountered %s %d',
          10, -- @@ERROR = 0 when Severity < 16
		  1, 
		  'Error Num = ', 
		  12345);
PRINT @@ERROR;

 
-- Obtaining the error message number and storing it in a variable
DECLARE @LastError INT;
SELECT 1/0;
SET @LastError = @@ERROR;
IF @LastError <> 0
	PRINT 'The error was ' + CAST(@LastError as varchar(10));
 
 -- Error message severity 20 or high stops execution and writes to the window event log
 -- print statement executes
 RAISERROR(N'error',19,1) WITH LOG; 
 PRINT 'Got here';
 
 -- Print statement doesn't execute 
 RAISERROR(N'error',20,1) WITH LOG; 
 PRINT 'Got here';

 -- all severity greater than 20 need the WITH LOG option  
 RAISERROR(N'error',20,1); 
 PRINT 'Got here';

-- try catch 
BEGIN TRY
SELECT 1/1;
SELECT 1/0;
SELECT 1/1;
END TRY
BEGIN CATCH
PRINT 'Caught the divide by zero error and the number was ' + cast(@@ERROR as varchar(10));
END CATCH;
SELECT 'Got Here';

-- nexting TRY/CATCH Blocks
BEGIN TRY
SELECT 1/1;
SELECT 1/0;
SELECT 1/1;
END TRY
BEGIN CATCH
    PRINT 'Caught the first divide by zero error and the number was ' + cast(@@ERROR as varchar(10));
	BEGIN TRY
		SELECT 1/0;
	END TRY
	BEGIN CATCH
		PRINT 'Caught the second divide by zero error and the number was ' + cast(@@ERROR as varchar(10));
    END CATCH 
	SELECT 'Got to end of nested TRY/CATCH';
END CATCH;
SELECT 'Got Here';

-- re-throwing error in try catch block with a THROW statement, stops execution.
BEGIN TRY
SELECT 1/1;
SELECT 1/0;
SELECT 1/1;
END TRY
BEGIN CATCH
PRINT 'Caught the divide by zero error';
THROW;
END CATCH;
SELECT 'Got Here';

-- THROW statement must be in CATCH block
BEGIN TRY
THROW;
SELECT 1/1;
SELECT 1/0;
SELECT 1/1;
END TRY
BEGIN CATCH
PRINT 'Caught the divide by zero error';
THROW;
END CATCH;
SELECT 'Got Here';

 



