USE northwind;

/*1.Pedidos por empresa en UK:
Desde las oficinas en UK nos han pedido con urgencia que realicemos una consulta a la base de datos con la que podamos conocer cuántos pedidos ha realizado cada empresa cliente de UK.
Nos piden el ID del cliente y el nombre de la empresa y el número de pedidos.
Deberéis obtener una tabla similar a esta:*/

select customers.customer_id as ID_Empresa, customers.company_name as Nombre_Empresa, COUNT(orders.order_id) AS Nº_Pedidos
FROM customers
NATURAL JOIN orders
GROUP BY customers.customer_id
HAVING max(orders.ship_country = 'UK');

/*2.Productos pedidos por empresa en UK por año:
Desde Reino Unido se quedaron muy contentas con nuestra rápida respuesta a su petición anterior y han decidido pedirnos una serie de consultas adicionales. 
La primera de ellas consiste en una query que nos sirva para conocer cuántos objetos ha pedido cada empresa cliente de UK durante cada año. 
Nos piden concretamente conocer el nombre de la empresa, el año, y la cantidad de objetos que han pedido. Para ello hará falta hacer 2 joins.
El resultado será una tabla similar a esta:*/
 
select company_name as Nombre, customer_id
from customers
where country = "UK";

select date_format(order_date , "%Y") as AÑO,order_id as ID_pedido
from orders
where ship_country = "UK";

select quantity, order_id
from order_details;

select company_name as Nombre_Empresa, date_format(o.order_date , "%Y"), sum(quantity) as NºObjeto
from customers as c
	inner join orders as o
	on o.customer_id = c.customer_id
	inner join order_details as od
	on o.order_id = od.order_id
	where o.ship_country = "UK"
    group by company_name,date_format(o.order_date , "%Y")
    ;
    
/*3.Mejorad la query anterior:
Lo siguiente que nos han pedido es la misma consulta anterior pero con la adición de la cantidad de dinero que han pedido por esa cantidad de objetos, 
teniendo en cuenta los descuentos, etc. Ojo que los descuentos en nuestra tabla nos salen en porcentajes, 15% nos sale como 0.15.
La tabla resultante será:*/
select company_name as Nombre_Empresa, date_format(o.order_date , "%Y") as AÑO, sum(quantity) as NºObjeto, sum((quantity*unit_price)*(1-discount)) as DineroTotal
from customers as c
	inner join orders as o
	on o.customer_id = c.customer_id
	inner join order_details as od
	on o.order_id = od.order_id
	where o.ship_country = "UK"
    group by company_name,date_format(o.order_date , "%Y")
    ;
/*4.BONUS: Pedidos que han realizado cada compañía y su fecha:
Después de estas solicitudes desde UK y gracias a la utilidad de los resultados que se han obtenido, 
desde la central nos han pedido una consulta que indique el nombre de cada compañia cliente junto con cada pedido que han realizado y su fecha.
El resultado deberá ser:*/

select order_id as orderID, company_name as CompanyName, (order_date ) as OrdeDate
from orders as o
inner join customers as c
on o.customer_id = c.customer_id
order by company_name ASC
;
/*5.BONUS: Tipos de producto vendidos:
Ahora nos piden una lista con cada tipo de producto que se han vendido, sus categorías, nombre de la categoría y el nombre del producto,
y el total de dinero por el que se ha vendido cada tipo de producto (teniendo en cuenta los descuentos).
Pista Necesitaréis usar 3 joins.*/
select category_id, category_name
from categories;
select product_name, product_id, category_id, unit_price
from products;
select product_id, sum((quantity*unit_price)*(1-discount)) as Product_Sales
from order_details
group by product_id;

select cat.category_id as Category_ID, cat.category_name as Category_Name, ps.product_name as Product_Name, sum((od.quantity*od.unit_price)*(1-od.discount)) as Product_Sales
from categories as cat
	inner join products as ps
	on cat.category_id = ps.category_id
	inner join order_details as od
	on ps.product_id = od.product_id
    group by category_id, product_name;
/*6.Qué empresas tenemos en la BBDD Northwind:
Lo primero que queremos hacer es obtener una consulta SQL que nos devuelva el nombre de todas las empresas cliente, los ID de sus pedidos y las fechas.
Los resultados deberán similares a la siguiente tabla:*/
select order_id as orderID, company_name as CompanyName, (order_date ) as OrdeDate
from orders as o
inner join customers as c
on o.customer_id = c.customer_id
order by company_name ASC

/*7.Pedidos por cliente de UK:
Desde la oficina de Reino Unido (UK) nos solicitan información acerca del número de pedidos que ha realizado cada cliente del propio Reino Unido de cara a conocerlos mejor 
y poder adaptarse al mercado actual. Especificamente nos piden el nombre de cada compañía cliente junto con el número de pedidos.
La tabla resultante será */

select company_name as NombreCliente, count(order_id) as NumeroPedidos
from customers as c
inner join orders as o
on c.customer_id = o.customer_id
where c.country = "UK"
group by company_name;

/*8.Empresas de UK y sus pedidos:
También nos han pedido que obtengamos todos los nombres de las empresas cliente de Reino Unido (tengan pedidos o no)
junto con los ID de todos los pedidos que han realizado y la fecha del pedido.
Los resultados de la query deberán ser:*/

select order_id as OrderID, company_name as NombreCliente, order_date as FechaPedido
from orders as o
inner join customers as c
on o.customer_id = c.customer_id
where o.ship_country = "UK"
order by company_name ASC
;

/*9. Empleadas que sean de la misma ciudad:
Ejercicio de SELF JOIN: Desde recursos humanos nos piden realizar una consulta que muestre por pantalla los datos de todas las empleadas y sus supervisoras.
Concretamente nos piden: la ubicación, nombre, y apellido tanto de las empleadas como de las jefas. Investiga el resultado, ¿sabes decir quién es el director?
La tabla resultado de la query deberá ser:*/

select a.first_name as NombreEmpleada, a.last_name as ApellidoEmpleada, a.city as CiuEmpleada, b.first_name as NombreMng, b.last_name as ApellidoMng, b.city as CiuMng
from employees as a, employees as b
where a.title <> b.title;

/*10.Selecciona todos los pedidos, tengan empresa asociada o no, y todas las empresas tengan pedidos asociados o no.
 Muestra el ID del pedido, el nombre de la empresa y la fecha del pedido (si existe).*/
 


