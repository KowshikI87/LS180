CREATE TABLE customers (
  id serial PRIMARY KEY,
  name text NOT NULL,
  payment_token char(8) NOT NULL UNIQUE CHECK (payment_token ~ '^[A-Z]{8}$')
);

CREATE TABLE services (
  id serial PRIMARY KEY,
  description text NOT NULL,
  price numeric(10, 2) NOT NULL CHECK (price >= 0.00)
);

INSERT INTO customers (name, payment_token)
VALUES
  ('Pat Johnson', 'XHGOAHEQ'),
  ('Nancy Monreal', 'JKWQPJKL'),
  ('Lynn Blake', 'KLZXWEEE'),
  ('Chen Ke-Hua', 'KWETYCVX'),
  ('Scott Lakso', 'UUEAPQPS'),
  ('Jim Pornot', 'XKJEYAZA');

INSERT INTO services (description, price)
VALUES
  ('Unix Hosting', 5.95),
  ('DNS', 4.95),
  ('Whois Registration', 1.95),
  ('High Bandwidth', 15.00),
  ('Business Support', 250.00),
  ('Dedicated Hosting', 50.00),
  ('Bulk Email', 250.00),
  ('One-to-one Training', 999.00);

CREATE TABLE customers_services (
  id serial PRIMARY KEY,
  customer_id integer
    REFERENCES customers (id)
    ON DELETE CASCADE
    NOT NULL,
  service_id integer
    REFERENCES services (id)
    NOT NULL,
  UNIQUE(customer_id, service_id)
);

INSERT INTO customers_services (customer_id, service_id)
VALUES
  (1, 1), -- Pat Johnson/Unix Hosting
  (1, 2), --            /DNS
  (1, 3), --            /Whois Registration
  (3, 1), -- Lynn Blake/Unix Hosting
  (3, 2), --           /DNS
  (3, 3), --           /Whois Registration
  (3, 4), --           /High Bandwidth
  (3, 5), --           /Business Support
  (4, 1), -- Chen Ke-Hua/Unix Hosting
  (4, 4), --            /High Bandwidth
  (5, 1), -- Scott Lakso/Unix Hosting
  (5, 2), --            /DNS
  (5, 6), --            /Dedicated Hosting
  (6, 1), -- Jim Pornot/Unix Hosting
  (6, 6), --           /Dedicated Hosting
  (6, 7); --           /Bulk Email


-- Customer names with services
SELECT c.name
FROM customers_services as cs
INNER JOIN customers as c
ON c.id = cs.customer_id
GROUP BY c.name;

--Customers without services

--V1
SELECT *
FROM customers
LEFT JOIN customers_services
ON customers.id = customers_services.customer_id;

--V2
SELECT DISTINCT c.name
FROM customers as c
LEFT JOIN customers_services as cs
ON c.id = cs.customer_id
WHERE cs.service_id IS NULL;


-- Services without customers

--V1
SELECT * 
FROM customers_services
RIGHT OUTER JOIN services
ON customers_services.service_id = services.id;


--V2
SELECT DISTINCT s.description
FROM customers_services as cs
RIGHT OUTER JOIN services as s
ON cs.service_id = s.id
WHERE cs.service_id IS NULL;

-- services for each customer

-- SELECT customers.name,  string_agg(services.description, ', ')
-- FROM customers
-- LEFT JOIN 

-- V1
SELECT *
FROM customers
LEFT JOIN customers_services
ON customers.id = customers_services.customer_id;

--V2
SELECT *
FROM customers
LEFT JOIN customers_services
ON customers.id = customers_services.customer_id
LEFT JOIN services
ON service_id = services.id;

--V3
SELECT customers.name, string_agg(description, ', ') as services --the select part is done last so we can use the column name as is
FROM customers
LEFT JOIN customers_services
ON customers.id = customers_services.customer_id
LEFT JOIN services
ON service_id = services.id
GROUP BY customers.name;

--services with at least 3 customers

--V1
SELECT *
FROM customers_services
INNER JOIN services
ON customers_services.service_id = services.id;

--V2
SELECT services.description, COUNT(*) as count
FROM customers_services
INNER JOIN services
ON customers_services.service_id = services.id
GROUP BY services.description
HAVING COUNT(*) >= 3;

-- Total Gross Income
  -- take it from V1 of previous question
SELECT SUM(price)
FROM customers_services
INNER JOIN services
ON customers_services.service_id = services.id;

--Hypothetical Question
SELECT *
FROM services
INNER JOIN customers_services
        ON services.id = service_id
WHERE price > 100;

SELECT SUM(price)
FROM customers
CROSS JOIN services
WHERE price > 100;