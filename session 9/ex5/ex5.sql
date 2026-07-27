CREATE DATABASE IF NOT EXISTS ss9_db;

USE ss9_db;

-- tạo bảng orders
CREATE TABLE IF NOT EXISTS orders (
	order_id INT PRIMARY KEY AUTO_INCREMENT,
    customer_id INT,
    product_id INT,
    quantity INT NOT NULL CHECK(quantity > 0),
    total_amount FLOAT NOT NULL CHECK(total_amount > 0),
    status ENUM('Pending', 'Success', 'Cancel') DEFAULT 'Pending',
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);

-- thêm 20 bản ghi
INSERT INTO orders
(customer_id, product_id, quantity, total_amount, status)
VALUES
(1, 3, 2, 4000000.00, 'Success'),
(1, 7, 1, 1200000.00, 'Success'),
(2, 5, 2, 5000000.00, 'Pending'),
(3, 1, 5, 2500000.00, 'Success'),
(4, 17, 1, 5555555.00, 'Success'),
(4, 8, 2, 2000000.00, 'Pending'),
(5, 12, 3, 3300000.00, 'Success'),
(6, 6, 2, 1600000.00, 'Success'),
(6, 9, 1, 1750000.00, 'Success'),
(6, 20, 2, 4000000.00, 'Pending'),
(7, 11, 4, 1800000.00, 'Cancel'),
(8, 14, 2, 1999999.98, 'Success'),
(8, 18, 1, 1700000.00, 'Success'),
(9, 13, 6, 3000000.00, 'Pending'),
(10, 2, 2, 3000000.00, 'Success'),
(10, 5, 1, 2500000.00, 'Success'),
(1, 15, 1, 3500000.00, 'Pending'),
(2, 10, 3, 2850000.00, 'Cancel'),
(5, 19, 2, 1700000.00, 'Success'),
(7, 4, 5, 1500000.00, 'Pending');
    
-- tạo view hiển thị thông tin khách hàng và tổng số tiền họ đã chi tiêu
-- customer_id, customer_name, total_orders (tổng số đơn hàng), total_spent (tổng số tiền đã chi)
CREATE VIEW view_customer_spending
AS
SELECT 
	c.customer_id, 
	c.customer_name, 
	COUNT(o.order_id) AS total_orders,
	SUM(o.total_amount) AS total_spent
FROM customers c
LEFT JOIN orders o
ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.customer_name;

-- kiểm tra view
SELECT * FROM view_customer_spending;