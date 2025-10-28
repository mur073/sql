CREATE TABLE students (
	student_id SERIAL PRIMARY KEY,
	first_name VARCHAR(50) NOT NULL,
	last_name VARCHAR(50) NOT NULL,
	birth_date DATE NOT NULL,
	email VARCHAR(100),
	group_id INT NOT NULL
);


-- 1. Напишите INSERT для заполнения таблицы
INSERT INTO students (first_name, last_name, birth_date, email, group_id) VALUES
('Алексей', 'Алексеев', '2003-04-12', 'alexey.alexeyev@home.com', 101),
('Darya', 'Alekseyeva', '2002-11-03', 'd.alexeyeva@home.com', 101),
('Murio', 'Khasanov', '2004-01-27', 'murio.khasanov@home.com', 102),
('Maria', 'Maria', '2003-07-19', 'm.maria@home.com', 103),
('Nikolay', 'Baskov', '2002-09-05', 'nikolay.backov@home.com', 102),
('Svetlana', 'Sidorchuk', '2003-02-14', 'svetlana.s@home.com', 103),
('Oleg', 'Efimov', '2004-10-08', 'o.efimov@home.com', 101),
('Kamila', 'Alimova', '2003-05-22', 'kamila.a@home.com', 104),
('Oleg', 'Efimov', '2002-12-30', 'oleg.nik@home.com', 104),
('Elena', 'Pavlova', '2003-03-11', 'elena.pavlova@home.com', 103);


-- 2. Найти дубликаты по имени и фамилии студента
SELECT 
    first_name,
    last_name,
    COUNT(*) AS count
FROM students
GROUP BY first_name, last_name
HAVING COUNT(*) > 1;


-- 3. Удалить дубликаты, оставить только первую запись
DELETE FROM students
WHERE student_id NOT IN (
    SELECT MIN(student_id)
    FROM students
    GROUP BY first_name, last_name
);
