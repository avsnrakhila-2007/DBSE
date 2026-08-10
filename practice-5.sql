CREATE DATABASE IF NOT EXISTS joins_set_db;
USE joins_set_db;

-- =========================================================
-- PART 1: CROSS JOIN
-- =========================================================

-- STEP 1: CREATE TABLES

CREATE TABLE class (
    id INT,
    name VARCHAR(30)
);

CREATE TABLE class_info (
    id INT,
    address VARCHAR(30)
);

-- STEP 2: INSERT DATA

INSERT INTO class VALUES
(1, 'abhi'),
(2, 'adam'),
(4, 'alex');

INSERT INTO class_info VALUES
(1, 'DELHI'),
(2, 'MUMBAI'),
(3, 'CHENNAI');

-- =========================================================
-- QUESTION 1: CROSS JOIN
-- =========================================================

SELECT *
FROM class
CROSS JOIN class_info;

-- =========================================================
-- PART 2: INNER JOIN
-- =========================================================

-- Add missing student for INNER JOIN example

INSERT INTO class VALUES
(3, 'alex');

-- QUESTION 2: INNER JOIN

SELECT *
FROM class
INNER JOIN class_info
ON class.id = class_info.id;

-- QUESTION 3: INNER JOIN

SELECT
    class.name,
    class_info.address
FROM class
INNER JOIN class_info
ON class.id = class_info.id;

-- =========================================================
-- PART 3: NATURAL JOIN
-- =========================================================

-- QUESTION 4: NATURAL JOIN

SELECT *
FROM class
NATURAL JOIN class_info;

-- =========================================================
-- PART 4: LEFT OUTER JOIN
-- =========================================================

-- Add students with no matching address

INSERT INTO class VALUES
(5, 'ashish');

-- Add addresses with no matching students

INSERT INTO class_info VALUES
(7, 'NOIDA'),
(8, 'PANIPAT');

-- QUESTION 5: LEFT JOIN

SELECT *
FROM class
LEFT OUTER JOIN class_info
ON class.id = class_info.id;

-- QUESTION 6: LEFT JOIN
-- Find students without address records

SELECT
    class.id,
    class.name
FROM class
LEFT JOIN class_info
ON class.id = class_info.id
WHERE class_info.id IS NULL;

-- =========================================================
-- PART 5: RIGHT OUTER JOIN
-- =========================================================

-- QUESTION 7: RIGHT JOIN

SELECT *
FROM class
RIGHT OUTER JOIN class_info
ON class.id = class_info.id;

-- QUESTION 8: RIGHT JOIN
-- Find address records without students

SELECT
    class_info.id,
    class_info.address
FROM class
RIGHT JOIN class_info
ON class.id = class_info.id
WHERE class.id IS NULL;

-- =========================================================
-- PART 6: FULL OUTER JOIN
-- =========================================================
-- MySQL does not support FULL OUTER JOIN directly.
-- Use LEFT JOIN UNION RIGHT JOIN.

-- QUESTION 9: FULL OUTER JOIN equivalent

SELECT
    class.id AS class_id,
    class.name,
    class_info.id AS info_id,
    class_info.address
FROM class
LEFT JOIN class_info
ON class.id = class_info.id

UNION

SELECT
    class.id AS class_id,
    class.name,
    class_info.id AS info_id,
    class_info.address
FROM class
RIGHT JOIN class_info
ON class.id = class_info.id;

-- QUESTION 10: FULL OUTER JOIN
-- Show only unmatched records

SELECT
    class.id AS class_id,
    class.name,
    class_info.id AS info_id,
    class_info.address
FROM class
LEFT JOIN class_info
ON class.id = class_info.id
WHERE class_info.id IS NULL

UNION

SELECT
    class.id AS class_id,
    class.name,
    class_info.id AS info_id,
    class_info.address
FROM class
RIGHT JOIN class_info
ON class.id = class_info.id
WHERE class.id IS NULL;

-- =========================================================
-- PART 7: UNION
-- =========================================================

CREATE TABLE first_table (
    id INT,
    name VARCHAR(30)
);

CREATE TABLE second_table (
    id INT,
    name VARCHAR(30)
);

INSERT INTO first_table VALUES
(1, 'abhi'),
(2, 'adam');

INSERT INTO second_table VALUES
(2, 'adam'),
(3, 'chester');

-- QUESTION 11: UNION

SELECT *
FROM first_table

UNION

SELECT *
FROM second_table;

-- QUESTION 12: UNION

SELECT name
FROM first_table

UNION

SELECT name
FROM second_table;

-- =========================================================
-- PART 8: UNION ALL
-- =========================================================

-- QUESTION 13: UNION ALL

SELECT *
FROM first_table

UNION ALL

SELECT *
FROM second_table;

-- QUESTION 14: UNION ALL + COUNT

SELECT COUNT(*)
FROM
(
    SELECT *
    FROM first_table

    UNION ALL

    SELECT *
    FROM second_table
) AS A;

-- =========================================================
-- PART 9: INTERSECT
-- =========================================================

-- QUESTION 15: INTERSECT
-- MySQL 8.0.31+ supports INTERSECT.

SELECT *
FROM first_table

INTERSECT

SELECT *
FROM second_table;

-- QUESTION 16: INTERSECT

SELECT name
FROM first_table

INTERSECT

SELECT name
FROM second_table;

-- =========================================================
-- PART 10: MINUS
-- =========================================================
-- MySQL uses EXCEPT instead of MINUS on supported versions.

-- QUESTION 17: MINUS equivalent

SELECT *
FROM first_table

EXCEPT

SELECT *
FROM second_table;

-- QUESTION 18: MINUS equivalent

SELECT name
FROM first_table

EXCEPT

SELECT name
FROM second_table;

-- =========================================================
-- QUESTION 19: INNER JOIN
-- =========================================================

SELECT
    c.id,
    c.name,
    ci.address
FROM class c
INNER JOIN class_info ci
ON c.id = ci.id;

-- =========================================================
-- QUESTION 20: JOIN + CASE
-- =========================================================

SELECT
    c.id,
    c.name,
    CASE
        WHEN ci.address IS NULL
        THEN 'Address Missing'
        ELSE 'Address Available'
    END AS Status
FROM class c
LEFT JOIN class_info ci
ON c.id = ci.id;