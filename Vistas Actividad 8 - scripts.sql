--Vista 1
create view Vista_ComprasComic as
select cc.id_CC, cc.cantidad, c.nombre as Comic, co.id_compra, co.fecha_compra, co.total
from Comic_Compras cc
join Comics c on c.id_comic = cc.id_comic
join Compras co on co.id_compra = cc.id_Compra

select * from Vista_ComprasComic

--Vista 2
create view Vista_ComicsComprados as
select cl.id_cliente, cl.nombre as Cliente, cc.cantidad as 'Cantidad de comics comprados'
from Comic_Compras cc
join Compras c on cc.id_compra = c.id_compra
right join Clientes cl on c.id_cliente = cl.id_cliente

select * from Vista_ComicsComprados