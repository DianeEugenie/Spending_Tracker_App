DROP TABLE IF EXISTS transactions;
DROP TABLE IF EXISTS tags;
DROP TABLE IF EXISTS merchants;

CREATE TABLE tags (
  id SERIAL PRIMARY KEY,
  type VARCHAR(255) not null
);

CREATE TABLE merchants (
  id SERIAL PRIMARY KEY,
  name VARCHAR(255) not null
);

CREATE TABLE transactions (
  id SERIAL PRIMARY KEY,
  tag_id INT REFERENCES tags(id) ON DELETE CASCADE,
  merchant_id INT REFERENCES merchants(id) ON DELETE CASCADE,
  tr_date VARCHAR(255) not null,
  amount DECIMAL
);
