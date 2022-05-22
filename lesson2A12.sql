SELECT genre 
FROM films
GROUP BY genre;

SELECT round(avg(duration), 0)
FROM films;

SELECT genre, round(avg(duration), 0)
FROM films
GROUP BY genre;



-- SELECT year / 10 * 10 AS decade, genre, string_agg(title, ', ') AS films
-- FROM films 
-- GROUP BY decade, genre 
-- ORDER BY decade, genre;

SELECT year / 10 * 10 AS decade, genre, title
FROM films 
GROUP BY decade, genre, title
ORDER BY decade, genre;