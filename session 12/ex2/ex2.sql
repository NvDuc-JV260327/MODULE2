CREATE DATABASE IF NOT EXISTS ss12_db;
USE ss12_db;

-- Tạo Stored Procedure sp_create_order
-- đầu vào: customer_id, product_id, quantity, và price.
DELIMITER //
CREATE PROCEDURE sp_create_order(
    IN in_customer_id INT,
    IN in_product_id INT,
    IN in_quantity INT,
    IN in_price DECIMAL(10, 2)
)
BEGIN
    DECLARE stock INT;
    DECLARE last_order_id INT;

    DECLARE EXIT HANDLER FOR SQLEXCEPTION
        BEGIN
            ROLLBACK;
            RESIGNAL;
        END;

    START TRANSACTION;

    SELECT stock_quantity
    INTO stock
    FROM inventory
    WHERE product_id = in_product_id;

    IF in_quantity > stock THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'số lượng hàng không đủ';
    ELSE
        INSERT INTO orders(customer_id)
        VALUES(in_customer_id);

        SET last_order_id = LAST_INSERT_ID();

        INSERT INTO order_items(order_id, product_id, quantity, price)
        VALUES(last_order_id, in_product_id, in_quantity, in_price);

        UPDATE inventory
        SET stock_quantity = stock_quantity - in_quantity
        WHERE product_id = in_product_id;

        COMMIT;
    END IF;
END //
DELIMITER ;

-- tạo Stored Procedure sp_pay_order
-- đầu vào: order_id và payment_method
DELIMITER //
CREATE PROCEDURE sp_pay_order(
    IN in_order_id INT, 
    IN in_payment_method VARCHAR(20)
    )
BEGIN
    DECLARE order_amount DECIMAL(10, 2);
    DECLARE order_status VARCHAR(20);

    DECLARE EXIT HANDLER FOR SQLEXCEPTION
        BEGIN
            ROLLBACK;
            RESIGNAL;
        END;
    
    START TRANSACTION;

    SELECT total_amount, status
    INTO order_amount, order_status
    FROM orders
    WHERE order_id = in_order_id;

    IF order_status <> 'Pending' THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'trạng thái không phải Pending';
    ELSE
        INSERT INTO payments(order_id, amount, payment_method)
        VALUES(in_order_id, order_amount, in_payment_method);

        UPDATE orders
        SET status = 'Completed'
        WHERE order_id = in_order_id;

        COMMIT;
    END IF;
END //
DELIMITER ;

-- Stored Procedure sp_cancel_order
-- đầu vào: order_id
DELIMITER //
CREATE PROCEDURE sp_cancel_order(IN cancel_order_id INT)
BEGIN
    DECLARE cancel_status VARCHAR(20);
    DECLARE cancel_quantity INT;
    DECLARE cancel_product_id INT;

    DECLARE EXIT HANDLER FOR SQLEXCEPTION
        BEGIN
            ROLLBACK;
            RESIGNAL;
        END;
    
    START TRANSACTION;

    SELECT status
    INTO cancel_status
    FROM orders
    WHERE order_id = cancel_order_id;

    IF cancel_status <> 'Pending' THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'STATUS ERROR';

    ELSE    
        SELECT product_id, quantity
        INTO cancel_product_id, cancel_quantity
        FROM order_items
        WHERE order_id = cancel_order_id;

        UPDATE inventory
        SET stock_quantity = stock_quantity + cancel_quantity
        WHERE product_id = cancel_product_id;

        DELETE FROM order_items
        WHERE order_id = cancel_order_id;

        UPDATE orders
        SET status = 'Cancelled'
        WHERE order_id = cancel_order_id;

        COMMIT;

    END IF;
END //
DELIMITER ;

-- xóa tất cả procedure đã tạo
DROP PROCEDURE sp_create_order;
DROP PROCEDURE sp_pay_order;
DROP PROCEDURE sp_cancel_order;
