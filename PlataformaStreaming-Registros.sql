INSERT INTO Usuarios (Nombre, Email, Pass, FechaRegistro) VALUES
	('Juan Pérez', 'juan.perez@example.com', 'password1', '2023-01-01'),
	('María López', 'maria.lopez@example.com', 'password2', '2023-02-01'),
	('Carlos García', 'carlos.garcia@example.com', 'password3', '2023-03-01'),
	('Ana Fernández', 'ana.fernandez@example.com', 'password4', '2023-04-01'),
	('Luis Martínez', 'luis.martinez@example.com', 'password5', '2023-05-01'),
	('Sofía Gómez', 'sofia.gomez@example.com', 'password6', '2023-06-01'),
	('Javier Díaz', 'javier.diaz@example.com', 'password7', '2023-07-01'),
	('Laura Torres', 'laura.torres@example.com', 'password8', '2023-08-01'),
	('Diego Romero', 'diego.romero@example.com', 'password9', '2023-09-01'),
	('Elena Vargas', 'elena.vargas@example.com', 'password10', '2023-10-01')
;

INSERT INTO Peliculas (Titulo, Genero, FechasEstreno) VALUES
	('Titanes del Pacífico', 'Ciencia Ficción', '2010-07-16'),
	('El niño y la Garza', 'Fantasia', '1972-03-24'),
	('Batman: The Dark Knight', 'Acción', '2008-07-18'),
	('Shrek', 'Comedia', '1994-10-14'),
	('The Shawshank Redemption', 'Drama', '1994-09-23'),
	('500 days of summer', 'Romance', '1994-07-06'),
	('The Matrix', 'Ciencia Ficción', '1999-03-31'),
	('Five Nights at Freddy´s', 'Terror', '1993-12-15'),
	('Interstellar', 'Ciencia Ficción', '2014-11-07'),
	('Parasite', 'Drama', '2019-05-30'),
	('The Lion King', 'Animación', '1994-06-15')
;

INSERT INTO Suscripciones (UsuarioID, FechaInicio, FechaFin, Tipo) VALUES
	(1, '2023-01-01', '2023-06-01', 'Básica'),
	(2, '2023-02-01', '2023-07-01', 'Premium'),
	(3, '2023-03-01', NULL, NULL),
	(4, '2023-04-01', NULL, NULL),
	(5, '2023-05-01', '2023-12-01', 'Básica'),
	(6, '2023-06-01', '2024-01-01', 'Premium'),
	(7, '2023-07-01', NULL, 'Premium')
;

INSERT INTO HistorialVisualizacion (UsuarioID, PeliculaID, FechaVisualizacion) VALUES
	(1, 1, '2023-01-02 10:00:00'),
	(1, 2, '2023-01-03 11:00:00'),
	(2, 3, '2023-02-04 12:00:00'),
	(2, 4, '2023-02-05 13:00:00'),
	(3, 5, '2023-03-06 14:00:00'),
	(3, 6, '2023-03-07 15:00:00'),
	(4, 7, '2023-04-08 16:00:00'),
	(4, 8, '2023-04-09 17:00:00'),
	(5, 9, '2023-05-10 18:00:00'),
	(5, 10, '2023-05-11 19:00:00'),
	(6, 11, '2023-06-12 20:00:00'),
	(6, 1, '2023-06-13 21:00:00'),
	(7, 2, '2023-07-14 22:00:00'),
	(7, 3, '2023-07-15 23:00:00'),
	(8, 4, '2023-08-16 00:00:00'),
	(8, 5, '2023-08-17 01:00:00'),
	(9, 6, '2023-09-18 02:00:00'),
	(9, 7, '2023-09-19 03:00:00'),
	(10, 8, '2023-10-20 04:00:00'),
	(10, 9, '2023-10-21 05:00:00')
;
