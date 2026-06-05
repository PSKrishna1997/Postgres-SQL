-- Table 1: employees
create table employees (
	emp_id SERIAL primary key,
	name Varchar(100) not null,
	age integer check (age >=18),
	Salary numeric (10,2),
	department VARCHAR(50),
	hire_date date
);

-- Table 2: products
create table products (
	prod_id SERIAL primary key,
	Prod_name VARCHAR(100) not null,
	Price numeric (10,2) check (Price >= 0),
	stock INT check (Stock >=0),
	category VARCHAR(50)
);

select * from products;
select * from employees;

-- Insert sample data into employees
INSERT INTO employees (name, age, salary, department, hire_date) VALUES
('Alice Johnson', 30, 55000.00, 'Sales', '2020-06-15'),
('Bob Smith', 45, 72000.00, 'Engineering', '2018-03-20'),
('Charlie Brown', 28, 48000.00, 'Marketing', '2021-11-01'),
('Diana Prince', 35, 68000.00, 'Sales', '2019-07-10'),
('Evan Wright', 40, 82000.00, 'Engineering', '2017-09-25'),
('Fiona Green', 26, 45000.00, 'Marketing', '2022-01-12'),
('George Hill', 50, 95000.00, 'Engineering', '2015-12-03'),
('Hannah Lee', 32, 59000.00, 'Sales', '2020-08-19');

-- Insert sample data into products
INSERT INTO products (prod_name, price, stock, category) VALUES
('Laptop', 1200.00, 25, 'Electronics'),
('Mouse', 25.50, 150, 'Electronics'),
('Desk Chair', 300.00, 12, 'Furniture'),
('Notebook', 2.99, 500, 'Stationery'),
('Monitor', 350.00, 18, 'Electronics'),
('Pen Set', 15.00, 200, 'Stationery'),
('Bookshelf', 180.00, 8, 'Furniture'),
('Keyboard', 75.00, 40, 'Electronics');

--DDL
-- 01. Add a new column email (VARCHAR(100)) to the employees table
alter table employees add email varchar(100);

--02. Rename the column email to contact_email.
alter table employees rename email to contact_email;

--03.Drop the column contact_email from employees.
alter table employees drop contact_email;

--04.Add a UNIQUE constraint on the name column of employees.
alter table employees add constraint unique_name unique (name);

--05.Drop the unique_name constraint
alter table employees drop constraint unique_name;

--06.Change the data type of salary from NUMERIC to INTEGER in employees
alter table employees alter column salary type int using salary::int;

/*Command Breakdown
ALTER TABLE employees: Tells the database to modify the structure of the existing employees table
ALTER COLUMN salary TYPE int: Targets the salary column and instructs the database to change its data type to integer
USING salary::int: This is the critical conversion clause. It tells PostgreSQL exactly how to convert the old data into the new format.
The :: is the PostgreSQL shorthand casting operator. It takes each existing value in the salary column and explicitly converts (casts) it into an integer.
 */

--07.Revert the salary column back to NUMERIC(10,2).
alter table employees alter column salary type numeric(10,2);

--08.Rename the products table to inventory.
alter table products rename to inventory;

--09.Rename it back to products
alter table inventory rename to products;

--10.Insert a new employee: 'Ivy Chen', age 29, salary 51000, department 'Sales', hire_date '2023-05-20'.
select * from employees;
INSERT INTO employees (name, age, salary, department, hire_date) values ('Ivy Chen', 29, 51000.00, 'Sales', '2023-05-20');

--11.Insert a new product: 'Tablet', price 400.00, stock 15, category 'Electronics'.
select *from products;
insert into products (prod_name,price,stock,category) values ('Tablets',400.00,15,'Electronis');

--12.Insert multiple employees at once: ('Jack Lee', 33, 62000, 'Engineering', '2022-09-01'), ('Karen White', 27, 47000, 'Marketing', '2023-02-14').
INSERT INTO employees (name, age, salary, department, hire_date) values
('Jack Lee', 33, 62000, 'Engineering', '2022-09-01'),
('Karen White', 27, 47000, 'Marketing', '2023-02-14');
select * from employees;

--13.Update the salary of all employees in 'Engineering' by 10%
update employees set salary = salary*1.10 where department ='Engineering'
select * from employees;

--14.Update the stock of 'Mouse' to 200.
update products set stock = 200 where prod_name = 'Mouse';
select * from products;

--15.Delete all products with stock less than 10.
delete from products where stock < 10;
select * from products;

--16.Delete the employee named 'Charlie Brown'
delete from employees where name='Charlie Brown';

--17.Increase the price of all 'Electronics' products by 5%.
update products set price = price*1.05 where category = 'Electronis';
select * from products;

--18.Update the department of 'Ivy Chen' to 'Marketing'.
update employees set department='Marketing' where name='Ivy Chen';

select * from employees;

--19.Update the hire_date of 'Bob Smith' to '2018-05-01'
update employees set hire_date='2018-05-01' where name='Bob Smith';

select* from employees;

--20.Change the category of all products with price > 500 to 'Premium'
update products set category='Premium' where price>500;

select*from products;

--21.Find all employees older than 35, sorted by age descending.
select * from employees where age>35 order by age desc;

--22.Count the number of products in each category.
select category, count(*) from products group by category;

--23.List employees whose salary is greater than 60000.
select * from employees where salary > 60000;

--24.Show the total stock value (price * stock) for each product
select prod_name, price*stock as total_values from products;

--25.Find departments that have more than 2 employees (using HAVING).
select department from employees group by department having count(*) > 2;


--