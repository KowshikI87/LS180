CREATE TABLE people(
  id SERIAL PRIMARY KEY,
  name varchar(50),
  age int,
  occupation varchar(50)
);

INSERT INTO people
  (name, age, occupation)
  VALUES ('Abby', 34, 'biologist'),
         ('Mu''nisah', 26, NULL),
         ('Mirabelle', 40, 'contractor');

SELECT * FROM people WHERE name = 'Mu''nisah';
SELECT * FROM people WHERE age = 26;
SELECT * FROM people WHERE occupation IS NULL;   

CREATE TABLE birds (
    name character varying(255),
    length numeric(4,1),
    wingspan numeric(4,1),
    family text,
    extinct boolean
);

INSERT INTO birds VALUES ('Spotted Towhee', 21.6, 26.7, 'Emberizidae', false);
INSERT INTO birds VALUES ('American Robin', 25.5, 36.0, 'Turdidae', false);
INSERT INTO birds VALUES ('Greater Koa Finch', 19.0, 24.0, 'Fringillidae', true);
INSERT INTO birds VALUES ('Carolina Parakeet', 33.0, 55.8, 'Psittacidae', true);
INSERT INTO birds VALUES ('Common Kestrel', 35.5, 73.5, 'Falconidae', false);

SELECT name, family FROM birds WHERE extinct=false ORDER BY length DESC;


