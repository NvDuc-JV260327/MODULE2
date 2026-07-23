CREATE DATABASE IF NOT EXISTS ss6_db;

USE ss6_db;

-- tìm các sản phẩm có giá nằm trong 1 khoảng cụ thể
SELECT * FROM products
WHERE price BETWEEN 10000000 AND 20000000;

-- tìm các sản phẩm có tên chứa 1 chuỗi ký tự nhất định
SELECT * FROM products
WHERE `name` LIKE '%o%';

-- tính giá trung bình của sp cho mỗi danh mục
SELECT c.name AS 'Tên danh mục', AVG(p.price) AS 'Giá trung bình'
FROM categories c
JOIN products p
ON c.id = p.category_id
GROUP BY c.name;

-- tìm những sp có giá cao hơn mức giá trung bình của toàn bộ sp
SELECT id, `name`
FROM products
WHERE price > (SELECT AVG(price) FROM products);

-- Tìm sản phẩm có giá thấp nhất cho từng danh mục
SELECT c.id, c.name, p.name, p.price
FROM categories c 
JOIN products p
ON c.id = p.category_id
WHERE p.price = (
	SELECT MIN(price)
    FROM products p2
    WHERE p2.category_id = p.category_id
);