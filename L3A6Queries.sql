--not required to do; listing all the customers who bought more than one ticket
SELECT customer_id, COUNT(id)
FROM tickets
GROUP BY customer_id HAVING count(id) > 1;


--Q4
-- can't just divide number of customer_id in tickets by number of customer ID
-- in customers table

SELECT count(customers.id) / count()
FROM customers
LEFT JOIN tickets
ON customers.id = tickets.customer_id
WHERE tickets.customer_id IS NOT NULL;
-- ORDER BY customers.id;


--Actual Solution
SELECT round( COUNT(DISTINCT tickets.customer_id)
            / COUNT(DISTINCT customers.id)::decimal * 100
            2)
       AS percent
  FROM customers
  LEFT OUTER JOIN tickets
    ON tickets.customer_id = customers.id;

-- Q5
SELECT events.name, COUNT(events.id) as popularity
FROM tickets
INNER JOIN events
ON tickets.event_id = events.id
GROUP BY events.name
ORDER BY popularity DESC;

--Q6 Try 1 --> a hot mess
-- SELECT tickets.customer_id, COUNT(DISTINCT tickets.id)
-- FROM tickets
-- INNER JOIN customers
-- ON customers.id = tickets.customer_id
-- GROUP BY tickets.customer_id HAVING count(tickets.id) = 3;

--Q6
--STep 1
--First step: returns a table that shows csutomer_id and how many events
-- they attended
SELECT customer_id, COUNT (DISTINCT event_id)
FROM tickets
GROUP BY customer_id 
ORDER BY count DESC
LIMIT 13;

--filter by number of events attended = 3
SELECT customer_id, COUNT (DISTINCT event_id)
FROM tickets
GROUP BY customer_id 
HAVING COUNT (DISTINCT event_id) = 3


--add the join part
SELECT customers.email, COUNT (DISTINCT tickets.event_id)
FROM tickets
INNER JOIN customers
ON tickets.customer_id = customers.id
GROUP BY customers.email
HAVING COUNT (DISTINCT tickets.event_id) = 3;



