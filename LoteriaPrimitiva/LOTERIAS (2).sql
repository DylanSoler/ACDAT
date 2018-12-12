CREATE DATABASE LOTERIAS
USE LOTERIAS 
GO

--DROP DATABASE LOTERIAS

CREATE TABLE BOLETO(
	ID TINYINT NOT NULL
		CONSTRAINT PK_BOLETO Primary Key,
	ID_SORTEO TINYINT NOT NULL,
	REINTEGRO SMALLINT NOT NULL,
	FECHA_HORA SMALLDATETIME NOT NULL,
	IMPORTE_TOTAL MONEY NOT NULL,
	GANADO_TOTAL MONEY NULL
)

CREATE TABLE SORTEO(
	ID TINYINT NOT NULL
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
	CATEGORIA_ESPECIAL MONEY NULL,
	CATEGORIA_1 MONEY NULL,
	CATEGORIA_2 MONEY NULL,
	CATEGORIA_3 MONEY NULL,
	CATEGORIA_4 MONEY NULL,
	CATEGORIA_5 MONEY NULL
)

CREATE TABLE APUESTA_SIMPLE (
	ID TINYINT NOT NULL
		CONSTRAINT PK_APUESTA_SIMPLE Primary Key,
	ID_BOLETO TINYINT NOT NULL,
	N1 SMALLINT NOT NULL,
	N2 SMALLINT NOT NULL,
	N3 SMALLINT NOT NULL,
	N4 SMALLINT NOT NULL,
	N5 SMALLINT NOT NULL,
	N6 SMALLINT NOT NULL,
	COMPLEMENTARIO SMALLINT NOT NULL,
	GANADO MONEY NULL
)

CREATE TABLE APUESTA_MULTIPLE (
	ID TINYINT NOT NULL
		CONSTRAINT PK_MULTIPLE Primary Key,
	ID_BOLETO TINYINT NOT NULL,
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
	COMPLEMENTARIO SMALLINT NOT NULL,
	GANADO MONEY NULL,
	IMPORTE MONEY NOT NULL
)

GO

--AÑADO LAS FK CORRESPONDIENTES
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

GO

--/*	
--	Descripcion: Procedimiento usado para añadir un boleto con una sola apuesta simple.
--	Entradas:  El sorteo y los seis números
--	Salidas: Ninguna
--*/
--GO
--CREATE PROCEDURE GRABASENCILLA (@Id_Sorteo tinyint, @n1 smallint,@n2 smallint,@n3 smallint,@n4 smallint,@n5 smallint,@n6 smallint)
--AS
--	BEGIN

--	--DECLARAMOS LAS VARIABLES CORRESPONDIENTES
--	DECLARE @RANDOM_REINTEGRO INT
--	DECLARE @RANDOM_COMPLEMENTARIO INT

--	--VALIDAMOS EL COMPLEMENTARIO PARA QUE SEA DISTINTO DE TODOS LOS NUMEROS DEL BOLETO
--	SELECT @RANDOM_COMPLEMENTARIO = ROUND(((1 + 48) * RAND() + 1), 0)
	
--	WHILE(@RANDOM_COMPLEMENTARIO IN (@n1,@n2,@n3,@n4,@n5,@n6))
--	BEGIN
--		SELECT @RANDOM_COMPLEMENTARIO = ROUND(((1 + 48) * RAND() + 1), 0)
--	END
------------------------------------------------------------------------


--	--BUSCAMOS EL RANDOM PARA EL REINTEGRO
--	SELECT @RANDOM_REINTEGRO = ROUND(((1 + 8) * RAND() + 1), 0)
	
-------------------------------------------------------------------------

--			--INSERTAMOS EL BOLETO CON UNA APUESTA SIEMPLE
--			INSERT INTO BOLETO(FECHA_HORA,GANADO_TOTAL,ID_SORTEO,IMPORTE_TOTAL,REINTEGRO) 
--				VALUES (GETDATE(),NULL,@Id_Sorteo,1,@RANDOM_REINTEGRO)

--			INSERT INTO APUESTA_SIMPLE(COMPLEMENTARIO,GANADO,ID,ID_BOLETO,N1,N2,N3,N4,N5,N6)
--			VALUES (@RANDOM_COMPLEMENTARIO,NULL,@@IDENTITY,@n1,@n2,@n3,@n4,@n5,@n6)

--	END
--GO

--EXEC GRABASENCILLA 1,3,6,5,7,8,8

--SELECT * FROM BOLETO
--SELECT * FROM APUESTA_SIMPLE
--/*
--DECLARE @RANDOM INT
--SELECT @RANDOM = ROUND(((1 + 48) * RAND() + 1), 0)
--PRINT @RANDOM
--*/

--/*
	
--	Descripcion: Procedimiento que genere n boletos con sus apuestas sencillas
--	Entradas:  El sorteo y los boletos que queremos insertar
--	Salidas: Ninguna
--*/
--GO
--ALTER PROCEDURE GrabaMuchasSencillas (@Id_Sorteo tinyint, @nveces smallint)
--AS
--	BEGIN
--	--Declaramos e inicializamos las variables oportunas
--	DECLARE @RANDOM_REINTEGRO INT
--	DECLARE @CONT INT
--	SET @CONT = 0
--	DECLARE @N1 int 
--	DECLARE @N2 int 
--	DECLARE @N3 int 
--	DECLARE @N4 int 
--	DECLARE @N5 int 
--	DECLARE @N6 int
--	DECLARE @COMPLEMENTARIO INT 
-------------------------------------------------------------------------

--		--Mientras el contador quiera...TRACATRÁÁÁ!!
--		WHILE (@Cont != @nveces)
--		BEGIN
			
--			--Hacemos una random para conseguir los numeros
--			SET @N1 = ROUND((48 * RAND() + 1), 0)
--			SET @N2  = ROUND((48 * RAND() + 1), 0)
--			SET @N3  = ROUND((48 * RAND() + 1), 0)
--			SET @N4  = ROUND((48 * RAND() + 1), 0)
--			SET @N5  = ROUND((48 * RAND() + 1), 0)
--			SET @N6  = ROUND((48 * RAND() + 1), 0)
--			SET @Complementario = ROUND((48 * RAND() + 1), 0)

-------------------------------------------------------------------------
--			--Validamos que los numeros del boleto no sean iguales, ni el complementario
--			WHILE @N2 = @N1
--				SET @N2 = ROUND((48 * RAND() + 1), 0)

--			WHILE @N3 IN (@N2, @N1)
--				SET @N3 = ROUND((48 * RAND() + 1), 0)

--			WHILE @N4 IN (@N3, @N2, @N1)
--				SET @N4 = ROUND((48 * RAND() + 1), 0)

--			WHILE @N5 IN (@N4, @N3, @N2, @N1)
--				SET @N5 = ROUND((48 * RAND() + 1), 0)

--			WHILE @N6 IN (@N5, @N4, @N3, @N2, @N1)
--				SET @N6 = ROUND((48 * RAND() + 1), 0)

--			WHILE @Complementario IN (@N6, @N5, @N4, @N3, @N2, @N1)
--				SET @Complementario = ROUND((48 * RAND() + 1), 0)

--			--Sacamos un reintregro para el boleto a insertar
--			SELECT @RANDOM_REINTEGRO = ROUND(((8) * RAND() + 1), 0)
-------------------------------------------------------------------------
--				--Insertamos los valores obtenidos enlas validaciones anteriores
--				INSERT INTO BOLETO(FECHA_HORA,GANADO_TOTAL,ID_SORTEO,IMPORTE_TOTAL,REINTEGRO) 
--					VALUES (GETDATE(),NULL,@Id_Sorteo,1,@RANDOM_REINTEGRO)

--				INSERT INTO APUESTA_SIMPLE(COMPLEMENTARIO,ID_BOLETO,N1,N2,N3,N4,N5,N6)
--				VALUES (@COMPLEMENTARIO,@@IDENTITY,@N1,@N2,@N3,@N4,@N5,@N6)
-------------------------------------------------------------------------

--		--Sumamos al contador para salir del bucle cuando se acaben el numero de veces
--		SET @CONT = @CONT + 1

--	END
--END
--GO

--EXEC GrabaMuchasSencillas 1,10000
--SELECT * FROM BOLETO
--SELECT * FROM APUESTA_SIMPLE

--------------------------------------------------------------------------------------------------------------


/*GrabaMultiple  --IDENTITY ID_APUESTA_MULTIPLE, --CALCULAR IMPORTE

Procedimiento que graba una apuesta multiple

Entradas: id_sorteo, y entre 5 y 11 numeros
Salidas: no hay.

*/
GO
CREATE PROCEDURE GrabaMultiple (@Id_Sorteo tinyint, @n1 smallint,@n2 smallint,@n3 smallint,@n4 smallint,@n5 smallint
								,@n6 smallint = NULL,@n7 smallint = NULL,@n8 smallint = NULL,@n9 smallint = NULL
								,@n10 smallint = NULL,@n11 smallint = NULL)
AS
BEGIN

	DECLARE @complementario int
	DECLARE @reintegro int

	--Generamos el reintegro y el complementario de forma aleatoria
	SELECT @reintegro = FLOOR(RAND()*10)
	SELECT @complementario = FLOOR(RAND()*49+1)

	--Validamos que no coincida el complementario con ninguno de los numeros introducidos
	WHILE(@complementario IN (@n1,@n2,@n3,@n4,@n5,@n6,@n7,@n8,@n9,@n10,@n11))
	BEGIN
		SELECT @complementario = FLOOR(RAND()*49+1)
	END

	--Insertamos el boleto
	INSERT INTO BOLETO
		(ID_SORTEO, REINTEGRO, FECHA_HORA, IMPORTE_TOTAL, GANADO_TOTAL) 
	VALUES 
		(@Id_Sorteo, @reintegro, GETDATE(), 1, NULL)
	--Insertamos la apuesta multiple
	INSERT INTO APUESTA_MULTIPLE
		(ID_BOLETO, N1, N2, N3, N4, N5, N6, N7, N8, N9, N10, N11, COMPLEMENTARIO, GANADO, IMPORTE )
	VALUES 
		(@@IDENTITY, @n1, @n2, @n3, @n4, @n5, @n6, @n7, @n8, @n9, @n10, @n11, @complementario, NULL, 1)
	
END
GO


