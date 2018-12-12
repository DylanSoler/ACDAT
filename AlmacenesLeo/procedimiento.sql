USE AlmacenesLeo
GO

--Procedimiento que obtiene el almacen mas cercano dado un id de almacen
GO
CREATE PROCEDURE almacenMasCercano(@IDAlmacen int, @almacen int OUTPUT)
AS
BEGIN
	SET @almacen = 0

	SELECT TOP 1 @almacen = AL.ID 
	FROM Almacenes AS AL 
	INNER JOIN Distancias AS D 
		ON AL.ID=D.IDAlmacen1 OR AL.ID=D.IDAlmacen2 
	WHERE (IDAlmacen1=@IDAlmacen OR IDAlmacen2=@IDAlmacen) AND AL.ID!=@IDAlmacen ORDER BY D.Distancia

RETURN @almacen
END
GO

declare @a int
EXECUTE almacenMasCercano 2 , @a OUTPUT
PRINT @a


--Procedimiento que obtiene el id correcto a insertar al meter un nuevo envio, ya que no es autogenerado
GO
CREATE FUNCTION nuevoIDEnvio ()
RETURNS BIGINT AS
BEGIN
	DECLARE @ID BIGINT
	SELECT TOP 1 @ID = ID FROM Envios ORDER BY ID DESC
	SET @ID +=1

RETURN @ID
END
GO

SELECT dbo.nuevoIDEnvio() as ID

