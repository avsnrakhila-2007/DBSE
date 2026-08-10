CREATE DATABASE IF NOT EXISTS hospital_db;
USE hospital_db;

-- =========================================================
-- STEP 1: CREATE PHYSICIAN TABLE
-- =========================================================

CREATE TABLE physician (
    employeeid INT PRIMARY KEY,
    name VARCHAR(100),
    position VARCHAR(100),
    ssn VARCHAR(20)
);

-- =========================================================
-- STEP 2: INSERT DATA INTO PHYSICIAN
-- =========================================================

INSERT INTO physician VALUES
(1, 'John Dorian', 'Staff Internist', '111111111'),
(2, 'Elliot Reid', 'Attending Physician', '222222222'),
(3, 'Christopher Turk', 'Surgical Attending Physician', '333333333'),
(4, 'Percival Cox', 'Senior Attending Physician', '444444444'),
(5, 'Bob Kelso', 'Head Chief of Medicine', '555555555'),
(6, 'Todd Quinlan', 'Surgical Attending Physician', '666666666'),
(7, 'John Wen', 'Surgical Attending Physician', '777777777'),
(8, 'Keith Dudemeister', 'MD Resident', '888888888'),
(9, 'Molly Clock', 'Attending Psychiatrist', '999999999');

-- =========================================================
-- STEP 3: CREATE DEPARTMENT TABLE
-- =========================================================

CREATE TABLE department (
    departmentid INT PRIMARY KEY,
    name VARCHAR(100),
    head INT
);

-- =========================================================
-- STEP 4: INSERT DATA INTO DEPARTMENT
-- =========================================================

INSERT INTO department VALUES
(1, 'General Medicine', 4),
(2, 'Surgery', 7),
(3, 'Psychiatry', 9);

-- =========================================================
-- QUESTION 1: INNER JOIN
-- Show each department and its department head
-- =========================================================

SELECT d.name AS Department,
       p.name AS Head_Physician
FROM department d
JOIN physician p
ON d.head = p.employeeid;

-- =========================================================
-- QUESTION 2: WHERE CLAUSE
-- Find Surgical Attending Physicians
-- =========================================================

SELECT *
FROM physician
WHERE position = 'Surgical Attending Physician';

-- =========================================================
-- QUESTION 3: WHERE + LIKE
-- Find physicians whose names start with John
-- =========================================================

SELECT *
FROM physician
WHERE name LIKE 'John%';

-- =========================================================
-- QUESTION 4: COUNT()
-- Find total number of physicians
-- =========================================================

SELECT COUNT(*) AS Total_Physicians
FROM physician;

-- =========================================================
-- QUESTION 5: COUNT DISTINCT
-- Find number of different job positions
-- =========================================================

SELECT COUNT(DISTINCT position) AS Different_Positions
FROM physician;

-- =========================================================
-- QUESTION 6: GROUP BY
-- Count physicians in each position
-- =========================================================

SELECT position,
       COUNT(*) AS Total_Employees
FROM physician
GROUP BY position;

-- =========================================================
-- QUESTION 7: GROUP BY + HAVING
-- Find positions occupied by more than one physician
-- =========================================================

SELECT position,
       COUNT(*) AS Total_Employees
FROM physician
GROUP BY position
HAVING COUNT(*) > 1;

-- =========================================================
-- QUESTION 8: ORDER BY
-- Display physicians alphabetically
-- =========================================================

SELECT *
FROM physician
ORDER BY name ASC;

-- =========================================================
-- QUESTION 9: ORDER BY DESC
-- Display physicians by employee ID from highest to lowest
-- =========================================================

SELECT *
FROM physician
ORDER BY employeeid DESC;

-- =========================================================
-- QUESTION 10: WHERE + IN
-- Find department heads
-- =========================================================

SELECT *
FROM physician
WHERE employeeid IN
(
    SELECT head
    FROM department
);

-- =========================================================
-- QUESTION 11: SUBQUERY
-- Find physicians who are not department heads
-- =========================================================

SELECT *
FROM physician
WHERE employeeid NOT IN
(
    SELECT head
    FROM department
);

-- =========================================================
-- QUESTION 12: GROUP BY + ORDER BY
-- Rank positions by number of employees
-- =========================================================

SELECT position,
       COUNT(*) AS Total_Employees
FROM physician
GROUP BY position
ORDER BY Total_Employees DESC;

-- =========================================================
-- QUESTION 13: WHERE + LIKE
-- Find physicians whose position contains Attending
-- =========================================================

SELECT *
FROM physician
WHERE position LIKE '%Attending%';

-- =========================================================
-- QUESTION 14: JOIN + WHERE
-- Find who heads the Surgery department
-- =========================================================

SELECT p.name
FROM physician p
JOIN department d
ON p.employeeid = d.head
WHERE d.name = 'Surgery';

-- =========================================================
-- QUESTION 15: JOIN + ORDER BY
-- Display departments and heads sorted by department
-- =========================================================

SELECT d.name,
       p.name
FROM department d
JOIN physician p
ON d.head = p.employeeid
ORDER BY d.name;

-- =========================================================
-- QUESTION 16: WHERE + NOT LIKE
-- Find physicians not involved in surgery
-- =========================================================

SELECT *
FROM physician
WHERE position NOT LIKE '%Surgical%';

-- =========================================================
-- QUESTION 17: COUNT + HAVING
-- Find positions having at least 2 employees
-- =========================================================

SELECT position,
       COUNT(*) AS Total
FROM physician
GROUP BY position
HAVING COUNT(*) >= 2;

-- =========================================================
-- QUESTION 18: EXISTS
-- Find departments that have a valid head
-- =========================================================

SELECT *
FROM department d
WHERE EXISTS
(
    SELECT 1
    FROM physician p
    WHERE p.employeeid = d.head
);

-- =========================================================
-- QUESTION 19: MAX()
-- Find highest employee ID
-- =========================================================

SELECT MAX(employeeid) AS Maximum_Employee_ID
FROM physician;

-- =========================================================
-- QUESTION 20: MIN()
-- Find lowest employee ID
-- =========================================================

SELECT MIN(employeeid) AS Minimum_Employee_ID
FROM physician;