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

-- thêm dữ liệu vào bảng products
INSERT INTO products (productName, quantity)
VALUES
    ('Iphone 15', 5),
    ('Iphone 16', 15),
    ('Iphone 17', 8),
    ('Iphone 18', 12);

-- Tạo Trigger BeforeProductDelete để kiểm tra 
-- số lượng sản phẩm trước khi xóa
DELIMITER //
CREATE TRIGGER BeforeProductDelete
BEFORE DELETE
ON products
FOR EACH ROW
BEGIN
    IF OLD.quantity > 10 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'không xóa được sản phẩm có số lượng lớn hơn 10!';
    END IF;
END //
DELIMITER ;

-- kiểm tra
DELETE FROM products
WHERE productID = 3;