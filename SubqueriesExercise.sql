CREATE TABLE bidders (
  id SERIAL PRIMARY KEY,
  name TEXT NOT NULL
);

CREATE TABLE items (
  id SERIAL PRIMARY KEY,
  name TEXT NOT NULL,
  initial_price DECIMAL(6,2) NOT NULL CHECK(initial_price BETWEEN 0.01 AND 1000.00),
  sales_price DECIMAL(6,2) CHECK(sales_price BETWEEN 0.01 AND 1000.00)
);

CREATE TABLE bids (
  id SERIAL PRIMARY KEY,
  bidder_id integer NOT NULL REFERENCES bidders(id) ON DELETE CASCADE,
  item_id integer NOT NULL REFERENCES items(id) ON DELETE CASCADE,
  amount DECIMAL(6,2) NOT NULL CHECK(amount BETWEEN 0.01 AND 1000.00)
);

CREATE INDEX ON bids (bidder_id, item_id);

SELECT name AS "Bid on Items"
FROM items
WHERE id IN
(SELECT item_id FROM bids);


SELECT name AS "Not Bid On"
FROM items
WHERE id NOT IN
(SELECT item_id FROM bids);

-- SELECT name 
-- FROM bidders
-- WHERE id

SELECT name FROM bidders
WHERE EXISTS (SELECT 1 FROM bids WHERE bids.bidder_id = bidders.id);


--Query from a virtual table
--get the bidders count then use max function on the subquery result

SELECT MAX(count) as max
FROM (SELECT bidder_id, COUNT(*)
      FROM bids
      GROUP BY bidder_id) AS bid_count;


--Conditional Subqueries: EXISTS


--Scalar Subqueries
--we return result from the items table so it needs to be in outer query
--we have to use the bids table inside the subquery

-- --V1 --> does not work because it does not list TELIVISION which has a count of 0
-- SELECT item_id, COUNT(*)
-- FROM bids
-- GROUP BY item_id;

-- --V2
-- SELECT id, 
-- FROM items
-- WHERE items.id IN
-- (SELECT item_id COUNT(*)
-- FROM bids
-- GROUP BY item_id);


SELECT name,
  (SELECT count(item_id) FROM bids WHERE item_id = items.id)
FROM items;


ALTER TABLE services
	ALTER COLUMN price
SET NOT NULL;

ALTER TABLE services
	ALTER COLUMN price
DROP NOT NULL;