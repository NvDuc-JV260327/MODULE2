CREATE DATABASE IF NOT EXISTS ss7_db;

USE ss7_db;

CREATE TABLE IF NOT EXISTS students (
	`id` INT PRIMARY KEY AUTO_INCREMENT,
	`name` VARCHAR(100) NOT NULL,
    `dob` DATE,
    `class` VARCHAR(50),
    `address` VARCHAR(100)
);

CREATE VIEW v_student_basic
AS
SELECT s.id, s.`name`, s.class
FROM students s;