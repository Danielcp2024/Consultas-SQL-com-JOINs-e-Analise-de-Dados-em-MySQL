use restaurante;

select * from produtos limit 10;
select * from info_produtos limit 10;
select * from pedidos limit 10;
select * from clientes limit 10;
select * from restaurante limit 10;


-- produtos: id, nome e descrição
-- info_produtos:  ingredientes

select p.id_produto, p.nome, p.descrição, i.ingredientes
from produtos p
left join info_produtos i on p.id_produto = i.id_produto;

-- pedidos:  id, quantidade e data
-- clientes: nome e email

select pe.id_pedido, pe.quantidade, pe.data_pedido, c.nome_completo, c.email
from pedidos pe
join clientes c on pe.id_pedido = c.id_cliente;

-- pedidos:  id, quantidade e data
-- clientes: nome e email
-- funcionarios: nome

select pe.id_produto, pe.quantidade, pe.data_pedido, c.nome_completo as nome_cliente, c.email, f.nome_completo as nome_funcionario
from pedidos pe
join clientes c on pe.id_produto = c.id_cliente
join restaurante f on pe.id_produto = f.id_funcionario;

-- pedidos:  id, quantidade e data
-- clientes: nome e email
-- funcionarios: nome
-- produtos: nome, preco

select pe.id_produto, pe.quantidade, pe.data_pedido, c.nome_completo 
as cliente, c.email, f.nome_completo
as funcionario, p.nome 
as produto, p.preço
from pedidos pe 
join clientes c on pe. id_cliente = c.id_cliente
left join restaurante f on pe.id_produto = f.id_funcionario
join produtos p on pe.id_produto = p.id_produto;

-- Selecionar o nome dos clientes com os pedidos com status ‘Pendente’ e exibir por ordem descendente de acordo com o id do pedido

select c.nome_completo, pe.id_pedido, pe.status_pedido
from pedidos pe
join clientes c on pe.id_cliente = c.id_cliente
where pe.status_pedido = "Pendente"
order by pe.id_pedido desc;

-- Selecionar clientes sem pedidos

select c.nome_completo, c.email
from clientes c
left join pedidos pe on c.id_cliente = 
pe.id_cliente
where pe.id_pedido is null;

-- Selecionar o nome do cliente e o total de pedidos cada cliente

select c.nome_completo, count(pe.id_pedido) as total_pedidos
from clientes c
left join pedidos pe on c.id_cliente = pe.id_cliente
group by c.id_cliente, c.nome_completo;

-- Selecionar o preço total (quantidade*preco) de cada pedido

select pe.id_pedido as id_pedido, sum(pe.quantidade * p.preço)
as preço_total
from pedidos pe
join produtos p on pe.id_pedido = p.id_produto
group by pe.id_pedido;