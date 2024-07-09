-- Crear la tabla Autores
CREATE TABLE Autores (
    id_autor bigint identity(300,1) PRIMARY KEY,
    nombre VARCHAR(100),
    pais_origen VARCHAR(100)
);

-- Agregar columna id_autor a la tabla Comics
ALTER TABLE Comics
ADD id_autor bigint,
FOREIGN KEY (id_autor) REFERENCES Autores(id_autor);

-- Insertar autores en la tabla Autores
INSERT INTO Autores (nombre, pais_origen) VALUES
('Frank Miller', 'Estados Unidos'),
('Alan Moore', 'Canada'),
('Neil Gaiman', 'Reino Unido'),
('Art Spiegelman', 'Alemania');

-- Actualizar la tabla Comics asignando autores
UPDATE Comics SET id_autor = 300 WHERE nombre = 'Batman: Year One';
UPDATE Comics SET id_autor = 300 WHERE nombre = 'The Dark Knight Returns';
UPDATE Comics SET id_autor = 301 WHERE nombre = 'Watchmen';
UPDATE Comics SET id_autor = 301 WHERE nombre = 'V for Vendetta';
UPDATE Comics SET id_autor = 302 WHERE nombre = 'Sandman: Preludes and Nocturnes';
UPDATE Comics SET id_autor = 303 WHERE nombre = 'Maus';
UPDATE Comics SET id_autor = 302 WHERE nombre = 'The Walking Dead, Vol. 1';

