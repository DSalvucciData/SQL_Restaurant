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


-- 1 ¿Cuáles son los nombres de todos los clientes en la tabla clientes?

SELECT 
	nombre
FROM 
	clientes
;

-- 2 ¿Qué pedidos ha realizado el cliente con id_cliente = 2?

SELECT 
	p.id_cliente, 
	pl.nombre_plato   
FROM pedidos AS p
	JOIN 
		platos AS pl ON p.id_pedido = pl.id_pedido
WHERE 
	id_cliente = 2
;

-- 3 ¿Cuáles son los detalles (precio y pedido asociado) del plato llamado "Pizza margerita"?

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

-- 4 ¿Cuáles son todos los pedidos realizados, mostrando id_pedido y la fecha?

SELECT 
	id_pedido,
    fecha
FROM 
	pedidos
;

-- 5- Muestra el id_pedido, la fecha y el nombre del cliente para cada pedido.

SELECT
	p.id_pedido 
	,p.fecha
    ,c.nombre
FROM 
	pedidos AS p
		JOIN clientes AS c ON c.id_cliente = p.id_cliente
        JOIN platos AS pl ON p.id_pedido = pl.id_pedido
;

-- 6- Muestra todos los platos asociados al pedido con id_pedido = 101.

SELECT
	nombre_plato
FROM 
	platos 
	WHERE 
		id_pedido = 101
;

-- 7- Muestra una lista que incluya el nombre del cliente, la fecha del pedido, y los platos que ordenó, junto con el precio de cada plato.

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

-- 8- ¿Cuáles son los pedidos que incluyen más de un plato?

SELECT
	id_pedido 
    , COUNT(id_pedido) AS pedido_con_mas_de_un_plato
FROM 
	platos
	GROUP BY id_pedido
	HAVING COUNT(id_pedido) > 1
;

-- 9 ¿Cuánto gastó cada cliente en su pedido? Muestra el id_pedido, el nombre del cliente y el total.
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
-- 10 ¿Qué platos se han ordenado más veces? Muestra el nombre_plato y la cantidad de veces que aparece en los pedidos.

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
-- 11 ¿Cuántos platos hay por pedido?

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

-- 12 ¿Cuáles son los clientes que han realizado más de un pedido?

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

-- Tambien podria ser 

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

-- 13 ¿Cuánto ha gastado en total cada cliente? Muestra el nombre del cliente y el monto total gastado.

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

-- 14 ¿Qué platos tienen un precio superior a 12.00?

SELECT
	nombre_plato
	FROM
		platos
	WHERE 
		precio > 12
;

-- 15 ¿Qué pedidos se realizaron después del 2024-11-28?

SELECT
	id_pedido
    FROM 
		pedidos
	WHERE 
		fecha > '2024-11-28'
;

-- 16 ¿Qué clientes no han realizado ningún pedido? (Usa una combinación de LEFT JOIN y NULL).

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

-- 17 ¿Qué clientes han realizado pedidos con más de un plato?

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

-- 18 ¿Cuál es el promedio de gasto por cliente considerando todos los pedidos?

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

-- 19 ¿Cuál fue el pedido más caro realizado, y qué cliente lo hizo?

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

-- 20 Para cada pedido, ¿cuál fue el plato más caro?

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
	) AS subquery -- Este sbuquery es una tabla con los precios maximos y su id_pedido (agrupado) de tabla platos. Se hace un INNER JOIN tabla platos. Hay que poner alias a ambas tablas para referenciar las columnas y evitar ambiguedades. 
    ON pl.id_pedido = subquery.id_pedido
	AND pl.precio = subquery.max_precio
ORDER  BY 
	pl.id_pedido ASC
	, plato_mas_caro DESC
;
-- 21 ¿Quiénes son los clientes que han realizado más pedidos?

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
    
-- 22 ¿Qué cliente gastó la mayor cantidad de dinero en total considerando todos sus pedidos?

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

-- 23 ¿Qué pedidos tienen un gasto total superior al promedio de todos los pedidos?

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

-- 24 ¿Cuáles son los platos que solo se han ordenado una vez?

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

-- 25 ¿Qué clientes han ordenado "Ensalada Cesar"?	

SELECT
	c.nombre AS cliente
FROM
	clientes AS c
JOIN pedidos AS p ON c.id_cliente = p.id_cliente
JOIN platos AS pl ON p.id_pedido = pl.id_pedido

WHERE
	nombre_plato = 'Ensalada cesar'
;

-- 26 Incrementa el precio de todos los platos en un 10%

SET SQL_SAFE_UPDATES = 0; -- desactivar safe mode 
;

UPDATE platos 
SET precio = precio * 1.10
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

-- 27 Borra todos los pedidos que no tienen platos asociados.

DELETE p
FROM
	pedidos p 
LEFT JOIN platos pl ON p.id_pedido = pl.id_pedido
WHERE 
	pl.id_pedido IS NULL
;

SELECT
	*
FROM 
	platos;

-- 28 Agrega un nuevo cliente llamado "Sofía López" y regístrale un pedido con dos platos: "Salmón a la plancha" y "Tarta de manzana".

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

-- 29 Elimina el cliente con id_cliente = 3 y todos sus pedidos asociados.

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

-- Verifico cada tabla que se elimino correctamente el cliente 3 y todos sus pedidos
SELECT *
FROM clientes;

SELECT *
FROM pedidos;

SELECT *
FROM platos;

-- 30 Genera un reporte que incluya el id_pedido, la fecha, el nombre del cliente, los platos ordenados y el total gastado por pedido.
-- Ranking de clientes por gasto:

-- Reporte con detalle de pedidos y ranking de clientes por gasto
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
    
-- 31 Muestra un ranking de los clientes según su gasto total, ordenado de mayor a menor.

  -- Ranking de clientes por su gasto total
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
  
