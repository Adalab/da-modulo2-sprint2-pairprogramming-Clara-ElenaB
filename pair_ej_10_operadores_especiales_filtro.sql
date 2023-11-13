USE northwind;


/* 1- Ciudades que empiezan con "A" o "B".
Por un extraño motivo, nuestro jefe quiere que le devolvamos una tabla con aquelas compañias que están afincadas en ciudades
 que empiezan por "A" o "B". Necesita que le devolvamos la ciudad, el nombre de la compañia y el nombre de contacto.*/
 
SELECT `city`,`company_name`, `contact_name`
	FROM `customers`
WHERE `city` LIKE 'A%' OR `city` LIKE 'B%'
ORDER BY `city` ASC;
 
 
 
 /* 2- Número de pedidos que han hecho en las ciudades que empiezan con L.
En este caso, nuestro objetivo es devolver los mismos campos que en la query anterior el número de total de pedidos
 que han hecho todas las ciudades que empiezan por "L".*/
 
  
 
SELECT C.`city`, C.`company_name`, C.`contact_name`, COUNT(O.`order_id`) AS `order_count`
FROM `customers` AS C
INNER JOIN `orders` AS O ON C.`customer_id` = O.`customer_id`
WHERE C.`city` LIKE 'L%'
GROUP BY C.`city`, C.`company_name`, C.`contact_name`;

 
 
 
 /* 3- Todos los clientes cuyo "contact_title" no incluya "Sales".
Nuestro objetivo es extraer los clientes que no tienen el contacto "Sales" en su "contact_title". 
Extraer el nombre de contacto, su posisión (contact_title) y el nombre de la compañia.*/

SELECT `contact_name`, `contact_title`, `company_name`
FROM `customers` 
WHERE `contact_title` NOT LIKE 'SALES%';






/* 4- Todos los clientes que no tengan una "A" en segunda posición en su nombre.
Devolved unicamente el nombre de contacto.*/

SELECT `contact_name`
FROM `customers`
WHERE `contact_name` NOT LIKE '_A%';




/* 5- Extraer toda la información sobre las compañias que tengamos en la BBDD
Nuestros jefes nos han pedido que creemos una query que nos devuelva todos los clientes y proveedores que tenemos en la BBDD. 
Mostrad la ciudad a la que pertenecen, el nombre de la empresa y el nombre del contacto, además de la relación (Proveedor o Cliente). 
Pero importante! No debe haber duplicados en nuestra respuesta. La columna Relationship no existe y debe ser creada como columna temporal. 
Para ello añade el valor que le quieras dar al campo y utilizada como alias Relationship.
Nota: Deberás crear esta columna temporal en cada instrucción SELECT.*/


SELECT `city`, `company_name`, `contact_name`, 'customers' AS `Relacion` -- 'customers' es el valor que aparece en la columna relación
FROM `customers` 
UNION
SELECT `city`, `company_name`, `contact_name`, 'suppliers' AS `Relacion`
FROM `suppliers`;




/* 6- Extraer todas las categorías de la tabla categories que contengan en la descripción "sweet" o "Sweet".*/

SELECT `description`
FROM `categories`
WHERE `description` LIKE '%Sweet%' OR `description` LIKE '%sweet%';





/* 7- Extraed todos los nombres y apellidos de los clientes y empleados que tenemos en la BBDD:
💡 Pista 💡 ¿Ambas tablas tienen las mismas columnas para nombre y apellido? Tendremos que combinar dos columnas usando concat para unir dos columnas.*/



SELECT CONCAT_WS(' ', columna1, columna2) AS columna_concatenada
FROM tu_tabla;


SELECT CONCAT_WS(' ', `first_name`, `last_name`) AS `contact_name`
FROM `employees`

UNION
SELECT `contact_name`
FROM `customers`;

