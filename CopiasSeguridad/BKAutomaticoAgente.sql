
--USE MSDB
--DECLARE @FicheroBackup NVarChar(40)
---- Obtenemos el nombre del dispositivo
--SELECT @FicheroBackup = Valor FROM TL_Parametros WHERE Den = 'BK_Fichero'
-- Creamos el dispositivo de copia de seguridad
--EXEC sp_dropdevice BKEjemplos
EXEC sp_addumpdevice 'disk', 'BKEjemplos', 'C:\\temp\\CopiasSeguridad\\BDEjemplos.bk'
-- La carpeta debe existir

-- Creamos la tarea del Agente
EXEC sp_add_job
    @job_name = N'BackupNocturno' ;

-- Añadimos el primer paso a la tarea: Poner la Base de datos en modo solo lectura
EXEC sp_add_jobstep
    @job_name = N'BackupNocturno',
    @step_name = N'Set database to read only',
    @subsystem = N'TSQL',
    @command = N'ALTER DATABASE Ejemplos SET READ_ONLY', 
    @retry_attempts = 5,
    @retry_interval = 5 ;
-- Siguiente paso: Ejecutamos la copia
EXEC sp_add_jobstep
    @job_name = N'BackupNocturno',
    @step_name = N'Ejecutar copia de seguridad',
    @subsystem = N'TSQL',
    @command = N'BACKUP DATABASE Ejemplos TO BKEjemplos', 
    @retry_attempts = 5,
    @retry_interval = 5 ;

-- Por último volvemos a poner la Base de datos en modo de lectura y escritura
EXEC sp_add_jobstep
    @job_name = N'BackupNocturno',
    @step_name = N'Set database to read and write',
    @subsystem = N'TSQL',
    @command = N'ALTER DATABASE Ejemplos SET READ_WRITE', 
    @retry_attempts = 5,
    @retry_interval = 5 ;

--Programamos la tarea
EXEC sp_add_schedule
    @schedule_name = N'EjecutarBackUp',
    @freq_type = 4,		-- El intervalo se expresa en dias
	@freq_interval = 1,	-- Cada 1 dia
    @active_start_time = 233000 ; -- A las 23:30

-- Y asociamos la programación con la tarea
EXEC sp_attach_schedule
   @job_name = N'BackupNocturno',
   @schedule_name = N'EjecutarBackUp' ;