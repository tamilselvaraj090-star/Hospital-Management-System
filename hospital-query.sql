create database hospitalmanagementsystem2
use hospitalmanagementsystem2

-- Display the doctor ID, doctor name, specialization, and experience years of all active doctors who have more than 5 years of experience. Sort the results in descending order of experience.”

SELECT doctor_id, doctor_name, specialization, experience_years
FROM doctor
WHERE status = 'Active'
AND experience_years > 5
ORDER BY experience_years DESC;

-- “Display the specialization and the total number of active doctors in each specialization.”

SELECT specialization,
       COUNT(*) AS total_doctors
FROM Doctor
WHERE status = 'Active'
GROUP BY specialization;

-- “Display the highest consultation fee for each doctor specialization.”

SELECT specialization,
       MAX(consultation_fee) AS highest_consultation_fee
FROM Doctor
GROUP BY specialization;

-- “Display the blood groups that have more than 10 patients, along with the number of patients in each blood group.”

SELECT blood_group,
       COUNT(*) AS patient_count
FROM Patient
GROUP BY blood_group
HAVING COUNT(*) > 10;

-- “Display the patient name, appointment date, and appointment status for all patients along with their appointments.”

SELECT p.patient_name,
       a.appointment_date,
       a.appointment_status
FROM Patient p 
JOIN Appointment a
ON p.patient_id = a.patient_id;

-- “Display the patient name, doctor name, department name, and appointment date for all appointments.”

SELECT p.patient_name,
       d.doctor_name,
       dept.department_name,
       a.appointment_date
FROM Appointment a
JOIN Patient p
ON a.patient_id = p.patient_id
JOIN Doctor d
ON a.doctor_id = d.doctor_id
JOIN Department dept
ON a.department_id = dept.department_id;

-- “Display the total number of appointments booked for each doctor.”

SELECT d.doctor_name,
       COUNT(a.appointment_id) AS total_appointments
FROM Doctor d
JOIN Appointment a
ON d.doctor_id = a.doctor_id
GROUP BY d.doctor_id, d.doctor_name;

-- “Display the names of doctors who have more than 5 appointments, along with their total number of appointments.”

SELECT d.doctor_name,
       COUNT(a.appointment_id) AS total_appointments
FROM Doctor d
JOIN Appointment a
ON d.doctor_id = a.doctor_id
GROUP BY d.doctor_id, d.doctor_name
HAVING COUNT(a.appointment_id) > 5;

-- “Calculate the total revenue generated through each payment method and display the results in descending order of total revenue.”

SELECT payment_method,
       SUM(payment_amount) AS total_revenue
FROM Payment
GROUP BY payment_method
ORDER BY total_revenue DESC;

-- “Display the departments that have more than 5 staff members, along with the total number of staff in each department.”

SELECT dept.department_name,
       COUNT(s.staff_id) AS total_staff
FROM Department dept
JOIN Staff s
ON dept.department_id = s.department_id
GROUP BY dept.department_id, dept.department_name
HAVING COUNT(s.staff_id) > 5;

-- “Create a view named Patient_Appointment_View to display the patient name, doctor name, doctor specialization, appointment date, and appointment status.”

CREATE VIEW Patient_Appointment_View AS
SELECT p.patient_name,
       d.doctor_name,
       d.specialization,
       a.appointment_date,
       a.appointment_status
FROM Appointment a
JOIN Patient p
ON a.patient_id = p.patient_id
JOIN Doctor d
ON a.doctor_id = d.doctor_id

-- “Create a view named Patient_Billing_View to display the patient name, bill ID, total amount, payment status, and payment method for billing records.”

CREATE VIEW Patient_Billing_View AS
SELECT p.patient_name,
       b.bill_id,
       b.total_amount,
       b.payment_status,
       b.payment_method
FROM Billing b
JOIN Patient p
ON b.patient_id = p.patient_id;

select * from Patient_Billing_View

-- “Create an AFTER INSERT trigger named reduce_medicine_stock that automatically decreases the medicine stock quantity by the prescribed quantity whenever a new record is inserted into the Prescription_Details table.”

DELIMITER $$

CREATE TRIGGER reduce_medicine_stock
AFTER INSERT ON Prescription_Details
FOR EACH ROW
BEGIN
    UPDATE Medicine
    SET stock_quantity = stock_quantity - NEW.quantity
    WHERE medicine_id = NEW.medicine_id;
END $$

DELIMITER ;

SHOW CREATE TRIGGER reduce_medicine_stock;

-- “Create a stored procedure named GetDoctorAppointments that accepts a doctor ID as input and displays the appointment ID, patient name, appointment date, appointment time, and appointment status for that doctor.”

DELIMITER $$

CREATE PROCEDURE GetDoctorAppointments(IN doc_id INT)
BEGIN
    SELECT a.appointment_id,
           p.patient_name,
           a.appointment_date,
           a.appointment_time,
           a.appointment_status
    FROM Appointment a
    JOIN Patient p
        ON a.patient_id = p.patient_id
    WHERE a.doctor_id = doc_id;
END $$

DELIMITER ;

SHOW CREATE PROCEDURE GetDoctorAppointments;

-- “Create a stored procedure named GetPatientTotalBill that accepts a patient ID as input and displays the patient name, total number of bills, and total bill amount for that patient.”

DELIMITER $$

CREATE PROCEDURE GetPatientTotalBill(IN pat_id INT)
BEGIN
    SELECT p.patient_name,
           COUNT(b.bill_id) AS total_bills,
           SUM(b.total_amount) AS total_amount
    FROM Patient p
    JOIN Billing b
        ON p.patient_id = b.patient_id
    WHERE p.patient_id = pat_id
    GROUP BY p.patient_id, p.patient_name;
END $$

DELIMITER ;

SHOW CREATE PROCEDURE GetPatientTotalBill;