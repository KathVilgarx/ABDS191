--Nombre del comic con los disponibles del inventario
select  c.nombre as 'Comic', i.cantidad_disponible as 'Cantidad disponible'
from Comics c
join Inventario i on c.id_comic= i.id_comic;

--Detalles de las compras realizadas por cada cliente y los cómics comprados
select cl.nombre as 'Cliente', c.id_compra as 'ID Compra', cs.nombre as 'Comic', cc.cantidad as 'Cantidad'
from Comic_Compras cc
right join Compras c on c.id_compra = cc.id_compra
left join Comics cs on cs.id_comic = cc.id_comic
join Clientes cl on cl.id_cliente = c.id_cliente;

--Compras junto con la cantidad disponible de cómics en el inventario incluidos los que no han sido comprados
select c.id_compra as 'ID Compra', cs.nombre as 'Comic', i.cantidad_disponible as 'Cantidad disponible'
from Inventario i
join Comics cs on i.id_comic = cs.id_comic
left join Comic_Compras cc on cc.id_comic = cs.id_comic
left join Compras c on c.id_compra = cc.id_compra;

--Consulta para enlistar todos los cómics y su cantidad disponible en el inventario
select cs.nombre as 'Comic', i.cantidad_disponible as 'Cantidad disponible'
from Comics cs
join Inventario i on i.id_comic = cs.id_comic;

--Todos datos de los comics, comics_compras e inventario disponible
select * from Comics, Inventario, Comic_Compras

--Los clientes que compraron algo con su id de compra nombre del comic, cantidad de compra y los disponibles en inventario
select cl.nombre as 'Cliente', c.id_compra as 'Compra', cs.nombre as 'Comic',
cc.cantidad as 'Cantidad', i.cantidad_disponible as 'En Inventario'
from Inventario i
join Comics cs on i.id_comic = cs.id_comic
left join Comic_Compras cc on cc.id_comic = cs.id_comic
left join Compras c on c.id_compra = cc.id_compra
join Clientes cl on cl.id_cliente = c.id_cliente