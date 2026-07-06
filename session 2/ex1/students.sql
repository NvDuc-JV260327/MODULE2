CREATE DATABASE students;
USE students;
CREATE TABLE student (
	`studentId` INT PRIMARY KEY,
    `name` VARCHAR(50),
    `dob` DATE,
    `gender` VARCHAR(10)
);