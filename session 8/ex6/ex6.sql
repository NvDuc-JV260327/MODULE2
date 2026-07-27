CREATE DATABASE IF NOT EXISTS ss8_db;

USE ss8_db;

CREATE TABLE IF NOT EXISTS students (
	id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100),
    avg_score DOUBLE
);

DROP PROCEDURE IF EXISTS sp_classify_student;

DELIMITER //
CREATE PROCEDURE sp_classify_student (
	IN in_avg_score DOUBLE,
    OUT ranking VARCHAR(15)
)
BEGIN
	CASE
		WHEN in_avg_score < 5 THEN SET ranking = 'Yếu';
        WHEN in_avg_score < 6.5 THEN SET ranking = 'Trung bình';
        WHEN in_avg_score < 8 THEN SET ranking = 'Khá';
        ELSE SET ranking = 'Giỏi';
	END CASE;
END //
DELIMITER ;

CALL sp_classify_student(7, @rank);
SELECT @rank AS 'Xếp loại';