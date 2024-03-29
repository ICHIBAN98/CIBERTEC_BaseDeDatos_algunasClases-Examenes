---ESTANDO EN BASE DE DATOS ACTIVA MASTER
USE master
GO

----BUSCAR / ELIMINAR / CREAR BASE DE DATOS 
IF DB_ID('SUPERMERCADOS') IS NOT NULL
BEGIN
  DROP DATABASE SUPERMERCADOS
END
GO
CREATE DATABASE SUPERMERCADOS
GO

-----VERIFICANDO LA BASE CREADA
SP_HELPDB SUPERMERCADOS
GO

----VERIFICADO TODAS LAS BASE DE DATOS EXISTENTES
SP_HELPDB
GO

----ACTIVANDO LA BASE DE DATOS "SUPERMERCADOS"
USE SUPERMERCADOS
GO

----CREANDO OBJETOS: TABLAS 

--CREAR LA TABLA CARGO_EMP
CREATE TABLE CARGO_EMP
(
CODIGO_CAR INT    NOT NULL PRIMARY KEY,
DESCRI_CAR VARCHAR
)
GO

----CREAR LA TABLA DISTRITO
CREATE TABLE DISTRITO 
(
CODIGO_DIST CHAR (3)   NOT NULL PRIMARY KEY,
NOMBRE_DIST VARCHAR (50)
)
GO

--CREAR LA TABLA CATEGORIA_PROD
CREATE TABLE CATEGORIA_PROD
(
CODIGO_CAT CHAR (3)   NOT NULL PRIMARY KEY,
NOMBRE_CAT VARCHAR (40)
)
GO

--CREANDO LA TABLA EMPLEADO
--se referencia a otras 2 tablas y se conectan mediante los atributos PRIMARIOS de esas tablas con las que se conectan. no necesariamente deben llamarse igual
CREATE TABLE EMPLEADO 
(
CODIGO_EMP  INT      NOT NULL PRIMARY KEY,
APELLI_EMP  VARCHAR (30) NOT NULL,
NOMBRE_EMP  VARCHAR (30) NOT NULL,
FECHANAC_EMP DATE     NOT NULL,
DIRECC_EMP  VARCHAR (60) NOT NULL,
FECHAING_EMP DATE     NOT NULL,
CORREO_EMP  VARCHAR (35) NULL,
TELEFO_EMP  VARCHAR (15) NULL,
CODIGO_CAR  INT      REFERENCES CARGO_EMP,
CODIGO_DIS  CHAR (3)   REFERENCES DISTRITO
)
GO

--CREANDO LA TABLA CLIENTE
-- tambi�n esta conectado/referenciando la tabla DISTRITO mediante su atributo PRIMARIO (de dicha tabla DISTRITO)
CREATE TABLE CLIENTE 
(
CODIGO_CLI CHAR (6) NOT NULL PRIMARY KEY,
NOMBRE_CLI VARCHAR (30) NOT NULL,
APATER_CLI VARCHAR (30) NOT NULL,
AMATER_CLI VARCHAR (30) NOT NULL,
DIRECC_CLI VARCHAR (50) NULL,
TELEFO_CLI VARCHAR (12) NULL,
CODIGO_DIS CHAR (3) NOT NULL REFERENCES DISTRITO,
CORREO_CLI VARCHAR (30) NULL
)
GO

---BUSCAR LA TABLA PRODUCTO... si lo encuentra entonces...
---ELIMINA LA TABLA PRODUCTO
---CREANDO LA TABLA PRODUCTO
---tambi�n referencia a otra tabla y se conecta mediante el atributo SECUNDARIO de esta tabla y el atributo PRIMARIO de dicha tabla a la que se conecta
IF OBJECT_ID('PRODUCTO') IS NOT NULL
BEGIN
 DROP TABLE PRODUCTO
END
GO
CREATE TABLE PRODUCTO 
(
CODIGO_PRO CHAR (6)   NOT NULL PRIMARY KEY,
DESCRI_PRO VARCHAR (50) NOT NULL,
PRE_VEN_PRO MONEY     NOT NULL,
ST_ACT_PRO INT      NOT NULL,
ST_MIN_PRO INT      NOT NULL,
FEC_VEN_PRO DATE     NOT NULL,
CODIGO_CAT CHAR (3)   NOT NULL REFERENCES CATEGORIA_PROD
) 
GO

--CREANDO LA TABLA BOLETA
CREATE TABLE BOLETA
(
NRO_BOLETA CHAR (6)  NOT NULL  PRIMARY KEY,
FECHA_VENTA DATE    NOT NULL,
CODIGO_CLI CHAR (6)  NOT NULL  REFERENCES  CLIENTE,
CODIGO_EMP INT     NOT NULL  REFERENCES  EMPLEADO,
CODIGO_PRO CHAR (6)  NOT NULL  REFERENCES  PRODUCTO,
CANTID_DET INT     NOT NULL,
ESTADO_BOL CHAR (2) ,
PRECIO_DET MONEY
)
GO

