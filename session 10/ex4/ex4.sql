CREATE DATABASE IF NOT EXISTS ss10_db;

USE ss10_db;

-- tạo bảng nhân viên
CREATE TABLE IF NOT EXISTS employees(
    id INT PRIMARY KEY AUTO_INCREMENT,
    fist_name VARCHAR(50),
    last_name VARCHAR(50),
    salary DECIMAL(10, 2),
    email VARCHAR(100) UNIQUE,
    phone_number VARCHAR(15)
);

-- thêm 10 bản ghi
INSERT INTO employees(fist_name, last_name, salary, email, phone_number)
VALUES
    ('Nguyen', 'An', 1200.00, 'an.nguyen@gmail.com', '0901234567'),
    ('Tran', 'Binh', 1500.00, 'binh.tran@gmail.com', '0901234568'),
    ('Le', 'Cuong', 1800.00, 'cuong.le@gmail.com', '0901234569'),
    ('Pham', 'Dung', 2000.00, 'dung.pham@gmail.com', '0901234570'),
    ('Hoang', 'Giang', 1700.00, 'giang.hoang@gmail.com', '0901234571'),
    ('Vo', 'Hai', 1600.00, 'hai.vo@gmail.com', '0901234572'),
    ('Dang', 'Khanh', 2200.00, 'khanh.dang@gmail.com', '0901234573'),
    ('Bui', 'Linh', 2500.00, 'linh.bui@gmail.com', '0901234574'),
    ('Do', 'Minh', 1900.00, 'minh.do@gmail.com', '0901234575'),
    ('Phan', 'Ngoc', 2100.00, 'ngoc.phan@gmail.com', '0901234576');

-- tạo bảng ghi lại thay đổi lương
CREATE TABLE IF NOT EXISTS salary_log(
    log_id INT PRIMARY KEY AUTO_INCREMENT,
    employee_id INT,
    old_salary DECIMAL(10, 2),
    new_salary DECIMAL(10, 2),
    change_date DATETIME DEFAULT CURRENT_TIMESTAMP
);

-- tạo trigger khi có thay đổi lương
DELIMITER //
CREATE TRIGGER trg_after_update_salary
AFTER UPDATE
ON employees
FOR EACH ROW
BEGIN
    IF OLD.salary <> NEW.salary THEN
        INSERT INTO salary_log(employee_id, old_salary, new_salary, change_date)
        VALUES(
            NEW.id,
            OLD.salary,
            NEW.salary,
            NOW()
        );
    END IF;
END //
DELIMITER ;

-- thử thay đổi lương
UPDATE employees
SET salary = 2000
WHERE id = 2;

-- kiểm tra nhật ký
SELECT * FROM salary_log;