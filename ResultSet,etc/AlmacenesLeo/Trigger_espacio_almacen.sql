
USE AlmacenesLeo
GO

/*trigger*/
GO
CREATE TRIGGER TR_EspacioDisponibleAlmacen
ON Asignaciones INSTEAD OF INSERT
AS	
	DECLARE @almacen int
	DECLARE @idEnvio bigint
	DECLARE @espacio int
	DECLARE @contenedores int
	DECLARE @capacidad int

	SELECT @almacen = IDAlmacen, @idEnvio = IDEnvio FROM inserted

	SELECT @capacidad = Capacidad FROM Almacenes WHERE ID=@almacen

	SELECT @contenedores = NumeroContenedores FROM Envios WHERE ID = @idEnvio

	IF(@capacidad>=@contenedores)
		BEGIN
			IF(SELECT TOP 1 IDAlmacen FROM Asignaciones WHERE IDAlmacen = @almacen) IS NOT NULL
				BEGIN
					SELECT @espacio = AL.Capacidad - ISNULL((SUM(NumeroContenedores)),0)
					FROM Envios AS E
					INNER JOIN Asignaciones AS A
						ON E.ID = A.IDEnvio
					INNER JOIN Almacenes AS AL
						ON A.IDAlmacen=AL.ID
					WHERE A.IDAlmacen = @almacen
					GROUP BY AL.ID, AL.Capacidad
				END
			ELSE
				BEGIN SET @espacio = @capacidad END
		END
	ELSE
		BEGIN SET @espacio = 0 END

	
	IF (@espacio<@contenedores)
		RAISERROR ('No hay suficiente espacio',18,1)
	ELSE
		INSERT INTO Asignaciones (IDEnvio,IDAlmacen) VALUES (@idEnvio,@almacen)
GO

