CREATE DATABASE IF NOT EXISTS ss11_db;
USE ss11_db;

-- tạo bảng products
CREATE TABLE IF NOT EXISTS products(
    id INT PRIMARY KEY AUTO_INCREMENT,
    product_name VARCHAR(100),
    price DECIMAL(10, 2),
    stock INT
);

-- tạo bảng orders
CREATE TABLE IF NOT EXISTS orders(
    id INT PRIMARY KEY AUTO_INCREMENT,
    product_id INT,
    quantity INT,
    total_price DECIMAL(12, 2),
    order_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (product_id) REFERENCES products(id)
);

-- Thêm 1 sản phẩm: "Laptop Gaming" giá 20.000.000, tồn kho 10 chiếc
INSERT INTO products(product_name, price, stock)
VALUES('Laptop Gaming', 20000000, 10);

-- cập nhật thêm cột trạng thái cho bảng orders
ALTER TABLE orders
ADD COLUMN status ENUM('pending', 'completed', 'cancelled') DEFAULT 'pending';

-- Viết Stored Procedure cancel_order để hủy đơn hàng
DELIMITER //
CREATE PROCEDURE cancel_order(IN p_order_id INT)
BEGIN
    DECLARE order_id_exists INT;
    DECLARE order_status ENUM('pending', 'completed', 'cancelled');
    DECLARE cancel_product_id INT;
    DECLARE cancel_quantity INT;

    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        RESIGNAL;
    END;

    START TRANSACTION;

    SELECT EXISTS(
        SELECT 1
        FROM orders
        WHERE id = p_order_id
    )
    INTO order_id_exists;

    IF order_id_exists = 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Đơn hàng không tồn tại';
    ELSE
        SELECT status
        INTO order_status
        FROM orders
        WHERE id = p_order_id;

        IF order_status = 'cancelled' THEN
            SELECT 'Trạng thái đơn hàng đã được cập nhật'
            AS 'Message';
        ELSE
            SELECT product_id
            INTO cancel_product_id
            FROM orders
            WHERE id = p_order_id;

            SELECT quantity
            INTO cancel_quantity
            FROM orders
            WHERE id = p_order_id;

            UPDATE products
            SET stock = stock + cancel_quantity
            WHERE id = cancel_product_id;

            UPDATE orders
            SET status = 'cancelled'
            WHERE id = p_order_id;

            COMMIT;
            
            SELECT 'Hủy đơn hàng thành công. Đã hoàn tồn kho!'
            AS 'Message';
        END IF;
    END IF;
END //
DELIMITER ;

-- hủy đơn hàng 2 lap top
CALL cancel_order(1);