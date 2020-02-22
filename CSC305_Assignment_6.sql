CREATE PROC USP_Get_Order_Info (@orderid int = NULL, 
								@custid int = NULL, 
								@productid int = NULL)
AS 
BEGIN
IF @orderid is null AND @custid is null AND @productid is null
   SELECT * FROM Sales.Orders AS o
   JOIN Sales.OrderDetails AS od
   ON o.orderid = od.orderid;
ELSE IF @orderid is not null AND @custid is null AND @productid is null
   SELECT * FROM Sales.Orders AS o
   JOIN Sales.OrderDetails AS od
   ON o.orderid = od.orderid
   WHERE o.orderid = @orderid;;
ELSE IF @orderid is null AND @custid is not null AND @productid is null
   SELECT * FROM Sales.Orders AS o
   JOIN Sales.OrderDetails AS od
   ON o.orderid = od.orderid
   WHERE o.custid = @custid;
ELSE IF @orderid is null AND @custid is null AND @productid is not null
   SELECT * FROM Sales.Orders AS o
   JOIN Sales.OrderDetails AS od
   ON o.orderid = od.orderid
   WHERE od.productid = @productid;
ELSE IF @orderid is not null AND @custid is not null AND @productid is not null
   SELECT 'Too many parameters passed'
ELSE IF @orderid is not null AND @custid is not null AND @productid is null
   SELECT 'Too many parameters passed'
ELSE IF @orderid is not null AND @custid is null AND @productid is not null
   SELECT 'Too many parameters passed'
ELSE IF @orderid is null AND @custid is not null AND @productid is not null
   SELECT 'Too many parameters passed'
END


EXEC USP_Get_Order_Info;
EXEC USP_Get_Order_Info @orderid = 10250;
EXEC USP_Get_Order_Info @custid = 25;
EXEC USP_Get_Order_INfo @productid = 10;
EXEC USP_Get_Order_Info @orderid = 10250, @custid = 25, @productid = 10;
EXEC USP_Get_Order_Info @orderid = 10250, @custid = 25;
EXEC USP_Get_Order_Info @orderid = 10250, @productid = 10;
EXEC USP_Get_Order_Info @custid = 25, @productid = 10;

DROP PROC USP_Get_Order_Info;