/* */

USE northwind;

/* 1- Extraer en una CTE todos los nombres de las compañias y los id de los clientes.
Para empezar nos han mandado hacer una CTE muy sencilla el id del cliente y el nombre de la compañia de
 la tabla Customers. */
 
 
 
 SELECT customer_id, company_name
 FROM customers;
 

 
 WITH compañias AS (
  SELECT customer_id, company_name
  FROM customers
)
SELECT * FROM compañias;

 
 /* 2- Selecciona solo los de que vengan de "Germany"
Ampliemos un poco la query anterior. En este caso, queremos un resultado similar al anterior, pero solo queremos
 los que pertezcan a "Germany".*/
 
 
  SELECT customer_id
  FROM customers
  WHERE country = "Germany";
  
  WITH pais AS (
  SELECT customer_id
  FROM customers
  WHERE country = "Germany")
  SELECT * FROM pais;
  
 /* 3- Extraed el id de las facturas y su fecha de cada cliente.
En este caso queremos extraer todas las facturas que se han emitido a un cliente, su fecha la compañia a la que pertenece.
📌 NOTA En este caso tendremos columnas con elementos repetidos(CustomerID, y Company Name).
*/

    
    WITH facturas AS (
    SELECT order_id, customer_id, order_date
    FROM orders
)
SELECT f.order_id, f.customer_id, c.company_name, f.order_date
FROM facturas AS f
INNER JOIN customers c ON c.customer_id = f.customer_id;


/* 4- Contad el número de facturas por cliente
Mejoremos la query anterior. En este caso queremos saber el número de facturas emitidas por cada cliente.*/


  
WITH facturas AS (
SELECT order_id, customer_id
FROM orders
)
SELECT COUNT(f.order_id), f.customer_id, c.company_name
FROM facturas AS f
INNER JOIN customers c ON c.customer_id = f.customer_id
GROUP BY f.customer_id,  c.company_name;



/* 5- Cuál la cantidad media pedida de todos los productos ProductID.
Necesitaréis extraer el average de las cantidades por cada producto y calcular la media.
Sacar quantity y nombre del producto*/

WITH media AS (
SELECT product_id, quantity
FROM order_details
) 

SELECT m.product_id, AVG(m.quantity), p.product_name
FROM media as m

JOIN products as p ON m.product_id = p.product_id
GROUP BY p.product_name,  m.product_id
;


/* 6 - Usando una CTE, extraer el nombre de las diferentes categorías de productos, 
con su precio medio, máximo y mínimo.*/

WITH tipo AS (
SELECT category_id, unit_price
FROM products)

SELECT c.category_name, AVG(t.unit_price), MAX(t.unit_price), MIN(t.unit_price)
FROM tipo as t 
INNER JOIN categories as c ON c.category_id = t.category_id
GROUP BY c.category_name;



/* 7 La empresa nos ha pedido que busquemos el nombre de cliente, su teléfono y el número de pedidos
 que ha hecho cada uno de ellos.*/

SELECT  




/*Modifica la consulta anterior para obtener los mismos resultados pero con los pedidos por año que ha hecho cada cliente.
/*Modifica la cte del ejercicio anterior, úsala en una subconsulta para saber el nombre del cliente y su teléfono, para aquellos clientes que hayan hecho más de 6 pedidos en el año 1998.
/*Nos piden que obtengamos el importe total (teniendo en cuenta los descuentos) de cada pedido de la tabla orders y el customer_id asociado a cada pedido.*/

