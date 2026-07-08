CREATE DATABASE school; 

USE school;

CREATE TABLE classes (
	class_id INT PRIMARY KEY AUTO_INCREMENT,
    class_name VARCHAR(50) NOT NULL UNIQUE
);

CREATE TABLE students (
	student_id INT PRIMARY KEY AUTO_INCREMENT ,
    student_name VARCHAR(50) NOT NULL UNIQUE,
    student_dob DATE NOT NULL,
    student_gender VARCHAR(10) NOT NULL,
    student_phone VARCHAR(15),
    student_email VARCHAR(50),
    class_id INT,
    FOREIGN KEY(class_id) REFERENCES classes(class_id)
);