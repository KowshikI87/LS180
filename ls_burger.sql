CREATE TABLE orders (
  id serial,
  customer_name varchar(100) NOT NULL,
  burger varchar(50),
  side varchar(50),
  drink varchar(50),
  order_total decimal(4, 2) NOT NULL
);

ALTER TABLE orders
  ADD COLUMN customer_email varchar(50),
  ADD COLUMN customer_loyalty_points integer DEFAULT 0;

ALTER TABLE orders
  ADD COLUMN burger_cost decimal(4, 2) DEFAULT 0,
  ADD COLUMN side_cost decimal(4, 2) DEFAULT 0,
  ADD COLUMN drink_cost decimal(4, 2) DEFAULT 0;

ALTER TABLE orders DROP COLUMN order_total;

INSERT INTO orders (customer_name, customer_email, customer_loyalty_points, burger, burger_cost, side, side_cost, drink, drink_cost)
  VALUES ('James Bergman', 'james1998@email.com', 28, 'LS Chicken Burger', 4.50, 'Fries', 0.99,'Cola', 1.50),
         ('Natasha O''Shea', 'natasha@osheafamily.com', 18, 'LS Chesseburger', 3.50, 'Fries', 0.99, NULL, DEFAULT),
         ('Natasha O''Shea', 'natasha@osheafamily.com', 42, 'LS Double Delux Burger', 6.00, 'Onion Rings', 1.50, 'Chocolate Shake', 2.00),
         ('Aaron Muller', NULL, 10, 'LS Burger', 3.00, NULL, DEFAULT, NULL, DEFAULT);


SELECT burger 
FROM orders
WHERE burger_cost < 5.00
ORDER BY burger_cost ASC;


SELECT customer_name, customer_email
FROM orders
WHERE customer_loyalty_points >= 20
ORDER BY customer_loyalty_points DESC;

SELECT burger
FROM orders
WHERE customer_name = 'Natasha O''Shea';

SELECT customer_name
FROM orders
WHERE drink is NULL;

SELECT burger, side, drink 
FROM orders 
WHERE side <> 'Fries' OR side IS NULL;

SELECT burger, side, drink 
FROM orders 
WHERE side IS NOT NULL 
AND drink IS NOT NULL;


--Start: wrong query
-- SELECT * FROM orders
-- WHERE side = 'Fries';

--end
SELECT avg(burger_cost) 
FROM orders
WHERE side = 'Fries';

SELECT min(side_cost)
FROM orders
WHERE side IS NOT NULL;

SELECT side, count(id)
FROM orders
WHERE side = 'Fries'
OR side = 'Onion Rings'
GROUP BY side;

UPDATE orders
SET drink = 'Lemonade'
WHERE id = 1;

UPDATE orders
SET side = 'Fries',
side_cost= 0.99,
customer_loyalty_points = 13
WHERE id = 4;

UPDATE orders
SET side_cost = 1.20
WHERE side = 'Fries';

CREATE TABLE customers (
id serial PRIMARY KEY,
customer_name varchar(100)
);

CREATE TABLE email_addresses (
customer_id integer PRIMARY KEY,
customer_email varchar(50),
FOREIGN KEY (customer_id)
REFERENCES customers (id)
ON DELETE CASCADE
);

INSERT INTO customers (customer_name)
VALUES ('James Bergman'),
('Natasha O''Shea'),
('Aaron Muller');

INSERT INTO email_addresses (customer_id, customer_email)
VALUES (1, 'james1998@email.com'),
(2, 'natasha@osheafamily.com');

CREATE TABLE products (
id serial PRIMARY KEY,
product_name varchar(50),
product_cost numeric(4,2) DEFAULT 0,
product_type varchar(20),
product_loyalty_points integer
);

INSERT INTO products (product_name, product_cost, product_type, product_loyalty_points)
VALUES ('LS Burger', 3.00, 'Burger', 10 ),
('LS Cheeseburger', 3.50, 'Burger', 15 ),
('LS Chicken Burger', 4.50, 'Burger', 20 ),
('LS Double Deluxe Burger', 6.00, 'Burger', 30 ),
('Fries', 1.20, 'Side', 3 ),
('Onion Rings', 1.50, 'Side', 5 ),
('Cola', 1.50, 'Drink', 5 ),
('Lemonade', 1.50, 'Drink', 5 ),
('Vanilla Shake', 2.00, 'Drink', 7 ),
('Chocolate Shake', 2.00, 'Drink', 7 ),
('Strawberry Shake', 2.00, 'Drink', 7);


DROP TABLE orders;

CREATE TABLE orders (
id serial UNIQUE PRIMARY KEY,
customer_id integer,
order_status varchar(20),
FOREIGN KEY (customer_id)
REFERENCES customers (id)
ON DELETE CASCADE
);

CREATE TABLE order_items (
id serial PRIMARY KEY,
order_id integer NOT NULL,
product_id integer NOT NULL,
FOREIGN KEY (order_id)
REFERENCES orders (id)
ON DELETE CASCADE,
FOREIGN KEY (product_id)
REFERENCES products (id)
ON DELETE CASCADE
);

-- ALTER TABLE orders
-- ADD CONSTRAINT unique_id UNIQUE(id);

INSERT INTO orders (customer_id, order_status)
VALUES (1, 'In Progress'),
(2, 'Placed'),
(2, 'Complete'),
(3, 'Placed');

INSERT INTO order_items (order_id, product_id)
VALUES (1, 3),
(1, 5),
(1, 6),
(1, 8),
(2, 2),
(2, 5),
(2, 7),
(3, 4),
(3, 2),
(3, 5),
(3, 5),
(3, 6),
(3, 10),
(3, 9),
(4, 1),
(4, 5);

-- SELECT order_items.order_id, products.product_name
-- FROM order_items
-- INNER JOIN products
-- ON order_items.product_id = products.id;

--Actual solution --> not too worried about this
SELECT orders.*, products.*
FROM orders JOIN order_items
ON orders.id = order_items.order_id
JOIN products
ON order_items.product_id = products.id;

SELECT DISTINCT order_items.order_id
FROM order_items
INNER JOIN products
ON order_items.product_id = products.id
WHERE products.product_name = 'Fries';

--Q9 not working; just do it from scratch
-- SELECT customers.customer_name
-- FROM (
--   SELECT DISTINCT order_items.order_id
--   FROM order_items
--   INNER JOIN products
--   ON order_items.product_id = products.id
--   WHERE products.product_name = 'Fries';
-- ) AS fries_order
-- INNER JOIN orders
-- ON orders.id = fries_order.order_id
-- INNER JOIN customers
-- ON customers.id = orders.customer_id;

--Q9 join orders and order_items

SELECT DISTINCT customers.customer_name AS "Customers who likes fries"
FROM orders
INNER JOIN order_items
ON orders.id = order_items.order_id
INNER JOIN products
ON products.id = order_items.product_id
INNER JOIN customers
ON orders.customer_id = customers.id
WHERE product_name = 'Fries';

--SELECT customers.customer_name, products.product_name, products.product_cost
SELECT sum(product_cost)
FROM orders
INNER JOIN order_items
ON orders.id = order_items.order_id
INNER JOIN products
ON products.id = order_items.product_id
INNER JOIN customers
ON orders.customer_id = customers.id
WHERE customer_name = 'Natasha O''Shea';

SELECT products.product_name, count(products.product_name)
FROM order_items
INNER JOIN products
ON order_items.product_id = products.id
GROUP BY product_name;