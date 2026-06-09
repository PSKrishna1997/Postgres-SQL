-- 2. Create tables
CREATE TABLE company.departments (
    dept_id SERIAL PRIMARY KEY,
    dept_name VARCHAR(50) NOT NULL,
    location VARCHAR(50)
);

CREATE TABLE company.employees (
    emp_id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    job_title VARCHAR(50),
    salary NUMERIC(10,2),
    hire_date DATE,
    dept_id INTEGER REFERENCES company.departments(dept_id)
);

CREATE TABLE company.orders (
    order_id SERIAL PRIMARY KEY,
    emp_id INTEGER REFERENCES company.employees(emp_id),
    order_date DATE NOT NULL,
    amount NUMERIC(10,2) CHECK (amount >= 0),
    quantity INTEGER CHECK (quantity > 0),
    product_name VARCHAR(100)
);

-- 3. Insert data (departments first, then employees, then orders)
INSERT INTO company.departments (dept_name, location) VALUES
('Sales', 'New York'),
('IT', 'San Francisco'),
('Marketing', 'Chicago');

INSERT INTO company.employees (name, job_title, salary, hire_date, dept_id) VALUES
('Alice Smith', 'Sales Manager', 75000, '2019-03-15', 1),
('Bob Johnson', 'IT Specialist', 68000, '2020-07-22', 2),
('Carol Lee', 'Sales Rep', 52000, '2021-01-10', 1),
('David Brown', 'Marketing Analyst', 58000, '2022-05-18', 3),
('Eva Green', 'Sales Rep', 49000, '2023-02-20', 1),
('Frank White', 'IT Manager', 82000, '2018-11-05', 2);

ALTER TABLE company.orders DROP CONSTRAINT orders_emp_id_fkey;


INSERT INTO company.orders (emp_id, order_date, amount, quantity, product_name) VALUES
(1, '2024-01-15', 1500.00, 3, 'Laptop'),
(1, '2024-02-10', 750.00, 10, 'Mouse'),
(3, '2024-01-20', 2000.00, 2, 'Monitor'),
(3, '2024-02-05', 1200.00, 5, 'Keyboard'),
(5, '2024-01-25', 600.00, 12, 'USB Cable'),
(5, '2024-02-15', 1800.00, 3, 'Printer'),
(2, '2024-01-30', 950.00, 4, 'Headset'),
(4, '2024-02-18', 3200.00, 1, 'Server'),
(6, '2024-02-20', 2500.00, 2, 'Laptop');

SELECT table_name 
FROM information_schema.tables 
WHERE table_type = 'BASE TABLE' 
  AND table_schema NOT IN ('pg_catalog', 'information_schema');

select * from company.departments;
select * from company.employees;
select * from company.orders;

SELECT dept_name, location, COUNT(*)
FROM company.departments
GROUP BY dept_name, location
HAVING COUNT(*) > 1;

SELECT * FROM company.departments 
WHERE dept_id IN (4, 5, 6);

DELETE FROM company.departments 
WHERE dept_id IN (4, 5, 6);

create schema training;

alter table company.employees set schema training;

alter table training.employees set schema company;

select table_name from information_schema.tables where table_schema = 'company';

drop schema training;

--Find all employees whose name starts with ‘A’.
select * from company.employees;
select name from company.employees where name like 'A%';

--Find all products that contain the word ‘top’ in their name (e.g., Laptop).
select * from company.orders;
select distinct product_name from company.orders where product_name like '%top%';

--Find employees whose name has exactly 5 letters.
select name from company.employees where name like '_____';

--Find orders where the product name ends with ‘er’ (e.g., Printer, Server)
select product_name from company.orders where product_name like '%er';

--Arithematic Operators
--Show each order’s amount, quantity, and the average price per unit (amount/quantity).
select * from company.orders;
select order_id, amount, quantity, quantity/amount as unit_price from company.orders;

--Increase every employee’s salary by 5% and show new salary.
select * from company.employees;
select salary*1.05 as new_salary from company.employees;

--Find the total value of all orders after applying a 10% discount.
select * from company.orders;
select sum(amount*0.9) as total_after_discount from company.orders;

--Find orders where the total amount (amount * quantity) is greater than 5000.
select * from company.orders;
select amount*quantity as total_amount from company.orders where amount*quantity > 5000;

--List all employees sorted by salary from highest to lowest.
select * from company.employees;
select name, salary from company.employees order by salary desc;

--List orders sorted by order_date (oldest first) and then by amount (largest first).
select * from company.orders;
select order_id, amount from company.orders order by order_date asc, amount desc;

--Get the top 3 most expensive orders.
select * from company.orders;
select order_id, product_name, amount from company.orders order by amount desc limit 3;




