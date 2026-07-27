CREATE DATABASE IF NOT EXISTS ss9_db;

USE ss9_db;

DELIMITER //

CREATE PROCEDURE insert_customer(
    IN in_customer_name VARCHAR(100),
    IN in_email VARCHAR(100),
    IN in_phone VARCHAR(20),
    IN in_address VARCHAR(255)
)
BEGIN
    INSERT INTO customers(customer_name, email, phone, address)
    VALUES(in_customer_name, in_email, in_phone, in_address);
    
    SELECT 'thêm mới khách hàng thành công!' AS messeger;
END //

DELIMITER ;

-- thêm mới 1 khách hàng
CALL insert_customer ('nva', 'a@gmail.com', '0123456', 'adadadad');

-- kiểm tra
SELECT * FROM customers;