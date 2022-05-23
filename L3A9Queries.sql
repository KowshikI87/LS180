CREATE TABLE directors (id serial PRIMARY KEY, name text NOT NULL);

INSERT INTO directors (name) VALUES ('John McTiernan');
INSERT INTO directors (name) VALUES ('Michael Curtiz');
INSERT INTO directors (name) VALUES ('Michael Anderson');
INSERT INTO directors (name) VALUES ('Tomas Alfredson');
INSERT INTO directors (name) VALUES ('Mike Nichols');

ALTER TABLE films ADD COLUMN director_id integer REFERENCES directors (id);