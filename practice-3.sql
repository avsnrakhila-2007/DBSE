CREATE DATABASE IF NOT EXISTS orders_db;
USE orders_db;

-- =========================================================
-- STEP 1: CREATE ORDERS TABLE
-- =========================================================

CREATE TABLE orders (
    ord_no INT PRIMARY KEY,
    purch_amt DECIMAL(10,2),
    ord_date DATE,
    customer_id INT,
    salesman_id INT
);

-- =========================================================
-- STEP 2: INSERT DATA
-- =========================================================

INSERT INTO orders VALUES
(70001, 150.50, '2012-10-05', 3005, 5002),
(70009, 270.65, '2012-09-10', 3001, 5005),
(70002, 65.26, '2012-10-05', 3002, 5001),
(70004, 110.50, '2012-08-17', 3009, 5003),
(70007, 948.50, '2012-09-10', 3005, 5002),
(70005, 2400.60, '2012-07-27', 3007, 5001),
(70008, 5760.00, '2012-09-10', 3002, 5001),
(70010, 1983.43, '2012-10-10', 3004, 5006),
(70003, 2480.40, '2012-10-10', 3009, 5003),
(70012, 250.45, '2012-06-27', 3008, 5002),
(70011, 75.29, '2012-08-17', 3003, 5007),
(70013, 3045.60, '2012-04-25', 3002, 5001);

-- =========================================================
-- QUESTION 1: WHERE CLAUSE
-- =========================================================

SELECT *
FROM orders
WHERE purch_amt > 2000;

-- =========================================================
-- QUESTION 2: WHERE CLAUSE
-- =========================================================

SELECT *
FROM orders
WHERE ord_date = '2012-09-10';

-- =========================================================
-- QUESTION 3: WHERE CLAUSE
-- =========================================================

SELECT *
FROM orders
WHERE salesman_id = 5001;

-- =========================================================
-- QUESTION 4: ORDER BY DESC
-- =========================================================

SELECT *
FROM orders
ORDER BY purch_amt DESC;

-- =========================================================
-- QUESTION 5: ORDER BY
-- =========================================================

SELECT *
FROM orders
ORDER BY ord_date;

-- =========================================================
-- QUESTION 6: SUM()
-- =========================================================

SELECT SUM(purch_amt) AS total_revenue
FROM orders;

-- =========================================================
-- QUESTION 7: AVG()
-- =========================================================

SELECT AVG(purch_amt) AS average_order
FROM orders;

-- =========================================================
-- QUESTION 8: MAX()
-- =========================================================

SELECT MAX(purch_amt) AS highest_order
FROM orders;

-- =========================================================
-- QUESTION 9: MIN()
-- =========================================================

SELECT MIN(purch_amt) AS lowest_order
FROM orders;

-- =========================================================
-- QUESTION 10: COUNT()
-- =========================================================

SELECT COUNT(*) AS total_orders
FROM orders;

-- =========================================================
-- QUESTION 11: GROUP BY
-- =========================================================

SELECT salesman_id,
       SUM(purch_amt) AS total_sales
FROM orders
GROUP BY salesman_id;

-- =========================================================
-- QUESTION 12: GROUP BY
-- =========================================================

SELECT customer_id,
       SUM(purch_amt) AS total_purchase
FROM orders
GROUP BY customer_id;

-- =========================================================
-- QUESTION 13: GROUP BY + MAX()
-- =========================================================

SELECT customer_id,
       MAX(purch_amt) AS highest_purchase
FROM orders
GROUP BY customer_id;

-- =========================================================
-- QUESTION 14: GROUP BY + HAVING
-- =========================================================

SELECT salesman_id,
       SUM(purch_amt) AS total_sales
FROM orders
GROUP BY salesman_id
HAVING SUM(purch_amt) > 3000;

-- =========================================================
-- QUESTION 15: GROUP BY + HAVING
-- =========================================================

SELECT customer_id,
       SUM(purch_amt) AS total_purchase
FROM orders
GROUP BY customer_id
HAVING SUM(purch_amt) > 2500;

-- =========================================================
-- QUESTION 16: GROUP BY + HAVING
-- =========================================================

SELECT customer_id,
       COUNT(*) AS total_orders
FROM orders
GROUP BY customer_id
HAVING COUNT(*) > 1;

-- =========================================================
-- QUESTION 17: GROUP BY + HAVING + ORDER BY
-- =========================================================

SELECT customer_id,
       SUM(purch_amt) AS total_purchase
FROM orders
GROUP BY customer_id
HAVING SUM(purch_amt) > 1000
ORDER BY total_purchase DESC;

-- =========================================================
-- QUESTION 18: BETWEEN + HAVING
-- =========================================================

SELECT customer_id,
       MAX(purch_amt) AS max_purchase
FROM orders
GROUP BY customer_id
HAVING MAX(purch_amt) BETWEEN 2000 AND 6000;

-- =========================================================
-- QUESTION 19: COUNT + HAVING
-- =========================================================

SELECT salesman_id,
       COUNT(*) AS total_orders
FROM orders
GROUP BY salesman_id
HAVING COUNT(*) >= 2;

-- =========================================================
-- QUESTION 20: MAX + GROUP BY + HAVING
-- =========================================================

SELECT ord_date,
       MAX(purch_amt) AS highest_purchase
FROM orders
GROUP BY ord_date
HAVING MAX(purch_amt) > 2000;