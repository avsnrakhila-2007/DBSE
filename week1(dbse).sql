CREATE DATABASE IF NOT EXISTS bookflow_db;
USE bookflow_db;
CREATE TABLE books (
    book_id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    isbn VARCHAR(13) NOT NULL UNIQUE,
    published_year INT,
    CONSTRAINT chk_published_year CHECK (published_year < 2027)
);
CREATE TABLE members (
    member_id INT AUTO_INCREMENT PRIMARY KEY,
    full_name VARCHAR(100) NOT NULL,
    email VARCHAR(150) NOT NULL UNIQUE
);
DESCRIBE books;

DESCRIBE members;
INSERT INTO books (title, isbn, published_year) VALUES
('Introduction to Database Systems', '9780000000001', 2020),
('Computer Networks', '9780000000002', 2021),
('Operating System Concepts', '9780000000003', 2022);
INSERT INTO members (full_name, email) VALUES
('Akhila', 'yourname@example.com'),
('sushma', 'teammate1@example.com'),
('Aswitha', 'teammate2@example.com');
SELECT * FROM books;
SELECT * FROM members;
INSERT INTO books (title, isbn, published_year)
VALUES ('Duplicate Book', '9780000000001', 2023);
INSERT INTO books (title, isbn, published_year)
VALUES (NULL, '9780000000004', 2023);
INSERT INTO books (title, isbn, published_year)
VALUES ('Future Book', '9780000000005', 2030);
INSERT INTO members (full_name, email)
VALUES ('Duplicate Member', 'yourname@example.com');
SELECT * FROM books;

SELECT * FROM members;