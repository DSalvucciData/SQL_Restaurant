# Proyecto práctico de SQL

- [Proyecto práctico de SQL](#proyecto-práctico-de-sql)
	- [Descripción](#descripción)
	- [Quick Access](#quick-access)
		- [Database: ver database\_restaurante.sql](#database-ver-database_restaurantesql)
		- [SQL Queries: ver restaurante.sql](#sql-queries-ver-restaurantesql)
		- [ER Diagram: ver ER Diagrama ](#er-diagram-ver-er-diagrama-)
	- [Creación de base de datos "restaurante"](#creación-de-base-de-datos-restaurante)
		- [Relaciones Entre Tablas](#relaciones-entre-tablas)
	- [Esquema Relacional (ER Diagram)](#esquema-relacional-er-diagram)
	- [Preguntas Básicas](#preguntas-básicas)
		- [Consulta básica de clientes:](#consulta-básica-de-clientes)
		- [Pedidos realizados por un cliente:](#pedidos-realizados-por-un-cliente)
		- [Detalles de un plato específico:](#detalles-de-un-plato-específico)
	- [Consultas con JOIN](#consultas-con-join)
		- [Combina información de clientes y pedidos:](#combina-información-de-clientes-y-pedidos)
		- [Platos de un pedido:](#platos-de-un-pedido)
		- [Información completa de pedidos:](#información-completa-de-pedidos)
		- [Pedidos con múltiples platos:](#pedidos-con-múltiples-platos)
	- [Consultas con GROUP BY y Funciones de Agregación](#consultas-con-group-by-y-funciones-de-agregación)
		- [Gasto total por pedido:](#gasto-total-por-pedido)
		- [Platos más pedidos:](#platos-más-pedidos)
		- [Clientes con más de un pedido:](#clientes-con-más-de-un-pedido)
		- [Gasto total de todos los clientes:](#gasto-total-de-todos-los-clientes)
	- [Consultas con Condicionales y Filtrados](#consultas-con-condicionales-y-filtrados)
		- [Platos caros:](#platos-caros)
		- [Pedidos recientes:](#pedidos-recientes)
		- [Clientes sin pedidos:](#clientes-sin-pedidos)
		- [Pedidos con más de un plato por cliente:](#pedidos-con-más-de-un-plato-por-cliente)
	- [Consultas Avanzadas](#consultas-avanzadas)
		- [Promedio de gasto por cliente:](#promedio-de-gasto-por-cliente)
		- [Pedidos con gasto máximo:](#pedidos-con-gasto-máximo)
		- [Plato más caro en cada pedido:](#plato-más-caro-en-cada-pedido)
		- [Clientes frecuentes:](#clientes-frecuentes)
	- [Consultas con Subconsultas](#consultas-con-subconsultas)
		- [Cliente que gastó más en total:](#cliente-que-gastó-más-en-total)
		- [Pedidos con gasto superior al promedio:](#pedidos-con-gasto-superior-al-promedio)
		- [Platos únicos:](#platos-únicos)
		- [Clientes que ordenaron platos específicos:](#clientes-que-ordenaron-platos-específicos)
	- [Consultas de Manipulación de Datos](#consultas-de-manipulación-de-datos)
		- [Actualización de precios:](#actualización-de-precios)
		- [Eliminar pedidos sin platos:](#eliminar-pedidos-sin-platos)
		- [Agregar un nuevo cliente y pedido:](#agregar-un-nuevo-cliente-y-pedido)
		- [Eliminar cliente con sus pedidos:](#eliminar-cliente-con-sus-pedidos)
	- [Consultas para Crear Reportes](#consultas-para-crear-reportes)
		- [Resumen de pedidos:](#resumen-de-pedidos)

## Descripción
El siguiente proyecto lo he realizado como práctica para afianzar habilidades de código en SQL. He aprendido a comprender modelado de una base de datos básica y a realizar consultas que van desde un nivel básico a un nivel más complejo con inclusión de subconsultas y JOIN. 

## Quick Access
### Database: [ver database_restaurante.sql](database_restaurante.sql)
### SQL Queries: [ver restaurante.sql](restaurante.sql)
### ER Diagram: [ver ER Diagrama ](er_restaurante.png)

## Creación de base de datos "restaurante"

Cree 3 tablas:
- clientes
- pedidos
- platos 

Defini en cada tabla la clave primaria (PK) y la clave foranea (FK). Esto es importante al crear las tablas en una DB si van a tener una relación entre ellas.

### Relaciones Entre Tablas
- Clientes y Pedidos (1:N):

Un cliente puede realizar múltiples pedidos, pero cada pedido pertenece a un solo cliente.
Representación:
Clave foránea id_cliente en la tabla pedidos.
- Pedidos y Platos (1:N):

Un pedido puede incluir múltiples platos, pero cada plato pertenece a un solo pedido.
Representación:
Clave foránea id_pedido en la tabla platos.

## Esquema Relacional (ER Diagram)

![](er_restaurante.png)


```sql

CREATE DATABASE restaurante
;

CREATE TABLE clientes(
id_cliente INT AUTO_INCREMENT,
nombre VARCHAR(50) NOT NULL,
PRIMARY KEY (id_cliente)
);

INSERT INTO clientes (nombre) 
VALUES 
('Ana Gómez'),
('Luis Perez'),
('Carla Torres')
;

SELECT *
FROM clientes
;

CREATE TABLE pedidos (
    id_pedido INT AUTO_INCREMENT,    -- Identificador único para cada pedido
    id_cliente INT NOT NULL,         -- Relación con el cliente que hizo el pedido
    fecha DATE,                      -- Fecha en que se realizó el pedido
    PRIMARY KEY (id_pedido),         -- Clave primaria de la tabla
    FOREIGN KEY (id_cliente) REFERENCES clientes(id_cliente) -- Relación con la tabla clientes
);


ALTER TABLE pedidos AUTO_INCREMENT = 101;

INSERT INTO pedidos (id_cliente, fecha) 
VALUES 
    (1, '2024-11-28'),
    (2, '2024-11-29'),
    (3, '2024-11-30');

SELECT *
FROM pedidos
;

CREATE TABLE platos (
    id_plato INT AUTO_INCREMENT,
    id_pedido INT NOT NULL,
    nombre_plato VARCHAR(50),
    precio DECIMAL(10, 2),
    PRIMARY KEY (id_plato),
    FOREIGN KEY (id_pedido) REFERENCES pedidos(id_pedido) -- Relación con la tabla pedidos
);

ALTER TABLE platos AUTO_INCREMENT = 1001;

INSERT INTO platos (id_pedido, nombre_plato, precio)  
VALUES 
    (101, 'Ensalada Cesar', 10.50),
    (101, 'Sopa de tomate', 8.00),
    (102, 'Pizza margerita', 12.00),
    (103, 'Filete de pollo', 15.00),
    (103, 'Tarta de queso', 6.50)
    ;
    
SELECT *
FROM platos
;    

```
## Preguntas Básicas
### Consulta básica de clientes:

1- ¿Cuáles son los nombres de todos los clientes en la tabla clientes?

```sql
SELECT 
	nombre
FROM 
	clientes
;
```


### Pedidos realizados por un cliente:

2- ¿Qué pedidos ha realizado el cliente con id_cliente = 2?

```sql
SELECT 
	p.id_cliente, 
	pl.nombre_plato   
FROM pedidos AS p
	JOIN 
		platos AS pl ON p.id_pedido = pl.id_pedido
WHERE 
	id_cliente = 2
;
```
```
2	Pizza margerita
```
### Detalles de un plato específico:

3- ¿Cuáles son los detalles (precio y pedido asociado) del plato llamado "Pizza margerita"?
Lista de pedidos con fechas:

```sql
SELECT 
	p.id_pedido,
    c.id_cliente,
    c.nombre,
	pl.precio,
    p.fecha
FROM
	pedidos AS p
    JOIN clientes AS c ON p.id_cliente = c.id_cliente
    JOIN platos AS pl ON p.id_pedido = pl.id_pedido

WHERE 
	pl.nombre_plato = 'Pizza margerita'
;

```
```sql
 id_pedido, id_cliente, nombre, precio, fecha
'102', '2', 'Luis Perez', '12.00', '2024-11-29'
```

4- ¿Cuáles son todos los pedidos realizados, mostrando id_pedido y la fecha?

```
SELECT 
	id_pedido,
    fecha
FROM 
	pedidos
;
```
```sql
id_pedido, fecha
'101', '2024-11-28'
'102', '2024-11-29'
'103', '2024-11-30'
```


## Consultas con JOIN

### Combina información de clientes y pedidos:

5- Muestra el id_pedido, la fecha y el nombre del cliente para cada pedido.

```sql
SELECT
	p.id_pedido 
	,p.fecha
    ,c.nombre
FROM 
	pedidos AS p
		JOIN clientes AS c ON c.id_cliente = p.id_cliente
        JOIN platos AS pl ON p.id_pedido = pl.id_pedido
;
```
```sql
id_pedido, fecha, nombre
'101', '2024-11-28', 'Ana Gómez'
'101', '2024-11-28', 'Ana Gómez'
'102', '2024-11-29', 'Luis Perez'
'103', '2024-11-30', 'Carla Torres'
'103', '2024-11-30', 'Carla Torres'

```
### Platos de un pedido:

6- Muestra todos los platos asociados al pedido con id_pedido = 101.

```sql
SELECT
	nombre_plato
FROM 
	platos 
	WHERE 
		id_pedido = 101
;
```
```sql
nombre_plato
'Ensalada Cesar'
'Sopa de tomate'
```

### Información completa de pedidos:

7- Muestra una lista que incluya el nombre del cliente, la fecha del pedido, y los platos que ordenó, junto con el precio de cada plato.

```sql
SELECT
	c.nombre
    , p.fecha
    , pl.nombre_plato
    , pl.precio
FROM 
	clientes AS c 
		JOIN 
			pedidos AS p ON c.id_cliente = p.id_cliente
		JOIN
			platos AS pl ON p.id_pedido = pl.id_pedido
;
```
```sql
 nombre, fecha, nombre_plato, precio
'Ana Gómez', '2024-11-28', 'Ensalada Cesar', '10.50'
'Ana Gómez', '2024-11-28', 'Sopa de tomate', '8.00'
'Luis Perez', '2024-11-29', 'Pizza margerita', '12.00'
'Carla Torres', '2024-11-30', 'Filete de pollo', '15.00'
'Carla Torres', '2024-11-30', 'Tarta de queso', '6.50'

```

### Pedidos con múltiples platos:

8- ¿Cuáles son los pedidos que incluyen más de un plato?

```sql
SELECT
	id_pedido 
    , COUNT(id_pedido) AS pedido_con_mas_de_un_plato
FROM 
	platos
	GROUP BY id_pedido
	HAVING COUNT(id_pedido) > 1
;
```
```sql
id_pedido, pedido_con_mas_de_un_plato
'101', '2'
'103', '2'

```
## Consultas con GROUP BY y Funciones de Agregación

### Gasto total por pedido:

9- ¿Cuánto gastó cada cliente en su pedido? Muestra el id_pedido, el nombre del cliente y el total.

```sql
SELECT
	p.id_pedido
	, c.nombre
	, SUM(precio) AS total
FROM
	clientes AS c 
			JOIN pedidos AS p ON c.id_cliente = p.id_cliente
            JOIN platos AS pl ON p.id_pedido = pl.id_pedido
	GROUP BY 
			id_pedido
;
```
```sql
id_pedido, nombre, total
'101', 'Ana Gómez', '18.50'
'102', 'Luis Perez', '12.00'
'103', 'Carla Torres', '21.50'

```

### Platos más pedidos:

10- ¿Qué platos se han ordenado más veces? Muestra el nombre_plato y la cantidad de veces que aparece en los pedidos.

```sql
SELECT 
    nombre_plato 
    , COUNT(*) AS cantidad_ordenes
FROM 
    platos
GROUP BY 
    nombre_plato
ORDER BY 
    cantidad_ordenes DESC
;
```
```sql
nombre_plato, cantidad_ordenes
'Ensalada Cesar', '1'
'Sopa de tomate', '1'
'Pizza margerita', '1'
'Filete de pollo', '1'
'Tarta de queso', '1'

```

11- ¿Cuántos platos hay por pedido?

```sql
SELECT 
	id_pedido
    nombre_plato, 
    COUNT(*) AS cantidad_platos
FROM 
    platos
GROUP BY 
    id_pedido
ORDER BY 
    id_pedido
    ;
```
```sql
nombre_plato, cantidad_platos
'101', '2'
'102', '1'
'103', '2'
```

### Clientes con más de un pedido:

12- ¿Cuáles son los clientes que han realizado más de un pedido?

```sql
SELECT 
	c.nombre
    , COUNT(p.id_pedido) AS num_pedidos
FROM
	clientes AS c
		JOIN pedidos AS p ON c.id_cliente = p.id_cliente
        JOIN platos AS pl ON pl.id_pedido = p.id_pedido
	GROUP BY c.nombre
				ORDER BY num_pedidos DESC
;
```
```sql
nombre, num_pedidos
'Ana Gómez', '2'
'Carla Torres', '2'
'Luis Perez', '1'
```

Tambien podria ser 

```sql
SELECT 
	c.nombre
    , COUNT(p.id_pedido) AS num_pedidos
FROM
	clientes AS c
		JOIN pedidos AS p ON c.id_cliente = p.id_cliente
        JOIN platos AS pl ON pl.id_pedido = p.id_pedido
	GROUP BY c.nombre
			, c.id_cliente
		HAVING 
			num_pedidos > 1
		ORDER BY num_pedidos DESC
;
```
```sql
nombre, num_pedidos
'Ana Gómez', '2'
'Carla Torres', '2'

```

### Gasto total de todos los clientes:

13- ¿Cuánto ha gastado en total cada cliente? Muestra el nombre del cliente y el monto total gastado.

```sql
SELECT
	c.nombre
    , SUM(pl.precio) AS total
    FROM 
		clientes AS c 
        JOIN pedidos AS p ON c.id_cliente = p.id_cliente
        JOIN platos AS pl ON p.id_pedido = pl.id_pedido
	GROUP BY 
		c.nombre
;
```
```sql
nombre, total
'Ana Gómez', '18.50'
'Luis Perez', '12.00'
'Carla Torres', '21.50'

```

## Consultas con Condicionales y Filtrados

### Platos caros:

14- ¿Qué platos tienen un precio superior a 12.00?

```sql
SELECT
	nombre_plato
	FROM
		platos
	WHERE 
		precio > 12
;
```
```sql
nombre_plato
'Filete de pollo'
```

### Pedidos recientes:

15- ¿Qué pedidos se realizaron después del 2024-11-28?

```sql
SELECT
	id_pedido
    FROM 
		pedidos
	WHERE 
		fecha > '2024-11-28'
;
```
```sql
id_pedido
'102'
'103'

```
### Clientes sin pedidos:

16- ¿Qué clientes no han realizado ningún pedido? (Usa una combinación de LEFT JOIN y NULL).

```sql
SELECT
	c.nombre
    , COUNT(p.id_pedido) AS num_pedidos
    FROM 
		clientes AS c 
		LEFT JOIN pedidos AS p ON c.id_cliente = p.id_cliente
	GROUP BY 
		c.nombre
        HAVING
		num_pedidos = NULL 
        OR 
        num_pedidos = 0
;
```
```sql
nombre num_pedidos
```

### Pedidos con más de un plato por cliente:

17- ¿Qué clientes han realizado pedidos con más de un plato?

```sql
SELECT
	c.nombre
    , COUNT(id_plato) AS num_platos
    FROM
		clientes AS c 
			JOIN pedidos AS p ON c.id_cliente = p.id_cliente
            JOIN platos AS pl ON p.id_pedido = pl.id_pedido
		GROUP BY
			c.nombre
				HAVING
					num_platos > 1
;

```
```sql
nombre, num_platos
'Ana Gómez', '2'
'Carla Torres', '2'

```

## Consultas Avanzadas
### Promedio de gasto por cliente:

18- ¿Cuál es el promedio de gasto por cliente considerando todos los pedidos?

```sql
SELECT
	c.nombre
    , ROUND(AVG(pl.precio), 2) AS gasto_promedio
FROM
	clientes AS c 
JOIN
	pedidos AS p 
    ON c.id_cliente = p.id_cliente
JOIN 
	platos AS pl 
    ON p.id_pedido = pl.id_pedido
GROUP BY
	c.nombre
;
```
```sql
nombre, gasto_promedio
'Ana Gómez', '9.25'
'Luis Perez', '12.00'
'Carla Torres', '10.75'

```

### Pedidos con gasto máximo:

19- ¿Cuál fue el pedido más caro realizado, y qué cliente lo hizo?

```sql
SELECT
	c.nombre
	, p.id_pedido
    , SUM(pl.precio) AS precio_pedido
FROM
	clientes AS c 
JOIN
	pedidos AS p ON c.id_cliente = p.id_cliente
JOIN
	platos AS pl ON p.id_pedido = pl.id_pedido
GROUP BY 
	p.id_pedido
ORDER BY
	precio_pedido DESC
LIMIT 1
;
```
```sql
nombre, id_pedido, precio_pedido
'Carla Torres', '103', '21.50'

```

### Plato más caro en cada pedido:

20- Para cada pedido, ¿cuál fue el plato más caro?

```sql
SELECT 
	pl.id_pedido
    , pl. nombre_plato
    , pl.precio AS plato_mas_caro
FROM	
	platos AS pl
JOIN 
	( SELECT
			id_pedido
            , MAX(precio) AS max_precio
		FROM 
			platos  
	GROUP BY
		id_pedido
	) AS subquery  -- Este sbuquery es una tabla con los precios maximos y su id_pedido (agrupado) de tabla platos. Se hace un INNER JOIN tabla platos. Hay que poner alias a ambas tablas para referenciar las columnas y evitar ambiguedades. 
    ON pl.id_pedido = subquery.id_pedido
	AND pl.precio = subquery.max_precio
ORDER  BY 
	pl.id_pedido ASC
	, plato_mas_caro DESC
;
```

### Clientes frecuentes:

21- ¿Quiénes son los clientes que han realizado más pedidos?

```sql
SELECT 
	c.nombre AS cliente
    , COUNT(p.id_pedido) AS num_pedido
FROM
	clientes AS c
    JOIN 
		pedidos AS p ON c.id_cliente = p.id_cliente
GROUP BY 
	c.nombre
 ORDER BY
	num_pedido DESC
LIMIT 2
;
```
```sql
cliente, num_pedido
'Ana Gómez', '1'
'Luis Perez', '1'

```

## Consultas con Subconsultas
### Cliente que gastó más en total:

22- ¿Qué cliente gastó la mayor cantidad de dinero en total considerando todos sus pedidos?

```sql
SELECT
	c.nombre AS cliente
    , SUM(pl.precio) AS total_gastado
FROM
	clientes AS c
JOIN 
	pedidos AS p ON c.id_cliente = p.id_cliente
JOIN
	platos AS pl ON p.id_pedido = pl.id_pedido
GROUP BY	
	cliente
ORDER BY
	total_gastado DESC
LIMIT 1
;

```
```sql
cliente, total_gastado
'Carla Torres', '21.50'

```
### Pedidos con gasto superior al promedio:

23- ¿Qué pedidos tienen un gasto total superior al promedio de todos los pedidos?

```sql
SELECT
	id_pedido
FROM
	platos
GROUP BY
	id_pedido
HAVING 
	 SUM(precio) > (
					SELECT
						AVG(total_pedido)
					FROM
						(
                        SELECT 
							id_pedido
                            , SUM(precio) AS total_pedido	
						FROM
							platos
						GROUP BY 
							id_pedido
                        )  AS promedio_pedidos -- gasto total de cada pedido que luego se promedia asi se saca el promedio sobre todos los pedidos
						)
;
```
```sql
id_pedido
'101'
'103'

```

### Platos únicos:

24- ¿Cuáles son los platos que solo se han ordenado una vez?

```sql
SELECT
	nombre_plato 
    , COUNT(*) AS frecuencia_plato
FROM
	platos
GROUP BY 
	nombre_plato
HAVING
	frecuencia_plato = 1
;					

```
```sql
nombre_plato, frecuencia_plato
'Ensalada Cesar', '1'
'Sopa de tomate', '1'
'Pizza margerita', '1'
'Filete de pollo', '1'
'Tarta de queso', '1'
```

### Clientes que ordenaron platos específicos:

25- ¿Qué clientes han ordenado "Ensalada Cesar"?

```sql
SELECT
	c.nombre AS cliente
FROM
	clientes AS c
JOIN pedidos AS p ON c.id_cliente = p.id_cliente
JOIN platos AS pl ON p.id_pedido = pl.id_pedido

WHERE
	nombre_plato = 'Ensalada cesar'
;

```
```sql
cliente
'Ana Gómez'

```

## Consultas de Manipulación de Datos
### Actualización de precios:

26- Incrementa el precio de todos los platos en un 10%.

```sql
SET SQL_SAFE_UPDATES = 0; -- desactivar safe mode 
;

UPDATE platos 
SET precio = precio / 1.10
;

SET SQL_SAFE_UPDATES = 1; -- activar safe mode 
;

 
SELECT 
	*
FROM 
	platos
;

-- otra forma: 

-- Iniciar la transacción
START TRANSACTION;

SET SQL_SAFE_UPDATES = 0; -- desactivar safe mode 
;
-- Realizar el UPDATE
UPDATE platos
SET precio = precio * 1.10;

-- Verificar los resultados antes de confirmar los cambios
-- (Puedes realizar un SELECT aquí para revisar el estado de los datos si es necesario)
-- SELECT * FROM platos;

-- Confirmar los cambios si todo está correcto
COMMIT;

-- Deshacer los cambios si algo salió mal
-- ROLLBACK;
```
```sql
'1001', '101', 'Ensalada Cesar', '11.56'
'1002', '101', 'Sopa de tomate', '8.80'
'1003', '102', 'Pizza margerita', '13.20'
'1004', '103', 'Filete de pollo', '16.50'
'1005', '103', 'Tarta de queso', '7.15'

```
### Eliminar pedidos sin platos:

27- Borra todos los pedidos que no tienen platos asociados.

```sql
DELETE p
FROM
	pedidos p 
LEFT JOIN platos pl ON p.id_pedido = pl.id_pedido
WHERE 
	pl.id_pedido IS NULL
;
```
```sql
SELECT
	*
FROM 
	platos;
```
```sql
id_plato, id_pedido, nombre_plato, precio
'1001', '101', 'Ensalada Cesar', '10.50'
'1002', '101', 'Sopa de tomate', '8.00'
'1003', '102', 'Pizza margerita', '12.00'
'1004', '103', 'Filete de pollo', '15.00'
'1005', '103', 'Tarta de queso', '6.50'
```


### Agregar un nuevo cliente y pedido:

28- Agrega un nuevo cliente llamado "Sofía López" y regístrale un pedido con dos platos: "Salmón a la plancha" y "Tarta de manzana".

```	sql
INSERT INTO clientes  (nombre)
VALUES 
	('Sofía López')
;

SELECT *
FROM clientes
;
 
INSERT INTO pedidos (id_cliente, fecha)
VALUES ((SELECT id_cliente FROM clientes WHERE nombre = 'Sofía López'), CURDATE())
;

SELECT *
FROM pedidos
;

INSERT INTO platos (id_pedido, nombre_plato, precio)
VALUES 
    ((SELECT id_pedido FROM pedidos WHERE id_cliente = (SELECT id_cliente FROM clientes WHERE nombre = 'Sofía López') ORDER BY fecha DESC LIMIT 1), 'Salmón a la plancha', 20.00),
    ((SELECT id_pedido FROM pedidos WHERE id_cliente = (SELECT id_cliente FROM clientes WHERE nombre = 'Sofía López') ORDER BY fecha DESC LIMIT 1), 'Tarta de manzana', 8.50);
	
SELECT *
	FROM platos
    ;
```
```sql
id_plato, id_pedido, nombre_plato, precio
'1001', '101', 'Ensalada Cesar', '10.50'
'1002', '101', 'Sopa de tomate', '8.00'
'1003', '102', 'Pizza margerita', '12.00'
'1004', '103', 'Filete de pollo', '15.00'
'1005', '103', 'Tarta de queso', '6.50'

```

### Eliminar cliente con sus pedidos:

29- Elimina el cliente con id_cliente = 3 y todos sus pedidos asociados.

```sql
-- Mostrar la estructura actual de la tabla 'pedidos' para verificar las claves foráneas existentes
SHOW CREATE TABLE pedidos;

-- Eliminar la clave foránea existente en la tabla 'pedidos' que referencia a la tabla 'clientes'
ALTER TABLE pedidos
DROP FOREIGN KEY pedidos_ibfk_1;

-- Eliminar la clave foránea existente en la tabla 'platos' que referencia a la tabla 'pedidos'
ALTER TABLE platos
DROP FOREIGN KEY platos_ibfk_1;

-- Volver a agregar la clave foránea en la tabla 'pedidos', esta vez con 'ON DELETE CASCADE',
-- lo que asegura que, si se elimina un cliente, se eliminarán automáticamente los pedidos asociados.
ALTER TABLE pedidos
ADD CONSTRAINT pedidos_ibfk_1
FOREIGN KEY (id_cliente)
REFERENCES clientes (id_cliente)
ON DELETE CASCADE;

-- Volver a agregar la clave foránea en la tabla 'platos', esta vez con 'ON DELETE CASCADE',
-- lo que asegura que, si se elimina un pedido, se eliminarán automáticamente los platos asociados.
ALTER TABLE platos
ADD CONSTRAINT platos_ibfk_1
FOREIGN KEY (id_pedido)
REFERENCES pedidos (id_pedido)
ON DELETE CASCADE;

-- Eliminar al cliente con id_cliente = 3 y sus pedidos y platos asociados,
-- gracias a las claves foráneas con 'ON DELETE CASCADE' que eliminarán automáticamente los registros relacionados.
DELETE FROM clientes
WHERE id_cliente = 3;

```
```sql
-- Verifico cada tabla que se elimino correctamente el cliente 3 y todos sus pedidos
SELECT *
FROM clientes;

SELECT *
FROM pedidos;

SELECT *
FROM platos;
```
```sql
id_cliente, nombre
'1', 'Ana Gómez'
'2', 'Luis Perez'
'4', 'Sofía López'

id_pedido, id_cliente, fecha
'101', '1', '2024-11-28'
'102', '2', '2024-11-29'
'104', '4', '2024-12-05'

# id_plato, id_pedido, nombre_plato, precio
'1001', '101', 'Ensalada Cesar', '11.56'
'1002', '101', 'Sopa de tomate', '8.80'
'1003', '102', 'Pizza margerita', '13.20'
'1006', '104', 'Salmón a la plancha', '22.00'
'1007', '104', 'Tarta de manzana', '9.35'

```

## Consultas para Crear Reportes
### Resumen de pedidos:

30- Genera un reporte que incluya el id_pedido, la fecha, el nombre del cliente, los platos ordenados y el total gastado por pedido.
Ranking de clientes por gasto:

```sql
SELECT
    p.id_pedido,                                      -- ID del pedido
    p.fecha,                                          -- Fecha del pedido
    c.nombre AS cliente,                              -- Nombre del cliente
    GROUP_CONCAT(pl.nombre_plato ORDER BY pl.nombre_plato) AS platos_ordenados,  -- Platos ordenados (concatenados)  GROUP_CONCAT(column_name ORDER BY column_name SEPARATOR ',')
    SUM(pl.precio) AS total_gastado_por_pedido,       -- Total gastado en ese pedido
    (SELECT SUM(pl2.precio)                         -- Total gastado por el cliente (en todos los pedidos)
     FROM platos pl2
     JOIN pedidos p2 ON pl2.id_pedido = p2.id_pedido
     WHERE p2.id_cliente = c.id_cliente) AS total_gastado_por_cliente  -- Total acumulado por cliente
FROM
    clientes c
JOIN
    pedidos p ON c.id_cliente = p.id_cliente
JOIN
    platos pl ON p.id_pedido = pl.id_pedido
GROUP BY
    p.id_pedido, p.fecha, c.id_cliente, c.nombre  -- Aseguramos que todos los elementos no agregados estén en GROUP BY
ORDER BY
    total_gastado_por_cliente DESC;  -- Ordenamos por el total gastado del cliente de mayor a menor
```
```sql
id_pedido, fecha, cliente, platos_ordenados, total_gastado_por_pedido, total_gastado_por_cliente
'104', '2024-12-05', 'Sofía López', 'Salmón a la plancha,Tarta de manzana', '31.35', '31.35'
'101', '2024-11-28', 'Ana Gómez', 'Ensalada Cesar,Sopa de tomate', '20.36', '20.36'
'102', '2024-11-29', 'Luis Perez', 'Pizza margerita', '13.20', '13.20'
```

31- Muestra un ranking de los clientes según su gasto total, ordenado de mayor a menor.

```sql
SELECT
    c.nombre AS cliente,
    SUM(pl.precio) AS total_gastado
FROM
    clientes c
JOIN
    pedidos p ON c.id_cliente = p.id_cliente
JOIN
    platos pl ON p.id_pedido = pl.id_pedido
GROUP BY
    c.nombre
ORDER BY
    total_gastado DESC;  -- Ordenamos por el total gastado de mayor a menor
  
```
```sql
cliente, total_gastado
'Sofía López', '31.35'
'Ana Gómez', '20.36'
'Luis Perez', '13.20'

```