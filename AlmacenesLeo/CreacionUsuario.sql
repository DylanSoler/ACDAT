--Creacion del usuario

CREATE LOGIN JefeAlmacen with password='elputojefe',
DEFAULT_DATABASE=AlmacenesLeo

USE AlmacenesLeo

CREATE USER JefeAlmacen FOR LOGIN JefeAlmacen
GRANT EXECUTE, INSERT, UPDATE, DELETE, SELECT TO JefeAlmacen

ALTER ROLE db_datawriter ADD MEMBER JefeAlmacen
ALTER ROLE db_owner ADD MEMBER JefeAlmacen
ALTER ROLE db_datareader ADD MEMBER JefeAlmacen

