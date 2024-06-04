CREATE TABLE Autores (
    id_autor bigint identity(300,1) PRIMARY KEY,
    nombre VARCHAR(100),
    pais_origen VARCHAR(100)
);

ALTER TABLE Comics
ADD id_autor bigint,
FOREIGN KEY (id_autor) REFERENCES Autores(id_autor);

insert into Autores (nombre, pais_origen) values
('Frank Miller', 'Estados Unidos'),
('Alan Moore', 'Canada'),
('Neil Gaiman', 'Reino Unido'),
('Art Spiegelman', 'Alemania');

update Comics set id_autor = 300 where nombre = 'Batman: Year One';
update Comics set id_autor = 300 where nombre = 'The Dark Knight Returns';
update Comics set id_autor = 301 where nombre = 'Watchmen';
update Comics set id_autor = 301 where nombre = 'V for Vendetta';
update Comics set id_autor = 302 where nombre = 'Sandman: Preludes and Nocturnes';
update Comics set id_autor = 303 where nombre = 'Maus';
update Comics set id_autor = 302 where nombre = 'The Walking Dead, Vol. 1';
update Comics set id_autor = 300 where nombre = 'Spider-Man: Blue';
update Comics set id_autor = 303 where nombre = 'Hellboy: Seed of Destruction';
update Comics set id_autor = 301 where id_comic = 26;
update Comics set id_autor = 302 where id_comic = 40;

select a.nombre as 'Autor', c.nombre as 'Comic', i.cantidad_disponible as 'Cantidad disponible'
from Comics c
left join Autores a on a.id_autor=c.id_autor
join Inventario i on i.id_comic=c.id_comic;

select a.pais_origen as 'Nacionalidad', a.nombre as 'Autor', c.nombre 'Comic'
from Autores a
join Comics c on a.id_autor= c.id_autor;