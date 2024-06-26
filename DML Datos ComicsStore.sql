INSERT INTO Clientes (nombre, correo_electronico, pass) VALUES
('Ana Garc�a', 'ana.garcia@example.com', 'password123'),
('Luis Mart�nez', 'luis.martinez@example.com', 'password456'),
('Marta Fern�ndez', 'marta.fernandez@example.com', 'password789'),
('Carlos L�pez', 'carlos.lopez@example.com', 'password101'),
('Elena Rodr�guez', 'elena.rodriguez@example.com', 'password202'),
('Juan P�rez', 'juan.perez@example.com', 'password303'),
('Luc�a S�nchez', 'lucia.sanchez@example.com', 'password404'),
('Pedro Gonz�lez', 'pedro.gonzalez@example.com', 'password505'),
('Sof�a D�az', 'sofia.diaz@example.com', 'password606'),
('Jorge Ram�rez', 'jorge.ramirez@example.com', 'password707'),
('Carmen Ruiz', 'carmen.ruiz@example.com', 'password808'),
('Alberto Jim�nez', 'alberto.jimenez@example.com', 'password909');

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
(12, 5, 1),  -- 'Batman: Year One'
(14, 10, 1), -- 'Watchmen'
(16, 8, 1),  -- 'Spider-Man: Blue'
(18, 0, 0),  -- 'The Dark Knight Returns'
(20, 12, 1), -- 'Maus'
(22, 7, 1),  -- 'V for Vendetta'
(24, 4, 1),  -- 'Sandman: Preludes and Nocturnes'
(26, 15, 1), -- 'X-Men: Days of Future Past'
(28, 9, 1),  -- 'Saga, Vol. 1'
(30, 3, 1),  -- 'Y: The Last Man, Vol. 1'
(32, 6, 1),  -- 'The Walking Dead, Vol. 1'
(34, 0, 0),  -- 'Persepolis'
(36, 11, 1), -- 'Hellboy: Seed of Destruction'
(38, 14, 1), -- 'Bone: Out from Boneville'
(40, 2, 1);  -- 'Ms. Marvel: No Normal'


INSERT INTO Compras (id_cliente, fecha_compra, total) VALUES
(1, '2024-05-01', 19.98), 
(2, '2024-05-02', 19.99), 
(3, '2024-05-03', 39.98), 
(4, '2024-05-04', 9.99),
(5, '2024-05-05', 30.98), 
(6, '2024-05-06', 15.99), 
(7, '2024-05-07', 19.99); 

INSERT INTO Comic_Compras (cantidad, id_compra, id_comic) VALUES
(2, 100, 12), -- 2x 'Batman: Year One' para Ana Garc�a
(1, 103, 14), -- 1x 'Watchmen' para Luis Mart�nez
(1, 106, 12), -- 1x 'Batman: Year One' para Marta Fern�ndez
(2, 109, 14), -- 2x 'Watchmen' para Marta Fern�ndez
(1, 112, 16), -- 1x 'Spider-Man: Blue' para Carlos L�pez
(2, 115, 18), -- 2x 'The Dark Knight Returns' para Elena Rodr�guez
(1, 118, 20); -- 1x 'Maus' para Juan P�rez
--(1, 107, 12); -- 1x 'Batman: Year One' para Luc�a S�nchez


select * from Comic_Compras