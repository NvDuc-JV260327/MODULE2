CREATE DATABASE IF NOT EXISTS ss11_db;

USE ss11_db;

-- tạo bảng accounts
CREATE TABLE IF NOT EXISTS accounts(
    accountID INT PRIMARY KEY AUTO_INCREMENT,
    balance DECIMAL(10,2)
);

-- tạo bảng transactions 
CREATE TABLE IF NOT EXISTS transactions(
    transaction_id INT PRIMARY KEY AUTO_INCREMENT,
    account_id INT,
    amount DECIMAL(10, 2),
    log_message VARCHAR(100),
    transaction_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (account_id) REFERENCES accounts(accountID)
);

DELIMITER //
CREATE PROCEDURE deposit_with_logging(p_account_id INT, p_amount DECIMAL(10, 2))
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
    END;

    START TRANSACTION;
    UPDATE accounts
    SET balance = balance + p_amount
    WHERE accountID = p_account_id;

    INSERT INTO transactions(account_id, amount, log_message)
    VALUES(p_account_id, p_amount, 'Nạp tiền vào tài khoản');
    COMMIT;
END //
DELIMITER ;

-- thử nạp 1000000 vào tk id = 3
CALL deposit_with_logging(3, 1000000);

-- kiểm tra
SELECT * FROM accounts
WHERE accountID = 3;

SELECT * FROM transactions;