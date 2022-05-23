-- Set up database
CREATE TABLE devices (
  id serial,
  name text NOT NULL,
  created_at timestamp DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (id)
);

CREATE TABLE parts (
  id serial,
  part_number integer UNIQUE NOT NULL,
  device_id integer, --should have NOT NULL constraint IMO
  PRIMARY KEY (id),
  FOREIGN KEY (device_id) REFERENCES devices(id)
);

INSERT INTO devices (name) VALUES ('Accelerometer');
INSERT INTO devices (name) VALUES ('Gyroscope');

INSERT INTO parts (part_number, device_id) VALUES (12, 1);
INSERT INTO parts (part_number, device_id) VALUES (14, 1);
INSERT INTO parts (part_number, device_id) VALUES (16, 1);

INSERT INTO parts (part_number, device_id) VALUES (31, 2);
INSERT INTO parts (part_number, device_id) VALUES (33, 2);
INSERT INTO parts (part_number, device_id) VALUES (35, 2);
INSERT INTO parts (part_number, device_id) VALUES (37, 2);
INSERT INTO parts (part_number, device_id) VALUES (39, 2);

INSERT INTO parts (part_number) VALUES (50);
INSERT INTO parts (part_number) VALUES (54);
INSERT INTO parts (part_number) VALUES (58);

SELECT devices.name, parts.part_number
FROM devices
INNER JOIN parts
ON devices.id = parts.device_id;

SELECT * FROM parts WHERE part_number::text LIKE '3%';

SELECT devices.name, count(*)
FROM devices
LEFT OUTER JOIN parts
ON devices.id = parts.device_id
GROUP BY devices.name;

SELECT devices.name AS name, COUNT(*)
FROM devices
JOIN parts ON devices.id = parts.device_id
GROUP BY devices.name
ORDER BY devices.name DESC;

-- Doesn't belong to a device
SELECT part_number, device_id FROM parts
WHERE device_id IS NULL;
-- Does belong to a device
SELECT part_number, device_id FROM parts
WHERE device_id IS NOT NULL;

INSERT INTO devices (name) VALUES ('Magnetometer');
INSERT INTO parts (part_number, device_id) VALUES (42, 3);

SELECT name AS oldest_device
 FROM devices
ORDER BY created_at ASC
LIMIT 1;

UPDATE parts SET device_id = 1
WHERE part_number=37 OR part_number=39;

DELETE FROM parts WHERE device_id = 1;
DELETE FROM devices WHERE name = 'Accelerometer';