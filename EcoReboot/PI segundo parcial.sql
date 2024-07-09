--> 1.- 3 vistas con Joins
CREATE VIEW Vista_Dispositivos_Reciclajes AS
SELECT d.id_dispositivo, 
	d.nombre AS nombre_dispositivo, 
	d.modelo, d.descripcion,
    r.id_reciclaje, 
	r.fecha AS fecha_reciclaje,
	r.descripcion AS descripcion_reciclaje,
	r.costo
FROM dispositivos d
INNER JOIN reciclajes r ON d.id_dispositivo = r.id_dispositivo;

select*from Vista_Dispositivos_Reciclajes;

------------------------------------------------------
CREATE VIEW Vista_Reparaciones_PzNuevas AS
SELECT rp.id_reparacion, rp.fecha AS fecha_reparacion, rp.descripcion AS descripcion_reparacion,
       pn.id_pza_nueva, pn.nombre AS nombre_pieza, pn.precio
FROM reparaciones rp
INNER JOIN pzs_nuevas pn ON rp.id_reparacion = pn.id_reparacion;

select*from Vista_Reparaciones_PzNuevas;

-----------------------------------------------------
CREATE VIEW Vista_Reciclajes_Materiales AS
SELECT r.id_reciclaje, r.fecha AS fecha_reciclaje, r.descripcion AS descripcion_reciclaje, r.costo,
       m.id_mat_reciclado, m.nombre AS nombre_material
FROM reciclajes r
INNER JOIN mat_reciclados m ON r.id_reciclaje = m.id_reciclaje;

select*from Vista_Reciclajes_Materiales;
--------------------------------------------------------------------


------2.- 5 procedimientos Almacenados simples ---------------------
CREATE PROCEDURE sp_DetallesDispositivo
    @id_dispositivo INT
AS
BEGIN
    SELECT nombre, modelo, descripcion
    FROM dispositivos
    WHERE id_dispositivo = @id_dispositivo;
END;

EXEC sp_DetallesDispositivo @id_dispositivo = 1;
EXEC sp_DetallesDispositivo @id_dispositivo = 2;
EXEC sp_DetallesDispositivo @id_dispositivo = 3;

-----------------------------------------------------------------
CREATE PROCEDURE sp_ListarDonaciones
    @id_usuario INT
AS
BEGIN
    SELECT id_donacion, fecha, total_dispositivos
    FROM donaciones
    WHERE id_usuario = @id_usuario;
END;

EXEC sp_ListarDonaciones @id_usuario = 21;
EXEC sp_ListarDonaciones @id_usuario = 22;
EXEC sp_ListarDonaciones @id_usuario = 23;

select*from donaciones;
---------------------------------------------------------------

CREATE PROCEDURE sp_ListarReciclajes
    @fecha_inicio DATE = NULL,
    @fecha_fin DATE = NULL
AS
BEGIN
    SELECT id_reciclaje, fecha, descripcion, costo
    FROM reciclajes
    WHERE (@fecha_inicio IS NULL OR fecha >= @fecha_inicio)
      AND (@fecha_fin IS NULL OR fecha <= @fecha_fin);
END;

EXEC sp_ListarReciclajes;
EXEC sp_ListarReciclajes @fecha_inicio = '2023-01-01', @fecha_fin = '2024-01-01';
EXEC sp_ListarReciclajes @fecha_inicio = '2022-06-01';

-------------------------------------------------------------------
CREATE PROCEDURE ap_ActualizarUsuario
    @id_usuario INT,
    @nombre NVARCHAR(100),
    @direccion NVARCHAR(255),
    @telefono NVARCHAR(20),
    @correo NVARCHAR(100),
    @id_rol_usuario INT
AS
BEGIN
    UPDATE usuarios
    SET nombre = @nombre,
        direccion = @direccion,
        telefono = @telefono,
        correo = @correo,
        id_rol_usuario = @id_rol_usuario
    WHERE id_usuario = @id_usuario;
END;

EXEC ap_ActualizarUsuario @id_usuario = 21, @nombre = 'Juan Pérez', @direccion = 'Calle A, Ciudad X', @telefono = '555-1234', @correo = 'juan.perez@example.com', @id_rol_usuario = 2;
EXEC ap_ActualizarUsuario @id_usuario = 22, @nombre = 'María López', @direccion = 'Av. B, Ciudad Y', @telefono = '555-5678', @correo = 'maria.lopez@example.com', @id_rol_usuario = 1;
EXEC ap_ActualizarUsuario @id_usuario = 23, @nombre = 'Pedro Ramírez', @direccion = 'Plaza C, Ciudad Z', @telefono = '555-9012', @correo = 'pedro.ramirez@example.com', @id_rol_usuario = 2;

select*from usuarios;
------------------------------------------

CREATE PROCEDURE sp_InsertarNuevaDonacion
    @id_usuario INT,
    @fecha DATE,
    @total_dispositivos INT
AS
BEGIN
    INSERT INTO donaciones (id_usuario, fecha, total_dispositivos)
    VALUES (@id_usuario, @fecha, @total_dispositivos);
END;

EXEC sp_InsertarNuevaDonacion @id_usuario = 21, @fecha = '2024-07-08', @total_dispositivos = 3;
EXEC sp_InsertarNuevaDonacion @id_usuario = 22, @fecha = '2024-07-07', @total_dispositivos = 2;
EXEC sp_InsertarNuevaDonacion @id_usuario = 23, @fecha = '2024-07-06', @total_dispositivos = 1;

select*from donaciones;

-----------------------------------------------------------


--3.- 3 procedimientos con transacciones -----------------------------
CREATE PROCEDURE InsertarDonacionActualizarUsuario
    @id_usuario INT,
    @fecha DATE,
    @total_dispositivos INT,
    @nueva_direccion NVARCHAR(255)
AS
BEGIN
    BEGIN TRANSACTION;
    BEGIN TRY
        INSERT INTO donaciones (id_usuario, fecha, total_dispositivos)
        VALUES (@id_usuario, @fecha, @total_dispositivos);

        UPDATE usuarios
        SET direccion = @nueva_direccion
        WHERE id_usuario = @id_usuario;

        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION;
        THROW;
    END CATCH
END;

----------------------------------------
CREATE PROCEDURE InsertarReparacionDetalles
    @fecha DATE,
    @id_dispositivo INT,
    @descripcion NVARCHAR(255),
    @costo DECIMAL(10, 2),
    @id_estado INT,
    @id_pza_nueva INT
AS
BEGIN
    BEGIN TRANSACTION;
    BEGIN TRY
        DECLARE @id_reparacion INT;

        INSERT INTO reparaciones (fecha, id_dispositivo, descripcion, costo, id_estado)
        VALUES (@fecha, @id_dispositivo, @descripcion, @costo, @id_estado);

        SET @id_reparacion = SCOPE_IDENTITY();

        INSERT INTO detalles_reparacion (id_reparacion, id_pza_nueva)
        VALUES (@id_reparacion, @id_pza_nueva);

        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION;
        THROW;
    END CATCH
END;

------------------------------------------------
CREATE PROCEDURE InsertarReciclajeMaterial
    @fecha DATE,
    @id_dispositivo INT,
    @descripcion NVARCHAR(255),
    @costo DECIMAL(10, 2),
    @id_estado INT,
    @id_tipo_material INT,
    @nombre_material NVARCHAR(100)
AS
BEGIN
    BEGIN TRANSACTION;
    BEGIN TRY
        DECLARE @id_reciclaje INT;

        INSERT INTO reciclajes (fecha, id_dispositivo, descripcion, costo, id_estado)
        VALUES (@fecha, @id_dispositivo, @descripcion, @costo, @id_estado);

        SET @id_reciclaje = SCOPE_IDENTITY();

        INSERT INTO mat_reciclados (id_tipo_material, nombre, id_reciclaje)
        VALUES (@id_tipo_material, @nombre_material, @id_reciclaje);

        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION;
        THROW;
    END CATCH
END;

--

