CREATE DATABASE users;
USE users;
CREATE TABLE users(
	`userId` INT PRIMARY KEY,
    `userName` VARCHAR(50) UNIQUE,
    `password` VARCHAR(50) NOT NULL,
    `status` VARCHAR(10) DEFAULT 'ACTIVE',
    CHECK (status IN ('ACTIVE', 'INACTIVE'))
);