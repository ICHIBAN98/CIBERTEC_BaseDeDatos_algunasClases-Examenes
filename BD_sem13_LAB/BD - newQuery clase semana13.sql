-----ACTIVAR LA BASE MASTER
USE MASTER
GO

----CREANDO NUEVA BASE DE DATOS
----BIBILOTECA_CENTRAL
IF DB_ID('BIBLIOTECA_CENTRAL')IS NOT NULL
BEGIN
 DROP DATABASE BIBLIOTECA_CENTRAL
END
GO

CREATE DATABASE BIBLIOTECA_CENTRAL
GO

---ACTIVAR LA BASE DE DATOS CREADA
USE BIBLIOTECA_CENTRAL
GO

---CREANDO UNA NUEVA TABLA LLAMADA : LIBROS
if object_id('libros') is not null
BEGIN
 drop table libros
END
GO

create table libros(
 codigo   int identity,
 titulo   varchar(40),
 autor   varchar(30),
 editorial varchar(20),
 precio   decimal(5,2)
 primary key(codigo) 
)
GO

---INSERTANDO DATOS EN LA TABLA LIBROS
insert into libros values('Alicia en el pais de las maravillas','Lewis Carroll','Emece',20.00);
insert into libros values('Alicia en el pais de las maravillas','Lewis Carroll','Plaza',35.00);
insert into libros values('Aprenda PHP','Mario Molina','Siglo XXI',40.00);
insert into libros values('El aleph','Borges','Emece',10.00);
insert into libros values('Ilusiones','Richard Bach','Planeta',15.00);
insert into libros values('Java en 10 minutos','Mario Molina','Siglo XXI',50.00);
insert into libros values('Martin Fierro','Jose Hernandez','Planeta',20.00);
insert into libros values('Martin Fierro','Jose Hernandez','Emece',30.00);
insert into libros values('Uno','Richard Bach','Planeta',10.00);

---REALIZANDO CONSULTA
SELECT * FROM libros
GO

---CREANDO PROCEDIMIENTOS ALMACENADOS DEFINIDOS POR USUSARIO
----SON OBJETOS
-- Creamos el procedimiento almacenado "libros_por_autor_editorial2" que recibe los mismos
-- parámetros, esta vez definimos valores por defecto para cada parámetro:
IF OBJECT_ID ('libros_por_autor_editorial2') IS NOT NULL
BEGIN
 DROP PROCEDURE libros_por_autor_editorial2
END
GO

create procedure libros_por_autor_editorial2
 @autor varchar(30)='Richard Bach',
 @editorial varchar(20)='Planeta' 
 as
 select titulo,autor,editorial,precio
  from libros
  where autor= @autor and
  editorial=@editorial;
go

---REALIZANDO CONSULTA
SELECT * FROM LIBROS
GO


-- Ejecutamos el procedimiento anterior sin enviarle valores para verificar que usa 
-- los valores por defecto (Muestra los libros de "Richard Bach" y editorial
-- "Planeta" (valores por defecto)):
exec libros_por_autor_editorial2;

---especificando un solo parametro
exec libros_por_autor_editorial2 @autor='Jose Hernadez'

-- Especificamos los 2 parámetros, enviando parámetros por nombre y editorial:
exec libros_por_autor_editorial2 @editorial='Planeta', @autor='Jose Hernandez';


----PROCEDIMIENTOS ALMACENADOS DEFINIDOS POR USUARIO
----VERIFICANDO PROCESOS AL MACENADOS
SELECT * FROM SYS.sysobjects P WHERE P.xtype='P'
GO


-- Definimos un procedimiento empleando patrones de búsqueda 
-- (antes verificamos si existe para eliminarlo):
if object_id('libros_por_autor_editorial3') is not null
begin
 drop procedure libros_por_autor_editorial3;
end
go

 create proc libros_por_autor_editorial3
 @autor varchar(30) = '%',
 @editorial varchar(30) = '%'
 as 
 select titulo,autor,editorial,precio
  from libros
  where autor like @autor and
  editorial like @editorial;
go

---REALIZANDO CONSULTA
SELECT * FROM LIBROS
GO

-- Ejecutamos el procedimiento especificando que el valor corresponde al segundo parámetro:
exec libros_por_autor_editorial3 @editorial='P%';



-----SUBCONSULTAS
-- Mostramos el título, autor y precio del libro mas costoso:
select titulo,autor, precio
 from libros
 where precio=(select max(precio) from libros);  
GO

---REALIZANDO CONSULTA
SELECT * FROM LIBROS
GO


-- Actualizamos el precio del libro con máximo valor:
update libros set precio=100
 where precio=
  (select max(precio) from libros);
GO



---REALIZANDO CONSULTA
SELECT * FROM LIBROS
GO



-- Eliminamos los libros con precio menor:
delete from libros
 where precio=
  (select min(precio) from libros)
GO





----CREANDO FUNCIONES
----CREANDO UNA NUEVA FUNCION DEFINIDA POR USUARIO
 ----Creamos una función con valores de tabla en línea que recibe un valor de autor como parámetro:
 if object_id('f_libros') is not null
 begin
  drop function f_libros;
 end
 go

 create function f_libros
 (@autor varchar(30)='Borges')
 returns table
 as
 return (
 select titulo,editorial
 from libros
  where autor like '%'+@autor+'%'
 );
 go

---Llamamos a la función creada anteriormente enviando un autor:
 select *from f_libros('Bach');


 --- modificando una funcion
alter function f_libros
 (@autor varchar(30)='Borges')
 returns table
 as
 return (
 select titulo,editorial,precio
 from libros
 where autor like '%'+@autor+'%'
 );
 go

---Llamamos a la función creada anteriormente enviando un autor:
 select *from f_libros('Bach');





  ----creando una nueva funcion para consulta en la tabla libros
 if object_id('LISTA_LIBROS_POR_AUTOR') is not null
begin
 drop function LISTA_LIBROS_POR_AUTOR;
end
go

CREATE FUNCTION LISTA_LIBROS_POR_AUTOR(@AUTOR VARCHAR(50))
RETURNS @LIBROS TABLE
(
TITULO VARCHAR(50), AUTOR VARCHAR(50),EDITORIAL VARCHAR(50) ,PRECIO MONEY
)
AS
BEGIN
INSERT @LIBROS SELECT titulo,autor,editorial,precio FROM libros
WHERE autor=@AUTOR
RETURN
END
GO

---EJECUCION DE FUNCION
SELECT * FROM LISTA_LIBROS_POR_AUTOR('Mario Molina')









----DESARROLLO DE VISTAS
----TABLAS VIRTUALES QUE ALMACEAN CONSULTA
----na vista almacena una consulta como un objeto para utilizarse posteriormente. Las tablas consultadas en una vista se llaman tablas base.
--general, se puede dar un nombre a cualquier consulta y almacenarla como una vista.
if object_id('secciones') is not null
begin
 drop table secciones;
end
go

create table secciones(
 codigo tinyint identity,
 nombre varchar(20),
 sueldo decimal(5,2)
  constraint CK_secciones_sueldo check (sueldo>=0),
 constraint PK_secciones primary key (codigo)
);
go 


if object_id('empleados') is not null
begin
 drop table empleados;
end
go

create table empleados(
 legajo int identity,
 documento char(8)
  constraint CK_empleados_documento check (documento like '[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]'),
 sexo char(1)
  constraint CK_empleados_sexo check (sexo in ('f','m')),
 apellido varchar(20),
 nombre varchar(20),
 domicilio varchar(30),
 seccion tinyint not null,
 cantidadhijos tinyint
  constraint CK_empleados_hijos check (cantidadhijos>=0),
 estadocivil char(10)
  constraint CK_empleados_estadocivil check (estadocivil in ('casado','divorciado','soltero','viudo')),
 fechaingreso datetime,
  constraint PK_empleados primary key (legajo),
 constraint FK_empleados_seccion
  foreign key (seccion)
  references secciones(codigo)
  on update cascade,
 constraint UQ_empleados_documento
  unique(documento)
);
go



insert into secciones values('Administracion',300);
insert into secciones values('Contaduría',400);
insert into secciones values('Sistemas',500);


insert into empleados values('22222222','f','Lopez','Ana','Colon 123',1,2,'casado','1990-10-10');
insert into empleados values('23333333','m','Lopez','Luis','Sucre 235',1,0,'soltero','1990-02-10');
insert into empleados values('24444444','m','Garcia','Marcos','Sarmiento 1234',2,3,'divorciado','1998-07-12');
insert into empleados values('25555555','m','Gomez','Pablo','Bulnes 321',3,2,'casado','1998-10-09');
insert into empleados values('26666666','f','Perez','Laura','Peru 1254',3,3,'casado','2000-05-09');

-- Eliminamos la vista "vista_empleados" si existe:
-- Creamos la vista "vista_empleados", que es resultado de una combinación 
-- en la cual se muestran 5 campos:
if object_id('vista_empleados') is not null
begin
 drop view vista_empleados;
end
go

create view vista_empleados as
 select (apellido+' '+e.nombre) as nombre,sexo,
  s.nombre as seccion, cantidadhijos
  from empleados as e
  join secciones as s
  on codigo=seccion;
go

-- Vemos la información de la vista:
select * from vista_empleados;