CREATE DATABASE IF NOT EXISTS ss9_db;

USE ss9_db;

DROP PROCEDURE IF EXISTS add_order;

-- tạo procedure
DELIMITER //
CREATE PROCEDURE add_order (
	IN in_customer_id INT,
    IN in_product_id INT,
    IN in_quantity INT,
    OUT message VARCHAR(100)
)
BEGIN
	IF in_quantity > (SELECT stock FROM products WHERE product_id = in_product_id) 
    THEN 
		SET message = 'Không đủ số lượng để đặt hàng';
    ELSE 
		UPDATE products
		SET stock = stock - in_quantity
        WHERE product_id = in_product_id;
        SET message = 'Thêm đơn hàng thành công';
	END IF;
END //
DELIMITER ;

-- gọi stored procedure
CALL add_order(1, 1, 10, @message);
SELECT @message;