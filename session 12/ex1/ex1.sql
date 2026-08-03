CREATE DATABASE IF NOT EXISTS ecommerce;
USE ecommerce;

-- 1. Bảng customers (Khách hàng)
CREATE TABLE customers (
    customer_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(255) NOT NULL,
    email VARCHAR(255) UNIQUE NOT NULL,
    phone VARCHAR(20),
    address TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- 2. Bảng orders (Đơn hàng)
CREATE TABLE orders (
    order_id INT PRIMARY KEY AUTO_INCREMENT,
    customer_id INT NOT NULL,
    order_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    total_amount DECIMAL(10,2) DEFAULT 0,
    status ENUM('Pending', 'Completed', 'Cancelled') DEFAULT 'Pending',
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id) ON DELETE CASCADE
);

-- 3. Bảng products (Sản phẩm)
CREATE TABLE products (
    product_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(255) NOT NULL,
    price DECIMAL(10,2) NOT NULL,
    description TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- 4. Bảng order_items (Chi tiết đơn hàng)
CREATE TABLE order_items (
    order_item_id INT PRIMARY KEY AUTO_INCREMENT,
    order_id INT NOT NULL,
    product_id INT NOT NULL,
    quantity INT NOT NULL CHECK (quantity > 0),
    price DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (order_id) REFERENCES orders(order_id) ON DELETE CASCADE,
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);

-- 5. Bảng inventory (Kho hàng)
CREATE TABLE inventory (
    product_id INT PRIMARY KEY,
    stock_quantity INT NOT NULL CHECK (stock_quantity >= 0),
    last_updated TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (product_id) REFERENCES products(product_id) ON DELETE CASCADE
);

-- 6. Bảng payments (Thanh toán)
CREATE TABLE payments (
    payment_id INT PRIMARY KEY AUTO_INCREMENT,
    order_id INT NOT NULL,
    payment_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    amount DECIMAL(10,2) NOT NULL,
    payment_method ENUM('Credit Card', 'PayPal', 'Bank Transfer', 'Cash') NOT NULL,
    status ENUM('Pending', 'Completed', 'Failed') DEFAULT 'Pending',
    FOREIGN KEY (order_id) REFERENCES orders(order_id) ON DELETE CASCADE
);

/*Tạo Trigger kiểm tra số lượng tồn kho trước khi thêm 
sản phẩm vào order_items. Nếu không đủ, báo lỗi SQLSTATE '45000'.*/
DELIMITER //
CREATE TRIGGER order_item_before_insert
BEFORE INSERT
ON order_items
FOR EACH ROW

BEGIN
    DECLARE stock INT;
    SELECT stock_quantity
    INTO stock
    FROM inventory
    WHERE product_id = NEW.product_id;

    IF NEW.quantity > stock THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Số lượng hàng không đủ';
    END IF;
END //
DELIMITER ;

/*Tạo Trigger cập nhật total_amount trong bảng orders sau khi 
thêm một sản phẩm mới vào order_items.*/
DELIMITER //
CREATE TRIGGER order_item_after_insert
AFTER INSERT
ON order_items
FOR EACH ROW
BEGIN
    DECLARE product_price DECIMAL(10, 2);

    SELECT price
    INTO product_price
    FROM products
    WHERE product_id = NEW.product_id;

    UPDATE orders
    SET total_amount = total_amount + product_price * NEW.quantity
    WHERE order_id = NEW.order_id;
END //
DELIMITER ;

/*Tạo Trigger kiểm tra số lượng tồn kho trước khi cập nhật 
số lượng sản phẩm trong order_items.*/
DELIMITER //
CREATE TRIGGER order_items_quantity_before_update
BEFORE UPDATE
ON order_items
FOR EACH ROW
BEGIN
    DECLARE stock INT;

    SELECT stock_quantity
    INTO stock
    FROM inventory
    WHERE product_id = NEW.product_id;

    IF NEW.quantity > stock THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Số lượng sản phẩm không đủ';
    END IF;
END //
DELIMITER ;

/*Tạo Trigger cập nhật lại total_amount trong bảng orders khi 
số lượng hoặc giá của một sản phẩm trong order_items thay đổi*/
DELIMITER //
CREATE TRIGGER order_update_total_amount
AFTER UPDATE
ON order_items
FOR EACH ROW
BEGIN
   IF NEW.quantity <> OLD.quantity OR NEW.price <> OLD.price THEN
        UPDATE orders o
        SET total_amount = (
            SELECT SUM(od.quantity * od.price)
            FROM order_items od
            WHERE o.order_id = od.order_id
        )
        WHERE o.order_id = NEW.order_id;
    END IF;
END //
DELIMITER ;

/*Tạo Trigger ngăn chặn việc xóa một đơn hàng có trạng thái 
Completed trong bảng orders */
DELIMITER //
CREATE TRIGGER order_before_delete
BEFORE DELETE
ON orders
FOR EACH ROW
BEGIN
    IF OLD.status = 'Completed' THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'không thể xóa đơn hàng đã hoàn thành';
    END IF;
END //
DELIMITER ;

/* Tạo Trigger hoàn trả số lượng sản phẩm vào kho (inventory) 
sau khi một sản phẩm trong order_items bị xóa */
DELIMITER //
CREATE TRIGGER order_after_delete
AFTER DELETE
ON order_items
FOR EACH ROW
BEGIN
    UPDATE inventory
    SET stock_quantity = stock_quantity + OLD.quantity
    WHERE product_id = OLD.product_id;
END //
DELIMITER ;