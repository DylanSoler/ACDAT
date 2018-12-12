USE LOTERIAS
GO

/*GrabaMultiple

Procedimiento que graba una apuesta multiple

Entradas: id_sorteo, y entre 5 y 11 numeros
Salidas: no hay.

*/
GO
ALTER PROCEDURE GrabaMultiple (@Id_Sorteo tinyint, @n1 smallint,@n2 smallint,@n3 smallint,@n4 smallint,@n5 smallint
								,@n6 smallint = NULL,@n7 smallint = NULL,@n8 smallint = NULL,@n9 smallint = NULL
								,@n10 smallint = NULL,@n11 smallint = NULL)
AS
BEGIN

	--Comprobar que los numeros no estan repetidos
	IF @n1 IN (@n2, @n3, @n4, @n5, @n6, @n7, @n8, @n9, @n10, @n11) OR @n2 IN (@n1, @n3, @n4, @n5, @n6, @n7, @n8, @n9, @n10, @n11) OR
	   @n3 IN (@n1, @n2, @n4, @n5, @n6, @n7, @n8, @n9, @n10, @n11) OR @n4 IN (@n1, @n2, @n3, @n5, @n6, @n7, @n8, @n9, @n10, @n11) OR
	   @n5 IN (@n1, @n2, @n3, @n4, @n6, @n7, @n8, @n9, @n10, @n11) OR @n6 IN (@n1, @n2, @n3, @n4, @n5, @n7, @n8, @n9, @n10, @n11) OR
	   @n7 IN (@n1, @n2, @n3, @n4, @n5, @n6, @n8, @n9, @n10, @n11) OR @n8 IN (@n1, @n2, @n3, @n4, @n5, @n6, @n7, @n9, @n10, @n11) OR
	   @n9 IN (@n1, @n2, @n3, @n4, @n5, @n6, @n7, @n8, @n10, @n11) OR @n10 IN (@n1, @n2, @n3, @n4, @n5, @n6, @n7, @n8, @n9, @n11) OR
	   @n11 IN (@n1, @n2, @n3, @n4, @n5, @n6, @n7, @n8, @n9, @n10)

			PRINT 'No puedes introducir numeros iguales'

	--Si no hay numeros repetidos empezamos la ejecucion
	ELSE
		BEGIN
			--Contar cantidad de numeros introducidos
			DECLARE @numeros tinyint = 5

			IF @n6 IS NOT NULL
				SET @numeros = @numeros + 1
			IF @n7 IS NOT NULL
				SET @numeros = @numeros + 1
			IF @n8 IS NOT NULL
				SET @numeros = @numeros + 1
			IF @n9 IS NOT NULL
				SET @numeros = @numeros + 1
			IF @n10 IS NOT NULL
				SET @numeros = @numeros + 1
			IF @n11 IS NOT NULL
				SET @numeros = @numeros + 1

			--Comprobar si ha introducido 6 numeros
			IF @numeros=6
				PRINT 'No puede introducir 6 numeros'

			--si no se han introducido 6 numeros ejecutamos
			ELSE
				BEGIN
				--Ahora vamos a introducir el boleto de la apuesta

					--Calcular importe boleto
					DECLARE @importe money

					IF @numeros=5
						SET @importe = 44
					IF @numeros=7
						SET @importe = 7
					IF @numeros=8
						SET @importe = 28
					IF @numeros=9
						SET @importe = 84
					IF @numeros=10
						SET @importe = 210
					IF @numeros=11
						SET @importe = 462

					--Generamos el reintegro de forma aleatoria
					DECLARE @reintegro int
					SELECT @reintegro = FLOOR(RAND()*10)


					--Insertamos el boleto
					INSERT INTO BOLETO
						(ID_SORTEO, REINTEGRO, FECHA_HORA, IMPORTE_TOTAL, GANADO_TOTAL) 
					VALUES 
						(@Id_Sorteo, @reintegro, GETDATE(), @importe, NULL)

					DECLARE @IDBoleto int = @@IDENTITY

				--Procedemos a insertar la apuesta multiple

					--Primero generamos aleatoriamente el complementario
					DECLARE @complementario int

					SELECT @complementario = FLOOR(RAND()*49+1)

					--Validamos que no coincida el complementario con ninguno de los numeros introducidos
					WHILE(@complementario IN (@n1,@n2,@n3,@n4,@n5,@n6,@n7,@n8,@n9,@n10,@n11))
					BEGIN
						SELECT @complementario = FLOOR(RAND()*49+1)
					END

					--Finalmente insertamos la apuesta multiple
					INSERT INTO APUESTA_MULTIPLE
						(ID_BOLETO, N1, N2, N3, N4, N5, N6, N7, N8, N9, N10, N11, COMPLEMENTARIO, GANADO, IMPORTE )
					VALUES 
						(@IDBoleto, @n1, @n2, @n3, @n4, @n5, @n6, @n7, @n8, @n9, @n10, @n11, @complementario, NULL, @importe)
				END
		END
END
GO
--------PRUEBA-------------------
BEGIN TRANSACTION

INSERT INTO SORTEO
	(FECHA)
VALUES
	(GETDATE())

SELECT * FROM SORTEO

EXEC GrabaMultiple @@identity,1,2,3,4,5
select * from APUESTA_MULTIPLE

ROLLBACK
COMMIT

----------------------------------------------------------------------------------------------------------------------------------------

SELECT * FROM APUESTA_MULTIPLE AS APM
INNER JOIN BOLETO AS B
	ON APM.ID_BOLETO=B.ID
INNER JOIN SORTEO AS S
	ON B.ID_SORTEO=S.ID
WHERE S.ID=12

