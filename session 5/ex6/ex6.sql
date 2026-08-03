CREATE DATABASE IF NOT EXISTS ss5_db;
USE ss5_db;

CREATE TABLE IF NOT EXISTS customers(
	customer_id INT PRIMARY KEY AUTO_INCREMENT,
    customer_name VARCHAR(50)
);

CREATE TABLE IF NOT EXISTS orders(
	order_id INT PRIMARY KEY AUTO_INCREMENT,
    order_date DATE,
    customer_id INT,
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

CREATE TABLE IF NOT EXISTS order_items(
	order_id INT,
    customer_id INT,
    product_name VARCHAR(50),
    quantity INT,
    price DECIMAL(10, 2),
    FOREIGN KEY (order_id)REFERENCES orders(order_id),
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

-- customers
INSERT INTO customers (customer_name)
VALUES
	('Nguyen Van An'),
	('Tran Thi Binh'),
	('Le Minh Chau'),
	('Pham Thi Dung'),
	('Hoang Gia Huy');
    
-- orders
INSERT INTO orders (order_date, customer_id)
VALUES
	('2026-08-01', 1),
	('2026-08-01', 2),
	('2026-08-02', 3),
	('2026-08-02', 4),
	('2026-08-03', 5);

-- order_items
INSERT INTO order_items (order_id, customer_id, product_name, quantity, price)
VALUES
	(1, 1, 'Laptop Asus', 1, 18000000.00),
	(2, 2, 'iPhone 15', 2, 22000000.00),
	(3, 3, 'Samsung Galaxy S24', 1, 19000000.00),
	(4, 4, 'AirPods Pro', 3, 5000000.00),
	(5, 5, 'iPad Air', 2, 16000000.00);
    
-- Hiển thị:mã đơn hàng, tên khách hàng, tổng tiền của đơn hàng
SELECT od.order_id, c.customer_name, od.price * od.quantity AS 'total_amount'
FROM order_items od
JOIN customers c
ON od.customer_id = c.customer_id;

-- Tính: tổng doanh thu của mỗi khách hàng
SELECT c.customer_id, c.customer_name, SUM(od.quantity * od.price) AS 'total'
FROM customers c
JOIN order_items od
ON c.customer_id = od.customer_id
GROUP BY c.customer_id, c.customer_name;

-- Chỉ hiển thị: các khách hàng có tổng doanh thu lớn hơn 20.000.000
SELECT c.customer_id, c.customer_name, SUM(od.quantity * od.price) AS 'total'
FROM customers c
JOIN order_items od
ON c.customer_id = od.customer_id
GROUP BY c.customer_id, c.customer_name
HAVING SUM(od.quantity * od.price) > 20000000;

-- Hiển thị: khách hàng có doanh thu cao nhất
SELECT c.customer_id, c.customer_name, SUM(od.quantity * od.price) AS 'total'
FROM customers c
JOIN order_items od
ON c.customer_id = od.customer_id
GROUP BY c.customer_id, c.customer_name
ORDER BY SUM(od.quantity * od.price) DESC
LIMIT 1;