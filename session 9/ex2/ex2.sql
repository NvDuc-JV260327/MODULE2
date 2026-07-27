CREATE DATABASE IF NOT EXISTS ss9_db;

USE ss9_db;

-- tạo view
CREATE VIEW view_customer_contact 
AS
SELECT customer_id, customer_name, email, phone
FROM customers;

-- kiểm tra view
SELECT * FROM view_customer_contact;