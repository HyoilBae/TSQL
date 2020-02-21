

SELECT orderid,
	   productid,
	   unitprice,
	   qty,
	   (unitprice * qty) AS LineTotal,
	   SUM(unitprice * qty) OVER( PARTITION BY orderid
							ORDER BY productid ASC
							ROWS BETWEEN UNBOUNDED PRECEDING
							AND CURRENT ROW ) AS RunningTotal
FROM Sales.OrderDetails
WHERE orderid = '10312';