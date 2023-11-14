USE northwind;

/*1. Extraed los pedidos con el máximo "order_date" para cada empleado.
Nuestro jefe quiere saber la fecha de los pedidos más recientes que ha gestionado cada empleado. Para eso nos pide que lo hagamos con una query correlacionada.
Los resultados de esta query serán:*/

SELECT order_id, customer_id, order_date AS max_order_date, employee_id, required_date
FROM orders
WHERE (employee_id, order_date) IN (
    SELECT employee_id, MAX(order_date) AS max_order_date
    FROM orders
    GROUP BY employee_id
);
    
/*2.Extraed el precio unitario máximo (unit_price) de cada producto vendido.
Supongamos que ahora nuestro jefe quiere un informe de los productos vendidos y su precio unitario. De nuevo lo tendréis que hacer con queries correlacionadas.
Los resultados deberán ser:*/

SELECT distinct product_id, unit_price as Max_Unit_Price
from order_details
where (product_id, unit_price) in 
	(select product_id, MAX(unit_price)
	from order_details
	group by product_id)
order by product_id ASC;

/*3.Extraed información de los productos "Beverages"
En este caso nuestro jefe nos pide que le devolvamos toda la información necesaria para identificar un tipo de producto. 
En concreto, tienen especial interés por los productos con categoría "Beverages". Devuelve el ID del producto, el nombre del producto y su ID de categoría.
La query debería resultar en una tabla como esta:*/

SELECT product_id, product_name, category_id
FROM products
where category_id = 1;

/*4.Extraed la lista de países donde viven los clientes, pero no hay ningún proveedor ubicado en ese país
Suponemos que si se trata de ofrecer un mejor tiempo de entrega a los clientes, entonces podría dirigirse a estos países para buscar proveedores adicionales.
Los resultados de esta query son:*/

SELECT distinct c.country
FROM customers as c
inner join suppliers as s
where c.country <> s.country;




/*5.Extraer los clientes que compraron mas de 20 articulos "Grandma's Boysenberry Spread"
Extraed el OrderId y el nombre del cliente que pidieron más de 20 artículos del producto "Grandma's Boysenberry Spread" (ProductID 6) en un solo pedido.
Resultado de nuestra query deberíamos tener una tabla como esta:*/

/*6.Extraed los 10 productos más caros
Nos siguen pidiendo más queries correlacionadas. En este caso queremos saber cuáles son los 10 productos más caros.
Los resultados esperados de esta query son:*/