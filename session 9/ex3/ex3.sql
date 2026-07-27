CREATE DATABASE IF NOT EXISTS ss9_db;

USE ss9_db;

-- tạo bảng products
CREATE TABLE IF NOT EXISTS products (
    product_id INT PRIMARY KEY AUTO_INCREMENT,
    product_name VARCHAR(50) NOT NULL,
    price FLOAT NOT NULL CHECK(price > 0),
    stock INT NOT NULL CHECK(stock > 0)
);

-- thêm 20 bản ghi
INSERT INTO products (product_id, product_name, price, stock)
VALUES 
    (1, 'Product 1', 500000.00, 10),
    (2, 'Product 2', 1500000.00, 5),
    (3, 'Product 3', 2000000.00, 8),
    (4, 'Product 4', 300000.00, 20),
    (5, 'Product 5', 2500000.00, 15),
    (6, 'Product 6', 800000.00, 12),
    (7, 'Product 7', 1200000.00, 7),
    (8, 'Product 8', 1000000.00, 3),
    (9, 'Product 9', 1750000.00, 6),
    (10, 'Product 10', 950000.00, 4),
    (11, 'Product 11', 450000.00, 9),
    (12, 'Product 12', 1100000.00, 13),
    (13, 'Product 13', 500000.00, 20),
    (14, 'Product 14', 999999.99, 12),
    (15, 'Product 15', 3500000.00, 6),
    (16, 'Product 16', 120000.00, 23),
    (17, 'Product 17', 5555555.00, 8),
    (18, 'Product 18', 1700000.00, 5),
    (19, 'Product 19', 850000.00, 7),
    (20, 'Product 20', 2000000.00, 10);

    -- tạo Stored Procedure get_high_value_products 
    -- lấy về danh sách tất cả các sản phẩm có giá lớn hơn 1.000.000
    DELIMITER //

    CREATE PROCEDURE get_high_value_products()
    BEGIN
        SELECT * FROM products
        WHERE price > 1000000;
    END //

    DELIMITER ;

    -- gọi stored procedure
    CALL get_high_value_products();