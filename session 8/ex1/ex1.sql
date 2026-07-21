CREATE DATABASE IF NOT EXISTS ss8_db;

USE ss8_db;

CREATE TABLE IF NOT EXISTS students (
    `id` INT PRIMARY KEY AUTO_INCREMENT,
    `name` VARCHAR(100) NOT NULL,
    `class_name` VARCHAR(100)
);

DELIMITER //
CREATE PROCEDURE sp_get_all_students()
BEGIN
    SELECT * FROM students;
END //
DELIMITER ;

CALL sp_get_all_students();