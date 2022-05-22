-- See if serial data type prevents duplicate data from
-- being entered into the column ID
CREATE TABLE airlines (
  id serial,
  airline_name varchar(30),
  country varchar(50),
  iata_code char(2),
  icao_code char(3),
  website varchar(40),
  CHECK (length(iata_code) = 2),
  CHECK (length(icao_code) = 3)
);

INSERT INTO airlines
  (id, airline_name, country, iata_code, icao_code, website)
  VALUES (1, 'hello', 'hello', 23, 355, 'www.amazon.com'),
         (1, 'hello', 'hello', 23, 355, 'www.amazon.com');

-- Question 12
CREATE TABLE students (
  id serial PRIMARY KEY,
  name varchar(50),
  age int,
  grade decimal(4, 2)
);

INSERT INTO students
  (name, age, grade)
  VALUES('Juan', 37, 86),
        ('Clara', 21, 87),
        ('Jin', 32, 85),
        ('Aishwarya', 25, 88);
