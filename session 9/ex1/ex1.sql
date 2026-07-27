CREATE DATABASE ss9_db;

USE ss9_db;

CREATE TABLE IF NOT EXISTS customers (
    customer_id INT PRIMARY KEY AUTO_INCREMENT,
    customer_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) NOT NULL,
    phone VARCHAR(15) NOT NULL,
    address VARCHAR(255) NOT NULL 
);

INSERT INTO customers (customer_name, email, phone, address) 
VALUES
	('Alice', 'alice@example.com', '1234567890', '123 Main St'),
	('Bob', 'bob@example.com', '1234567891', '456 Elm St'),
	('Carol', 'carol@example.com', '1234567892', '789 Oak St'),
	('David', 'david@example.com', '1234567893', '135 Pine St'),
	('Eva', 'eva@example.com', '1234567894', '246 Maple St'),
	('Frank', 'frank@example.com', '1234567895', '369 Cedar St'),
	('Grace', 'grace@example.com', '1234567896', '159 Birch St'),
	('Hannah', 'hannah@example.com', '1234567897', '753 Willow St'),
	('Ian', 'ian@example.com', '1234567898', '852 Ash St'),
	('Jane', 'jane@example.com', '1234567899', '951 Cherry St'),
	('Ken', 'ken@example.com', '1234567800', '258 Palm St'),
	('Liam', 'liam@example.com', '1234567801', '369 Spruce St'),
	('Mia', 'mia@example.com', '1234567802', '147 Fir St'),
	('Noah', 'noah@example.com', '1234567803', '258 Larch St'),
	('Olivia', 'olivia@example.com', '1234567804', '369 Redwood St'),
	('Paul', 'paul@example.com', '1234567805', '654 Poplar St'),
	('Quinn', 'quinn@example.com', '1234567806', '987 Magnolia St'),
	('Rita', 'rita@example.com', '1234567807', '321 Willow St'),
	('Sam', 'sam@example.com', '1234567808', '654 Hickory St'),
	('Tina', 'tina@example.com', '1234567809', '987 Acacia St');

-- tạo unique index cho cột email
CREATE UNIQUE INDEX index_customer_email
ON customers(email);

-- tạo index thường cho cột phone
CREATE INDEX index_customer_phone
ON customers(phone);