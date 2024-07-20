-->Trigger que se active cada que se crea una tabla en la BD
CREATE TRIGGER Trigger_CrearTabla
ON DATABASE
FOR CREATE_TABLE
AS
BEGIN
    PRINT 'Se ha creado una nueva tabla en DBBANK.';
END;


-->Crear dos tablas nuevas para comprobar el trigger
CREATE TABLE Prestamos (
	PrestamoID INT IDENTITY(1,1) PRIMARY KEY,
	ClienteID INT,
	Monto DECIMAL(18,2),
	TasaInteres DECIMAL(5,2),
	FechaInicio DATE,
	FechaFin DATE,
	FOREIGN KEY (ClienteID) REFERENCES Clientes(ClienteID)
);

CREATE TABLE PagosPrestamos(
	PagoID INT IDENTITY(1,1) PRIMARY KEY,
	PrestamoID INT,
	MontoPagado DECIMAL(18,2),
	FechaPago DATE,
	FOREIGN KEY (PrestamoID) REFERENCES Prestamos(PrestamoID)
);

-->3 registros para cada tabla
INSERT INTO Prestamos (ClienteID, Monto, TasaInteres, FechaInicio, FechaFin) VALUES
(1, 10000.00, 5.00, '2023-01-01', '2025-01-01'),
(2, 20000.00, 4.50, '2023-02-15', '2026-02-15'),
(3, 15000.00, 6.00, '2023-03-10', '2025-03-10');

INSERT INTO PagosPrestamos (PrestamoID, MontoPagado, FechaPago) VALUES
(1, 500.00, '2023-04-01'),
(2, 1000.00, '2023-05-01'),
(3, 750.00, '2023-06-01');


--Trigger que se activa cada que se crea un SP
CREATE TRIGGER DDLTrigger_CreateProcedure
ON DATABASE
FOR CREATE_PROCEDURE
AS
BEGIN
    PRINT 'Se ha creado un Nuevo Procedimiento en DBBANK.'
END;



--SP para ingresar un nuevo prestamo a un usuario ya registrado y que tambien se ingrese el primer pago
CREATE PROCEDURE IngresarPrestamoPrimerPago
    @ClienteID INT,
    @Monto DECIMAL(18,2),
    @TasaInteres DECIMAL(5,2),
    @FechaInicio DATE,
    @FechaFin DATE,
    @MontoPrimerPago DECIMAL(18,2),
    @FechaPrimerPago DATE
AS
BEGIN
BEGIN TRANSACTION
    BEGIN TRY
        DECLARE @PrestamoID INT;
        INSERT INTO Prestamos (ClienteID, Monto, TasaInteres, FechaInicio, FechaFin)
        VALUES (@ClienteID, @Monto, @TasaInteres, @FechaInicio, @FechaFin);

        SET @PrestamoID = SCOPE_IDENTITY();

        INSERT INTO PagosPrestamos (PrestamoID, MontoPagado, FechaPago)
        VALUES (@PrestamoID, @MontoPrimerPago, @FechaPrimerPago);

        COMMIT TRANSACTION;        
        PRINT 'El préstamo y el primer pago han sido ingresados correctamente.';
    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION;
        DECLARE @ErrorMessage NVARCHAR(4000);
        SET @ErrorMessage = ERROR_MESSAGE();
        RAISERROR(@ErrorMessage, 16, 1);
    END CATCH
END;


--SP para consultar clientes con los datos de su préstamo y los pagos que ha realizado
CREATE PROCEDURE ConsultarClientesPrestamosYPagos
AS
BEGIN
    SELECT 
        c.ClienteID,
        c.Nombre AS Nombre,
        c.Direccion,
        c.Telefono,
        c.Email,
        p.PrestamoID,
        p.Monto AS 'Monto del Prestamo',
        p.TasaInteres AS 'Tasa de Interes',
        p.FechaInicio AS 'Inicio',
        p.FechaFin AS 'Fin',
        pp.PagoID,
        pp.MontoPagado 'Monto Depositado',
        pp.FechaPago 'Fecha de Pago'
    FROM Clientes c
    LEFT JOIN Prestamos p ON c.ClienteID = p.ClienteID
    LEFT JOIN PagosPrestamos pp ON p.PrestamoID = pp.PrestamoID
    ORDER BY c.ClienteID, p.PrestamoID, pp.FechaPago;
END;

