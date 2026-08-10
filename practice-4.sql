CREATE DATABASE IF NOT EXISTS bank_management_db;
USE bank_management_db;

-- =========================================================
-- SECTION 1: DDL
-- =========================================================

-- QUESTION 1: CREATE TABLE

CREATE TABLE bank_transactions (
    txn_id INT PRIMARY KEY,
    customer_name VARCHAR(50),
    branch_name VARCHAR(50),
    transaction_type VARCHAR(20),
    amount DECIMAL(10,2),
    transaction_date DATE
);

-- QUESTION 2: ALTER TABLE ADD COLUMN

ALTER TABLE bank_transactions
ADD account_no VARCHAR(20);

-- QUESTION 3: ALTER TABLE MODIFY COLUMN

ALTER TABLE bank_transactions
MODIFY customer_name VARCHAR(100);

-- =========================================================
-- SECTION 2: DML
-- =========================================================

-- STEP 1: INSERT SAMPLE DATA

INSERT INTO bank_transactions
(txn_id, customer_name, branch_name, transaction_type, amount, transaction_date)
VALUES
(101, 'Ravi', 'Hyderabad', 'Deposit', 5000, '2024-01-05'),
(102, 'Sita', 'Hyderabad', 'Withdrawal', 2000, '2024-01-06'),
(103, 'Kiran', 'Vijayawada', 'Deposit', 12000, '2024-01-08'),
(104, 'Anil', 'Vizag', 'Deposit', 8000, '2024-01-10'),
(105, 'Priya', 'Hyderabad', 'Withdrawal', 3500, '2024-01-11'),
(106, 'Ramesh', 'Vizag', 'Deposit', 15000, '2024-01-12'),
(107, 'Keerthi', 'Vijayawada', 'Withdrawal', 1000, '2024-01-13'),
(108, 'Rahul', 'Hyderabad', 'Deposit', 9000, '2024-01-14'),
(109, 'Sneha', 'Vizag', 'Withdrawal', 4000, '2024-01-15'),
(110, 'Madhu', 'Vijayawada', 'Deposit', 11000, '2024-01-16');

-- QUESTION 7: INSERT

INSERT INTO bank_transactions
(txn_id, customer_name, branch_name, transaction_type, amount, transaction_date)
VALUES
(111, 'Venu', 'Vizag', 'Deposit', 7000, '2024-01-18');

-- QUESTION 8: UPDATE

UPDATE bank_transactions
SET amount = 5000
WHERE txn_id = 105;

-- QUESTION 9: DELETE

DELETE FROM bank_transactions
WHERE txn_id = 111;

-- QUESTION 10: SELECT

SELECT *
FROM bank_transactions;

-- QUESTION 11: SELECT WITH WHERE

SELECT *
FROM bank_transactions
WHERE transaction_type = 'Deposit';

-- QUESTION 12: SELECT WITH ORDER BY

SELECT *
FROM bank_transactions
ORDER BY amount DESC;

-- =========================================================
-- QUESTION 4: RENAME TABLE
-- =========================================================
-- We perform this at the end because the remaining
-- DML/TCL queries use bank_transactions.

RENAME TABLE bank_transactions
TO customer_transactions;

-- Verify renamed table

SELECT *
FROM customer_transactions;

-- =========================================================
-- QUESTION 5: TRUNCATE TABLE
-- =========================================================
-- WARNING: This deletes all records.
-- Run this only if your teacher asks you to demonstrate TRUNCATE.

-- TRUNCATE TABLE customer_transactions;

-- =========================================================
-- QUESTION 6: DROP TABLE
-- =========================================================
-- Demonstration only.
-- Creates a backup table first so DROP can be executed safely.

CREATE TABLE bank_backup AS
SELECT *
FROM customer_transactions;

DROP TABLE IF EXISTS bank_backup;

-- =========================================================
-- SECTION 3: DCL
-- =========================================================

-- DCL commands require appropriate MySQL privileges.
-- These users must exist before GRANT/REVOKE.

-- Create users if they don't already exist.

CREATE USER IF NOT EXISTS 'Auditor1'@'localhost'
IDENTIFIED BY 'Auditor123';

CREATE USER IF NOT EXISTS 'BranchManager'@'localhost'
IDENTIFIED BY 'Manager123';

-- QUESTION 13: GRANT SELECT

GRANT SELECT
ON bank_management_db.customer_transactions
TO 'Auditor1'@'localhost';

-- QUESTION 14: GRANT ALL PRIVILEGES

GRANT ALL PRIVILEGES
ON bank_management_db.customer_transactions
TO 'BranchManager'@'localhost';

-- QUESTION 15: REVOKE SELECT

REVOKE SELECT
ON bank_management_db.customer_transactions
FROM 'Auditor1'@'localhost';

-- QUESTION 16: REVOKE ALL

REVOKE ALL PRIVILEGES
ON bank_management_db.customer_transactions
FROM 'BranchManager'@'localhost';

-- =========================================================
-- SECTION 4: TCL
-- =========================================================

-- QUESTION 17: COMMIT

START TRANSACTION;

UPDATE customer_transactions
SET amount = 6000
WHERE txn_id = 101;

COMMIT;

-- Verify

SELECT *
FROM customer_transactions
WHERE txn_id = 101;

-- QUESTION 18: SAVEPOINT

START TRANSACTION;

SAVEPOINT Before_Update;

-- QUESTION 19: ROLLBACK TO SAVEPOINT

UPDATE customer_transactions
SET amount = 99999
WHERE txn_id = 102;

ROLLBACK TO Before_Update;

-- Verify that the incorrect update was undone

SELECT *
FROM customer_transactions
WHERE txn_id = 102;

COMMIT;

-- =========================================================
-- QUESTION 20: FULL TCL EXAMPLE
-- =========================================================

START TRANSACTION;

UPDATE customer_transactions
SET amount = 7000
WHERE txn_id = 101;

SAVEPOINT SP1;

UPDATE customer_transactions
SET amount = 9000
WHERE txn_id = 102;

ROLLBACK TO SP1;

COMMIT;

-- Final verification

SELECT *
FROM customer_transactions
WHERE txn_id IN (101, 102);