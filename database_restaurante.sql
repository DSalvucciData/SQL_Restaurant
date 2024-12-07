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
    
