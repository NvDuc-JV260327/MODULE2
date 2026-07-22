USE ss6_db;

CREATE TABLE IF NOT EXISTS customers (
	`id` INT PRIMARY KEY AUTO_INCREMENT,
    `name` VARCHAR(255) NOT NULL,
    `email` VARCHAR(255)
);

CREATE TABLE IF NOT EXISTS orders (
	`id` INT PRIMARY KEY AUTO_INCREMENT,
    order_date DATE,
    customer_id INT,
    FOREIGN KEY (customer_id) REFERENCES customers(`id`)
);

CREATE TABLE IF NOT EXISTS order_details (
	order_id INT,
    product_id INT,
    quantity INT,
    price DOUBLE,
    FOREIGN KEY (order_id) REFERENCES orders(`id`),
    FOREIGN KEY (product_id) REFERENCES products(`id`)
);

-- Thêm 2 khách hàng
INSERT INTO customers (`name`, `email`)
VALUES 
	('Nguyen van A', 'a@gmail.com'),
    ('Nguyen van B', 'b@gmail.com');
    
-- Liệt kê những khách hàng đã có ít nhất 1 đơn hàng
SELECT c.id, c.`name`
FROM customers c
INNER JOIN orders o
ON c.id = o.customer_id ;

-- tìm những khách hàng chưa từng đặt đơn nào
SELECT c.id, c.`name`
FROM customers c
LEFT JOIN  orders o
ON c.id = o.customer_id
WHERE o.id IS NULL;

-- tính toán tổng doanh thu mỗi khách hàng mang lại
SELECT c.id, c.`name`, SUM(od.quantity * od.price) AS revenue
FROM customers c
INNER JOIN orders o
	ON c.id = o.customer_id
INNER JOIN order_details od
    ON o.id = od.order_id
GROUP BY c.id, c.name;

-- xác định khách hàng đã mua sản phẩm giá cao nhất
SELECT c.id, c.`name`, c.email
FROM customers c
JOIN orders o
	ON c.id = o.customer_id
JOIN order_details od
	ON o.id = od.order_id
JOIN products p
	ON od.product_id = p.id
WHERE p.price = (SELECT MAX(price) FROM products);