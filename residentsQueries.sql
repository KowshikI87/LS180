SELECT state, count(state)
FROM people
GROUP BY state
ORDER BY count(state) DESC
LIMIT 10;


SELECT right(email, length(email) - position('@' in email)) AS domain, COUNT(email)
FROM people
GROUP BY domain
ORDER BY count DESC;

UPDATE people
SET given_name = UPPER(given_name)
WHERE email LIKE "%teleworm.us";

