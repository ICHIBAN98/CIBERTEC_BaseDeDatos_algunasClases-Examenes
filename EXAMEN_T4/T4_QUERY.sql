USE MASTER
GO

IF DB_ID('VENTAS2023')IS NOT NULL
BEGIN
 DROP DATABASE VENTAS2023
END
GO

CREATE DATABASE VENTAS2023
GO

SP_HELPDB VENTAS2023
GO

USE VENTAS2023
GO



IF OBJECT_ID('CLIENTES') IS NOT NULL
BEGIN
 DROP TABLE CLIENTES
END
GO

CREATE TABLE CLIENTES
(
 ID_CLIENTE		CHAR(10)	NOT NULL,
 NOMBRE			VARCHAR(40)	NOT NULL,
 DIRECCION		VARCHAR(70)	NOT NULL,
 TELEFONO		VARCHAR(12)	NOT NULL,
 PRIMARY KEY(ID_CLIENTE) 
)
GO

IF OBJECT_ID('CATEGORIAS') IS NOT NULL
BEGIN
 DROP TABLE CATEGORIAS
END
GO

CREATE TABLE CATEGORIAS
(
 ID_CATEGORIA	CHAR(10)	NOT NULL,
 DESCRIPCION	VARCHAR(50)	NOT NULL,
 PRIMARY KEY(ID_CATEGORIA)
)
GO

IF OBJECT_ID('FACTURAS') IS NOT NULL
BEGIN
 DROP TABLE FACTURAS
END
GO

CREATE TABLE FACTURAS
(
 ID_FACTURA		CHAR(15)	NOT NULL,
 FECHA			DATE		NOT NULL,
 ID_CLIENTE		CHAR(10)	NOT NULL,
 PRIMARY KEY(ID_FACTURA),
 FOREIGN KEY (ID_CLIENTE) REFERENCES CLIENTES
)
GO

IF OBJECT_ID('PROVEEDORES') IS NOT NULL
BEGIN
 DROP TABLE PROVEEDORES
END
GO

CREATE TABLE PROVEEDORES
(
ID_PROVEEDOR	CHAR(10)	NOT NULL,
NOMBRE			VARCHAR(50) NOT NULL,
DIRECCION		VARCHAR(70) NOT NULL,
TELEFONO		VARCHAR(15) NOT NULL,
PRIMARY KEY (ID_PROVEEDOR)
)
GO

IF OBJECT_ID('PRODUCTOS') IS NOT NULL
BEGIN
 DROP TABLE PRODUCTOS
END
GO

CREATE TABLE PRODUCTOS
(
ID_PRODUCTO		CHAR(10)	NOT NULL,
DESCRIPCION		VARCHAR(70) NOT NULL,
PRECIO			MONEY		NOT NULL,
ID_CATEGORIA	CHAR(10)	NOT NULL,
ID_PROVEEDOR	CHAR(10)	NOT NULL,
PRIMARY KEY (ID_PRODUCTO),
FOREIGN KEY (ID_CATEGORIA) REFERENCES CATEGORIAS,
FOREIGN KEY (ID_PROVEEDOR) REFERENCES PROVEEDORES
)
GO

IF OBJECT_ID('VENTAS') IS NOT NULL
BEGIN
 DROP TABLE VENTAS
END
GO

CREATE TABLE VENTAS
(
ID_VENTA		CHAR(10)	NOT NULL,
ID_FACTURA		CHAR(15)	NOT NULL,
ID_PRODUCTO		CHAR(10)	NOT NULL,
CANTIDAD		INT			NOT NULL,
PRIMARY KEY (ID_VENTA),
FOREIGN KEY (ID_FACTURA) REFERENCES FACTURAS,
FOREIGN KEY (ID_PRODUCTO) REFERENCES PRODUCTOS
)
GO


---INGRESANDO REGISTROS

INSERT INTO CLIENTES
VALUES
('C00001', 'JUAN P�REZ', 'AV. LA MARINA 111, SAN MIGUEL, LIMA', '987654321'),
('C00002', 'MAR�A GARC�A', 'AV. PASEO COL�N 222, CERCADO DE LIMA, LIMA', '912345678'),
('C00003', 'CARLOS TORRES', 'AV. JAVIER PRADO ESTE 333, LA MOLINA, LIMA', '934567890'),
('C00004', 'ANA RODR�GUEZ', 'AV. ARENALES 444, LINCE, LIMA', '976543210'),
('C00005', 'PEDRO G�MEZ', 'AV. EL SOL 555, LA VICTORIA, LIMA', '945678901'),
('C00006', 'LAURA FLORES', 'AV. LA FONTANA 666, SAN ISIDRO, LIMA', '923456789'),
('C00007', 'MIGUEL S�NCHEZ', 'AV. ANGAMOS 777, SURQUILLO, LIMA', '954321078'),
('C00008', 'SOF�A RAM�REZ', 'AV. REP�BLICA DE PANAM� 888, SAN BORJA, LIMA', '967890123'),
('C00009', 'JORGE VARGAS', 'AV. SALAVERRY 999, JES�S MAR�A, LIMA', '998765432'),
('C00010', 'ISABEL MENDOZA', 'AV. TACNA 1010, BRE�A, LIMA', '932109876')
GO

SELECT * FROM CLIENTES
GO

INSERT INTO CATEGORIAS
VALUES
('CAT00001', 'ELECTRODOMESTICOS: PARA EL HOGAR'),
('CAT00002', 'MODA: ROPA, CALZADO Y ACCESORIOS DE MODA'),
('CAT00003', 'TECNOLOGIA: GADGETS, ELECTRONICOS Y ACCESORIOS'),
('CAT00004', 'MUEBLES: MOBILIARIO PARA HOGAR Y OFICINA'),
('CAT00005', 'DEPORTE: EQUIPAMIENTO Y ROPA DEPORTIVA'),
('CAT00006', 'BELLEZA: COSM�TICOS Y ACCESORIOS DE BELLEZA'),
('CAT00007', 'HOGAR: DECORACI�N Y ORGANIZACI�N DEL HOGAR'),
('CAT00008', 'JOYERIA: JOYAS, RELOJES Y ACCESORIOS DE LUJO'),
('CAT00009', 'LIBROS: LITERATURA, JUEGOS Y OCIO'),
('CAT00010', 'ALIMENTOS: COMESTIBLES, GOURMET Y SNACKS')
GO

SELECT * FROM CATEGORIAS
GO

INSERT INTO FACTURAS
VALUES
('FAC00001', '2023-10-24', 'C00001'),
('FAC00002', '2023-12-23', 'C00002'),
('FAC00003', '2023-11-22', 'C00003'),
('FAC00004', '2023-09-21', 'C00004'),
('FAC00005', '2023-07-20', 'C00005'),
('FAC00006', '2023-10-19', 'C00006'),
('FAC00007', '2023-10-18', 'C00007'),
('FAC00008', '2023-10-17', 'C00008'),
('FAC00009', '2023-11-16', 'C00009'),
('FAC00010', '2023-10-15', 'C00010'),
('FAC00011', '2023-12-19', 'C00003'),
('FAC00012', '2023-08-15', 'C00007'),
('FAC00013', '2023-04-20', 'C00009'),
('FAC00014', '2023-01-30', 'C00005')
GO

SELECT * FROM FACTURAS
GO

INSERT INTO PROVEEDORES
VALUES
('PROV00001', 'ROBERTO PEREZ', 'AV. JAVIER PRADO OESTE 111, SAN ISIDRO, LIMA', '987123456'),
('PROV00002', 'ANA MART�NEZ', 'AV. REP�BLICA DE PANAM� 222, MIRAFLORES, LIMA', '912234567'),
('PROV00003', 'CARLOS RAMOS', 'AV. AREQUIPA 333, LINCE, LIMA', '934345678'),
('PROV00004', 'MAR�A LOPEZ', 'AV. LA MAR 444, SAN MIGUEL, LIMA', '976456789'),
('PROV00005', 'JUAN GUTI�RREZ', 'AV. LOS PROCERES 555, SAN JUAN DE LURIGANCHO, LIMA', '945567890'),
('PROV00006', 'LAURA CASTILLO', 'AV. PER� 666, SAN BORJA, LIMA', '923678901'),
('PROV00007', 'MIGUEL RIVERA', 'AV. EL SOL 777, LA VICTORIA, LIMA', '954789012'),
('PROV00008', 'SOF�A TORO', 'AV. PASEO DE LA REP�BLICA 888, LIMA', '967890123'),
('PROV00009', 'JORGE SALAZAR', 'AV. T�PAC AMARU 999, RIMAC, LIMA', '998901234'),
('PROV00010', 'ISABEL D�AZ', 'AV. LOS INGENIEROS 1010, SURCO, LIMA', '932112345')
GO

SELECT * FROM PROVEEDORES
GO

INSERT INTO PRODUCTOS
VALUES
('PROD00001', 'Televisor LED 50 pulgadas', 1500.00, 'CAT00001', 'PROV00001'),
('PROD00002', 'Camisa de algod�n para hombre', 80.50, 'CAT00002', 'PROV00002'),
('PROD00003', 'Smartphone Android 128GB', 1200.00, 'CAT00003', 'PROV00003'),
('PROD00004', 'Sof� de cuero moderno', 2500.00, 'CAT00004', 'PROV00004'),
('PROD00005', 'Zapatillas running para mujer', 120.00, 'CAT00005', 'PROV00005'),
('PROD00006', 'Set de maquillaje profesional', 200.00, 'CAT00006', 'PROV00006'),
('PROD00007', 'Juego de s�banas de algod�n', 50.00, 'CAT00007', 'PROV00007'),
('PROD00008', 'Reloj de lujo con cron�grafo', 800.00, 'CAT00008', 'PROV00008'),
('PROD00009', 'Libro de bestseller internacional', 25.00, 'CAT00009', 'PROV00009'),
('PROD00010', 'Caja de chocolates premium', 30.00, 'CAT00010', 'PROV00010'),
('PROD00011', 'Smartwatch de �ltima generaci�n', 120.00, 'CAT00003', 'PROV00003'),
('PROD00012', 'Auriculares inal�mbricos AKG', 85.00, 'CAT00003', 'PROV00003'),
('PROD00013', 'Cargador para iPhone', 145.00, 'CAT00003', 'PROV00003'),
('PROD00014', 'Dron Velox5000', 750.00, 'CAT00003', 'PROV00003')
GO

SELECT * FROM PRODUCTOS
GO

INSERT INTO VENTAS
VALUES
('V00001', 'FAC00001', 'PROD00001', 2),
('V00002', 'FAC00002', 'PROD00002', 3),
('V00003', 'FAC00003', 'PROD00003', 1),
('V00004', 'FAC00004', 'PROD00004', 1),
('V00005', 'FAC00005', 'PROD00005', 4),
('V00006', 'FAC00006', 'PROD00006', 1),
('V00007', 'FAC00007', 'PROD00007', 2),
('V00008', 'FAC00008', 'PROD00008', 1),
('V00009', 'FAC00009', 'PROD00009', 3),
('V00010', 'FAC00010', 'PROD00010', 2),
('V00011', 'FAC00011', 'PROD00011', 5),
('V00012', 'FAC00012', 'PROD00012', 4),
('V00013', 'FAC00013', 'PROD00013', 9),
('V00014', 'FAC00014', 'PROD00014', 3)
GO

SELECT * FROM VENTAS
GO



---PREGUNTA 1

SELECT 
    P.ID_PRODUCTO AS 'ID PRODUCTO',
    P.DESCRIPCION AS 'DESCRIPCI�N DEL PRODUCTO',
    V.CANTIDAD AS 'CANTIDAD VENDIDA',
    P.PRECIO AS 'PRECIO POR UNIDAD'
FROM 
    VENTAS V
INNER JOIN 
    PRODUCTOS P ON V.ID_PRODUCTO = P.ID_PRODUCTO
INNER JOIN 
    FACTURAS F ON V.ID_FACTURA = F.ID_FACTURA
WHERE 
    MONTH(F.FECHA) = 10 AND YEAR(F.FECHA) = 2023
ORDER BY 
    P.PRECIO DESC
GO







---PREGUNTA 2

---EN LA TABLA PRODUCTOS

---PROCEDIMIENTO ALMACENADO RegistrarProducto

CREATE PROCEDURE RegistrarProducto
    @ID_PRODUCTO CHAR(10),
    @DESCRIPCION VARCHAR(70),
    @PRECIO MONEY,
    @ID_CATEGORIA CHAR(10),
    @ID_PROVEEDOR CHAR(10)
AS
BEGIN
    INSERT INTO PRODUCTOS
    VALUES (@ID_PRODUCTO, @DESCRIPCION, @PRECIO, @ID_CATEGORIA, @ID_PROVEEDOR)
END
GO

EXEC RegistrarProducto 'PROD00015', 'Laptop Ultrabook', 2000.00, 'CAT00003', 'PROV00003';

SELECT * FROM
PRODUCTOS
GO

---PROCEDIMIENTO ALMACENADO ActualizarProducto

CREATE PROCEDURE ActualizarProducto
    @ID_PRODUCTO CHAR(10),
    @DESCRIPCION VARCHAR(70),
    @PRECIO MONEY,
    @ID_CATEGORIA CHAR(10),
    @ID_PROVEEDOR CHAR(10)
AS
BEGIN
    UPDATE PRODUCTOS
    SET DESCRIPCION = @DESCRIPCION, PRECIO = @PRECIO, ID_CATEGORIA = @ID_CATEGORIA, ID_PROVEEDOR = @ID_PROVEEDOR
    WHERE ID_PRODUCTO = @ID_PRODUCTO
END
GO

EXEC ActualizarProducto 'PROD00015', 'Laptop Ultrabook Pro', 2500.00, 'CAT00003', 'PROV00003';

SELECT * FROM
PRODUCTOS
GO

---PROCEDIMIENTO ALMACENADO EliminarProducto

CREATE PROCEDURE EliminarProducto
    @ID_PRODUCTO CHAR(10)
AS
BEGIN
    DELETE FROM PRODUCTOS WHERE ID_PRODUCTO = @ID_PRODUCTO
END
GO

EXEC EliminarProducto 'PROD00015';

SELECT * FROM
PRODUCTOS
GO





---EN LA TABLA CATEGORIAS

---PROCEDIMIENTO ALMACENADO RegistrarCategoria

CREATE PROCEDURE RegistrarCategoria
    @ID_CATEGORIA CHAR(10),
    @DESCRIPCION VARCHAR(50)
AS
BEGIN
    INSERT INTO CATEGORIAS
    VALUES (@ID_CATEGORIA, @DESCRIPCION)
END
GO

EXEC RegistrarCategoria 'CAT00011', 'TECNOLOGIA: ACCESORIOS AVANZADOS';

SELECT * FROM
CATEGORIAS
GO

---PROCEDIMIENTO ALMACENADO ActualizarCategoria

CREATE PROCEDURE ActualizarCategoria
    @ID_CATEGORIA CHAR(10),
    @DESCRIPCION VARCHAR(50)
AS
BEGIN
    UPDATE CATEGORIAS
    SET DESCRIPCION = @DESCRIPCION
    WHERE ID_CATEGORIA = @ID_CATEGORIA
END
GO

EXEC ActualizarCategoria 'CAT00011', 'TECNOLOGIA: ACCESORIOS DE �LTIMA GENERACI�N';

SELECT * FROM
CATEGORIAS
GO

---PROCEDIMIENTO ALMACENADO EliminarCategoria

CREATE PROCEDURE EliminarCategoria
    @ID_CATEGORIA CHAR(10)
AS
BEGIN
    DELETE FROM CATEGORIAS WHERE ID_CATEGORIA = @ID_CATEGORIA
END
GO

EXEC EliminarCategoria 'CAT00011';

SELECT * FROM
CATEGORIAS
GO







---PREGUNTA 3

CREATE PROCEDURE Top5ProductosVendidos
    @descripcionCategoria VARCHAR(50)
AS
BEGIN
    SELECT TOP 5
        P.ID_PRODUCTO AS 'ID Producto',
        P.DESCRIPCION AS 'Descripci�n del Producto',
        V.CANTIDAD AS 'Cantidad Vendida',
        P.PRECIO AS 'Precio Unitario'
    FROM
        VENTAS V
    INNER JOIN
        PRODUCTOS P ON V.ID_PRODUCTO = P.ID_PRODUCTO
    INNER JOIN
        CATEGORIAS C ON P.ID_CATEGORIA = C.ID_CATEGORIA
    WHERE
        C.DESCRIPCION = @descripcionCategoria
    ORDER BY
        P.PRECIO DESC;
END
GO

EXEC Top5ProductosVendidos 'TECNOLOGIA: GADGETS, ELECTRONICOS Y ACCESORIOS'
GO







---PREGUNTA 4

---PROCEDIMIENTO ALMACENADO MostrarDatosProductoVendido

CREATE PROCEDURE MostrarDatosProductoVendido
    @fechaVenta DATE,
    @codigoProducto CHAR(10)
AS
BEGIN
    SELECT 
        P.ID_PRODUCTO AS 'ID PRODUCTO',
        P.DESCRIPCION AS 'DESCRIPCION',
        P.PRECIO AS 'PRECIO',
        P.ID_CATEGORIA AS 'ID CATEGORIA',
        C.DESCRIPCION AS 'CATEGORIA',
        P.ID_PROVEEDOR AS 'ID PROVEEDOR',
        PROV.NOMBRE AS 'NOMBRE PROVEEDOR'
    FROM
        PRODUCTOS P
    INNER JOIN
        CATEGORIAS C ON P.ID_CATEGORIA = C.ID_CATEGORIA
    INNER JOIN
        PROVEEDORES PROV ON P.ID_PROVEEDOR = PROV.ID_PROVEEDOR
    INNER JOIN
        VENTAS V ON P.ID_PRODUCTO = V.ID_PRODUCTO
    INNER JOIN
        FACTURAS F ON V.ID_FACTURA = F.ID_FACTURA
    WHERE
        V.ID_PRODUCTO = @codigoProducto
        AND F.FECHA = @fechaVenta
END
GO

---EJECUTANDO EL PROCEDIMIENTO ALMACENADO

EXEC MostrarDatosProductoVendido '2023-09-21', 'PROD00004'
GO

-----SUBCONSULTA
-- Con esta vamos a mostrar el ID, descripci�n y precio del producto m�s costoso:

SELECT 
	ID_PRODUCTO,DESCRIPCION,PRECIO
FROM 
	PRODUCTOS
WHERE PRECIO=(SELECT max(PRECIO) from PRODUCTOS)  
GO

---VISTA
-- Con esta vista vamos a almacenar una consulta que muestre la informaci�n
-- de los productos cuyo precio sea mayor a 700.00

CREATE VIEW vistaProductosCostosos AS
SELECT *
FROM PRODUCTOS
WHERE PRECIO>700.00
GO

SELECT * FROM
vistaProductosCostosos
GO