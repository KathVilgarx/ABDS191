--declaracion de variables
declare @idCliente int

--inicializar o asignar valor
set @idCliente= 8

--if
--if @idCliente= 8
	--select *from Clientes where id_cliente=@idCliente

/*
declare @edad int
set @idCliente= 8

if @idCliente= 8
	begin
		set @edad=25
		select * from Clientes where id_cliente=@idCliente
		print @edad

		if exists (select * from Clientes where id_cliente= 10)
		print 'Si existe'
	end
else
	begin
		print 'Error:'
		print'id no autorizado para la consulta'
	end
*/

/*
--While
declare @contador int= 0

while @contador <= 10 
	begin
		print @contador
		set @contador= @contador+1
	end
*/

--Return y Break
declare @contador int= 0

while @contador <= 10 
	begin
		print @contador
		set @contador= @contador+1
		if @contador=3
			break
		print 'hola'
	end
	print 'aqui continua el flujo'

--Try-Catch
begin try
set @contador = 'kath'
end try
begin catch
	print 'la variable contador solo acepta enteros'
end catch

print 'soy otra consulta'
print 'yo tambien'


