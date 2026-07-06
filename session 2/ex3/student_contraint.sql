CREATE DATABASE students_contraint;
USE students_contraint;
CREATE TABLE student (
	`studentId` INT PRIMARY KEY,
    `name` VARCHAR(50) NOT NULL,
    `email` VARCHAR(50) UNIQUE,
    `age` INT,
    CHECK (age >= 18)
);