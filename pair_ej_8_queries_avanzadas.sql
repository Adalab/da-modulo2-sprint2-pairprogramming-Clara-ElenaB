USE northwind;

/* 1 Productos más baratos y caros de nuestra BBDD:
Desde la división de productos nos piden conocer el precio de los productos que tienen el precio más alto y más bajo. 
Dales el alias lowestPrice y highestPrice.*/



SELECT `product_name`, `unit_price` AS `lowestPrice `
FROM `products`
ORDER BY `unit_price` ASC;
 
SELECT `product_name`, `unit_price` AS `highestPrice`
FROM `products`
ORDER BY `unit_price` DESC;

 /* 2 Conociendo el numero de productos y su precio medio:
Adicionalmente nos piden que diseñemos otra consulta para conocer el número de productos y el precio medio de todos ellos (en general, no por cada producto).*/

SELECT AVG(`unit_price`) -- precio medio de la tienda
FROM `products`;

-- num. productos del catálogo:

SELECT COUNT(`product_id`) AS `catalogo`, AVG(`unit_price`) AS`AIV`
FROM `products`;

/* 3 Sacad la máxima y mínima carga de los pedidos de UK:
Nuestro siguiente encargo consiste en preparar una consulta que devuelva la máxima y mínima cantidad de carga para
 un pedido (freight) enviado a Reino Unido (United Kingdom).*/

SELECT MIN(`freight`) AS `carga minima`, MAX(`freight`) AS `carga maxima`
FROM `orders`
WHERE `ship_country`= "UK";

/* 4 Qué productos se venden por encima del precio medio:
Después de analizar los resultados de alguna de nuestras consultas anteriores, desde el departamento de Ventas quieren conocer 
qué  productos en concreto se venden por encima del precio medio para todos los productos de la empresa,

 ya que sospechan que dicho número es demasiado elevado. 
También quieren que ordenemos los resultados por su precio de mayor a menor.
📌NOTA: para este ejercicio puedes necesitar dos consultas separadas y usar el resultado de la primera para filtrar la segunda. */

    
SELECT AVG(`unit_price`) AS `AIV`
FROM `products`;


SELECT `product_name`
FROM `products`
WHERE `unit_price`>= 28.866363636363637
ORDER BY `unit_price` DESC;

/* 5 Qué productos se han descontinuado:
De cara a estudiar el histórico de la empresa nos piden una consulta para conocer el número de productos que se han descontinuado. 
El atributo Discontinued es un booleano: si es igual a 1 el producto ha sido descontinuado. */

SELECT `product_name`, `discontinued` AS `discontinuado`
FROM `products`
WHERE `discontinued` = 1;

/* 6 Detalles de los productos de la query anterior:
Adicionalmente nos piden detalles de aquellos productos no descontinuados, sobre todo el ProductID y ProductName. 
Como puede que salgan demasiados resultados, nos piden que los limitemos a los 10 con ID más elevado, que serán los más recientes.
 No nos pueden decir del departamento si habrá pocos o muchos resultados, pero lo limitamos por si acaso.*/
 
SELECT `product_id`, `product_name`
FROM `products`
WHERE `discontinued` = 0
LIMIT  10;

 
 
 
 
 /*7 Relación entre número de pedidos y máxima carga:
Desde logística nos piden el número de pedidos y la máxima cantidad de carga de entre los mismos (freight)
que han sido enviados por cada empleado (mostrando el ID de empleado en cada caso).*/

SELECT `employee_id`, COUNT(`order_id`) AS `numero pedidos` , MAX(`freight`) AS `maxima cantidad de carga`
FROM `orders`
GROUP BY `employee_id`;

/*8- Descartar pedidos sin fecha y ordénalos:
Una vez han revisado los datos de la consulta anterior, nos han pedido afinar un poco más el "disparo". En el resultado anterior se han incluido muchos pedidos cuya fecha
de envío estaba vacía, por lo que tenemos que mejorar la consulta en este aspecto. También nos piden que ordenemos los resultados según el ID de empleado para que la visualización sea más sencilla. */
SELECT `employee_id`, COUNT(`order_id`), MAX(`freight`) AS `peso_maximo`, MAX(`shipped_date`) AS `fecha_envio`
FROM `orders`
GROUP BY `employee_id`
HAVING  MAX(`shipped_date`) IS NOT NULL;


/* 9 -  Números de pedidos por día:
El siguiente paso en el análisis de los pedidos va a consistir en conocer mejor la distribución de los mismos según las fechas. 
Por lo tanto, tendremos que generar una consulta que nos saque el número de pedidos para cada día, mostrando de manera separada el día (DAY()), el mes (MONTH()) y el año (YEAR()). */

SELECT DATE_FORMAT(`order_date`, '%d') AS `DIA`,  DATE_FORMAT(`order_date`, '%M') AS `MES`, DATE_FORMAT(`order_date`, '%Y')AS `AÑO` , COUNT(`order_id`) AS `Nº pedidos/día`
FROM `orders`
GROUP BY `order_date`;



/* 10 - Número de pedidos por mes y año:
La consulta anterior nos muestra el número de pedidos para cada día concreto, pero esto es demasiado detalle. 
Genera una modificación de la consulta anterior para que agrupe los pedidos por cada mes concreto de cada año.*/

SELECT month(`order_date`) AS `mes`,  year(`order_date`) AS `año`, COUNT(`order_id`) AS `total_pedidos`
FROM `orders`
GROUP BY `mes`, `año`; 
-- se tienen que agrupar las dos columnas para que se cumpla la agrupación mes/año

/* 11 Seleccionad las ciudades con 4 o más empleadas:
Desde recursos humanos nos piden seleccionar los nombres de las ciudades con 4 o más empleadas de cara a estudiar la apertura de nuevas oficinas. */

SELECT `city` AS `Ciudad`, COUNT(`employee_id`) AS `Nº Empleados`
FROM `employees`
GROUP BY `city`
HAVING `Nº Empleados` >= 4;



/* 12 Cread una nueva columna basándonos en la cantidad monetaria:
Necesitamos una consulta que clasifique los pedidos en dos categorías ("Alto" y "Bajo") en función de la cantidad monetaria total que han supuesto: por encima o por debajo de 2000 euros.*/

-- creamos una nueva columna llamada cantidad_monetaria
ALTER TABLE `order_details`
ADD COLUMN `cantidad_monetaria` FLOAT

-- adjucicamos a la columna cantidad_monetaria el cálculo de cantidad * precio unitario
UPDATE `order_details`
SET `cantidad_monetaria` = `quantity` * `unit_price`;


SELECT `product_id`, `cantidad_monetaria`,
	CASE
		WHEN `cantidad_monetaria` < 2000 THEN "Bajo"
		ELSE "ALTO"
    END AS "Categoría"
FROM `order_details`;

