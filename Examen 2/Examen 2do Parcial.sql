Create table Clientes(
	ClienteID int identity(1,1) primary key,
	Nombre nvarchar(100),
	Direccion nvarchar(200),
	Telefono nvarchar(15),
	Email nvarchar(100)
);

create table Cuentas( 
	CuentaID int identity(1,1) primary key,
	ClienteID int,
	TipoCuenta nvarchar(50),
	Saldo decimal(18,2),
	FechaApertura date,
	foreign key (ClienteID) references Clientes(ClienteID)
);

create table Transacciones(
	TransaccionID int identity(1,1) primary key,
	CuentaID int,
	TipoTransaccion nvarchar(50),
	Monto decimal(18,2),
	FechaTransaccion datetime,
	foreign key (CuentaID) references Cuentas(CuentaID)
);

create table Empleados(
	EmpleadoID int identity(1,1) primary key,
	Nombre nvarchar(100),
	Posicion nvarchar(50),
	Departamento nvarchar(50),
	FechaContratacion date
);


--> 3 inserts de cada tabla
INSERT INTO Clientes (Nombre, Direccion, Telefono, Email) VALUES
('Juan Pérez', 'Av. Siempre Viva 742, Springfield', '555-1234', 'juan.perez@example.com'),
('María García', 'Calle Falsa 123, Shelbyville', '555-5678', 'maria.garcia@example.com'),
('Carlos López', 'Calle Luna, Calle Sol, Ciudad de México', '555-8765', 'carlos.lopez@example.com');


INSERT INTO Cuentas (ClienteID, TipoCuenta, Saldo, FechaApertura) VALUES
(1, 'Ahorro', 1500.00, '2023-01-15'),
(2, 'Corriente', 2500.50, '2023-02-20'),
(3, 'Ahorro', 3000.75, '2023-03-10');


INSERT INTO Transacciones (CuentaID, TipoTransaccion, Monto, FechaTransaccion) VALUES
(1, 'Depósito', 500.00, '2023-04-01 10:30:00'),
(2, 'Retiro', 200.00, '2023-04-02 11:00:00'),
(3, 'Depósito', 300.00, '2023-04-03 12:00:00');


INSERT INTO Empleados (Nombre, Posicion, Departamento, FechaContratacion) VALUES
('Ana Torres', 'Gerente', 'Ventas', '2022-05-01'),
('Luis Fernández', 'Analista', 'Finanzas', '2022-06-15'),
('Marta Sánchez', 'Desarrollador', 'TI', '2022-07-20');



--SP para abrir una cuenta
CREATE PROCEDURE sp_AbrirCuentaNueva
    @ClienteID int,
	@TipoCuenta nvarchar(50),
	@Saldo decimal(18,2),
	@FechaApertura date
AS
BEGIN
    BEGIN TRANSACTION;

    BEGIN TRY
        insert into Cuentas(ClienteID, TipoCuenta, Saldo, FechaApertura)
		values (@ClienteID, @TipoCuenta, @Saldo, @FechaApertura)

        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION;
        DECLARE @ErrorMessage NVARCHAR(4000);
        SET @ErrorMessage = ERROR_MESSAGE();
        RAISERROR(@ErrorMessage, 16, 1);
    END CATCH
END;

EXEC sp_AbrirCuentaNueva 1, 'Inversiones', 10000.00, '2024-07-10'
EXEC sp_AbrirCuentaNueva 2, 'Ahorro', 1500.99, '2024-07-09'

select * from Cuentas

--SP para modificar datos de una cuenta existente
CREATE PROCEDURE sp_EditarCuenta
    @CuentaID int,
	@ClienteID int,
	@TipoCuenta nvarchar(50),
	@Saldo decimal(18,2),
	@FechaApertura date
AS
BEGIN
    BEGIN TRANSACTION;

    BEGIN TRY
		update Cuentas set ClienteID=@ClienteID, TipoCuenta=@TipoCuenta, 
		Saldo=@Saldo, FechaApertura=@FechaApertura
		where CuentaID= @CuentaID

        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION;
        DECLARE @ErrorMessage NVARCHAR(4000);
        SET @ErrorMessage = ERROR_MESSAGE();
        RAISERROR(@ErrorMessage, 16, 1);
    END CATCH
END;

EXEC sp_EditarCuenta 4, 3, 'Inversion', 1000.25, '2024-07-01'
EXEC sp_EditarCuenta 5, 2, 'Inversion', 1200.00, '2024-07-09'

select * from Cuentas


--Sp para transferir dinero entre dos cuentas existentes
CREATE PROCEDURE sp_TransferenciaDinero
    @CuentaID1 int,
	@CuentaID2 int,
	@Cantidad decimal(18,2)
AS
BEGIN
    BEGIN TRANSACTION;

    BEGIN TRY
		update Cuentas set Saldo=Saldo-@Cantidad where CuentaID=@CuentaID1
		update Cuentas set Saldo=Saldo+@Cantidad where CuentaID=@CuentaID2

        COMMIT TRANSACTION;
		PRINT 'TRANSFERENCIA REALIZADA CON EXITO'
    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION;
        DECLARE @ErrorMessage NVARCHAR(4000);
        SET @ErrorMessage = ERROR_MESSAGE();
        RAISERROR(@ErrorMessage, 16, 1);
    END CATCH
END;

EXEC sp_TransferenciaDinero 3, 4, 150.75
EXEC sp_TransferenciaDinero 1, 5, 121.25

select * from Cuentas