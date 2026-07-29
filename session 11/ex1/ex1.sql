CREATE DATABASE IF NOT EXISTS ss11_db;

USE ss11_db;

-- tạo bảng accounts
CREATE TABLE IF NOT EXISTS accounts(
    accountID INT PRIMARY KEY AUTO_INCREMENT,
    balance DECIMAL(10,2)
);

-- thêm 10 tài khoản vào bảng accounts
INSERT INTO accounts(balance)
VALUES
    (1000.00),
    (2500.50),
    (5000.00),
    (7500.25),
    (10000.00),
    (12500.75),
    (15000.00),
    (20000.50),
    (30000.00),
    (50000.00);

-- bắt đầu transaction
START TRANSACTION;

-- Cộng thêm 1.000.000 VNĐ vào tài khoản có account_id = 1
UPDATE accounts
SET balance = balance + 1000000
WHERE accountID = 1;
-- nếu k có lỗi, commit
COMMIT;

-- kiểm tra số dư sau giao dịch
SELECT * FROM accounts
WHERE accountID = 1;