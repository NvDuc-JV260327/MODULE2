CREATE DATABASE IF NOT EXISTS ss8_db;

USE ss8_db;

CREATE TABLE employees (
    `id` INT PRIMARY KEY AUTO_INCREMENT,
    `name` VARCHAR(100) NOT NULL,
    salary FLOAT
);

DELIMITER //

CREATE PROCEDURE sp_get_avg_salary()
BEGIN
    DECLARE avg_salary FLOAT;
    SELECT AVG(salary)
    INTO avg_salary
    FROM employees;

    SELECT avg_salary AS 'lương trung bình';
END //

DELIMITER ;