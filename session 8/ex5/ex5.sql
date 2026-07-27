CREATE DATABASE IF NOT EXISTS ss8_db;

USE ss8_db;

-- tạo bảng employees
CREATE TABLE IF NOT EXISTS employees (
	id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100),
    salary FLOAT,
    department VARCHAR(100)
);

-- thêm dữ liệu
INSERT INTO employees (name, salary, department)
VALUES 
	('Nguyen Van A', 8500000, 'IT'),
	('Tran Thi B', 12000000, 'HR'),
	('Le Van C', 23000000, 'Finance'),
	('Pham Thi D', 17500000, 'Marketing'),
	('Hoang Van E', 6500000, 'IT'),
	('Vo Thi F', 21000000, 'Sales'),
	('Dang Van G', 14500000, 'Finance'),
	('Bui Thi H', 9000000, 'HR'),
	('Do Van I', 25000000, 'IT'),
	('Nguyen Thi J', 11000000, 'Marketing'),
	('Tran Van K', 7000000, 'Sales'),
	('Le Thi L', 19500000, 'Finance'),
	('Pham Van M', 15500000, 'IT'),
	('Vo Van O', 22000000, 'Marketing'),
	('Dang Thi P', 13500000, 'Sales'),
	('Bui Van Q', 18000000, 'Finance'),
	('Do Thi R', 24000000, 'IT'),
	('Nguyen Van S', 10000000, 'HR'),
	('Tran Thi T', 16500000, 'Marketing');
    
-- Xóa procedure
DROP PROCEDURE IF EXISTS sp_check_employee_income;
-- tạo procedure
DELIMITER //
CREATE PROCEDURE sp_check_employee_income (
	IN in_name VARCHAR(100),
    IN in_salary FLOAT
)
BEGIN
	IF(in_salary < 8000000) THEN
		SELECT in_name AS 'name', 'Thu nhập thấp' AS message;
	ELSEIF(in_salary < 15000000) THEN
		SELECT in_name AS 'name', 'Thu nhập trung bình' AS message;
	ELSE 
		SELECT in_name AS 'name', 'Thu nhập cao' AS message;
	END IF;
END //
DELIMITER ;

-- gọi procedure
CALL sp_check_employee_income('Hoang Van E',850000);