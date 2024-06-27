--> 1.- Insertar usuarios atraves de los parámetros
create procedure sp_InsertarUsuarios
	@nombre nvarchar(100),
	@email nvarchar(100),
	@pass nvarchar(100)
as
begin
	insert into Usuarios(Nombre, Email, Pass)
	values (@nombre, @email, @pass)
end;

exec sp_InsertarUsuarios @nombre='Estrella Aguillon', @email='estrella.torrijos@gmail.com', @pass='michilover63'
exec sp_InsertarUsuarios @nombre='Diego Valdelamar', @email='diego.valdelamar@gmail.com', @pass='5zombieland3'
exec sp_InsertarUsuarios @nombre='Ian Serrano', @email='ian.serrano@gmail.com', @pass='Agslcpant'
select *from Usuarios


--> 2.-Editar una Suscripción
create procedure sp_EditarSuscripcion
    @suscripcionID int,
	@fechaInicio date,
    @fechaFin date,
    @tipo nvarchar(50)
as
begin
    update Suscripciones
    set 
        FechaInicio = @fechaInicio,
        FechaFin = @fechaFin,
        Tipo = @tipo
    where 
        SuscripcionID = @suscripcionID;
end;

EXEC sp_EditarSuscripcion @SuscripcionID = 1, @FechaInicio = '2023-01-01', @FechaFin = '2023-06-01', @Tipo = 'Premium';
EXEC sp_EditarSuscripcion @SuscripcionID = 2, @FechaInicio = '2023-02-01', @FechaFin = '2023-07-01', @Tipo = 'Basica';
EXEC sp_EditarSuscripcion @SuscripcionID = 1, @FechaInicio = '2023-03-01', @FechaFin = '2023-08-01', @Tipo = 'Basica';

select * from Suscripciones

--> 3.-Eliminar un registro en la tabla de Historial Visualización
create procedure sp_EliminarHistorial
    @HistorialID int
as
begin    
    delete from HistorialVisualizacion
    where HistorialID = @HistorialID;
end;

exec sp_EliminarHistorial 1;
exec sp_EliminarHistorial 3;
exec sp_EliminarHistorial 5;


select * from HistorialVisualizacion


--> 4.-Consultar los usuarios con su suscripción, que use como parámetro el tipo de suscripción
CREATE PROCEDURE sp_ConsultarUsuarioSuscripcion
	@usuarioID int
as
begin
	select u.Nombre, s.Tipo as 'Tipo de Suscripcion', s.FechaInicio as 'Inicio de Suscripcion', s.FechaFin as 'Fin de Suscripcion'
	from Suscripciones s
	join Usuarios u on u.UsuarioID = s.UsuarioID
	
	where u.UsuarioID = @usuarioID;
end;

exec sp_ConsultarUsuarioSuscripcion 1;
exec sp_ConsultarUsuarioSuscripcion 2;
exec sp_ConsultarUsuarioSuscripcion 4;

select * from Suscripciones

--> 5.-Consultar que películas fueron reproducidas por el usuario pasando como parámetro el género de la película
create procedure sp_HistorialPorGenero
    @usuarioID int,
    @genero nvarchar(50)
as
begin    
    select p.Titulo, p.Genero, h.FechaVisualizacion
    from HistorialVisualizacion h
    join Peliculas p on h.PeliculaID = p.PeliculaID

    where 
		p.Genero = @Genero and h.UsuarioID = @usuarioID
end;

exec sp_HistorialPorGenero 1, fantasia;
exec sp_HistorialPorGenero 2, comedia;
exec sp_HistorialPorGenero 3, romance;
