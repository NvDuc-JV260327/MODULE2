USE ss7_db; 

CREATE TABLE IF NOT EXISTS employees (
    `id` INT PRIMARY KEY AUTO_INCREMENT,
    `name` VARCHAR(100) NOT NULL,
    department VARCHAR(100) NOT NULL,
    salary FLOAT
);

CREATE INDEX idx_department ON employees(department);