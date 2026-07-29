CREATE DATABASE IF NOT EXISTS ss11_db;
USE ss11_db;

-- tạo bảng accounts
CREATE TABLE IF NOT EXISTS accounts(
    accountID INT PRIMARY KEY AUTO_INCREMENT,
    balance DECIMAL(10,2)
);

-- thêm dữ liệu mẫu vào accounts
INSERT INTO accounts(accountID, balance)
VALUES
	(4, 2000000),
    (5, 0);

-- tạo Stored Procedure transfer_money
DROP PROCEDURE IF EXISTS transfer_money;
DELIMITER //

CREATE PROCEDURE transfer_money(
    IN p_sender_id INT,
    IN p_receiver_id INT,
    IN p_amount DECIMAL(10,2)
)
BEGIN
    DECLARE acc_balance DECIMAL(10,2);

    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        RESIGNAL;
    END;

    START TRANSACTION;

    SELECT balance
    INTO acc_balance
    FROM accounts
    WHERE accountID = p_sender_id;

    IF acc_balance >= p_amount THEN
        UPDATE accounts
        SET balance = balance - p_amount
        WHERE accountID = p_sender_id;

        UPDATE accounts
        SET balance = balance + p_amount
        WHERE accountID = p_receiver_id;
		
        SELECT 'Chuyển tiền thành công!' AS 'Message';
		
        COMMIT;
	ELSE
		SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'so du khong du';
        
        ROLLBACK;
    END IF;
END //

DELIMITER ;

-- thử chuyển tiền
CALL  transfer_money(4, 5, 1500000);