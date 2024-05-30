--INNER JOIN
SELECT c.id_compra AS 'ID de compra', c.fecha_compra AS 'Fecha de compra', c.total AS 'Total', cl.nombre AS CLIENTE
FROM Compras c
JOIN  Clientes cl ON c.id_cliente = cl.id_cliente;

--LEFT JOIN
SELECT c.id_compra AS 'ID de compra', c.fecha_compra AS 'Fecha de compra', c.total AS 'Total', cl.nombre AS CLIENTE
FROM Compras c
LEFT JOIN  Clientes cl ON c.id_cliente = cl.id_cliente;

--RIGHT JOIN
SELECT c.id_compra AS 'ID de compra', c.fecha_compra AS 'Fecha de compra', c.total AS 'Total', cl.nombre AS CLIENTE
FROM Compras c
RIGHT JOIN  Clientes cl ON c.id_cliente = cl.id_cliente;

--FULL JOIN
select * from Clientes cl
full join Compras c
on c.id_cliente = cl.id_cliente;