-->Insertar Autores
create procedure sp_InsertarAutores
	


--> Insertar nuevos comics
create procedure sp_InsertarComics
	@nombre varchar(100), 
	@anio tinyint,
	@precio decimal (10,2),
	@id_autor int
as
begin
	insert into Comics (nombre, anio, precio, id_autor) 
	values (@nombre, @anio, @precio, @id_autor)
end;

exec sp_InsertarComics

select * from Comics