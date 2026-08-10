CREATE DATABASE IF NOT EXISTS skytrack_db;
USE skytrack_db;
CREATE TABLE Flights (
    flight_id INT PRIMARY KEY,
    flight_number VARCHAR(20) NOT NULL UNIQUE,
    source VARCHAR(100) NOT NULL,
    destination VARCHAR(100) NOT NULL,
    departure_date DATE NOT NULL,
    ticket_price DECIMAL(10,2) CHECK (ticket_price > 0)
);
INSERT INTO Flights
(flight_id, flight_number, source, destination, departure_date, ticket_price)
VALUES
(1, 'SK101', 'Hyderabad', 'Delhi', '2026-08-01', 5500.00),
(2, 'SK102', 'Mumbai', 'Bangalore', '2026-08-02', 4800.00),
(3, 'SK103', 'Chennai', 'Hyderabad', '2026-08-03', 4200.00),
(4, 'SK104', 'Delhi', 'Kolkata', '2026-08-04', 5100.00),
(5, 'SK105', 'Bangalore', 'Mumbai', '2026-08-05', 4600.00),
(6, 'SK106', 'Hyderabad', 'Chennai', '2026-08-06', 3900.00),
(7, 'SK107', 'Kolkata', 'Delhi', '2026-08-07', 5300.00),
(8, 'SK108', 'Mumbai', 'Hyderabad', '2026-08-08', 4500.00),
(9, 'SK109', 'Chennai', 'Bangalore', '2026-08-09', 4100.00),
(10, 'SK110', 'Delhi', 'Mumbai', '2026-08-10', 5700.00);
SELECT * FROM Flights;
CREATE TABLE Passengers (
    passenger_id INT PRIMARY KEY,
    passenger_name VARCHAR(100) NOT NULL,
    email VARCHAR(150) NOT NULL UNIQUE
);

SELECT * FROM Passengers;
CREATE TABLE Bookings (
    booking_id INT PRIMARY KEY,
    passenger_id INT NOT NULL,
    flight_id INT NOT NULL,
    booking_date DATE NOT NULL,
    seat_number VARCHAR(10),
    FOREIGN KEY (passenger_id) REFERENCES Passengers(passenger_id),
    FOREIGN KEY (flight_id) REFERENCES Flights(flight_id)
);
INSERT INTO Bookings
(booking_id, passenger_id, flight_id, booking_date, seat_number)
VALUES
(1, 101, 1, '2026-07-20', '12A'),
(2, 102, 2, '2026-07-21', '14B'),
(3, 103, 3, '2026-07-22', '10C'),
(4, 104, 4, '2026-07-23', '8A'),
(5, 105, 5, '2026-07-24', '15D'),
(6, 106, 6, '2026-07-25', '7B'),
(7, 107, 7, '2026-07-26', '11A'),
(8, 108, 8, '2026-07-27', '9C'),
(9, 109, 9, '2026-07-28', '13B'),
(10, 110, 10, '2026-07-29', '6D');
SELECT * FROM Bookings;
SELECT
    p.passenger_name AS Passenger_Name,
    f.flight_number AS Flight_Number,
    f.source AS Source,
    f.destination AS Destination
FROM Bookings b
INNER JOIN Passengers p
    ON b.passenger_id = p.passenger_id
INNER JOIN Flights f
    ON b.flight_id = f.flight_id;
    SELECT
    destination,
    COUNT(flight_id) AS Total_Flights
FROM Flights
GROUP BY destination
ORDER BY destination;
CREATE TABLE Flight_History (
    history_id INT PRIMARY KEY,
    flight_id INT NOT NULL,
    action_type VARCHAR(50) NOT NULL,
    action_date DATE NOT NULL,
    FOREIGN KEY (flight_id) REFERENCES Flights(flight_id)
);
START TRANSACTION;

INSERT INTO Flights
(flight_id, flight_number, source, destination, departure_date, ticket_price)
VALUES
(11, 'SK111', 'Hyderabad', 'Goa', '2026-08-15', 4300.00);

INSERT INTO Flight_History
(history_id, flight_id, action_type, action_date)
VALUES
(1, 11, 'NEW FLIGHT ADDED', CURDATE());

COMMIT;

CREATE INDEX idx_flight_number
ON Flights(flight_number);
SELECT *
FROM Flights
WHERE flight_number = 'SK105';
SELECT * FROM Flights;

SELECT * FROM Passengers;

SELECT * FROM Bookings;

SELECT * FROM Flight_History;