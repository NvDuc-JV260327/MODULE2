CREATE DATABASE IF NOT EXISTS ss10_db;

USE ss10_db;

CREATE TABLE IF NOT EXISTS orders(
    id INT PRIMARY KEY AUTO_INCREMENT,
    customer_name VARCHAR(100),
    total_amount DECIMAL(10, 2),
    order_date DATETIME,
    `status` VARCHAR(50)
);

CREATE TABLE order_logs(
    log_id INT PRIMARY KEY AUTO_INCREMENT,
    order_id INT,
    old_status VARCHAR(50),
    new_status VARCHAR(50),
    log_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (order_id) REFERENCES orders(id)
);

-- tạo trigger lưu thông tin khi có thay đổi trạng thái của bảng orders vào bảng order_logs
DELIMITER //
CREATE TRIGGER after_order_status_update
AFTER UPDATE
ON orders
FOR EACH ROW
BEGIN
    IF NEW.status <> OLD.status THEN
        INSERT INTO order_logs(order_id, old_status, new_status)
        VALUES(
            NEW.id,
            OLD.status,
            NEW.status
            );
    END IF;
END //
DELIMITER ;

-- kiểm tra trigger
INSERT INTO orders(customer_name, total_amount, order_date, `status`)
VALUES(
    'Nva', 3000000, NOW(), 'Pending'
);

-- kiểm tra
UPDATE orders
SET status = 'Shipping'
WHERE id = 1;

SELECT * FROM orders;
SELECT * FROM order_logs;
