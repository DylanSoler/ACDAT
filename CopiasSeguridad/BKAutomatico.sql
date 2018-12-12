USE TransLeo  -- O la base de datos en cuestion
GO
-- ESTE CREA EL DISPOSITIVO, SI HACE FALTA, Y EJECUTA LA COPIA DE SEGURIDAD
CREATE PROCEDURE ProgramaBackup AS 
DECLARE @FicheroBackup AS Varchar(50), @nombreActual AS nVarchar(260),
	    @Tiempo SmallDatetime

SELECT @FicheroBackup = Valor FROM TL_Parametros WHERE Den = 'BK_Fichero'
	-- COMPROBAMOS SI EXISTE EL DISPOSITIVO DE BackUp "MyTransleo"
SELECT @nombreActual = phyname FROM master.dbo.sysdevices WHERE name = 'MyTransleo' 
IF  (@@ROWCOUNT > 0)
BEGIN
	IF (@nombreActual <> @FicheroBackup)
	BEGIN
		EXEC sp_dropdevice MyTransleo
		EXEC sp_addumpdevice 'disk', 'MyTransleo', @FicheroBackup
		-- Crea el dispositivo de copia de seguridad.
		-- La carpeta debe existir
	END
END
ELSE
	EXEC sp_addumpdevice 'disk', 'MyTransleo', @FicheroBackup
	-- FIN del IF
SET @Tiempo = GETDATE();
	-- Actualizamos el tiempo del último intento
UPDATE TL_Parametros SET Valor = @Tiempo WHERE Den = 'BK_UltimoIntento'
	-- Ejecutamos la copia de seguridad
BACKUP DATABASE Transleo TO MyTransLeo
	-- Si sale bien, actalizamos la fecha del último éxito
IF (@@ERROR = 0)
	UPDATE TL_Parametros SET Valor = @Tiempo WHERE Den = 'BK_UltimoExito'
-- FIN del PROCEDURE ProgramaBackup


-- Creamos la tabla de los parámetros
GO
/*Create Table TL_Parametros (
	Den Varchar(20) Primary Key,
	Valor Varchar (50) Not Null)
*/
GO

-- El demonio ha de crearse en master. Y hay que tener permisos, claro
USE master
GO
CREATE PROCEDURE TL_BK_Demonio AS
DECLARE @Unidad VarChar(50), @UnidadFecha Char(2),@Periodo SmallInt, 
	@Ultimo SmallDatetime, @Proximo SmallDatetime, 
	@HoraInicio VarChar(50), @MinutoInicio VarChar(50)
SELECT * FROM TransLeo.dbo.TL_Parametros
IF (@@ROWCOUNT > 0) --La copia de seguridad está configurada
WHILE (2+2=4) -- Hasta el infinito... ¡y más allá!
BEGIN
-- Calculamos cuándo hay que hacer la copia
	SELECT @Ultimo = Valor FROM TransLeo.dbo.TL_Parametros WHERE Den = 'BK_UltimoIntento'
	SELECT @Periodo = Valor FROM TransLeo.dbo.TL_Parametros WHERE Den = 'BK_Periodo'
	SELECT @Unidad = Valor FROM TransLeo.dbo.TL_Parametros WHERE Den = 'BK_UnidadPeriodo'
	IF (@Periodo = 0)
		SET @Periodo = 1
	SET @Proximo = CASE 
		WHEN @Unidad = 'D' THEN DATEADD (Day, @Periodo, @Ultimo) -- Días
		WHEN @Unidad = 'S' THEN DATEADD (Week, @Periodo, @Ultimo) -- Semanas
		WHEN @Unidad = 'M' THEN DATEADD (Month, @Periodo, @Ultimo) -- Meses
		ELSE DATEADD (Day, @Periodo, @Ultimo)
	END
	SET @Proximo = DATEADD( Hour, -1, @Proximo) -- Le restamos una hora, ya que de no hacerlo así llegaríamos un día tarde
	WHILE (DATEDIFF( Hour, GETDATE(), @Proximo) >24 ) -- Queda más de un día (24 horas)
	BEGIN
		WAITFOR DELAY '12:00'
		WAITFOR DELAY '12:00'
	END
	-- Falta menos de un dia
	SELECT @HoraInicio = Valor FROM TransLeo.dbo.TL_Parametros WHERE Den = 'BK_HoraInicio'
	SELECT @MinutoInicio = Valor FROM TransLeo.dbo.TL_Parametros WHERE Den = 'BK_MinutosInicio'
	SET @HoraInicio=@HoraInicio + ':' + @MinutoInicio
	WAITFOR TIME @HoraInicio
	EXEC TransLeo.dbo.ProgramaBackup  -- Ya era hora
END
ELSE
	Raiserror('La copia de seguridad no está correctamente programada. Ejecute la utilidad de configuración',16,1);

GO
IF EXISTS(SELECT * FROM sysobjects WHERE name = 'TL_BK_Demonio')
BEGIN
	sp_procoption TL_BK_Demonio, startup, true
	EXEC TL_BK_Demonio
END
