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

-- tạo trigger lưu sau khi có thay đổi quantity trong products
DELIMITER //
CREATE TRIGGER AfterProductUpdate
AFTER UPDATE 
ON products
FOR EACH ROW
BEGIN
    INSERT INTO iventoryChanges (
        productID,
        oldQuantity, 
        newQuantity,
        changeDate
    )
    VALUES (
        OLD.productID,
        OLD.quantity,
        NEW.quantity,
        NOW()
    );
END //
DELIMITER ;

-- kiểm tra
INSERT INTO products(productName, quantity)
VALUES('iphone 15', 5);

UPDATE products
SET quantity = 2
WHERE productID = 1;

SELECT * FROM iventorychanges