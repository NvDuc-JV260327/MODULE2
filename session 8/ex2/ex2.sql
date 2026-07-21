CREATE DATABASE IF NOT EXISTS ss8_db;

USE ss8_db;

CREATE TABLE products (
    `id` INT PRIMARY KEY AUTO_INCREMENT,
    `name` VARCHAR(100) NOT NULL,
    price FLOAT,
    category VARCHAR(50)
);

DELIMITER //

CREATE PROCEDURE sp_get_products_by_category (
IN p_category VARCHAR(100)
)
BEGIN
SELECT * 
FROM products
WHERE category = p_category;
END //

DELIMITER ;

CALL sp_get_products_by_category('laptop');