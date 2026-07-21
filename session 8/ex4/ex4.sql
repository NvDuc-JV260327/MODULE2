USE ss8_db;

CREATE TABLE IF NOT EXISTS orders (
	order_id INT PRIMARY KEY AUTO_INCREMENT,
    order_total FLOAT
);

DELIMITER //

CREATE PROCEDURE sp_check_order_value (
	IN total FLOAT
)
BEGIN
	IF total >= 5000000 THEN
    SELECT 'Đơn hàng giá trị cao' AS messeger;
    ELSE 
    SELECT 'Đơn hàng bình thường' AS messeger;
    END IF;
END //

DELIMITER ;

CALL sp_check_order_value(10000000);