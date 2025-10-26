-- 1.	Создай две таблицы:
--			customers — клиенты (id, имя, email)
-- 			orders — заказы (id, сумма, дата, клиент)
CREATE TABLE customers (
	id SERIAL PRIMARY KEY,
	name TEXT NOT NULL,
	email TEXT NOT NULL UNIQUE
);

CREATE TABLE orders (
	id SERIAL PRIMARY KEY,
	total NUMERIC(10, 2) NOT NULL,
	create_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
	customer_id INT NOT NULL,
	CONSTRAINT fk_customer
		FOREIGN KEy (customer_id)
		REFERENCES customers(id)
		ON DELETE CASCADE
);



-- 2. Создай две таблицы:
-- 		departments (id, название)
-- 		employees (id, имя, должность, отдел)

CREATE TABLE departments (
    id SERIAL PRIMARY KEY,
    name TEXT NOT NULL
);

CREATE TABLE employees (
    id SERIAL PRIMARY KEY,
    name TEXT NOT NULL,
    position TEXT NOT NULL,
    department_id INT,
    CONSTRAINT fk_department
        FOREIGN KEY (department_id)
        REFERENCES departments(id)
        ON DELETE SET NULL
);



-- 3. Создай две таблицы:
-- 		categories (id, name)
-- 		products (id, name, price, category_id)
CREATE TABLE categories (
    id SERIAL PRIMARY KEY,
    name TEXT NOT NULL
);

CREATE TABLE products (
    id SERIAL PRIMARY KEY,
    name TEXT NOT NULL,
    price NUMERIC(10, 2) NOT NULL CHECK (price >= 0),
    category_id INT,
    CONSTRAINT fk_category
        FOREIGN KEY (category_id)
        REFERENCES categories(id)
        ON DELETE SET NULL
);



-- 4. Создай 3 таблицы:
-- 		customers — покупатели
-- 		products — товары
-- 		orders — заказы
CREATE TABLE customers (
    id SERIAL PRIMARY KEY,
    name TEXT NOT NULL,
    email TEXT UNIQUE NOT NULL
);

CREATE TABLE products (
    id SERIAL PRIMARY KEY,
    name TEXT NOT NULL,
    price NUMERIC(10, 2) NOT NULL CHECK (price >= 0)
);

CREATE TABLE orders (
    id SERIAL PRIMARY KEY,
    customer_id INT NOT NULL,
    order_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_customer
        FOREIGN KEY (customer_id)
        REFERENCES customers(id)
        ON DELETE CASCADE
);

CREATE TABLE order_items (
    order_id INT NOT NULL,
    product_id INT NOT NULL,
    quantity INT NOT NULL CHECK (quantity > 0),
    PRIMARY KEY (order_id, product_id),
    CONSTRAINT fk_order
        FOREIGN KEY (order_id)
        REFERENCES orders(id)
        ON DELETE CASCADE,
    CONSTRAINT fk_product
        FOREIGN KEY (product_id)
        REFERENCES products(id)
        ON DELETE RESTRICT
);



-- 5. Создай таблицы:
-- 		students (id, name, group_id)
-- 		groups (id, name, faculty_id)
-- 		faculties (id, name)
-- 		courses (id, name, teacher_id)
-- 		teachers (id, name)
-- 		student_courses (student_id, course_id, grade)
CREATE TABLE faculties (
    id SERIAL PRIMARY KEY,
    name TEXT NOT NULL
);

CREATE TABLE groups (
    id SERIAL PRIMARY KEY,
    name TEXT NOT NULL,
    faculty_id INT NOT NULL,
    CONSTRAINT fk_faculty
        FOREIGN KEY (faculty_id)
        REFERENCES faculties(id)
        ON DELETE CASCADE
);

CREATE TABLE students (
    id SERIAL PRIMARY KEY,
    name TEXT NOT NULL,
    group_id INT,
    CONSTRAINT fk_group
        FOREIGN KEY (group_id)
        REFERENCES groups(id)
        ON DELETE SET NULL
);

CREATE TABLE teachers (
    id SERIAL PRIMARY KEY,
    name TEXT NOT NULL
);

CREATE TABLE courses (
    id SERIAL PRIMARY KEY,
    name TEXT NOT NULL,
    teacher_id INT NOT NULL,
    CONSTRAINT fk_teacher
        FOREIGN KEY (teacher_id)
        REFERENCES teachers(id)
        ON DELETE SET NULL
);

CREATE TABLE student_courses (
    student_id INT NOT NULL,
    course_id INT NOT NULL,
    grade INT CHECK (grade BETWEEN 1 AND 5),
    PRIMARY KEY (student_id, course_id),
    CONSTRAINT fk_student
        FOREIGN KEY (student_id)
        REFERENCES students(id)
        ON DELETE CASCADE,
    CONSTRAINT fk_course
        FOREIGN KEY (course_id)
        REFERENCES courses(id)
        ON DELETE CASCADE
);



-- 6. Создай таблицы:
-- 		users (id, name, email, created_at)
-- 		posts (id, user_id, text, created_at)
-- 		comments (id, post_id, user_id, text, created_at)
-- 		likes (user_id, post_id)
CREATE TABLE users (
    id SERIAL PRIMARY KEY,
    name TEXT NOT NULL,
    email TEXT UNIQUE NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE posts (
    id SERIAL PRIMARY KEY,
    user_id INT NOT NULL,
    text TEXT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_post_user
        FOREIGN KEY (user_id)
        REFERENCES users(id)
        ON DELETE CASCADE
);

CREATE TABLE comments (
    id SERIAL PRIMARY KEY,
    post_id INT NOT NULL,
    user_id INT NOT NULL,
    text TEXT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_comment_post
        FOREIGN KEY (post_id)
        REFERENCES posts(id)
        ON DELETE CASCADE,
    CONSTRAINT fk_comment_user
        FOREIGN KEY (user_id)
        REFERENCES users(id)
        ON DELETE CASCADE
);

CREATE TABLE likes (
    user_id INT NOT NULL,
    post_id INT NOT NULL,
    PRIMARY KEY (user_id, post_id),
    CONSTRAINT fk_like_user
        FOREIGN KEY (user_id)
        REFERENCES users(id)
        ON DELETE CASCADE,
    CONSTRAINT fk_like_post
        FOREIGN KEY (post_id)
        REFERENCES posts(id)
        ON DELETE CASCADE
);

