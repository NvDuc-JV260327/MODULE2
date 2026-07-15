CREATE DATABASE IF NOT EXISTS ss5; 

USE ss5;

CREATE TABLE IF NOT EXISTS products (
	product_id INT PRIMARY KEY AUTO_INCREMENT,
    product_name VARCHAR(50) NOT NULL UNIQUE,
    category VARCHAR(50),
    price FLOAT NOT NULL
);

INSERT INTO products (product_name, category, price)
VALUES 
('samsung galaxy note 6', 'phone', 10000000),
('iphone 15', 'phone', 12000000),
('dell inspiron', 'laptop', 20000000),
('macbook air', 'macbook', 11000000),
('asus pro', 'laptop', 25000000);

-- các sản phẩm có giá cao hơn giá trung bình của tất cả sản phẩm
SELECT * FROM products
WHERE price > 
	(SELECT AVG(price) FROM products);
    
-- giá cao nhất trong từng loại sản phẩm
SELECT category AS 'Sản phẩm', MAX(price) AS 'Giá cao nhất'
FROM products
GROUP BY category;

-- có ít nhất 1 sản phẩm giá trên 20.000.000
SELECT category
FROM products
GROUP BY category
HAVING MAX(price) > 20000000;