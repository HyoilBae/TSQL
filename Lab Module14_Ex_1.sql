CREATE VIEW Sales.PivotCustGroups AS
WITH PivotCustGroups AS
(
SELECT custid, country, custgroup
FROM Sales.CustGroups
)
SELECT country, p.A, p.B, p.C
FROM PivotCustGroups
PIVOT (COUNT(custid) FOR custgroup IN (A, B, C)) AS p;

SELECT country, A, B, C
FROM Sales.PivotCustGroups;

SELECT custgroup, country, numberofcustomers
FROM Sales.PivotCustGroups
UNPIVOT (numberofcustomers FOR custgroup IN (A, B, C)) AS p;

SELECT country, city, COUNT(custid) AS noofcustomers
FROM Sales.Customers
GROUP BY GROUPING SETS ((country, city), (country), (city), ( ) );

SELECT YEAR(orderdate) AS orderyear, MONTH(orderdate) AS ordermonth, DAY(orderdate) AS orderday,
SUM(val) AS salesvalue
FROM Sales.OrderValues
GROUP BY CUBE (YEAR(orderdate), MONTH(orderdate), DAY(orderdate));

SELECT YEAR(orderdate) AS orderyear, MONTH(orderdate) AS ordermonth, DAY(orderdate) AS orderday,
SUM(val) AS salesvalue
FROM Sales.OrderValues
GROUP BY ROLLUP (YEAR(orderdate), MONTH(orderdate), DAY(orderdate));

SELECT GROUPING_ID(YEAR(orderdate), MONTH(orderdate)) as groupid, YEAR(orderdate) AS orderyear,
MONTH(orderdate) AS ordermonth, SUM(val) AS salesvalue
FROM Sales.OrderValues
GROUP BY ROLLUP (YEAR(orderdate), MONTH(orderdate))
ORDER BY groupid, orderyear, ordermonth;
