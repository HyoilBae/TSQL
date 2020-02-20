USE TSQL;
GO
--1)	You need a SELECT statement that uses the COUNT function to return the number of unique mgrid values. 
--	Grading criterial: Your SELECT statement needs to return just a single row, that contains a single integer value.  
--	That integer should be the number of unique mgrid values.  Do not return a list of unique mgrid’s, 

SELECT COUNT(DISTINCT mgrid) + COUNT(DISTINCT CASE WHEN mgrid is null then 1 end) FROM HR.Employees;
SELECT COUNT(DISTINCT COALESCE(mgrid, 0)) FROM HR.Employees;
SELECT COUNT(DISTINCT ISNULL(mgrid, 0)) FROM HR.Employees;

--2)	You need to write a SELECT statement that uses a subquery to retuns all the companyname’s that have placed at least one order where the freight is greater than $800.00.
--	Grading Criteria:  Your SELECT statement needs to use a subquery.  If no subquery is used than you will be marked down.

--SELECT c.custid, c.companyname, o.freight
--FROM Sales.Customers AS c
--JOIN Sales.Orders AS o
--ON c.custid = o.custid
--WHERE freight > 800
--ORDER BY freight

SELECT custid, companyname
FROM Sales.Customers
WHERE custid IN (
	SELECT custid
	FROM Sales.Orders
	WHERE freight > 800)


--3)	You need to write a correlated subquery that  returns ALL the order information for any customer that lives in the city of Boise that has placed an order with a freight value > 800.
--	Grading Criteria:  Must use a correlated subquery to resolve this query. If no correlate subquery is used than you will be marked down.

SELECT *
FROM Sales.Orders AS o
WHERE o.freight > 800 and o.custid IN (
	SELECT c.custid
	FROM Sales.Customers AS c
	WHERE c.city = N'Boise')
ORDER BY o.custid

SELECT * FROM Sales.Orders
WHERE custid IN (
			SELECT custid FROM Sales.Orders o
			WHERE custid IN(
				SELECT custid FROM Sales.Customers
				WHERE city ='Boise' AND o.freight > 800))



