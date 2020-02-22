SELECT custid, orderid, orderdate, val,

* val / SUM(val) OVER (PARTITION BY custid) AS percoftotalcust
FROM Sales.OrderValues
ORDER BY custid, percoftotalcust DESC;

SELECT custid, orderid, orderdate, val,

* val / SUM(val) OVER (PARTITION BY custid) AS percoftotalcust,
SUM(val) OVER (PARTITION BY custid ORDER BY orderdate, orderid
ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS runval
FROM Sales.OrderValues;

WITH SalesMonth2007 AS
(
SELECT MONTH(orderdate) AS monthno, SUM(val) AS val
FROM Sales.OrderValues
WHERE orderdate >= '20070101' AND orderdate < '20080101'
GROUP BY MONTH(orderdate)
)
SELECT monthno, val,
AVG(val) OVER (ORDER BY monthno ROWS BETWEEN 3 PRECEDING AND CURRENT ROW) AS avglast3months,
SUM(val) OVER (ORDER BY monthno ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS ytdval
FROM SalesMonth2007;