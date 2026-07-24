create database hospitalmanagementsystem2;
use   hospitalmanagementsystem2


-- 1. Patient Table
CREATE TABLE Patient (
    patient_id INT PRIMARY KEY AUTO_INCREMENT,
    patient_name VARCHAR(100),
    gender VARCHAR(10),
    dob DATE,
    age INT,
    blood_group VARCHAR(5),
    phone_no VARCHAR(15),
    email VARCHAR(100),
    address VARCHAR(255),
    city VARCHAR(50),
    admitted_date DATE
);

-- 2. Doctor Table
CREATE TABLE Doctor (
    doctor_id INT PRIMARY KEY AUTO_INCREMENT,
    doctor_name VARCHAR(100),
    gender VARCHAR(10),
    dob DATE,
    specialization VARCHAR(100),
    qualification VARCHAR(100),
    experience_years INT,
    phone_no VARCHAR(15),
    email VARCHAR(100),
    address VARCHAR(255),
    city VARCHAR(50),
    consultation_fee DECIMAL(10,2),
    joining_date DATE,
    status VARCHAR(20)
);

-- 3. Department Table
CREATE TABLE Department (
    department_id INT PRIMARY KEY AUTO_INCREMENT,
    department_name VARCHAR(100),
    department_head VARCHAR(100),
    contact_no VARCHAR(15),
    email VARCHAR(100),
    location VARCHAR(100),
    number_of_staff INT,
    status VARCHAR(20)
);

-- 4. Staff Table
CREATE TABLE Staff (
    staff_id INT PRIMARY KEY AUTO_INCREMENT,
    staff_name VARCHAR(100),
    gender VARCHAR(10),
    dob DATE,
    phone_no VARCHAR(15),
    email VARCHAR(100),
    address VARCHAR(255),
    city VARCHAR(50),
    department_id INT,
    role VARCHAR(50),
    qualification VARCHAR(100),
    experience INT,
    joining_date DATE,
    salary DECIMAL(10,2),
    shift VARCHAR(20),
    status VARCHAR(20),
    FOREIGN KEY (department_id) REFERENCES Department(department_id)
);

-- 5. Nurse Table
CREATE TABLE Nurse (
    nurse_id INT PRIMARY KEY AUTO_INCREMENT,
    nurse_name VARCHAR(100),
    gender VARCHAR(10),
    age INT,
    phone_no VARCHAR(15),
    email VARCHAR(100),
    qualification VARCHAR(100),
    experience_years INT,
    department VARCHAR(100),
    shift VARCHAR(20),
    salary DECIMAL(10,2),
    joining_date DATE,
    status VARCHAR(20),
    address VARCHAR(255),
    notes VARCHAR(255)
);

-- 6. Medicine Table
CREATE TABLE Medicine (
    medicine_id INT PRIMARY KEY AUTO_INCREMENT,
    medicine_name VARCHAR(100),
    category VARCHAR(50),
    manufacturer VARCHAR(100),
    batch_no VARCHAR(30),
    expiry_date DATE,
    stock_quantity INT,
    unit_price DECIMAL(10,2),
    dosage VARCHAR(50),
    status VARCHAR(20),
    notes VARCHAR(255)
);

-- 7. Appointment Table
CREATE TABLE Appointment (
    appointment_id INT PRIMARY KEY AUTO_INCREMENT,
    patient_id INT,
    doctor_id INT,
    department_id INT,
    appointment_date DATE,
    appointment_time TIME,
    appointment_type VARCHAR(50),
    appointment_status VARCHAR(20),
    symptoms VARCHAR(255),
    notes VARCHAR(255),
    FOREIGN KEY (patient_id) REFERENCES Patient(patient_id),
    FOREIGN KEY (doctor_id) REFERENCES Doctor(doctor_id),
    FOREIGN KEY (department_id) REFERENCES Department(department_id)
);

-- 8. Prescription Table
CREATE TABLE Prescription (
    prescription_id INT PRIMARY KEY AUTO_INCREMENT,
    patient_id INT,
    doctor_id INT,
    appointment_id INT,
    medicine_id INT,
    prescription_date DATE,
    dosage VARCHAR(50),
    frequency VARCHAR(50),
    duration VARCHAR(50),
    instructions VARCHAR(255),
    status VARCHAR(20),
    FOREIGN KEY (patient_id) REFERENCES Patient(patient_id),
    FOREIGN KEY (doctor_id) REFERENCES Doctor(doctor_id),
    FOREIGN KEY (appointment_id) REFERENCES Appointment(appointment_id),
    FOREIGN KEY (medicine_id) REFERENCES Medicine(medicine_id)
);

-- 9. Prescription Details Table
CREATE TABLE Prescription_Details (
    prescription_detail_id INT PRIMARY KEY AUTO_INCREMENT,
    prescription_id INT,
    medicine_id INT,
    quantity INT,
    dosage VARCHAR(50),
    frequency VARCHAR(50),
    duration VARCHAR(50),
    instructions VARCHAR(255),
    FOREIGN KEY (prescription_id) REFERENCES Prescription(prescription_id),
    FOREIGN KEY (medicine_id) REFERENCES Medicine(medicine_id)
);

-- 10. Admission Table
CREATE TABLE Admission (
    admission_id INT PRIMARY KEY AUTO_INCREMENT,
    patient_id INT,
    doctor_id INT,
    room_id INT,
    admission_date DATE,
    discharge_date DATE,
    admission_reason VARCHAR(255),
    admission_type VARCHAR(50),
    ward VARCHAR(50),
    bed_number VARCHAR(20),
    status VARCHAR(20),
    notes VARCHAR(255),
    FOREIGN KEY (patient_id) REFERENCES Patient(patient_id),
    FOREIGN KEY (doctor_id) REFERENCES Doctor(doctor_id)
);

-- 11. Billing Table
CREATE TABLE Billing (
    bill_id INT PRIMARY KEY AUTO_INCREMENT,
    patient_id INT,
    admission_id INT,
    doctor_id INT,
    bill_date DATE,
    consultation_fee DECIMAL(10,2),
    room_charge DECIMAL(10,2),
    medicine_charge DECIMAL(10,2),
    lab_charge DECIMAL(10,2),
    total_amount DECIMAL(10,2),
    payment_status VARCHAR(20),
    payment_method VARCHAR(50),
    notes VARCHAR(255),
    FOREIGN KEY (patient_id) REFERENCES Patient(patient_id),
    FOREIGN KEY (admission_id) REFERENCES Admission(admission_id),
    FOREIGN KEY (doctor_id) REFERENCES Doctor(doctor_id)
);

-- 12. Payment Table
CREATE TABLE Payment (
    payment_id INT PRIMARY KEY AUTO_INCREMENT,
    bill_id INT,
    patient_id INT,
    payment_date DATE,
    payment_amount DECIMAL(10,2),
    payment_method VARCHAR(50),
    payment_status VARCHAR(20),
    payment_mode VARCHAR(20),
    transaction_id VARCHAR(50),
    remarks VARCHAR(255),
    FOREIGN KEY (bill_id) REFERENCES Billing(bill_id),
    FOREIGN KEY (patient_id) REFERENCES Patient(patient_id)
);

-- 13. Lab Test Table
CREATE TABLE Lab_Test (
    lab_test_id INT PRIMARY KEY AUTO_INCREMENT,
    patient_id INT,
    doctor_id INT,
    appointment_id INT,
    test_name VARCHAR(100),
    test_date DATE,
    result VARCHAR(255),
    normal_range VARCHAR(100),
    lab_technician VARCHAR(100),
    status VARCHAR(20),
    remarks VARCHAR(255),
    FOREIGN KEY (patient_id) REFERENCES Patient(patient_id),
    FOREIGN KEY (doctor_id) REFERENCES Doctor(doctor_id),
    FOREIGN KEY (appointment_id) REFERENCES Appointment(appointment_id)
);

-- 14. Room Table
CREATE TABLE Room (
    room_id INT PRIMARY KEY AUTO_INCREMENT,
    room_number VARCHAR(20),
    room_type VARCHAR(50),
    ward VARCHAR(50),
    floor INT,
    bed_capacity INT,
    available_beds INT,
    room_status VARCHAR(20),
    charges_per_day DECIMAL(10,2),
    notes VARCHAR(255)
);

-- 15. Medical Record Table
CREATE TABLE Medical_Record (
    record_id INT PRIMARY KEY AUTO_INCREMENT,
    patient_id INT,
    doctor_id INT,
    appointment_id INT,
    record_date DATE,
    diagnosis VARCHAR(255),
    symptoms VARCHAR(255),
    treatment VARCHAR(255),
    prescription VARCHAR(255),
    test_results VARCHAR(255),
    notes VARCHAR(255),
    FOREIGN KEY (patient_id) REFERENCES Patient(patient_id),
    FOREIGN KEY (doctor_id) REFERENCES Doctor(doctor_id),
    FOREIGN KEY (appointment_id) REFERENCES Appointment(appointment_id)
);