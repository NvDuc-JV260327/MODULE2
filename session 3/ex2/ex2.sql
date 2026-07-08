CREATE DATABASE ex2;

USE ex2;

CREATE TABLE books (
	book_id INT PRIMARY KEY AUTO_INCREMENT,
    book_name VARCHAR(50) NOT NULL UNIQUE,
    book_author VARCHAR(50),
    book_price INT NOT NULL,
    book_publicationdate DATE
);

CREATE TABLE readers (
	reader_id INT PRIMARY KEY AUTO_INCREMENT,
    reader_name VARCHAR(50) NOT NULL,
    reader_gender VARCHAR(10),
    reader_dob DATE,
    reader_phone VARCHAR(20),
    reader_email VARCHAR(50),
	reader_address VARCHAR(100)
);

CREATE TABLE borrowings (
	book_id INT,
    reader_id INT,
    FOREIGN KEY (book_id) REFERENCES books(book_id),
    FOREIGN KEY (reader_id) REFERENCES readers(reader_id),
	PRIMARY KEY (book_id, reader_id),
    borrow_quantity INT NOT NULL,
    borrow_date DATE,
    return_date DATE NOT NULL
);

ALTER TABLE borrowings 
	MODIFY borrow_date DATE NOT NULL;