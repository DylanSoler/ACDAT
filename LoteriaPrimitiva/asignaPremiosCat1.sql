
USE LOTERIAS
GO

--Devuelve el numero de aciertos de una apuesta multiple------------------------------------------------------------
GO
CREATE FUNCTION aciertosApuestaMult (@IDApuesta int)
RETURNS Int AS
BEGIN
	DECLARE @aciertos int = 0
	
	--obtienes numero sorteo
	DECLARE @IDSorteo int

	SELECT @IDSorteo=S.ID
	FROM SORTEO AS S
	INNER JOIN BOLETO AS B ON S.ID=B.ID_SORTEO
	INNER JOIN APUESTA_MULTIPLE AS APM ON B.ID=APM.ID_BOLETO
	WHERE APM.ID=@IDApuesta

	--asignar numeros sorteo a variables
	DECLARE @S1 tinyint
	DECLARE @S2 tinyint
	DECLARE @S3 tinyint
	DECLARE @S4 tinyint
	DECLARE @S5 tinyint
	DECLARE @S6 tinyint
	SELECT @S1=N1,  @S2=N2,  @S3=N3,  @S4=N4,  @S5=N5,  @S6=N6 FROM SORTEO WHERE ID=@IDSorteo
		
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
	SELECT @A1=N1,  @A2=N2,  @A3=N3,  @A4=N4,  @A5=N5,  @A6=N6, @A7=N7, @A8=N8,  @A9=N9,  @A10=N10, @A11=N11 FROM APUESTA_MULTIPLE WHERE ID=@IDApuesta

	--comparas y cuentas aciertos
	IF (@A1=@S1 OR @A1=@S2 OR @A1=@S3 OR @A1=@S4 OR @A1=@S5 OR @A1=@S6)
		SET @aciertos = @aciertos +1
	IF (@A2=@S1 OR @A2=@S2 OR @A2=@S3 OR @A2=@S4 OR @A2=@S5 OR @A2=@S6)
		SET @aciertos = @aciertos +1
	IF (@A3=@S1 OR @A3=@S2 OR @A3=@S3 OR @A3=@S4 OR @A3=@S5 OR @A3=@S6)
		SET @aciertos = @aciertos +1
	IF (@A4=@S1 OR @A4=@S2 OR @A4=@S3 OR @A4=@S4 OR @A4=@S5 OR @A4=@S6)
		SET @aciertos = @aciertos +1
	IF (@A5=@S1 OR @A5=@S2 OR @A5=@S3 OR @A5=@S4 OR @A5=@S5 OR @A5=@S6)
		SET @aciertos = @aciertos +1
	IF (@A6=@S1 OR @A6=@S2 OR @A6=@S3 OR @A6=@S4 OR @A6=@S5 OR @A6=@S6)
		SET @aciertos = @aciertos +1
	IF (@A7=@S1 OR @A7=@S2 OR @A7=@S3 OR @A7=@S4 OR @A7=@S5 OR @A7=@S6)
		SET @aciertos = @aciertos +1
	IF (@A8=@S1 OR @A8=@S2 OR @A8=@S3 OR @A8=@S4 OR @A8=@S5 OR @A8=@S6)
		SET @aciertos = @aciertos +1
	IF (@A9=@S1 OR @A9=@S2 OR @A9=@S3 OR @A9=@S4 OR @A9=@S5 OR @A9=@S6)
		SET @aciertos = @aciertos +1
	IF (@A10=@S1 OR @A10=@S2 OR @A10=@S3 OR @A10=@S4 OR @A10=@S5 OR @A10=@S6)
		SET @aciertos = @aciertos +1
	IF (@A11=@S1 OR @A11=@S2 OR @A11=@S3 OR @A11=@S4 OR @A11=@S5 OR @A11=@S6)
		SET @aciertos = @aciertos +1

	RETURN @aciertos

END
GO



--Devuelve el numero de aciertos de una apuesta sencilla------------------------------------------------------------
GO
CREATE FUNCTION aciertosApuestaSencilla (@IDApuesta int)
RETURNS Int AS
BEGIN
	DECLARE @aciertos int = 0
	
	--obtienes numero sorteo
	DECLARE @IDSorteo int

	SELECT @IDSorteo=S.ID
	FROM SORTEO AS S
	INNER JOIN BOLETO AS B ON S.ID=B.ID_SORTEO
	INNER JOIN APUESTA_MULTIPLE AS APM ON B.ID=APM.ID_BOLETO
	WHERE APM.ID=@IDApuesta

	--asignar numeros sorteo a variables
	DECLARE @S1 tinyint
	DECLARE @S2 tinyint
	DECLARE @S3 tinyint
	DECLARE @S4 tinyint
	DECLARE @S5 tinyint
	DECLARE @S6 tinyint
	SELECT @S1=N1,  @S2=N2,  @S3=N3,  @S4=N4,  @S5=N5,  @S6=N6 FROM SORTEO WHERE ID=@IDSorteo
		
	--asignar numeros apuesta a variables
	DECLARE @A1 tinyint
	DECLARE @A2 tinyint
	DECLARE @A3 tinyint
	DECLARE @A4 tinyint
	DECLARE @A5 tinyint
	DECLARE @A6 tinyint
	SELECT @A1=N1,  @A2=N2,  @A3=N3,  @A4=N4,  @A5=N5,  @A6=N6 FROM APUESTA_SIMPLE WHERE ID=@IDApuesta

	--comparas y cuentas aciertos
	IF (@A1=@S1 OR @A1=@S2 OR @A1=@S3 OR @A1=@S4 OR @A1=@S5 OR @A1=@S6)
		SET @aciertos = @aciertos +1
	IF (@A2=@S1 OR @A2=@S2 OR @A2=@S3 OR @A2=@S4 OR @A2=@S5 OR @A2=@S6)
		SET @aciertos = @aciertos +1
	IF (@A3=@S1 OR @A3=@S2 OR @A3=@S3 OR @A3=@S4 OR @A3=@S5 OR @A3=@S6)
		SET @aciertos = @aciertos +1
	IF (@A4=@S1 OR @A4=@S2 OR @A4=@S3 OR @A4=@S4 OR @A4=@S5 OR @A4=@S6)
		SET @aciertos = @aciertos +1
	IF (@A5=@S1 OR @A5=@S2 OR @A5=@S3 OR @A5=@S4 OR @A5=@S5 OR @A5=@S6)
		SET @aciertos = @aciertos +1
	IF (@A6=@S1 OR @A6=@S2 OR @A6=@S3 OR @A6=@S4 OR @A6=@S5 OR @A6=@S6)
		SET @aciertos = @aciertos +1

	RETURN @aciertos

END
GO



--PRUEBAS---------------------------------------------------------------------------------
/*
SELECT dbo.aciertosApuestaMult(11)
SELECT * FROM APUESTA_MULTIPLE WHERE ID=11
SELECT * FROM SORTEO WHERE ID=12
*/
SELECT DBO.aciertosApuestaMult(ID) AS ACIERTOS
FROM APUESTA_MULTIPLE

SELECT DBO.aciertosApuestaSencilla(ID) AS ACIERTOS
FROM APUESTA_SIMPLE


INSERT INTO SORTEO
	(FECHA,N1,N2,N3,N4,N5,N6,COMPLEMENTARIO,REINTEGRO)
VALUES
	(GETDATE(),1,2,3,4,5,6,10,7)

SELECT * FROM SORTEO


EXEC GrabaMultiple 1,6,5,4,3,2,1,7
EXEC GrabaMultiple 1,2,3,12,13,14,15,23
SELECT * FROM APUESTA_MULTIPLE


EXEC GrabaSencilla 1,1,2,3,4,5,6
EXEC GrabaSencilla 1,1,2,3,4,8,9
SELECT * FROM APUESTA_SIMPLE

---------------------------------------------------------------------------------------------------


/*asignarPremiosCat1

Procedimiento que asigna el dinero ganado por cada apuesta acertada en la categoria 1
en un sorteo indicado

Entradas: id_sorteo
Salidas: no hay.

*/
GO
CREATE PROCEDURE AsignarPremiosCat1 (@IdSorteo int)
AS
BEGIN

		--OBTENEMOS EL NUMERO TOTAL DE ACERTANTES DE LA CATEGORIA 1
			DECLARE @TotalGanadoras tinyint
			
			--CONTAMOS PRIMERO LAS SIMPLES
			SELECT @TotalGanadoras = COUNT(DBO.aciertosApuestaSencilla(APS.ID))
			FROM APUESTA_SIMPLE AS APS
			INNER JOIN BOLETO AS B
				ON APS.ID_BOLETO=B.ID
			INNER JOIN SORTEO AS S
				ON B.ID_SORTEO=S.ID
			WHERE S.ID=@IdSorteo
			--CONTAMOS LAS MULTIPLES
			SELECT @TotalGanadoras += COUNT(DBO.aciertosApuestaMult(APM.ID))
			FROM APUESTA_MULTIPLE AS APM
			INNER JOIN BOLETO AS B
				ON APM.ID_BOLETO=B.ID
			INNER JOIN SORTEO AS S
				ON B.ID_SORTEO=S.ID
			WHERE S.ID=@IdSorteo

		--ACTUALIZAMOS EL DINERO GANADO DE CADA APUESTA ACERTADA (AUN NO COMPLETO)

			--PRIMERO LAS APUESTAS SIMPLES
			UPDATE APUESTA_SIMPLE
				SET GANADO = (SELECT CATEGORIA_5 FROM SORTEO WHERE ID=@IdSorteo) / @TotalGanadoras
				WHERE ID IN (
								SELECT ID FROM (
								SELECT APS.ID, dbo.aciertosApuestaSencilla(APS.ID) AS aciertos
								FROM APUESTA_SIMPLE AS APS
								INNER JOIN BOLETO AS B
									ON APS.ID_BOLETO=B.ID
								WHERE B.ID_SORTEO=@IdSorteo
								) AS apAciertos
								WHERE aciertos=6
							)

			--LAS APUESTAS MULTIPLES



	
END
GO




--PRUEBAAAAAAAAAAAAAAAAAAAAAASSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSS
SELECT * FROM SORTEO WHERE ID=12
SELECT * FROM BOLETO WHERE ID_SORTEO=12
SELECT * FROM APUESTA_SIMPLE WHERE ID_BOLETO=20

EXEC GrabaSencillaAleatoria 1000, 12
SELECT * FROM APUESTA_SIMPLE

INSERT INTO APUESTA_SIMPLE
	(ID_BOLETO,N1,N2,N3,N4,N5,N6,COMPLEMENTARIO,GANADO)
VALUES
	(20,1,20,34,7,13,46,6,NULL)

UPDATE SORTEO
SET CATEGORIA_5=100
WHERE ID=12

----------------------------------------------------------------------------------------------------------------------


SELECT * FROM APUESTA_MULTIPLE AS APM
INNER JOIN BOLETO AS B
	ON APM.ID_BOLETO=B.ID
INNER JOIN SORTEO AS S
	ON B.ID_SORTEO=S.ID
WHERE S.ID=12
----------------------------------------------------------------------------------------------------------------------

