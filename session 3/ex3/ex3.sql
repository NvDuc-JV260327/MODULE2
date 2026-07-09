CREATE DATABASE ex3;

USE ex3;

CREATE TABLE orders (
	order_id INT PRIMARY KEY AUTO_INCREMENT,
    order_name VARCHAR(50) NOT NULL UNIQUE,
    order_quantity INT NOT NULL CHECK (order_quantity >= 0),
    order_date DATE
);

CREATE TABLE products (
	product_id INT PRIMARY KEY AUTO_INCREMENT,
    product_name VARCHAR(50) NOT NULL UNIQUE,
    product_price FLOAT NOT NULL,
    product_status VARCHAR(15) DEFAULT 'IN STOCK'
);

CREATE TABLE order_items (
	order_id INT,
    product_id INT,
    payment FLOAT NOT NULL,
    PRIMARY KEY (order_id, product_id),
    FOREIGN KEY (order_id) REFERENCES orders(order_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);