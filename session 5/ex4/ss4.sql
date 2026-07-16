USE ss5;

CREATE TABLE customers (
    customer_id INT PRIMARY KEY AUTO_INCREMENT,
    customer_name VARCHAR(100) NOT NULL
);

CREATE TABLE orders (
    order_id INT PRIMARY KEY AUTO_INCREMENT,
    order_date DATE NOT NULL,
    customer_id INT,
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

CREATE TABLE order_items (
    order_id INT,
    customer_id INT,
    product_name VARCHAR(100) NOT NULL,
    quantity INT NOT NULL,
    price DECIMAL(15,2) NOT NULL,
    PRIMARY KEY (order_id, product_name),
    FOREIGN KEY (order_id) REFERENCES orders(order_id),
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

INSERT INTO customers (customer_name) VALUES
('Nguyen Van A'),
('Tran Thi B'),
('Le Van C');

INSERT INTO orders (order_date, customer_id) VALUES
('2026-07-01', 1),
('2026-07-02', 2),
('2026-07-03', 3);

INSERT INTO order_items (order_id, customer_id, product_name, quantity, price) VALUES
(1, 1, 'Laptop Dell', 1, 25000000),
(1, 1, 'Mouse Logitech', 2, 500000),
(2, 2, 'iPhone 15', 1, 22000000),
(3, 3, 'Ban phim co', 1, 1500000),
(3, 3, 'Tai nghe', 2, 1000000);

-- 1. Hiển thị mã đơn hàng, ngày đặt hàng, tên khách hàng
SELECT
    o.order_id,
    o.order_date,
    c.customer_name
FROM orders o
JOIN customers c
ON o.customer_id = c.customer_id;

-- 2. Hiển thị danh sách sản phẩm trong mỗi đơn hàng
SELECT
    o.order_id,
    oi.product_name,
    oi.quantity,
    oi.price
FROM orders o
JOIN order_items oi
ON o.order_id = oi.order_id
ORDER BY o.order_id;

-- 3. Tính tổng tiền của mỗi đơn hàng
SELECT
    order_id,
    SUM(quantity * price) AS total_amount
FROM order_items
GROUP BY order_id;

-- 4. Hiển thị các đơn hàng có tổng tiền lớn hơn 10.000.000
SELECT
    o.order_id,
    o.order_date,
    c.customer_name,
    SUM(oi.quantity * oi.price) AS total_amount
FROM orders o
JOIN customers c
ON o.customer_id = c.customer_id
JOIN order_items oi
ON o.order_id = oi.order_id
GROUP BY o.order_id, o.order_date, c.customer_name
HAVING SUM(oi.quantity * oi.price) > 10000000;