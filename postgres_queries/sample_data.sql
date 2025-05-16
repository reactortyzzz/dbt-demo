-- 0) optional: start fresh
DROP SCHEMA IF EXISTS dbt_demo CASCADE;
CREATE SCHEMA dbt_demo;
SET search_path = dbt_demo;

-- 1) DIMENSIONS

-- customers
CREATE TABLE customers (
  customer_id   INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  first_name    TEXT NOT NULL,
  last_name     TEXT NOT NULL,
  email         TEXT UNIQUE NOT NULL,
  signup_date   DATE NOT NULL DEFAULT current_date
);

-- employees
CREATE TABLE employees (
  employee_id   INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  first_name    TEXT NOT NULL,
  last_name     TEXT NOT NULL,
  title         TEXT NOT NULL,
  hire_date     DATE NOT NULL DEFAULT current_date
);

-- products
CREATE TABLE products (
  product_id    INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  name          TEXT NOT NULL,
  category      TEXT NOT NULL,
  price         NUMERIC(10,2) NOT NULL
);

-- 2) FACT

CREATE TABLE orders (
  order_id      INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  order_date    TIMESTAMP NOT NULL DEFAULT now(),
  customer_id   INT NOT NULL REFERENCES customers(customer_id),
  employee_id   INT NOT NULL REFERENCES employees(employee_id),
  product_id    INT NOT NULL REFERENCES products(product_id),
  quantity      INT NOT NULL CHECK (quantity > 0)
);


CREATE VIEW orders_with_totals AS
SELECT 
    o.*,
    o.quantity * p.price as total_amount
FROM orders o
JOIN products p ON o.product_id = p.product_id;

-- 3) SAMPLE DATA

-- customers
INSERT INTO customers (first_name, last_name, email, signup_date) VALUES
  ('Alice',   'Johnson',  'alice.j@example.com', '2024-01-15'),
  ('Bob',     'Smith',    'bob.smith@example.com', '2024-02-20'),
  ('Carol',   'Nguyen',   'carol.n@example.com', '2024-03-05'),
  ('David',   'Lee',      'david.lee@example.com', '2024-04-10'),
  ('Eva',     'Martinez', 'eva.m@example.com', '2024-05-01');

-- employees
INSERT INTO employees (first_name, last_name, title, hire_date) VALUES
  ('Frank',   'Wright',   'Sales Rep',  '2023-11-01'),
  ('Grace',   'Kim',      'Sales Rep',  '2023-12-15'),
  ('Hank',    'Patel',    'Manager',    '2022-08-20'),
  ('Ivy',     'Chen',     'Analyst',    '2024-02-01'),
  ('Jack',    'O’Neil',   'Support',    '2023-06-30');

-- products
INSERT INTO products (name, category, price) VALUES
  ('Widget A',    'Widgets',   9.99),
  ('Widget B',    'Widgets',  14.99),
  ('Gadget X',    'Gadgets',   19.50),
  ('Gadget Y',    'Gadgets',   24.75),
  ('Thingamajig', 'Accessories', 4.25);

-- orders
INSERT INTO orders (order_date, customer_id, employee_id, product_id, quantity) VALUES
  ('2025-05-01 10:15','1','1','1', 3),
  ('2025-05-02 11:30','2','2','3', 1),
  ('2025-05-03 14:45','3','1','2', 2),
  ('2025-05-04 09:20','4','3','5', 5),
  ('2025-05-05 16:00','5','4','4', 2),
  ('2025-05-06 12:10','1','2','3', 4),
  ('2025-05-07 13:55','2','3','1', 1),
  ('2025-05-08 08:40','3','5','5', 6),
  ('2025-05-09 17:25','4','4','2', 2),
  ('2025-05-10 15:05','5','1','4', 3);
