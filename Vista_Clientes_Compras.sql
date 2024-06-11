CREATE VIEW VISTA_ClientesCompras AS 
SELECT c.id_cliente, c.nombre as Cliente, c.correo_electronico, cm.id_compra, cm.fecha_compra, cm.total
FROM Clientes c
left join Compras cm on c.id_cliente = cm.id_cliente

select * from VISTA_ClientesCompras

select * from Vista_ComicsInventario