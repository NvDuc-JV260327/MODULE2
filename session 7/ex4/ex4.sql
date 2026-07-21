USE ss7_db

CREATE TABLE IF NOT EXISTS products (
    `id` INT PRIMARY KEY AUTO_INCREMENT,
    `name` VARCHAR(100) NOT NULL,
    category VARCHAR(100),
    price FLOAT
);

CREATE INDEX inx_category_price 
ON products(category, price);