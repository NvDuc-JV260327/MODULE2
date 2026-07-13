CREATE DATABASE ss4;

USE ss4;

CREATE TABLE students;

INSERT INTO students
(full_name, birth_day, gender, email)
VALUES
('Nguyen Van A','20260124','male', 'nvA@gmail.com'),
('Nguyen Van B', '20001111', 'male', NULL),
('Nguyen Thi C', '20010101', 'female', 'ntC@gmail.com'),
('Nguyen Thi D', '19990909', 'female', NULL),
('Nguyen Van E', '19920202', 'male', 'nvE@gmail.com');

SELECT * FROM students;

SELECT student_id, full_name, email FROM students;