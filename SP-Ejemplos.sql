--> Explorar las propiedades de una base de datos
EXEC sp_helpdb		--> Muestra todas las bd
EXEC sp_helpdb 'ComicsStore'	--> Muestra solo una bd en especifico

--> Explorar las propiedades de un objeto de la BD
EXEC sp_help 'Clientes'

--> Llaves primarias de una tablas
EXEC sp_helpindex 'Clientes'

--> Informacion de los usuarios y procesos actuales
EXEC sp_who

--> Rendimiento del servidor
EXEC sp_monitor

--> Espacio usado por la BD
EXEC sp_spaceused

--> Puerto de escucha del SQL SERVER
EXEC sp_readerrorlog 0,1	--> Necesita de dos parametros (en este caso el 0 y 1)


--> Nuestros propios procedimientos <--
--> SP Para obtener el historial de un usuario en la BD de Streaming
CREATE PROCEDURE sp_ObtenerHistorial
	@usuarioId INT 
AS
BEGIN
	select h.HistorialID, p.Titulo, h.FechaVisualizacion
	from HistorialVisualizacion h
	join Peliculas p on h.PeliculaID = p.PeliculaID
	where h.UsuarioID = @usuarioId
	order by h.FechaVisualizacion desc

END;

EXEC sp_ObtenerHistorial 1


--> SP para insertar peliculas
create procedure sp_InsertarPeliculas
	@titulo nvarchar(100),
	@genero nvarchar(50),
	@fechaEstreno date
as
begin
	insert into Peliculas(Titulo, Genero, FechasEstreno)
	values (@titulo, @genero, @fechaEstreno)
end;

exec sp_InsertarPeliculas @titulo='El Castillo Vagabundo', @genero='Fantasia', @fechaEstreno='2005-09-02'
select *from Peliculas