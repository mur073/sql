CREATE TABLE students (
   student_id INT PRIMARY KEY,
   full_name VARCHAR(100),
   age INT,
   group_id INT
);

CREATE TABLE groups (
   group_id INT PRIMARY KEY,
   group_name VARCHAR(50)
);

CREATE TABLE subjects (
   subject_id INT PRIMARY KEY,
   subject_name VARCHAR(50)
);

CREATE TABLE grades (
   grade_id INT PRIMARY KEY,
   student_id INT,
   subject_id INT,
   grade INT,
   FOREIGN KEY (student_id) REFERENCES students(student_id),
   FOREIGN KEY (subject_id) REFERENCES subjects(subject_id)
);


-- 1. Напишите INSERT для заполнения таблиц
INSERT INTO groups (group_id, group_name) VALUES
	(40, 'M1-22'),
	(41, 'M2-22'),
	(42, 'M-23');

INSERT INTO students (student_id, full_name, age, group_id) VALUES
	(1, 'Alexey Alexeyev', 20, 40),
	(2, 'Darya Sergeyeva', 21, 40),
	(3, 'Murio Khasanov', 19, 41),
	(4, 'Maria Djuraeva', 20, 41),
	(5, 'Nikolay Baskov', 22, 42);

INSERT INTO subjects (subject_id, subject_name) VALUES
	(1, 'Mathematics'),
	(2, 'Physics'),
	(3, 'History');

INSERT INTO grades (grade_id, student_id, subject_id, grade) VALUES
	(1, 1, 1, 90),
	(2, 1, 2, 84),
	(3, 2, 1, 78),
	(4, 2, 3, 88),
	(5, 3, 1, 92),
	(6, 3, 2, 73),
	(7, 4, 3, 95),
	(8, 5, 1, 81);

-- 1. Подсчитайте количество студентов в университете.
SELECT COUNT(*) as students_count
FROM students;

-- 2. Найдите средний возраст студентов.
SELECT AVG(age) as average_age
FROM students;

-- 3. Определите минимальный и максимальный возраст студентов.
SELECT MIN(age) as min_age, MAX(age) as max_age
FROM students;

-- 4. Подсчитайте, сколько всего оценок выставлено.
SELECT COUNT(*) as grades_count
FROM grades;

-- 5. Подсчитайте, сколько студентов учится в каждой группе.
SELECT group_id, AVG(age) as average_age
FROM students
GROUP BY group_id;

-- 6. Определите средний балл по каждому предмету.
SELECT subject_id, AVG(grade) as average_grade
FROM grades
GROUP BY subject_id;

-- 7. Найдите количество студентов, у которых есть оценки по каждому предмету.
SELECT COUNT(*) AS count
FROM (
    SELECT student_id
    FROM grades
    GROUP BY student_id
    HAVING COUNT(DISTINCT subject_id) = (SELECT COUNT(*) FROM subjects)
) AS sub;

-- 8. Выведите только те группы, где учится больше 1 студента.
SELECT group_id, COUNT(*) AS students_count
FROM students
GROUP BY group_id
HAVING COUNT(*) > 1;

-- 9. Покажите предметы, где средний балл выше 8.
SELECT subject_id, AVG(grade) as average_grade
FROM grades
GROUP BY subject_id
HAVING AVG(grade) > 8;

-- 10. Найдите студентов, у которых средний балл по всем предметам выше 8.5.
SELECT student_id
FROM grades
GROUP BY student_id
HAVING AVG(grade) > 8.5;



