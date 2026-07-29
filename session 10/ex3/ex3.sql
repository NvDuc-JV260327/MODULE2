CREATE DATABASE IF NOT EXISTS ss10_db;

USE ss10_db;

-- Tạo bảng products
CREATE TABLE IF NOT EXISTS products (
    productID INT PRIMARY KEY AUTO_INCREMENT,
    productName VARCHAR(100),
    quantity INT
);

-- tạo bảng iventoryChanges
CREATE TABLE IF NOT EXISTS iventoryChanges (
    changeID INT PRIMARY KEY AUTO_INCREMENT,
    productID INT NOT NULL,
    oldQuantity INT,
    newQuantity INT,
    changeDate DATE,
    FOREIGN KEY (productID) REFERENCES products(productID)
);

-- Tạo Trigger BeforeInsertProduct để kiểm tra xem 
-- số lượng sản phẩm thêm mới vào có < 0 hay không . 
-- Nếu quantity < 0 thì tạo ra một lỗi và ngăn cản 
-- việc chèn sản phẩm 
DELIMITER //
CREATE TRIGGER BeforeInsertProduct
BEFORE INSERT
ON products
FOR EACH ROW
BEGIN
    IF NEW.quantity < 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Quantity cannot be less than 0';
    END IF;
END //
DELIMITER ;

-- kiểm tra trigger
INSERT INTO products(productName, quantity)
VALUES('iphone', -1);