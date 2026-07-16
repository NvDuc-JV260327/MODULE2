CREATE DATABASE IF NOT EXISTS ss6_db;

USE ss6_db;

-- tạo bảng
CREATE TABLE IF NOT EXISTS categories (
	id INT PRIMARY KEY AUTO_INCREMENT,
    `name` VARCHAR(255)
);

CREATE TABLE IF NOT EXISTS products (
	id INT PRIMARY KEY AUTO_INCREMENT,
    `name` VARCHAR(255),
    price DOUBLE,
    category_id INT,
    FOREIGN KEY (category_id) REFERENCES categories(id)
);

-- thêm danh mục
INSERT INTO categories (`name`)
VALUES ('laptop'),('phone'),('bike');
-- thêm sản phẩm    
INSERT INTO products (`name`, price, category_id)
VALUES
	('iphone x', 10000000, 2),
    ('asus pro', 20000000, 1),
    ('wave', 25000000, 3),
    ('vision', 40000000, 3),
    ('samsung galaxy s9',12000000, 2);
    
-- xóa 1 sản phẩm    
DELETE FROM products
WHERE id = 4;

-- hiển thị tất cả sản phẩm, sắp xếp theo giá
SELECT * FROM products
ORDER BY price DESC;

-- thống kê số lượng sản phẩm cho từng danh mục
SELECT c.`name` AS 'Danh mục', COUNT(p.id) AS 'Số lượng'
FROM categories c
INNER JOIN products p
ON p.category_id = c.id
GROUP BY c.id, c.`name`;
