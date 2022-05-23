CREATE TABLE stars (
  id serial,
  name varchar(25) UNIQUE NOT NULL,
  distance int NOT NULL,
  spectral_type char(1),
  companions int NOT NULL,
  PRIMARY KEY (id),
  CHECK (distance > 0),
  CHECK (length(spectral_type) = 1 AND strpos('OBAFGKM', spectral_type) != 0),
  CHECK(companions > 0)
);

CREATE TABLE stars (


CREATE TABLE planets (
  id serial,
  designation char(1),
  mass int,
  PRIMARY KEY (id),
  CHECK(length(designation) <= 1)
);

INSERT INTO stars
  (name, distance, spectral_type, companions)
  VALUES ('Sun', 1500, 'A', 40);

-- SELECT strpos('OBAFGKM', spectral_type)
-- FROM stars;