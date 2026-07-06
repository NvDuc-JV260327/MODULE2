CREATE DATABASE products;
USE products;
CREATE TABLE product (
	`id` INT PRIMARY KEY,
    `name` VARCHAR(50),
    `price` INT,
    `inventory` INT
); 