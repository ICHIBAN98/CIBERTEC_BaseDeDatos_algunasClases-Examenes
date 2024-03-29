----///////DML
----LENGUAJE DE MANIPULACION DE DATOS
----CLAUSULAS: INSERT , DELETE,UPDATE, SELECT
----OPERAR SOBRE LOS REGISTROS
----CREANDO LA BASE DE DATOS
---CREANDO BASE DE DATOS COMPUTER_PERU_SAC DE FORMA PERSONALIZADA EN UNA RUTA
----CREANDO 3 ARCHIVOS PERSONALIZADOS DEL SISTEMA DE LA BASE DE DATOS
IF DB_ID(' COMPUTER_PERU_SAC')IS NOT NULL
BEGIN
 DROP DATABASE COMPUTER_PERU_SAC
END
GO
CREATE DATABASE COMPUTER_PERU_SAC
ON
(
NAME= COMPUTER_PERU_SAC_PRI,
FILENAME='D:\DATA\COMPUTADORA\COMPUTER_PERU_SAC_PRI.MDF',
SIZE=40,
MAXSIZE=UNLIMITED,
FILEGROWTH=5MB
),
(
NAME=COMPUTER_PERU_SAC_SEC,
FILENAME='D:\DATA\COMPUTADORA\COMPUTER_PERU_SAC_SEC.NDF',
SIZE=50,
MAXSIZE=250,
FILEGROWTH=10%
)
LOG ON (
NAME=COMPUTER_PERU_SAC_LOG,
FILENAME='D:\DATA\COMPUTADORA\COMPUTER_PERU_SAC_LOG.LDF',
SIZE=5,
MAXSIZE=50,
FILEGROWTH=5
)
GO

-----VERIFICANDO LA BASE CREADA
SP_HELPDB COMPUTER_PERU_SAC
GO

---BASE ACTIVA COMPUTER_JH_SAC
USE COMPUTER_PERU_SAC
GO

---CREANDO UNA NUEVA TABLA LLAMADA : CATEGORIA_COMPU
IF OBJECT_ID('CATEGORIA_COMPU') IS NOT NULL
BEGIN  
  DROP TABLE CATEGORIA_COMPU
END
GO
CREATE TABLE CATEGORIA_COMPU
(
COD_CATEGORIA  CHAR(3)   NOT NULL,
NOMBRE     VARCHAR(25) NOT NULL,
PRIMARY KEY (COD_CATEGORIA)
)
GO

----CREANDO UNA NUEVA TABLA PRODUCTO
IF OBJECT_ID('PRODUCTO') IS NOT NULL
BEGIN  
  DROP TABLE PRODUCTO
END
GO
CREATE TABLE PRODUCTO
(
ID_PRODUCTO  CHAR(6)   NOT NULL,
NOMBRE_PROD  VARCHAR(45) NOT NULL,
DESCRIPCION  VARCHAR(100) NOT NULL,
PRECIO_VENTA  MONEY    NOT NULL,
STOCK_MINIMO  INT     NULL,
STOCK_MAXIMO  INT     NULL,
STOCK_ACTUAL  INT     NOT NULL,
FECHA_VENC   DATE     NULL,
PRECIO_COSTO  MONEY     NOT NULL,
COD_CATEGORIA CHAR(3)    NOT NULL,
PRIMARY KEY (ID_PRODUCTO),
FOREIGN KEY (COD_CATEGORIA) REFERENCES CATEGORIA_COMPU
)
GO

---CREANDO UNA NUEVA TABLA LLAMADA : DETALLE_BOLETA
IF OBJECT_ID('DETALLE_BOLETA') IS NOT NULL
BEGIN  
  DROP TABLE DETALLE_BOLETA
END
GO
CREATE TABLE DETALLE_BOLETA
(
NUM_BOLETA   CHAR(8)   NOT NULL,
ID_PRODUCTO   CHAR(6)   NOT NULL,
CANTIDAD    INT     NOT NULL,
IMPORTE     MONEY    NOT NULL,
idEmpleado   CHAR(8)   NOT NULL
PRIMARY KEY (NUM_BOLETA,ID_PRODUCTO)
FOREIGN KEY(ID_PRODUCTO)REFERENCES PRODUCTO
)
GO

----DML
---LENGUAJE DE MANIPULACION DE DATOS
----INSERT INTO
--- ESTA CLA�SULA PERMITE INSERTAR REGISTROS
INSERT INTO CATEGORIA_COMPU
VALUES
('C01','MAINBOARD'),
('C02','PROCESADORES'),
('C03','FUENTES'),
('C04','CASE'),
('C05','PARLANTES'),
('C06','MONITORES'),
('C07','TECLADOS'),
('C08','T_VIDEO'),
('C09','T_SONIDO'),
('C10','MOUSE'),
('C11','TECLADOS'),
('C12','M_RAM'),
('C13','ESTABILIZADORES'),
('C14','UPS')
GO

----CONSULTANDO LOS REGISTROS DE LA TABLA CATEGORIA_COMPU
SELECT * FROM CATEGORIA_COMPU
GO

------VOLVER A INSERTAR REGISTROS
INSERT INTO CATEGORIA_COMPU
VALUES
('C15','T_USB'),
('C16','POWERCERT'),
('C17','IMPRESORAS'),
('C18','T_RED'),
('C19','CAMARAS'),
('C20','TV'),
('C21','BLUERAY'),
('C22','GRABADORES'),
('C23','SMARTPHONE'),
('C24','T_HDMI'),
('C25','GAME')
GO

----CONSULTANDO LOS REGISTROS DE LA TABLA CATEGORIA_COMPU
SELECT * FROM CATEGORIA_COMPU
GO

----USANDO DELETE
----ELIMINANDO LOS REGISTROS DE C15 A C25
DELETE FROM CATEGORIA_COMPU
WHERE COD_CATEGORIA BETWEEN 'C15' AND 'C25'
GO

----CONSULTANDO LOS REGISTROS DE LA TABLA CATEGORIA_COMPU
SELECT * FROM CATEGORIA_COMPU
GO

---ACTUALIZAR REGISTROS
---UTILIZANDO UPDATE
UPDATE CATEGORIA_COMPU
SET  NOMBRE='T_DVI'
WHERE COD_CATEGORIA='C13'

----CONSULTANDO LOS REGISTROS DE LA TABLA CATEGORIA_COMPU
SELECT * FROM CATEGORIA_COMPU
GO

