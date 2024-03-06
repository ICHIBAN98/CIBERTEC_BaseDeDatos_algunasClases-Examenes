USE MASTER
GO

IF DB_ID('VENTA_AUTOS')IS NOT NULL
BEGIN
 DROP DATABASE VENTA_AUTOS
END
GO

CREATE DATABASE VENTA_AUTOS

SP_HELPDB VENTA_AUTOS
GO

USE VENTA_AUTOS 
GO

IF OBJECT_ID('concesionario') IS NOT NULL
BEGIN  
  DROP TABLE concesionario
END
GO

IF OBJECT_ID('concesionario') IS NOT NULL
BEGIN  
  DROP TABLE concesionario
END
GO
CREATE TABLE concesionario
(
codConcesionario		CHAR(8) NOT NULL,
nombre					VARCHAR(40) NOT NULL,
direccion				VARCHAR(30) NOT NULL,
telefonoConcesionario   VARCHAR (12) NOT NULL,
PRIMARY KEY (codConcesionario)
)
GO

IF OBJECT_ID('servicioOficial') IS NOT NULL
BEGIN  
  DROP TABLE servicioOficial
END
GO
CREATE TABLE servicioOficial
(
RUC						CHAR(11) NOT NULL,
nombre					VARCHAR(40) NOT NULL,
direccion				VARCHAR(30) NOT NULL,
codConcesionario		CHAR(8) NOT NULL,
PRIMARY KEY (RUC),
FOREIGN KEY (codConcesionario) REFERENCES concesionario
)
GO

IF OBJECT_ID('automovil') IS NOT NULL
BEGIN  
  DROP TABLE automovil
END
GO
CREATE TABLE automovil
(
codAutomovil			CHAR(10) NOT NULL,
modelo					VARCHAR(20) NOT NULL,
marca					VARCHAR(15) NOT NULL,
datosTecnicos			VARCHAR(100) NOT NULL,
precio					MONEY NOT NULL,
descuento				MONEY NOT NULL,
PRIMARY KEY (codAutomovil)
)
GO

IF OBJECT_ID('equipamiento') IS NOT NULL
BEGIN  
  DROP TABLE equipamiento
END
GO
CREATE TABLE equipamiento
(
codEquipamiento			CHAR(10) NOT NULL,
cierreCentralizado		BIT NOT NULL,
airbagConductor 		BIT NOT NULL,
codAutomovil			CHAR(10) NOT NULL,
PRIMARY KEY (codEquipamiento),
FOREIGN KEY (codAutomovil) REFERENCES automovil
)
GO

IF OBJECT_ID('equipExtra') IS NOT NULL
BEGIN  
  DROP TABLE equipExtra
END
GO
CREATE TABLE equipExtra
(
codEquipExtra			CHAR(10) NOT NULL,
precioExtra				MONEY NOT NULL,
aireAcondicionado 		BIT NOT NULL,
airbagAcompañante		BIT NOT NULL,
pinturaMetalizada		BIT NOT NULL,
codAutomovil			CHAR(10) NOT NULL,
PRIMARY KEY (codEquipExtra),
FOREIGN KEY (codAutomovil) REFERENCES automovil
)
GO

IF OBJECT_ID('automovil_concesionario') IS NOT NULL
BEGIN  
  DROP TABLE automovil_concesionario
END
GO
CREATE TABLE automovil_concesionario
(
codAutomovil			CHAR(10) NOT NULL,
codConcesionario		CHAR(8) NOT NULL,
PRIMARY KEY (codAutomovil, codConcesionario),
FOREIGN KEY (codAutomovil) REFERENCES automovil,
FOREIGN KEY (codConcesionario) REFERENCES concesionario
)
GO

IF OBJECT_ID('vendedor') IS NOT NULL
BEGIN  
  DROP TABLE vendedor
END
GO
CREATE TABLE vendedor
(
codVendedor			CHAR(10) NOT NULL,
nombre				VARCHAR(60) NOT NULL,
DNI 				VARCHAR(8) NOT NULL,
telefonoVendedor	VARCHAR(12) NOT NULL,
codConcesionario		CHAR(8) NOT NULL,
PRIMARY KEY (codVendedor),
FOREIGN KEY (codConcesionario) REFERENCES concesionario
)
GO

IF OBJECT_ID('boletaVenta') IS NOT NULL
BEGIN  
  DROP TABLE boletaVenta
END
GO
CREATE TABLE boletaVenta
(
codBoleta			CHAR(15) NOT NULL,
codVendedor			CHAR(10) NOT NULL,
precioTotal 		MONEY NOT NULL,
metodoPago			VARCHAR(10) NOT NULL,
PRIMARY KEY (codBoleta),
FOREIGN KEY (codVendedor) REFERENCES vendedor
)
GO

IF OBJECT_ID('cliente') IS NOT NULL
BEGIN  
  DROP TABLE cliente
END
GO
CREATE TABLE cliente
(
codCliente			CHAR(15) NOT NULL,
nombre				CHAR(40) NOT NULL,
direccion 			VARCHAR(50) NOT NULL,
telefonoCliente		VARCHAR(12) NOT NULL,
PRIMARY KEY (codCliente)
)
GO

IF OBJECT_ID('atencion') IS NOT NULL
BEGIN  
  DROP TABLE atencion
END
GO
CREATE TABLE atencion
(
codVendedor			CHAR(10) NOT NULL,
codCliente			CHAR(15) NOT NULL,
PRIMARY KEY (codVendedor, codCliente),
FOREIGN KEY (codVendedor) REFERENCES vendedor,
FOREIGN KEY (codCliente) REFERENCES cliente
)
GO