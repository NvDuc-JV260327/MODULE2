USE ss5;

CREATE TABLE employees (
	emp_id INT PRIMARY KEY AUTO_INCREMENT,
    full_name VARCHAR(50) NOT NULL,
    department VARCHAR(50),
    salary FLOAT
);

INSERT INTO employees 
VALUES 
(1, 'Nguyen Van A', 's1', 10000000),
(2, 'Nguyen Thi B', 's2', 15000000),
(3, 'Nguyen Van C', 's3', 12000000),
(4, 'Nguyen Thi D', 's2', 18000000),
(5, 'Nguyen Van E', 's3', 12000000),
(6, 'Nguyen Thi F', 's2', 18000000);

-- Mỗi phòng có bao nhiêu nhân viên
SELECT department AS 'Phòng', COUNT(department) AS 'Số nhân viên'
FROM employees
GROUP BY department;

-- Lương trung bình của từng phòng ban
SELECT department AS 'Phòng', AVG(salary) AS 'Lương trung bình'
FROM employees
GROUP BY department;

-- Các phòng ban có trên 3 nhân viên
SELECT department AS 'Phòng', COUNT(emp_id) AS 'Số nhân viên'
FROM employees
GROUP BY department
HAVING COUNT(emp_id) > 3;

-- Các phòng ban có lương trung bình lớn hơn 12.000.000
SELECT department AS 'Phòng', AVG(salary) AS 'Lương trung bình'
FROM employees
GROUP BY department
HAVING AVG(salary) > 12000000;