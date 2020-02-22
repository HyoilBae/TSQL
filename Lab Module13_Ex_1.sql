SELECT orderid, orderdate, val, ROW_NUMBER() OVER (ORDER BY orderdate) AS rowno
FROM Sales.OrderValues

SELECT orderid, orderdate, val, ROW_NUMBER() OVER (ORDER BY orderdate) AS rowno,
RANK() OVER (ORDER BY orderdate) AS rankno
FROM Sales.OrderValues;

SELECT orderid, orderdate, custid, val,
RANK() OVER (PARTITION BY custid ORDER BY val DESC) AS orderrankno
FROM Sales.OrderValues;

SELECT custid, val, YEAR(orderdate) as orderyear,
RANK() OVER (PARTITION BY custid, YEAR(orderdate) ORDER BY val DESC) AS orderrankno
FROM Sales.OrderValues;

SELECT s.custid, s.orderyear, s.orderrankno, s.val
FROM
(
SELECT custid, val, YEAR(orderdate) as orderyear,
RANK() OVER (PARTITION BY custid, YEAR(orderdate) ORDER BY val DESC) AS orderrankno
FROM Sales.OrderValues
) AS s
WHERE s.orderrankno <= 2;

