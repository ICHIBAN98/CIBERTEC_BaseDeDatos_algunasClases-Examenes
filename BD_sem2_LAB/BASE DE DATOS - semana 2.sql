----UBICACION EN BASE DE DATOS MASTER
USE MASTER
GO

----BUSCAR / ELIMINAR / CREAR BASE DE DATOS Y SU ESTRUCTURA
IF DB_ID('COMERCIAL2023') IS NOT NULL
BEGIN
  DROP DATABASE COMERCIAL2023
END
GO

CREATE DATABASE COMERCIAL2023
ON
(
NAME=COMERCIAL_PRI,
FILENAME='D:\DATA\COMERCIAL\COMERCIAL_PRI.MDF',
SIZE=40,
MAXSIZE=250,
FILEGROWTH=5MB
),
(
NAME=COMERCIAL_SEC,
FILENAME='D:\DATA\COMERCIAL\COMERCIAL_SEC.NDF',
SIZE=50,
MAXSIZE=250,
FILEGROWTH=10%
)
LOG ON (
NAME=COMERCIAL_LOG,
FILENAME='D:\DATA\COMERCIAL\COMERCIAL_LOG.LDF',
SIZE=5,
MAXSIZE=50,
FILEGROWTH=5
)
GO

-----VERIFICANDO LA BASE CREADA
SP_HELPDB COMERCIAL2023
GO

----VERIFICADO TODAS LAS BASE DE DATOS EXISTENTES
SP_HELPDB
GO

---AGREGAR 2 ARCHIVOS SECUNDARIOS NDF A LA BASE DE DATOS CREADA
ALTER DATABASE COMERCIAL2023
ADD FILE
(
NAME=COMERCIAL_SEC2,
FILENAME='D:\DATA\COMERCIAL\COMERCIAL_SEC2.NDF',
SIZE=10,
MAXSIZE=50,
FILEGROWTH=10%
),
(
NAME=COMERCIAL_SEC3,
FILENAME='D:\DATA\COMERCIAL\COMERCIAL_SEC3.NDF',
SIZE=10,
MAXSIZE=100,
FILEGROWTH=15%
)
GO

--VERIFICANDO LOS ARCHIVOS CREADOS
SP_HELPDB COMERCIAL2023
GO

---ELIMINAR ARCHIVO SECUNDARIO "COMERCIAL_SEC2"
ALTER DATABASE COMERCIAL2023
REMOVE FILE COMERCIAL_SEC2
GO

--VERIFICANDO LOS ARCHIVOS CREADOS
SP_HELPDB COMERCIAL2023
GO

---CAMBIANDO EL NOMBRE DE LA BASE DE DATOS
ALTER DATABASE COMERCIAL2023
MODIFY NAME=TIENDA_COMERCIAL_2023
GO

--VERIFICANDO LOS ARCHIVOS CREADOS
SP_HELPDB COMERCIAL2023
GO

--VERIFICANDO LOS ARCHIVOS CREADOS
SP_HELPDB TIENDA_COMERCIAL_2023
GO

--VERIFICANDO TODAS LAS BASES DE DATOS EXISTENTES
SP_HELPDB 
GO