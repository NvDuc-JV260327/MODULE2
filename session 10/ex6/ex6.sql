CREATE DATABASE IF NOT EXISTS ss10_db;

USE ss10_db;

-- Tạo bảng products
CREATE TABLE IF NOT EXISTS products (
    productID INT PRIMARY KEY AUTO_INCREMENT,
    productName VARCHAR(100),
    quantity INT
);

CREATE TABLE IF NOT EXISTS cart_items(
    id INT PRIMARY KEY AUTO_INCREMENT,
    product_id INT,
    quantity INT,
    FOREIGN KEY (product_id) REFERENCES products(productID)
);

DELIMITER //
CREATE TRIGGER before_cart_add
BEFORE INSERT
ON cart_items
FOR EACH ROW
BEGIN
    DECLARE stock_quantity INT;
    SELECT quantity
    INTO stock_quantity
    FROM products
    WHERE productID = NEW.product_id;
    IF NEW.quantity > stock_quantity THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Số lượng hàng trong kho không đủ!';
    END IF;
END //
DELIMITER ;

-- thêm sản phẩm
INSERT INTO products(productName, quantity)
VALUES('iphone 15', 5);

-- -- thêm sản phẩm vào giỏ lỗi
INSERT INTO cart_items(product_id, quantity)
VALUES(1, 10);

-- -- thêm sản phẩm vào giỏ ok
INSERT INTO cart_items(product_id, quantity)
VALUES(1, 2);