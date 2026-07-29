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
    (100000.00),
    (300000.00),
    (5000000.00),
    (750000.25),
    (1000000.00),
    (1200500.75),
    (1500000.00),
    (2000000.50),
    (3000000.00),
    (5000000.00);

-- tạo Stored Procedure
DELIMITER //
CREATE PROCEDURE withdraw_money(
    IN p_account_id INT,
    IN p_amount DECIMAL(10, 2)
)
BEGIN
-- tạo biến để kiểm tra số dư sau thay đổi
    DECLARE currBalance DECIMAL(10, 2);
-- bắt đầu transaction   
    START TRANSACTION;
    UPDATE accounts
    SET balance = balance - p_amount
    WHERE accountID = p_account_id;
    
    SELECT balance
    INTO currBalance
    FROM accounts
    WHERE accountID = p_account_id;

    IF currBalance < 0 THEN
        SELECT 'Số dư không đủ' AS 'Message';
        ROLLBACK;
    ELSE
        SELECT 'Rút tiền thành công' AS 'Message';
        COMMIT;
    END IF;
END //
DELIMITER ;

-- test rút tiền thành công
CALL withdraw_money(2, 1000);

-- test rút tiền thất bại
CALL withdraw_money(2, 500000);