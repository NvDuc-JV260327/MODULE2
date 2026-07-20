USE ss7_db;

CREATE TABLE IF NOT EXISTS customers (
	`id` INT PRIMARY KEY AUTO_INCREMENT,
    `name` VARCHAR(100) NOT NULL
);

CREATE TABLE IF NOT EXISTS orders (
	`id` INT PRIMARY KEY AUTO_INCREMENT,
    order_date DATE,
    customer_id INT,
    FOREIGN KEY (customer_id) REFERENCES customers(id)
);

CREATE VIEW v_order_info
AS
SELECT o.id, o.order_date, c.`name`
FROM orders o
JOIN customers c
ON c.id = o.customer_id;
