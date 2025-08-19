-- Task 8: Stored Procedures and Functions for Hospital Database

-- 1. STORED PROCEDURES
-- ========================================
use Hospital;

-- Procedure 1: Get all bills for a patient
DELIMITER //
CREATE PROCEDURE GetPatientBills (IN p_id INT)
BEGIN
    SELECT b.bill_id, b.total_amount, b.billing_date
    FROM Bills b
    WHERE b.patient_id = p_id;
END //
DELIMITER ;

-- Usage
CALL GetPatientBills(1);

show tables;
select * from Admissions;
select * from departments;
select * from bills;
select * from Rooms;
-- Procedure 2: Get total revenue for a room
DELIMITER //
CREATE PROCEDURE RoomRevenue (IN room_id INT, OUT total_rev DECIMAL(10,2))
BEGIN
    SELECT SUM(r.cost_per_day)
    INTO total_rev
    FROM Rooms r
    WHERE r.room_id = room_id;
END //
DELIMITER ;

-- Usage
SET @rev = 0;
CALL RoomRevenue(2, @rev);
SELECT @rev AS TotalRevenue;


-- Procedure 3: Insert a new appointment
DELIMITER //
CREATE PROCEDURE AddAppointment (
    IN p_id INT,
    IN d_id INT,
    IN appt_date DATE,
    IN reasons TEXT,
    IN statuses TEXT
)
BEGIN
    INSERT INTO Appointments (patient_id, doctor_id, appointment_datetime, reason, status)
    VALUES (p_id, d_id, appt_date, reasons, statuses);
END //
DELIMITER ;

-- Usage
CALL AddAppointment(3, 2, '2025-08-21',"Initial Consultaion","Scheduled");

-- ========================================
-- 2. STORED FUNCTIONS
-- ========================================

-- Function 1: Calculate stay duration
DELIMITER //
CREATE FUNCTION StayDuration(admit DATE, discharge DATE)
RETURNS INT
DETERMINISTIC
BEGIN
    RETURN DATEDIFF(COALESCE(discharge, NOW()), admit);
END //
DELIMITER ;

-- Usage
SELECT patient_id, StayDuration(admitted_on, discharged_on) AS stay_days
FROM Admissions;


-- Function 2: Calculate discount on bill
DELIMITER //
CREATE FUNCTION ApplyDiscount(amount DECIMAL(10,2), disc_percent INT)
RETURNS DECIMAL(10,2)
DETERMINISTIC
BEGIN
    RETURN amount - (amount * disc_percent / 100);
END //
DELIMITER ;

-- Usage
SELECT bill_id, total_amount, ApplyDiscount(total_amount, 10) AS discounted_amount
FROM Bills;


-- Function 3: Get doctor's full name
DELIMITER //
CREATE FUNCTION DoctorFullName(d_id INT)
RETURNS VARCHAR(100)
DETERMINISTIC
BEGIN
    DECLARE fullname VARCHAR(100);
    SELECT CONCAT(first_name, ' ', last_name) INTO fullname
    FROM Doctors
    WHERE doctor_id = d_id;
    RETURN fullname;
END //
DELIMITER ;

-- Usage
SELECT DoctorFullName(2) AS DoctorName;
