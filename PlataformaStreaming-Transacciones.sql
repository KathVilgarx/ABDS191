create procedure sp_ActualizarSuscripcion
	@UsuarioID int,
	@FechaInicio date,
	@FechaFin date,
	@Tipo nvarchar(50)
as
begin
	BEGIN TRANSACTION
	BEGIN TRY
		insert into Suscripciones (UsuarioID, FechaInicio, FechaFin, Tipo)
		values (@UsuarioID, @FechaInicio, @FechaFin, @Tipo);

		update Usuarios
		set FechaRegistro=@FechaInicio
		where UsuarioID = @UsuarioID;

		COMMIT TRANSACTION;
	END TRY
	BEGIN CATCH
		ROLLBACK TRANSACTION
			DECLARE @ErrorMessage nvarchar(4000)
			SET @ErrorMessage =ERROR_MESSAGE();
			PRINT @ErrorMessage;
	END CATCH
end;

exec sp_ActualizarSuscripcion 25, '2024-07-01', '2024-07-01', Basica




