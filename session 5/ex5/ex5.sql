CREATE DATABASE IF NOT EXISTS ss5_db;
USE ss5_db;

CREATE TABLE students (
	student_id INT PRIMARY KEY AUTO_INCREMENT,
    full_name VARCHAR(50) NOT NULL,
    birth_year DATE,
    gender VARCHAR(10)
);

-- thêm 5 sinh viên
INSERT INTO students (full_name, birth_year, gender)
VALUES
	('Nguyen Van An', '2002-05-15', 'Nam'),
	('Tran Thi Binh', '2001-08-22', 'Nu'),
	('Le Minh Chau', '2003-01-10', 'Nam'),
	('Pham Thi Dung', '2002-11-30', 'Nu'),
	('Hoang Gia Huy', '2001-07-18', 'Nam');

CREATE TABLE IF NOT EXISTS scores(
	student_id INT NOT NULL,
    `subject` VARCHAR(50),
    score DOUBLE,
    FOREIGN KEY (student_id) REFERENCES students(student_id)
);

-- thêm dữ liệu
INSERT INTO scores (student_id, `subject`, score)
VALUES
	(1, 'Toán', 8.5),
	(1, 'Lý', 7.8),
	(1, 'Hóa', 9.0),
	(2, 'Toán', 6.5),
	(2, 'Lý', 7.0),
	(2, 'Hóa', 6.8),
	(3, 'Toán', 9.2),
	(3, 'Lý', 8.9),
	(3, 'Hóa', 9.5),
	(4, 'Toán', 5.8),
	(4, 'Lý', 6.2),
	(4, 'Hóa', 5.5),
	(5, 'Toán', 7.5),
	(5, 'Lý', 8.0),
	(5, 'Hóa', 7.2);
    
-- tính điểm trung bình mỗi sinh viên
SELECT s.student_id, s.full_name, ROUND(AVG(score), 2) AS 'AVG SCORE'
FROM students s
JOIN scores sc
ON s.student_id = sc.student_id
GROUP BY s.student_id, s.full_name;

-- Chỉ hiển thị các sinh viên có: điểm trung bình ≥ 7.0
SELECT s.student_id, s.full_name, ROUND(AVG(score), 2) AS 'AVG SCORE'
FROM students s
JOIN scores sc
ON s.student_id = sc.student_id
GROUP BY s.student_id, s.full_name
HAVING AVG(score) > 7;

-- Hiển thị sinh viên có: điểm trung bình cao nhất trong toàn bộ danh sách
SELECT s.student_id, s.full_name, ROUND(AVG(score), 2) AS 'AVG SCORE'
FROM students s
JOIN scores sc
ON s.student_id = sc.student_id
GROUP BY s.student_id, s.full_name
ORDER BY AVG(score) DESC 
LIMIT 1;

-- Hiển thị các sinh viên có: điểm trung bình cao hơn điểm trung bình chung của tất cả sinh viên
SELECT s.student_id, s.full_name, ROUND(AVG(score), 2) AS 'AVG SCORE'
FROM students s
JOIN scores sc
ON s.student_id = sc.student_id
GROUP BY s.student_id, s.full_name
HAVING AVG(score) > (
	SELECT AVG(score)
    FROM scores
    );