-->Crea un procedimiento que inserte una nueva película, y que al mismo tiempo inserte un registro en 
--Historial Visualización de esa misma película a cualquier usuario

create procedure sp_PeliculaNuevaHistorial
	@Titulo nvarchar(100),
	@Genero nvarchar(50),
	@FechaEstreno date,
	@UsuarioID int,
	@FechaVisualizacion datetime
	
as
begin
	begin transaction
		begin try
			insert into Peliculas(Titulo, Genero, FechasEstreno) 
			values (@Titulo, @Genero, @FechaEstreno)
			
			DECLARE @PeliculaID INT;
			SET @PeliculaID = SCOPE_IDENTITY(); 

			insert into HistorialVisualizacion(UsuarioID, PeliculaID, FechaVisualizacion)
			values (@UsuarioID, @PeliculaID, @FechaVisualizacion)
		commit transaction
		end try
		
		begin catch
		rollback
			declare @ErrorMessage NVARCHAR(4000);
			set @ErrorMessage= ERROR_MESSAGE();
			print @ErrorMessage;
		end catch
end;

-- Ejecución del stored procedure sp_PeliculaNuevaHistorial con parámetros nombrados

EXEC sp_PeliculaNuevaHistorial 
    @Titulo = 'Ultraman: Rising',
    @Genero = 'Acción',
    @FechaEstreno = '2024-06-25',
    @UsuarioID = 1,
    @FechaVisualizacion = '2024-07-03 15:30:00';

select * from Peliculas
select * from HistorialVisualizacion



-->Crea un procedimiento que permita insertar un usuario, con su respectiva suscripción y una 
--visualización de cualquier película
create procedure sp_UsuarioSuscripcionVisualizacion
	@Nombre nvarchar(100),
	@Email nvarchar(100),
	@Pass nvarchar(100),
	@FechaRegistro date,
	@FechaInicio date,
	@FechaFin date,
	@Tipo nvarchar(50),
	@PeliculaID int,
	@FechaVisualizacion datetime
as
begin
	begin transaction
		begin try
			insert into Usuarios(Nombre, Email, Pass, FechaRegistro)
			values (@Nombre, @Email, @Pass, @FechaRegistro)
			
			DECLARE @UsuarioID INT;
			SET @UsuarioID = SCOPE_IDENTITY(); 

			insert into Suscripciones(UsuarioID, FechaInicio, FechaFin, Tipo)
			values (@UsuarioID, @FechaInicio, @FechaFin, @Tipo)

			insert into HistorialVisualizacion(UsuarioID, PeliculaID, FechaVisualizacion)
			values (@UsuarioID, @PeliculaID, @FechaVisualizacion)
		commit transaction
		end try
		
		begin catch
		rollback
			declare @ErrorMessage NVARCHAR(4000);
			set @ErrorMessage= ERROR_MESSAGE();
			print @ErrorMessage;
		end catch
end;

exec sp_UsuarioSuscripcionVisualizacion 'Samuel Veytia', 'vitya@gmail.com', 'sincebolla', '2004-06-22', '2024-07-03', '2024-08-03', 'Basica', 6, '2024-07-04 07:48:00'

select * from Usuarios
select * from Suscripciones
select * from HistorialVisualizacion


--Crea un procedimiento que permita actualizar el correo de los usuarios y al mismo tiempo cambie el tipo suscripción a Anual
create procedure sp_CambiarCorreoTipoSuscripcion
	@UsuarioID int,
	@Email nvarchar (100),
	@Tipo nvarchar(50)
as
begin
begin transaction
		begin try
			update Usuarios set Email= @Email
			where UsuarioID=@UsuarioID

			update Suscripciones set Tipo=@Tipo
			where UsuarioID=@UsuarioID
		commit transaction
		end try
		
		begin catch
		rollback
			declare @ErrorMessage NVARCHAR(4000);
			set @ErrorMessage= ERROR_MESSAGE();
			print @ErrorMessage;
		end catch
end;

exec sp_CambiarCorreoTipoSuscripcion 14, 'samveytia6@gmail.com', 'Premium'

select * from Usuarios
select * from Suscripciones


--Crea un procedimiento que permita eliminar una película y al mismo tiempo todos los registros de esa misma película en Historial de visualización
CREATE PROCEDURE sp_EliminarPeliculaHistorial
    @PeliculaID INT
AS
BEGIN
    BEGIN TRANSACTION;

    BEGIN TRY
        DELETE FROM HistorialVisualizacion
        WHERE PeliculaID = @PeliculaID;

        DELETE FROM Peliculas
        WHERE PeliculaID = @PeliculaID;
        COMMIT TRANSACTION;
        PRINT 'Pelicula y su historial eliminados exitosamente.';
    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION;
        DECLARE @ErrorMessage NVARCHAR(4000);
        SET @ErrorMessage = ERROR_MESSAGE();
        PRINT 'Error: ' + @ErrorMessage;
    END CATCH
END;

exec sp_EliminarPeliculaHistorial 5

select * from Peliculas
select * from HistorialVisualizacion


--Crea un procedimiento que Elimine un usuario con todas sus suscripciones y registros en historial de visualización
create procedure sp_EliminarUsuarioPermanente
	@UsuarioID int
as
begin
begin transaction
		begin try
			delete from HistorialVisualizacion
			where UsuarioID=@UsuarioID

			delete from Suscripciones 
			where UsuarioID=@UsuarioID

			delete from Usuarios
			where UsuarioID=@UsuarioID
		commit transaction
		print 'Usuario eliminado exitosamente'
		end try
		
		begin catch
		rollback
			declare @ErrorMessage NVARCHAR(4000);
			set @ErrorMessage= ERROR_MESSAGE();
			print @ErrorMessage;
		end catch
end;

exec sp_EliminarUsuarioPermanente 9


select * from Usuarios
select * from Suscripciones
select * from HistorialVisualizacion