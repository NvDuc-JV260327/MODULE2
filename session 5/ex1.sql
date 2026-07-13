CREATE DATABASE ss5;

USE ss5;

CREATE TABLE students (
	student_id INT PRIMARY KEY AUTO_INCREMENT,
    full_name VARCHAR(50) NOT NULL,
    birth_year DATE,
    gender VARCHAR(10),
    score FLOAT
);

INSERT INTO students VALUE (1, 'Nguyen Van A', 1992, 'male', 7);
INSERT INTO students VALUE (2, 'Nguyen Van B', 1998, 'male', 6);
INSERT INTO students VALUE (3, 'Nguyen Thi C', 2005, 'female', 4);
INSERT INTO students VALUE (4, 'Nguyen Van D', 2011, 'male', 8);
INSERT INTO students VALUE (5, 'Nguyen Thi E', 1988, 'female', 5);

SELECT UPPER(full_name) FROM students;

SELECT full_name, 2026 - birth_year AS age FROM students;

SELECT ROUND(AVG(score), 1) AS `Điểm trung bình` FROM students; 

SELECT COUNT(student_id) AS 'Tổng số sinh viên' FROM students;

SELECT MAX(score) AS 'Điểm cao nhất' FROM students;

SELECT MIN(score) AS 'Điểm thấp nhất' FROM students;