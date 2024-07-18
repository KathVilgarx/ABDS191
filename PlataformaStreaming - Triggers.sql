--> I. Crear 2 Triggers DDL
	-->Para registrar la creacion de tablas
CREATE TRIGGER Trigger_CrearTabla
ON DATABASE
FOR CREATE_TABLE
AS
BEGIN
    PRINT 'Una nueva tabla ha sido creada en la base de datos.';
END;


--****Ejecucion (creacion de una tabla random)****
CREATE TABLE PruebaCreacion (
    ID INT PRIMARY KEY,
    Nombre NVARCHAR(100)
);


-- Crear un trigger DDL para registrar la eliminación de tablas
CREATE TRIGGER Trigger_EliminarTabla
ON DATABASE
FOR DROP_TABLE
AS
BEGIN
    PRINT 'Una tabla ha sido eliminada de la base de datos.';
END;

--*Ejecucion (eliminacion de una tabla)*
DROP TABLE PruebaCreacion;

--> II. 2 Triggers DML
-- Para auditar inserciones en la tabla Usuarios
CREATE TRIGGER Trigger_InsertarUsuario
ON Usuarios
AFTER INSERT
AS
BEGIN
    DECLARE @UsuarioID INT, @Nombre NVARCHAR(100), @Email NVARCHAR(100);

    SELECT @UsuarioID = UsuarioID, @Nombre = Nombre, @Email = Email FROM inserted;

    PRINT 'Nuevo usuario insertado:';
    PRINT 'UsuarioID: ' + CAST(@UsuarioID AS NVARCHAR);
    PRINT 'Nombre: ' + @Nombre;
    PRINT 'Email: ' + @Email;
END;

--*Ejecucion (Insertar un nuevo usuario)*
INSERT INTO Usuarios (Nombre, Email, Pass, FechaRegistro)
VALUES ('Oliver Tree', 'oliver.tree@example.com', 'password123', GETDATE());


-->Para auditar actualizaciones en la tabla Suscripciones
CREATE TRIGGER Trigger_ActualizarSuscripcion
ON Suscripciones
AFTER UPDATE
AS
BEGIN
    DECLARE @SuscripcionID INT, @UsuarioID INT, @FechaInicio DATE, @FechaFin DATE, @Tipo NVARCHAR(50);

    SELECT @SuscripcionID = SuscripcionID, @UsuarioID = UsuarioID, @FechaInicio = FechaInicio, @FechaFin = FechaFin, @Tipo = Tipo FROM inserted;

    PRINT 'Suscripción actualizada:';
    PRINT 'SuscripcionID: ' + CAST(@SuscripcionID AS NVARCHAR);
    PRINT 'UsuarioID: ' + CAST(@UsuarioID AS NVARCHAR);
    PRINT 'FechaInicio: ' + CONVERT(NVARCHAR, @FechaInicio, 120);
    PRINT 'FechaFin: ' + ISNULL(CONVERT(NVARCHAR, @FechaFin, 120), 'NULL');
    PRINT 'Tipo: ' + ISNULL(@Tipo, 'NULL');
END;


--*Ejecucion (crear una nueva suscripcion para editarla)*
INSERT INTO Suscripciones (UsuarioID, FechaInicio, FechaFin, Tipo)
VALUES (15, GETDATE(), NULL, NULL);

UPDATE Suscripciones
SET FechaFin= '2025-07-17', Tipo = 'Premium'
WHERE SuscripcionID = 10;

select * from Suscripciones
