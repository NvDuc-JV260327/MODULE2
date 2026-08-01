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

-- Viết Stored Procedure place_order 
-- để xử lý đơn đặt hàng
DELIMITER //
CREATE PROCEDURE place_order(
    IN in_product_id INT,
    IN in_quantity INT
)
BEGIN
    DECLARE stock_quantity INT;
    DECLARE order_total_price DECIMAL(12, 2);

    DECLARE EXIT HANDLER FOR SQLEXCEPTION
        BEGIN
            ROLLBACK;
            RESIGNAL;
        END;

    START TRANSACTION;

    SELECT stock
    INTO stock_quantity
    FROM products
    WHERE id = in_product_id;

    IF stock_quantity >= in_quantity THEN      
        UPDATE products
        SET stock = stock - in_quantity
        WHERE id = in_product_id;

        SELECT price * in_quantity
        INTO order_total_price
        FROM products
        WHERE id = in_product_id;

        INSERT INTO orders(product_id, quantity, total_price)
        VALUES(in_product_id, in_quantity, order_total_price);

        COMMIT;

        SELECT 'Đặt hàng thành công !' AS 'Message';

    ELSE
        ROLLBACK;

        SELECT 'Số lượng hàng không đủ!' AS 'Message';

    END IF;
END //
DELIMITER ;

-- thử đặt số thất bại
CALL place_order(1, 20);

-- thử đặt thành công
CALL place_order(1, 2);

SELECT * FROM products;
SELECT * FROM orders;
