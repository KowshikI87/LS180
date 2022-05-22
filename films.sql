DROP TABLE IF EXISTS public.films;
CREATE TABLE films (title varchar(255), "year" integer, genre varchar(100));

INSERT INTO films(title, "year", genre) VALUES ('Die Hard', 1988, 'action');  
INSERT INTO films(title, "year", genre) VALUES ('Casablanca', 1942, 'drama');  
INSERT INTO films(title, "year", genre) VALUES ('The Conversation', 1974, 'thriller');  

ALTER TABLE films 
ADD COLUMN director varchar(255),
ADD COLUMN duration integer;

--YEAR(CURDATE())

SELECT year, EXTRACT(year FROM CURRENT_DATE) - year as AGE
FROM films;