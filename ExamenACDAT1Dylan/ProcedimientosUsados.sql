USE ACDAT
GO


--Procedimiento que comprueba si hay stock para todos los productos de un pedido
--Devuelve 1 si hay stock, en caso de que no haya stock para alguno de los productos
--devolvera 0.
GO
CREATE PROCEDURE comprobarStock(@IDPedido int, @stock int OUTPUT)
AS
BEGIN
	SET @stock = 0

	IF(
		(SELECT PR.Nombre
			FROM Productos AS PR
			INNER JOIN LineasPedidos AS LP
				ON PR.IDProducto=LP.IDProducto
			INNER JOIN Pedidos AS P
				ON LP.IDPedido=P.IDPedido
			WHERE P.IDPedido=@IDPedido AND (LP.Cantidad>PR.Stock)) 
		IS NULL)
		BEGIN
			SET @stock = 1
		END

RETURN @stock
END
GO

--Prueba
DECLARE @stock int
EXECUTE comprobarStock 71774, @stock OUTPUT 
PRINT @stock



--Procedimiento que actualiza el stock de los productos de un pedido servido
--Devuelve 1 si todo ha ido bien, en caso de que no, devolvera 0.
GO
CREATE PROCEDURE actualizarStock(@IDPedido int, @IDProducto int, @ok int OUTPUT)
AS
BEGIN
	SET @ok = 0

	UPDATE Productos 
		SET Stock -= (SELECT Cantidad FROM LineasPedidos WHERE IDPedido=@IDPedido AND IDProducto=@IDProducto) 
	WHERE IDProducto=@IDProducto

RETURN @ok
END
GO



