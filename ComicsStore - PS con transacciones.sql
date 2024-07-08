-->1.-SP para agragar clientes
CREATE PROCEDURE sp_AgregarCliente
    @nombre VARCHAR(100),
    @correo_electronico NVARCHAR(255),
    @pass VARCHAR(255)
AS
BEGIN
    BEGIN TRANSACTION;

    BEGIN TRY
        INSERT INTO Clientes (nombre, correo_electronico, pass)
        VALUES (@nombre, @correo_electronico, @pass);

        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION;

        DECLARE @ErrorMessage NVARCHAR(4000);
        SET @ErrorMessage = ERROR_MESSAGE();
        RAISERROR(@ErrorMessage, 16, 1);
    END CATCH
END;
-->Ejemplos
EXEC sp_AgregarCliente 'Carlos Pérez','carlos.perez@example.com', 'password123';
EXEC sp_AgregarCliente 'Ana Gómez', 'ana.gomez@example.com', 'securepass456';
EXEC sp_AgregarCliente 'Luis Martínez', 'luis.martinez@example.com', 'mypassword789';

select * from Clientes



-->2.-Sp para cambiar la cantidad de comics en el inventario ---------------------------------
CREATE PROCEDURE sp_ActualizarInventario
    @id_comic BIGINT,
    @cantidad_disponible INT,
    @disponibilidad BINARY
AS
BEGIN
    BEGIN TRANSACTION;

    BEGIN TRY
        UPDATE Inventario
        SET cantidad_disponible = @cantidad_disponible, disponibilidad = @disponibilidad
        WHERE id_comic = @id_comic;

        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION;

        DECLARE @ErrorMessage NVARCHAR(4000);
        SET @ErrorMessage = ERROR_MESSAGE();
        RAISERROR(@ErrorMessage, 16, 1);
    END CATCH
END;

-->ejemplos
EXEC sp_ActualizarInventario 10, 15, 1;
EXEC sp_ActualizarInventario 11, 8, 1;
EXEC sp_ActualizarInventario 12, 0, 0;

select * from Inventario


-->3.- Sp para eliminar clientes --------------------------------------------
CREATE PROCEDURE sp_EliminarCliente
    @id_cliente BIGINT
AS
BEGIN
    BEGIN TRANSACTION;

    BEGIN TRY
        DELETE FROM Comic_Compras
        WHERE id_compra IN (SELECT id_compra FROM Compras WHERE id_cliente = @id_cliente);

        DELETE FROM Compras
        WHERE id_cliente = @id_cliente;

        DELETE FROM Clientes
        WHERE id_cliente = @id_cliente;

        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION;

        DECLARE @ErrorMessage NVARCHAR(4000);
        SET @ErrorMessage = ERROR_MESSAGE();
        RAISERROR(@ErrorMessage, 16, 1);
    END CATCH
END;

-->ejemplos
EXEC sp_EliminarCliente 1;
EXEC sp_EliminarCliente 2;
EXEC sp_EliminarCliente 3;


select * from Clientes


-->4.- SP para editar los datos de un comic -------------------------------------------------------
CREATE PROCEDURE sp_ActualizarComic
    @id_comic BIGINT,
    @nombre VARCHAR(100),
    @anio INT,
    @precio DECIMAL(10, 2),
    @id_autor BIGINT
AS
BEGIN
    BEGIN TRANSACTION;

    BEGIN TRY
        UPDATE Comics
        SET nombre = @nombre, anio = @anio, precio = @precio, id_autor = @id_autor
        WHERE id_comic = @id_comic;

        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION;

        DECLARE @ErrorMessage NVARCHAR(4000);
        SET @ErrorMessage = ERROR_MESSAGE();
        RAISERROR(@ErrorMessage, 16, 1);
    END CATCH
END;

-->ejemplos
EXEC sp_ActualizarComic 10, 'Batman: Year One Updated', 1986, 25.99, 300;
EXEC sp_ActualizarComic 11, 'Watchmen Updated', 1987, 29.99, 301;
EXEC sp_ActualizarComic 12, 'V for Vendetta Updated', 1989, 19.99, 301;

select * from Comics


-->5.-SP pra agregar comics ---------------------------------------------------
CREATE PROCEDURE sp_AgregarComic
    @nombre VARCHAR(100),
    @anio INT,
    @precio DECIMAL(10, 2),
    @id_autor BIGINT
AS
BEGIN
    BEGIN TRANSACTION;

    BEGIN TRY
        INSERT INTO Comics (nombre, anio, precio, id_autor)
        VALUES (@nombre, @anio, @precio, @id_autor);

        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION;

        DECLARE @ErrorMessage NVARCHAR(4000);
        SET @ErrorMessage = ERROR_MESSAGE();
        RAISERROR(@ErrorMessage, 16, 1);
    END CATCH
END;

--Ejemplos
EXEC sp_AgregarComic 'The Killing Joke', 1988, 14.99, 300;
EXEC sp_AgregarComic 'Preacher', 1995, 24.99, 302;
EXEC sp_AgregarComic 'The Sandman', 1989, 29.99, 302;


select * from Comics