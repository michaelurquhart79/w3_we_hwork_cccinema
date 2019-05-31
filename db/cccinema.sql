DROP TABLE tickets;
DROP TABLE films;
DROP TABLE customers;

CREATE TABLE films(
  id SERIAL4 PRIMARY KEY,
  name VARCHAR(255),
  price INT4
);

CREATE TABLE customers(
  id SERIAL4 PRIMARY KEY,
  title VARCHAR(255),
  price INT4
);

CREATE TABLE tickets(
  id SERIAL4 PRIMARY KEY,
  customer_id INT4 REFERENCES customers(id) ON DELETE CASCADE,
  film_id INT4 REFERENCES films(id) ON DELETE CASCADE
);
