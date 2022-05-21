CREATE TABLE birds(
  id serial,
  name varchar(25),
  age integer,
  species varchar(25),
  PRIMARY KEY (id)
);

INSERT INTO birds
  (name, age, species)
  VALUES('Charlie', 3, 'Finch'),
        ('Allie', 5, 'Owl'),
        ('Jennifer', 3, 'Magpie'),
        ('Jamie', 4, 'Owl'),
        ('Roy', 8, 'Crow');

SELECT * FROM birds;

SELECT *
FROM birds
WHERe age < 5;

UPDATE birds
SET species = "Raven"
WHERE species = "Crow";

DELETE FROM birds
WHERE species = 'Finch';

ALTER TABLE birds
ADD age_check CHECK(age >= 0);