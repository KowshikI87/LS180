CREATE TABLE temperatures (
    date date NOT NULL,
    low integer NOT NULL,
    high integer NOT NULL
);

INSERT INTO temperatures VALUES ('2016-03-01', 34, 43);
INSERT INTO temperatures VALUES ('2016-03-02', 32, 44);
INSERT INTO temperatures VALUES ('2016-03-03', 31, 47);
INSERT INTO temperatures VALUES ('2016-03-04', 33, 42);
INSERT INTO temperatures VALUES ('2016-03-05', 39, 46);
INSERT INTO temperatures VALUES ('2016-03-06', 32, 43);
INSERT INTO temperatures VALUES ('2016-03-07', 29, 32);
INSERT INTO temperatures VALUES ('2016-03-08', 23, 31);
INSERT INTO temperatures VALUES ('2016-03-09', 17, 28);

SELECT date, ROUND((low + high) / 2, 1) as average
FROM temperatures
WHERE date >= '2016-03-02' AND date <= '2016-03-08';

ALTER TABLE temperatures ADD COLUMN rainfall integer DEFAULT 0;

-- Dont' need this as rainfall already has default value of 0
-- UPDATE temperatures
-- SET rainfall = 0
-- WHERE ROUND((low + high) / 2, 1) <= 35.0;

UPDATE temperatures
SET rainfall = ROUND((low + high) / 2, 1) - 35
WHERE ROUND((low + high) / 2, 1) > 35;
