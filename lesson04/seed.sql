insert into departments (id, name, location) values
	(1, 'IT', '3rd floor'),
	(2, 'Support', '2rd floor'),
	(3, 'HR', '2rd floor');

insert into employees (id, name, position, salary, department_id, manager_id) values
	(1, 'Harry Kane', 'Teamlead', 2100, 1, null),
	(2, 'Joseph Kane', 'Senior Java Dev', 1600, 1, 1),
	(3, 'Ruby Kane', 'Middle Python Dev', 1400, 1, 1),
	(4, 'Marcus Rashford', 'Head Support', 1100, 2, null),
	(5, 'Boba Rashford', 'Junior Support', 400, 2, 4),
	(6, 'Biba Rashford', 'Junior Support', 400, 2, 4),
	(7, 'Jane Doe', 'Senior HR', 1200, 3, null),
	(8, 'John Doe', 'Junior HR', 300, 3, 7),
	(9, 'Susan Doe', 'Middle HR', 750, 3, 7),
	(10, 'Unkno Wndepartment', 'Very Busy', 666, null, null);

insert into customers (id, name, city) values
	(1, 'Jonh Customer', 'Tashkent'),
	(2, 'Jane Customer', 'Tashkent'),
	(3, 'Bob Customer', 'Chirchicago'),
	(4, 'Jack Customer', 'Bukhara');

insert into orders (id, order_date, amount, employee_id, customer_id) values
	(1, '2025-10-29', 1000, 1, 1),
	(2, '2025-10-29', 500, 1, 2),
	(3, '2025-10-30', 8000, 2, 3),
	(4, '2025-10-30', 2000, 5, 4),
	(5, '2025-10-30', 1200, 9, 3);

insert into products (id, name, price) values
	(1, 'Product 1', 100),
	(2, 'Product 2', 200),
	(3, 'Product 3', 500),
	(4, 'Product 4', 1000);

insert into order_items (id, order_id, product_id, quantity) values
	(1, 1, 4, 1),
	(2, 3, 2, 5),
	(3, 3, 3, 2),
	(4, 3, 4, 5),
	(5, 4, 1, 20),
	(6, 5, 1, 2),
	(7, 5, 4, 1);








