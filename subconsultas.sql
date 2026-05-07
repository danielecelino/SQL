-- Ejercicio 01
USE northwind;
SELECT id, product_name, list_price
from products
where list_price >
(Select avg(list_price) from products);

-- Ejercicio 02
SELECT 
    p1.id, 
    p1.product_name, 
    p1.category, 
    p1.list_price
FROM 
    products p1
WHERE 
    p1.list_price > (
        SELECT AVG(p2.list_price)    
        FROM products p2 
        WHERE p2.category = p1.category 
    );
    
    -- Ejercicio 03
    use northwind;
SELECT 
    id, 
    product_name, 
    list_price
FROM 
    products
WHERE 
    list_price = (
        SELECT MAX(list_price) 
        FROM products 
        WHERE list_price < (
            SELECT MAX(list_price) FROM products
        )
    );
-- Ejercicio 04
SELECT 
c.id,
concat(c.first_name, ' ', c.last_name) as cliente 
from customers c
left join orders o on c.id = o.customer_id
where o.id is null;

-- Ejercicio 05
use northwind;
select c.id, concat(c.first_name,
c.last_name) as cliente,
max(od.unit_price) as max_price_paid

from customers c
join orders o on o.customer_id = c.id
join order_details od on od.order_id = o.id
where od.unit_price > (select avg(list_price) from products)
group by c.id, c.first_name, c.last_name;


-- Ejercicio 06.1

select td.customer_id, concat(c.first_name, ' ', c.last_name) as cliente, td.total_spent
from (

-- subconsulta
select o.customer_id, sum( od.quantity * od.unit_price *(1 - od.discount)) as total_spent
from orders o
join order_details od on o.id = od.order_id
group by o.customer_id) as td
join customers c on td.customer_id = c.id
where td.total_spent > 1000;

-- Ejercicio 06.2

select td.customer_id, concat(c.first_name, ' ', c.last_name) as cliente, td.total_spent
from (

-- subconsulta
select o.customer_id, sum( od.quantity * od.unit_price *(1 - od.discount)) as total_spent
from orders o
join order_details od on o.id = od.order_id
group by o.customer_id) as td
join customers c on td.customer_id = c.id and td.total_spent > 1000;

-- Ejercicio 7
use northwind;
INSERT INTO customers (company, last_name, first_name, email_address, city, country_region)
VALUES ('Mi Empresa SL', 
'Juan',
'Pérez',
LCASE('CONTACTO@MIEMPRESA.COM'),
'Madrid',
'Spain');

-- Ejercicio 8.1
use northwind;
UPDATE customers
SET city = TRIM(' Valencia ')
WHERE company = 'Mi empresa SL';

-- Ejercicio 8.2
DELETE FROM customers
WHERE id = (
	SELECT id FROM (
		SELECT id
        FROM customers
        WHERE company = 'Mi Empresa SL'
        ) as tmp
);

