INSERT INTO Clientes (nombre, correo_electronico, pass) VALUES
('Ana García', 'ana.garcia@example.com', 'password123'),
('Luis Martínez', 'luis.martinez@example.com', 'password456'),
('Marta Fernández', 'marta.fernandez@example.com', 'password789'),
('Carlos López', 'carlos.lopez@example.com', 'password101'),
('Elena Rodríguez', 'elena.rodriguez@example.com', 'password202'),
('Juan Pérez', 'juan.perez@example.com', 'password303'),
('Lucía Sánchez', 'lucia.sanchez@example.com', 'password404'),
('Pedro González', 'pedro.gonzalez@example.com', 'password505'),
('Sofía Díaz', 'sofia.diaz@example.com', 'password606'),
('Jorge Ramírez', 'jorge.ramirez@example.com', 'password707'),
('Carmen Ruiz', 'carmen.ruiz@example.com', 'password808'),
('Alberto Jiménez', 'alberto.jimenez@example.com', 'password909');

INSERT INTO Comics (nombre, anio, precio) VALUES
('Batman: Year One', 1987, 9.99),
('Watchmen', 1986, 19.99),
('Spider-Man: Blue', 2002, 14.99),
('The Dark Knight Returns', 1986, 15.99),
('Maus', 1991, 17.99),
('V for Vendetta', 1988, 12.99),
('Sandman: Preludes and Nocturnes', 1989, 13.99),
('X-Men: Days of Future Past', 1981, 10.99),
('Saga, Vol. 1', 2012, 9.99),
('Y: The Last Man, Vol. 1', 2003, 11.99),
('The Walking Dead, Vol. 1', 2004, 8.99),
('Persepolis', 2000, 16.99),
('Hellboy: Seed of Destruction', 1994, 14.99),
('Bone: Out from Boneville', 1995, 9.99),
('Ms. Marvel: No Normal', 2014, 12.99);

INSERT INTO Inventario (id_comic, cantidad_disponible, disponibilidad) VALUES
(10, 5, 1),
(11, 10, 1),
(12, 8, 1),
(13, 0, 0),
(14, 12, 1),
(15, 7, 1),
(16, 4, 1),
(17, 15, 1),
(18, 9, 1),
(19, 3, 1),
(20, 6, 1),
(21, 0, 0),
(22, 11, 1),
(23, 14, 1),
(24, 2, 1);  

INSERT INTO Compras (id_cliente, fecha_compra, total) VALUES
(1, '2024-05-01', 19.98), 
(2, '2024-05-02', 19.99), 
(3, '2024-05-03', 39.98), 
(4, '2024-05-04', 9.99),
(5, '2024-05-05', 30.98), 
(6, '2024-05-06', 15.99), 
(7, '2024-05-07', 19.99); 

INSERT INTO Comic_Compras (cantidad, id_compra, id_comic) VALUES
(2, 100, 10), 
(1, 103, 10),
(1, 102, 11),
(2, 103, 11),
(1, 104, 12), 
(2, 105, 13),
(1, 106, 14),
(1, 107, 10);
