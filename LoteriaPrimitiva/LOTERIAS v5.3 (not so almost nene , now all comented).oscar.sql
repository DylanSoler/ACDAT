SET DATEFORMAT dmy
CREATE DATABASE LOTERIAS
GO
USE LOTERIAS 
GO

/*
	*********************************************************************************************
	********************************* C R E A C I Ó N  B B D D **********************************
	*********************************************************************************************
*/
CREATE TABLE BOLETO(
	ID INT IDENTITY(1,1) NOT NULL
		CONSTRAINT PK_BOLETO Primary Key,
	ID_SORTEO INT NOT NULL,
	REINTEGRO SMALLINT NOT NULL,
	FECHA_HORA SMALLDATETIME NOT NULL,
	IMPORTE_TOTAL MONEY NOT NULL,
	REINTEGROACERTADO BIT NULL,
	GANADO_TOTAL MONEY NULL
)

CREATE TABLE SORTEO(
	ID int IDENTITY(1,1) NOT NULL
		CONSTRAINT PK_SORTEO Primary Key,
	FECHA SMALLDATETIME NOT NULL,
	N1 SMALLINT  NULL,
	N2 SMALLINT  NULL,
	N3 SMALLINT  NULL,
	N4 SMALLINT  NULL,
	N5 SMALLINT  NULL,
	N6 SMALLINT  NULL,
	COMPLEMENTARIO SMALLINT  NULL,
	REINTEGRO SMALLINT  NULL,
	RECAUDACION MONEY  NULL,
	TOTAL_REINTEGRO MONEY NULL,
	CATEGORIA_ESPECIAL_ACERTANTES INT DEFAULT 0,
	CATEGORIA_ESPECIAL MONEY NULL,
	CATEGORIA_1 MONEY NULL,
	CATEGORIA_1_ACERTANTES INT NOT NULL DEFAULT 0,
	CATEGORIA_2 MONEY NULL,
	CATEGORIA_2_ACERTANTES INT NOT NULL DEFAULT 0,
	CATEGORIA_3 MONEY NULL,
	CATEGORIA_3_ACERTANTES INT NOT NULL DEFAULT 0,
	CATEGORIA_4 MONEY NULL,
	CATEGORIA_4_ACERTANTES INT NOT NULL DEFAULT 0,
	CATEGORIA_5 MONEY NULL,
	CATEGORIA_5_ACERTANTES INT NOT NULL DEFAULT 0
)

CREATE TABLE APUESTA_SIMPLE (
	ID INT IDENTITY(1,1) NOT NULL
		CONSTRAINT PK_APUESTA_SIMPLE Primary Key,
	ID_BOLETO INT NOT NULL,
	N1 SMALLINT NOT NULL,
	N2 SMALLINT NOT NULL,
	N3 SMALLINT NOT NULL,
	N4 SMALLINT NOT NULL,
	N5 SMALLINT NOT NULL,
	N6 SMALLINT NOT NULL,
	NACERTADOS SMALLINT NULL,
	COMPLEMENTARIOACERTADO BIT NULL,
	GANADO MONEY NULL
)

CREATE TABLE APUESTA_MULTIPLE (
	ID INT IDENTITY(1,1) NOT NULL
		CONSTRAINT PK_MULTIPLE Primary Key,
	ID_BOLETO INT NOT NULL,
	N1 SMALLINT NOT NULL,
	N2 SMALLINT NOT NULL,
	N3 SMALLINT NOT NULL,
	N4 SMALLINT NOT NULL,
	N5 SMALLINT NOT NULL,
	N6 SMALLINT  NULL,
	N7 SMALLINT  NULL,
	N8 SMALLINT  NULL,
	N9 SMALLINT  NULL,
	N10 SMALLINT  NULL,
	N11 SMALLINT  NULL,
	NACERTADOS SMALLINT NULL,
	COMPLEMENTARIOACERTADO BIT NULL,
	CANTIDADNUMEROS TINYINT NULL,
	GANADO MONEY NULL,
	IMPORTE MONEY NOT NULL
)

CREATE TABLE DesarrolloPremios(
	pronostico tinyint  NOT NULL
	,numerosAcertados tinyint NOT NULL
	,catEspecial tinyint NOT NULL
	,cat1 tinyint NOT NULL
	,cat2 tinyint NOT NULL
	,cat3 tinyint NOT NULL
	,cat4 tinyint NOT NULL
	,cat5 tinyint NOT NULL

	,CONSTRAINT PK_DesarrolloPremios PRIMARY KEY (pronostico,numerosAcertados)
)

ALTER TABLE BOLETO ADD
	CONSTRAINT FK_BOLETO_SORTEO FOREIGN KEY (ID_SORTEO) REFERENCES SORTEO(ID)
	ON DELETE NO ACTION
	ON UPDATE NO ACTION

ALTER TABLE APUESTA_SIMPLE ADD
	CONSTRAINT FK_APUESTA_SIMPLE_BOLETO FOREIGN KEY (ID_BOLETO) REFERENCES BOLETO(ID)
	ON DELETE NO ACTION
	ON UPDATE NO ACTION

ALTER TABLE APUESTA_MULTIPLE ADD
	CONSTRAINT FK_APUESTA_MULTIPLE_BOLETO FOREIGN KEY (ID_BOLETO) REFERENCES BOLETO(ID)
	ON DELETE NO ACTION
	ON UPDATE NO ACTION

/* Relleno de datos de la tabla AsignarPremios */
/*
Significado valores de la columna numerosAcertados:

	0  - 6 + R + C
	1  - 6 + R
	2  - 6 + C
	3  - 6
	4  - 5 + C
	5  - 5 + R
	6  - 5
	7  - 4 + C
	8  - 4
	9  - 3
	10 - 2
*/
INSERT INTO DesarrolloPremios (pronostico,numerosAcertados,catEspecial,cat1,cat2,cat3,cat4,cat5) 
	VALUES
		 (5,5,1,1,1,42,0,0)
		,(5,6,0,1,1,42,0,0)
		,(5,7,0,0,2,0,42,0)
		,(5,8,0,0,0,2,42,0)
		,(5,9,0,0,0,0,3,41)
		,(5,10,0,0,0,0,0,4)

		,(7,0,1,1,6,0,0,0)
		,(7,1,1,1,0,6,0,0)
		,(7,2,0,1,6,0,0,0)
		,(7,3,0,1,0,6,0,0)
		,(7,4,0,0,1,1,5,0)
		,(7,6,0,0,0,2,5,0)
		,(7,8,0,0,0,0,3,4)
		,(7,9,0,0,0,0,0,4)

		,(8,0,1,1,6,6,15,0)
		,(8,1,1,1,0,12,15,0)
		,(8,2,0,1,6,6,15,0)
		,(8,3,0,1,0,12,15,0)
		,(8,4,0,0,1,2,15,0)
		,(8,6,0,0,0,3,15,10)
		,(8,8,0,0,0,0,6,16)
		,(8,9,0,0,0,0,0,10)

		,(9,0,1,1,6,12,45,20)
		,(9,1,1,1,0,18,45,20)
		,(9,2,0,1,6,12,45,20)
		,(9,3,0,1,0,18,45,20)
		,(9,4,0,0,1,3,30,40)
		,(9,6,0,0,0,4,30,40)
		,(9,8,0,0,0,0,10,40)
		,(9,9,0,0,0,0,0,20)

		,(10,0,1,1,6,18,90,80)
		,(10,1,1,1,0,24,90,80)
		,(10,2,0,1,6,18,90,80)
		,(10,3,0,1,0,24,90,80)
		,(10,4,0,0,1,4,50,100)
		,(10,6,0,0,0,5,50,100)
		,(10,8,0,0,0,0,15,80)
		,(10,9,0,0,0,0,0,35)

		,(11,0,1,1,6,24,150,200)
		,(11,1,1,1,0,30,150,200)
		,(11,2,0,1,6,24,150,200)
		,(11,3,0,1,0,30,150,200)
		,(11,4,0,0,1,5,75,200)
		,(11,6,0,0,0,6,75,200)
		,(11,8,0,0,0,0,21,140)
		,(11,9,0,0,0,0,0,56)

/*
	*********************************************************************************************
	******************************** P R O C E D I M I E N T O S ********************************
	*********************************************************************************************
*/


-----------------------------------------------------------------------------------------------------------
/*	
	Descripcion: Procedimiento usado para añadir un boleto con una sola apuesta simple.
	Entradas:  El sorteo y los seis números
	Salidas: Ninguna
*/
GO
CREATE PROCEDURE GrabaSencilla (@Id_Sorteo int, @n1 smallint,@n2 smallint,@n3 smallint,@n4 smallint,@n5 smallint,@n6 smallint)
AS
	BEGIN

	--DECLARAMOS LAS VARIABLES CORRESPONDIENTES
	DECLARE @RANDOM_REINTEGRO INT

----------------------------------------------------------------------

	--BUSCAMOS EL RANDOM PARA EL REINTEGRO
	SELECT @RANDOM_REINTEGRO = FLOOR(RAND()*9)

-----------------------------------------------------------------------

			--INSERTAMOS EL BOLETO CON UNA APUESTA SIMPLE
			INSERT INTO BOLETO(FECHA_HORA,ID_SORTEO,IMPORTE_TOTAL,REINTEGRO) 
				VALUES (GETDATE(),@Id_Sorteo,1,@RANDOM_REINTEGRO)

			INSERT INTO APUESTA_SIMPLE(ID_BOLETO,N1,N2,N3,N4,N5,N6)
			VALUES (@@IDENTITY,@n1,@n2,@n3,@n4,@n5,@n6)

	END
GO
-----------------------------------------------------------------------------------------------------------


-----------------------------------------------------------------------------------------------------------
/*
	Procedimiento usado para generar un boleto con n apuestas sencillas, con números generados aleatoriamente
	Entradas:
		Int n, la cantidad de apuestas sencillas del boleto
		Int IDSorteo, la ID del Sorteo
	Salida: Ninguna
	Requisitos: Solo puede haber 8 apuestas sencillas por boleto
*/
GO
CREATE PROCEDURE GrabaSencillaAleatoria (@NumeroApuestas int, @IDSorteo int)
AS
	BEGIN
		IF(@NumeroApuestas < 1 OR @NumeroApuestas > 8)
			BEGIN
				Print '¡Introduce entre 1 y 8 apuestas!'
			END
		ELSE
			BEGIN
				DECLARE @Cont int = 0
				DECLARE @Reintegro int = FLOOR(RAND()*9)
				INSERT INTO BOLETO (ID_SORTEO, REINTEGRO, FECHA_HORA, IMPORTE_TOTAL) 
					VALUES (@IDSorteo, @Reintegro, GETDATE(), @NumeroApuestas)
				DECLARE @IDBoleto int = @@IDENTITY

				/* Generación de todas las apuestas del boleto */
				WHILE (@Cont != @NumeroApuestas)
				BEGIN
					DECLARE @N1 int = ROUND((48 * RAND() + 1), 0)
					DECLARE @N2 int = ROUND((48 * RAND() + 1), 0)
					DECLARE @N3 int = ROUND((48 * RAND() + 1), 0)
					DECLARE @N4 int = ROUND((48 * RAND() + 1), 0)
					DECLARE @N5 int = ROUND((48 * RAND() + 1), 0)
					DECLARE @N6 int = ROUND((48 * RAND() + 1), 0)
			
					WHILE @N2 = @N1
						SET @N2 = ROUND((48 * RAND() + 1), 0)

					WHILE @N3 IN (@N2, @N1)
						SET @N3 = ROUND((48 * RAND() + 1), 0)

					WHILE @N4 IN (@N3, @N2, @N1)
						SET @N4 = ROUND((48 * RAND() + 1), 0)

					WHILE @N5 IN (@N4, @N3, @N2, @N1)
						SET @N5 = ROUND((48 * RAND() + 1), 0)

					WHILE @N6 IN (@N5, @N4, @N3, @N2, @N1)
						SET @N6 = ROUND((48 * RAND() + 1), 0)

					INSERT INTO APUESTA_SIMPLE (ID_BOLETO, N1, N2, N3, N4, N5, N6)
						VALUES (@IDBoleto, @N1, @N2, @N3, @N4, @N5, @N6)

					SET @Cont = @Cont + 1
				END
			END
	END
GO
-----------------------------------------------------------------------------------------------------------


-----------------------------------------------------------------------------------------------------------
/*
	Descripcion: Procedimiento que genere n boletos con sus apuestas sencillas
	Entradas:  El sorteo y los boletos que queremos insertar
	Salidas: Ninguna
*/
GO
CREATE PROCEDURE GrabaMuchasSencillas (@Id_Sorteo int, @nveces int)
AS
	BEGIN
		DECLARE @Cont int = 0
		WHILE @Cont < @nveces
		BEGIN
			EXEC GrabaSencillaAleatoria 1, @Id_Sorteo
			SET @Cont += 1
		END
	END
GO
-----------------------------------------------------------------------------------------------------------


-----------------------------------------------------------------------------------------------------------
/*
	Procedimiento que crea un boleto nuevo y graba una apuesta multiple en ella
	Entradas: id_sorteo, y entre 5 y 11 numeros
	Salidas: no hay.

*/
GO
CREATE PROCEDURE GrabaMultiple (@Id_Sorteo tinyint, @n1 smallint,@n2 smallint,@n3 smallint,@n4 smallint,@n5 smallint
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

			RAISERROR(N'No puedes introducir numeros iguales',18,1)

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

				RAISERROR('No puede introducir 6 numeros',18,1)

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
					SELECT @reintegro = FLOOR(RAND()*9)


					--Insertamos el boleto
					INSERT INTO BOLETO
						(ID_SORTEO, REINTEGRO, FECHA_HORA, IMPORTE_TOTAL, GANADO_TOTAL) 
					VALUES 
						(@Id_Sorteo, @reintegro, GETDATE(), @importe, NULL)

					DECLARE @IDBoleto int = @@IDENTITY

				--Procedemos a insertar la apuesta multiple
					INSERT INTO APUESTA_MULTIPLE
						(ID_BOLETO, N1, N2, N3, N4, N5, N6, N7, N8, N9, N10, N11, IMPORTE, CANTIDADNUMEROS )
					VALUES 
						(@IDBoleto, @n1, @n2, @n3, @n4, @n5, @n6, @n7, @n8, @n9, @n10, @n11, @importe, @numeros)
				END
		END
END
GO
-----------------------------------------------------------------------------------------------------------



-----------------------------------------------------------------------------------------------------------
/*
	Procedimiento almacenado que crea una tabla temporal con los que tienen un boleto simple con premio
	En la tabla temporal se almacena su apuesta junto a la cantidad de aciertos de la misma
	Entradas: IDSorteo
	Salidas: No hay
*/
GO
CREATE PROCEDURE ContarAciertosMultiples (@IDSorteo int)
AS
	BEGIN
		DECLARE @aciertos int = 0

		--asignar numeros sorteo a variables
		DECLARE @S1 tinyint
		DECLARE @S2 tinyint
		DECLARE @S3 tinyint
		DECLARE @S4 tinyint
		DECLARE @S5 tinyint
		DECLARE @S6 tinyint
		DECLARE @SCOMPLEMENTARIO tinyint
		DECLARE @SREINTEGRO tinyint
		SELECT @S1=N1,  @S2=N2, @S3=N3,  @S4=N4,  @S5=N5,  @S6=N6, @SCOMPLEMENTARIO = COMPLEMENTARIO, @SREINTEGRO = REINTEGRO FROM SORTEO WHERE ID=@IDSorteo
		
		--asignar numeros apuesta a variables
		DECLARE @A1 tinyint
		DECLARE @A2 tinyint
		DECLARE @A3 tinyint
		DECLARE @A4 tinyint
		DECLARE @A5 tinyint
		DECLARE @A6 tinyint
		DECLARE @A7 tinyint
		DECLARE @A8 tinyint
		DECLARE @A9 tinyint
		DECLARE @A10 tinyint
		DECLARE @A11 tinyint
		DECLARE @IDApuesta int
		DECLARE @ACOMPLEMENTARIO tinyint
		DECLARE @AREINTEGRO tinyint
		DECLARE @CANTNUMEROS tinyint

		
		
		--COMENZAMOS EL BUCLE BUSCANDO MIENTRAS NACERTADOS SEA NULO
		WHILE (SELECT TOP 1 NACERTADOS FROM APUESTA_MULTIPLE AS APS INNER JOIN BOLETO AS B ON APS.ID_BOLETO = B.ID WHERE ID_SORTEO = @IDSorteo ORDER BY NACERTADOS ASC) IS NULL
		BEGIN

			--GUARDAMOS LOS NUMEROS , COMPLEMENTARIO Y REINTEGRO EN VARIABLES
			SELECT @A1=APS.N1,  @A2=APS.N2,  @A3=APS.N3,  @A4=APS.N4,  @A5=APS.N5,  @A6=APS.N6,	
				@A7=APS.N7,  @A8=APS.N8,  @A9=APS.N9,  @A10=APS.N10,  @A11=APS.N11, @IDApuesta=APS.ID, 
				@ACOMPLEMENTARIO = S.COMPLEMENTARIO , @AREINTEGRO = B.REINTEGRO, @CANTNUMEROS = APS.CANTIDADNUMEROS
				
				FROM APUESTA_MULTIPLE AS APS
					INNER JOIN BOLETO AS B
						ON APS.ID_BOLETO = B.ID
					INNER JOIN SORTEO AS S
						ON B.ID_SORTEO = S.ID
				WHERE B.ID_SORTEO = @IDSorteo AND APS.NACERTADOS IS NULL

				--PONEMOS LOS ACIERTOS A 0 PARA LA PROX ITERACION
				SET @aciertos = 0

			

	--SELECT TOP 1 * FROM APUESTA_SIMPLE AS APS INNER JOIN BOLETO AS B ON APS.ID_BOLETO = B.ID WHERE ID_SORTEO = 2 ORDER BY NACERTADOS ASC

			--comparas y cuentas aciertos
			IF (@A1 IN (@S1, @S2, @S3, @S4, @S5, @S6))
				SET @aciertos += 1
			IF (@A2 IN (@S1, @S2, @S3, @S4, @S5, @S6))
				SET @aciertos += 1
			IF (@A3 IN (@S1, @S2, @S3, @S4, @S5, @S6))
				SET @aciertos += 1
			IF (@A4 IN (@S1, @S2, @S3, @S4, @S5, @S6))
				SET @aciertos += 1
			IF (@A5 IN (@S1, @S2, @S3, @S4, @S5, @S6))
				SET @aciertos += 1
			IF (@CANTNUMEROS > 6 AND @A6 IN (@S1, @S2, @S3, @S4, @S5, @S6))
				SET @aciertos += 1
			IF (@CANTNUMEROS > 6 AND @A7 IN (@S1, @S2, @S3, @S4, @S5, @S6))
				SET @aciertos += 1
			IF (@CANTNUMEROS > 7 AND @A8 IN (@S1, @S2, @S3, @S4, @S5, @S6))
				SET @aciertos += 1
			IF (@CANTNUMEROS > 8 AND @A9 IN (@S1, @S2, @S3, @S4, @S5, @S6))
				SET @aciertos += 1
			IF (@CANTNUMEROS > 9 AND @A10 IN (@S1, @S2, @S3, @S4, @S5, @S6))
				SET @aciertos += 1
			IF (@CANTNUMEROS > 10 AND @A11 IN (@S1, @S2, @S3, @S4, @S5, @S6))
				SET @aciertos += 1
		
			
		
		
			

			--ACTUALIZAMOS LAS COLUMNAS CORRESPONDIENTES
			IF (@ACOMPLEMENTARIO = @SCOMPLEMENTARIO)
				UPDATE APUESTA_MULTIPLE SET COMPLEMENTARIOACERTADO = 1
			ELSE
				UPDATE APUESTA_MULTIPLE SET COMPLEMENTARIOACERTADO = 0
		
			
			IF ( @AREINTEGRO IS NULL AND @AREINTEGRO = @SREINTEGRO )
				UPDATE BOLETO SET REINTEGROACERTADO = 1
			ELSE 
				UPDATE BOLETO SET REINTEGROACERTADO = 0

			--ACTUALIZACION BUCLE
			UPDATE APUESTA_MULTIPLE SET NACERTADOS = @aciertos
			WHERE ID = @IDApuesta
		END
	END
GO
-----------------------------------------------------------------------------------------------------------

/* 
	Procedimiento que asigna la recaudacion de un sorteo
	Entrada:IDSorteo
	Salidas: No hay
*/
GO
CREATE PROCEDURE AsignarRecaudacionSorteo (@IDSorteo int)
AS
	BEGIN
		IF(SELECT RECAUDACION FROM SORTEO WHERE ID = @IDSorteo) IS NOT NULL
			RAISERROR('La recaudación del sorteo ya esta asignada', 18, 1)
		ELSE
		BEGIN
			DECLARE @Recaudacion money = (SELECT SUM(IMPORTE) 
											FROM APUESTA_MULTIPLE AS APM
											INNER JOIN BOLETO AS B
												ON APM.ID_BOLETO=B.ID
											WHERE ID_SORTEO=@IDSorteo)
			
			SET @Recaudacion += (SELECT COUNT(*) 
									FROM APUESTA_SIMPLE AS APS
									INNER JOIN BOLETO AS B
										ON APS.ID_BOLETO=B.ID
									WHERE ID_SORTEO=@IDSorteo) 
															
			
			UPDATE SORTEO
				SET RECAUDACION = @Recaudacion
			WHERE ID=@IDSorteo
		END
	END
GO


-----------------------------------------------------------------------------------------------------------
/* 
	Procedimiento que asigna la cuantia por categorias de un sorteo teniendo en cuenta los porcentajes correspondientes a cada una
	Entrada:IDSorteo
	Salidas: No hay
*/
GO
CREATE PROCEDURE AsignarCuantiaPorCategoria (@IDSorteo int)
AS
	BEGIN
		IF(SELECT RECAUDACION FROM SORTEO WHERE ID = @IDSorteo) IS NULL
			RAISERROR('Recaudación nula', 18, 1)
		ELSE
		BEGIN
			DECLARE @Cuantia45 money = (SELECT RECAUDACION FROM SORTEO WHERE ID = @IDSorteo) * 0.45
			UPDATE SORTEO
				SET CATEGORIA_1 = @Cuantia45 * 0.4,
					CATEGORIA_2 = @Cuantia45 * 0.06,
					CATEGORIA_3 = @Cuantia45 * 0.13,
					CATEGORIA_4 = @Cuantia45 * 0.21,
					CATEGORIA_ESPECIAL = @Cuantia45 * 0.2
		END
	END
GO
-----------------------------------------------------------------------------------------------------------


-----------------------------------------------------------------------------------------------------------
/*
	Funcion que nos devuelve segun el pronostico y la cantidad de numeros acertados la cantidad de premios de cada categoria
	Entrada: IDSorteo
	Salida: Nos devolvera una tabla con todas las categorias y sus premios
*/
GO
CREATE FUNCTION FUNC_DES_PREMIOS_UNION_SORTEO(@IDSORTEO INT)
RETURNS TABLE
AS
RETURN
(
 SELECT SUM(cat1) AS CATEGORIA1,SUM(cat2) AS CATEGORIA2,SUM(cat3) AS CATEGORIA3,SUM(cat4) AS CATEGORIA4, SUM(cat5) AS CATEGORIA5, SUM(catEspecial) AS CATEGORIAESPECIAL 
				FROM DesarrolloPremios AS DP
				INNER JOIN APUESTA_MULTIPLE AS APM
				ON dbo.NUMEROPREMIOSPORAPUESTA(APM.ID) = numerosAcertados AND pronostico = APM.CANTIDADNUMEROS
				INNER JOIN BOLETO AS B
				ON B.ID = APM.ID_BOLETO
				WHERE @IDSORTEO = B.ID_SORTEO

)


GO
-----------------------------------------------------------------------------------------------------------


-----------------------------------------------------------------------------------------------------------
/*
	Procedimientos el cual nos asignara la cantidad de acertantes por cada categoria
	Entradas: IDSorteo
	Salidas: No hay
*/
GO
CREATE PROCEDURE AsignarAcertantes (@IDSorteo int)
AS
	BEGIN

		/* UPDATE de la tabla de las apuestas simples */
		UPDATE SORTEO
			SET CATEGORIA_1_ACERTANTES += (SELECT COUNT(*) 
											FROM APUESTA_SIMPLE AS APS
												INNER JOIN BOLETO AS B
													ON APS.ID_BOLETO = B.ID
											WHERE B.ID_SORTEO = @IDSorteo AND APS.NACERTADOS = 6 AND REINTEGROACERTADO = 0),

				CATEGORIA_ESPECIAL_ACERTANTES += (SELECT COUNT(*) 
											FROM APUESTA_SIMPLE AS APS
												INNER JOIN BOLETO AS B
													ON APS.ID_BOLETO = B.ID
											WHERE B.ID_SORTEO = @IDSorteo AND APS.NACERTADOS = 6 AND REINTEGROACERTADO = 1),

				CATEGORIA_2_ACERTANTES += (SELECT COUNT(*) 
											FROM APUESTA_SIMPLE AS APS
												INNER JOIN BOLETO AS B
													ON APS.ID_BOLETO = B.ID
											WHERE B.ID_SORTEO = @IDSorteo AND APS.NACERTADOS = 5 AND APS.COMPLEMENTARIOACERTADO = 1),

				CATEGORIA_3_ACERTANTES += (SELECT COUNT(*) 
											FROM APUESTA_SIMPLE AS APS
												INNER JOIN BOLETO AS B
													ON APS.ID_BOLETO = B.ID
											WHERE B.ID_SORTEO = @IDSorteo AND APS.NACERTADOS = 5 AND APS.COMPLEMENTARIOACERTADO = 0),

				CATEGORIA_4_ACERTANTES += (SELECT COUNT(*) 
											FROM APUESTA_SIMPLE AS APS
												INNER JOIN BOLETO AS B
													ON APS.ID_BOLETO = B.ID
											WHERE B.ID_SORTEO = @IDSorteo AND APS.NACERTADOS = 4),

				CATEGORIA_5_ACERTANTES += (SELECT COUNT(*) 
											FROM APUESTA_SIMPLE AS APS
												INNER JOIN BOLETO AS B
													ON APS.ID_BOLETO = B.ID
											WHERE B.ID_SORTEO = @IDSorteo AND APS.NACERTADOS = 3)
			WHERE ID = @IDSorteo


		/* UPDATE de la tabla de las apuestas múltiples */

		UPDATE SORTEO

				SET CATEGORIA_1_ACERTANTES += FDPUS.CATEGORIA1,
				CATEGORIA_2_ACERTANTES += FDPUS.CATEGORIA2,
				CATEGORIA_3_ACERTANTES += FDPUS.CATEGORIA3,
				CATEGORIA_4_ACERTANTES += FDPUS.CATEGORIA4,
				CATEGORIA_5_ACERTANTES += FDPUS.CATEGORIA5,
				CATEGORIA_ESPECIAL_ACERTANTES += FDPUS.CATEGORIAESPECIAL


				FROM dbo.FUNC_DES_PREMIOS_UNION_SORTEO(@IDSorteo) AS FDPUS
				
				/*DesarrolloPremios AS DP
				INNER JOIN APUESTA_MULTIPLE AS APM
				ON dbo.NUMEROPREMIOSPORAPUESTA(APM.ID) = numerosAcertados AND pronostico = APM.CANTIDADNUMEROS
				*/
											
		WHERE SORTEO.ID = @IDSorteo
				
	END
GO
-----------------------------------------------------------------------------------------------------------


-----------------------------------------------------------------------------------------------------------
/*
	Funcion tochisima la cual nos dira el numero de premios por apuesta realizadas
	Entradas: IDApuesta
	Salida: Numero de premios en la apuesta que le hayamos enviado como parametro.
*/
GO
CREATE FUNCTION NUMEROPREMIOSPORAPUESTA (@IDAPUESTA INT)
RETURNS TINYINT AS
BEGIN
DECLARE @SUPERSELECT AS TINYINT 

SET @SUPERSELECT = -1

select @SUPERSELECT = 
						CASE NACERTADOS
							WHEN 2 THEN 10
							WHEN 3 THEN 9
							WHEN 4 THEN --Debemos ir contemplando las diferentes posibilidades	con el complementario y el reintegro
										CASE COMPLEMENTARIOACERTADO
											WHEN 1 THEN 7
											ELSE 8
										END
							WHEN 5 THEN 
										CASE 
											WHEN COMPLEMENTARIOACERTADO = 1 AND REINTEGROACERTADO = 0 THEN 4
											WHEN COMPLEMENTARIOACERTADO = 0 AND REINTEGROACERTADO = 1 THEN 5
											ELSE 6
										END
							WHEN 6 THEN 
										CASE 
											WHEN COMPLEMENTARIOACERTADO = 1 AND REINTEGROACERTADO = 1 THEN 0
											WHEN COMPLEMENTARIOACERTADO = 0 AND REINTEGROACERTADO = 1 THEN 1
											WHEN COMPLEMENTARIOACERTADO = 1 AND REINTEGROACERTADO = 0 THEN 2
											ELSE 3
										END					
						END

from APUESTA_MULTIPLE AS APM
INNER JOIN BOLETO AS B
ON B.ID = APM.ID_BOLETO
WHERE APM.ID = @IDAPUESTA
	
	RETURN @SUPERSELECT
END
GO
-----------------------------------------------------------------------------------------------------------


/*

PRUEBAS Y POO VARIADA
*/
SELECT DBO.NUMEROPREMIOSPORAPUESTA(5) 

UPDATE BOLETO 
	SET REINTEGROACERTADO = 0
	WHERE ID = 2



--PONER EN CONCENSO CANTIDAD DE NUMEROS APUESTAS MULTIPLES: CHEQUEADO
--PENSAR PROCEDIMIENTOS APUESTAMULTIPLE: CHEQUEADO
--CALCULAR Y DIVIDIR DINERO POR CATEGORIA
--CONTAR ACIERTOS POR CATEGORIA
--ASIGNAR IMPORTES A APUESTAS
--HACER CASO A LEO, TABLITA CON LOS NUMEROS DE LAS APUESTAS, PARA ASI PODER COMPARARLOS MAS EFICIENTEMENTE


--CREATE PROCEDURE 


select * from BOLETO
select * from APUESTA_MULTIPLE
select * from APUESTA_SIMPLE
SELECT * FROM SORTEO

--INSERT INTO APUESTA_SIMPLE ()
INSERT INTO BOLETO (FECHA_HORA,GANADO_TOTAL,ID_SORTEO,IMPORTE_TOTAL,REINTEGRO) VALUES 
(GETDATE(),0,@@IDENTITY,0,5)

INSERT INTO APUESTA_SIMPLE (GANADO,ID_BOLETO,N1,N2,N3,N4,N5,N6,NACERTADOS) VALUES
(0,@@IDENTITY,4,18,26,30,45,49,4)



SELECT * FROM SORTEO

/*
	*********************************************************************************************
	*************************************** P R U E B A S ***************************************
	*********************************************************************************************
*/
INSERT INTO SORTEO (FECHA, N1, N2, N3 , N4, N5, N6,REINTEGRO) VALUES(GETDATE(), 4,18,26,30,45,49,5)
--SELECT * FROM SORTEO
--EXEC GrabaSencilla 1, 2, 3, 4, 5, 6, 7
--EXEC dbo.GrabaMuchasSencillas 2, 100
--EXEC dbo.AsignarPremiosCat5 6
--SELECT * FROM APUESTA_SIMPLE ORDER BY GANADO DESC
EXEC ContarAciertosMultiples 1
SELECT * FROM DesarrolloPremios
SELECT * FROM APUESTA_MULTIPLE

INSERT INTO APUESTA_MULTIPLE(N1, N2, N3, N4, N5, N6, N7, COMPLEMENTARIOACERTADO, NACERTADOS, IMPORTE) VALUES (1, 2, 3, 4, 5, 6, 7, 1, 6, 1000)
