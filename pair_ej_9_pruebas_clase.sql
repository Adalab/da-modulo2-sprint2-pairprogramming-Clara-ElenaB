/* 1 -- Pedidos por empresa en UK:
Desde las oficinas en UK nos han pedido con urgencia que realicemos una consulta a la base de datos
 con la que podamos conocer cuántos pedidos ha realizado cada empresa cliente de UK.
 Nos piden el ID del cliente y el nombre de la empresa y el número de pedidos.*/
 
 SELECT * FROM northwind.order_details;
  
  SELECT * FROM northwind.orders;
  
SELECT `customer_id`, `company_name`, COUNT(`order_id`)
	FROM `customers`
	WHERE `country` = UK
	LEFT JOIN `customer_id` 
	ON `customers`.`sales_rep_employee_number` = `employees`.`employee_number`;

  
  SELECT customers.customer_id, customers.company_name,  count(orders.order_id)
  NATURAL JOIN orders
  groaup by customers.customer_id
  having orders.ship_country = "UK";
  
  
SELECT customers.customer_id, customers.company_name, COUNT(orders.order_id) AS order_count
FROM customers
NATURAL JOIN orders
GROUP BY customers.customer_id
HAVING MAX(orders.ship_country) = 'UK';


SELECT customers.customer_id, customers.company_name, COUNT(orders.order_id) AS order_count
FROM orders
NATURAL JOIN customers
GROUP BY order_count
HAVING MAX(orders.ship_country) = 'UK';


-- 


