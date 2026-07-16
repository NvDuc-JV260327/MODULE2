USE ss5;

CREATE TABLE products (
    product_id INT PRIMARY KEY AUTO_INCREMENT,
    product_name VARCHAR(100) NOT NULL,
    category VARCHAR(50) NOT NULL,
    price DECIMAL(15,2) NOT NULL
);

INSERT INTO products (product_name, category, price) VALUES
('Dell XPS 15', 'Laptop', 30000000),
('MacBook Pro', 'Laptop', 50000000),
('Asus Vivobook', 'Laptop', 15000000),
('iPhone 15', 'Phone', 25000000),
('Samsung S24', 'Phone', 18000000),
('Xiaomi 14', 'Phone', 12000000),
('Logitech MX Master 3', 'Accessory', 2500000),
('Razer DeathAdder', 'Accessory', 1200000);

-- 1. Hiển thị các sản phẩm có giá cao hơn giá trung bình của tất cả sản phẩm
SELECT *
FROM products
WHERE price > (
    SELECT AVG(price)
    FROM products
);

-- 2. Hiển thị sản phẩm có giá cao nhất trong từng loại sản phẩm
SELECT *
FROM products p
WHERE price = (
    SELECT MAX(price)
    FROM products
    WHERE category = p.category
);

-- 3. Hiển thị các sản phẩm thuộc loại có ít nhất một sản phẩm giá trên 20.000.000
SELECT *
FROM products
WHERE category IN (
    SELECT DISTINCT category
    FROM products
    WHERE price > 20000000
);