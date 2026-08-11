DROP DATABASE IF EXISTS smart_clinic;
CREATE DATABASE smart_clinic;
USE smart_clinic;

CREATE TABLE PATIENT (
    patient_id INT PRIMARY KEY,
    full_name VARCHAR(100) NOT NULL,
    date_of_birth DATE,
    gender VARCHAR(10),
    phone VARCHAR(20) UNIQUE,
    email VARCHAR(100) UNIQUE,
    address VARCHAR(200),
    blood_type VARCHAR(5)
);
CREATE TABLE DOCTOR (
    doctor_id INT PRIMARY KEY,
    full_name VARCHAR(100) NOT NULL,
    specialty VARCHAR(100) NOT NULL,
    phone VARCHAR(20) UNIQUE,
    email VARCHAR(100) UNIQUE,
    consultation_fee DECIMAL(10,2) NOT NULL
);
CREATE TABLE APPOINTMENT (
    appointment_id INT PRIMARY KEY,
    patient_id INT NOT NULL,
    doctor_id INT NOT NULL,
    appointment_date DATE NOT NULL,
    appointment_time TIME NOT NULL,
    status VARCHAR(20) NOT NULL,
    reason VARCHAR(255),
    FOREIGN KEY (patient_id) REFERENCES PATIENT(patient_id),
    FOREIGN KEY (doctor_id) REFERENCES DOCTOR(doctor_id)
);
CREATE TABLE TREATMENT (
    treatment_id INT PRIMARY KEY,
    appointment_id INT NOT NULL,
    diagnosis VARCHAR(255) NOT NULL,
    treatment_description VARCHAR(255),
    treatment_date DATE NOT NULL,
    treatment_cost DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (appointment_id) REFERENCES APPOINTMENT(appointment_id)
);
CREATE TABLE PRESCRIPTION (
    prescription_id INT PRIMARY KEY,
    appointment_id INT NOT NULL,
    issue_date DATE NOT NULL,
    notes VARCHAR(255),
    FOREIGN KEY (appointment_id) REFERENCES APPOINTMENT(appointment_id)
);
CREATE TABLE MEDICINE (
    medicine_id INT PRIMARY KEY,
    medicine_name VARCHAR(100) NOT NULL UNIQUE,
    stock_quantity INT NOT NULL,
    unit_price DECIMAL(10,2) NOT NULL,
    expiry_date DATE NOT NULL
);
CREATE TABLE PAYMENT (
    payment_id INT PRIMARY KEY,
    appointment_id INT NOT NULL UNIQUE,
    amount DECIMAL(10,2) NOT NULL,
    payment_date DATE NOT NULL,
    payment_status VARCHAR(20) NOT NULL,
    FOREIGN KEY (appointment_id) REFERENCES APPOINTMENT(appointment_id)
);
CREATE TABLE CONTAINS (
    prescription_id INT NOT NULL,
    medicine_id INT NOT NULL,
    dosage VARCHAR(50) NOT NULL,
    frequency VARCHAR(50) NOT NULL,
    duration_days INT NOT NULL,
    quantity INT NOT NULL,
    PRIMARY KEY (prescription_id, medicine_id),
    FOREIGN KEY (prescription_id) REFERENCES PRESCRIPTION(prescription_id),
    FOREIGN KEY (medicine_id) REFERENCES MEDICINE(medicine_id)
);
CREATE TABLE CASH_PAYMENT (
    payment_id INT PRIMARY KEY,
    received_by VARCHAR(100) NOT NULL,
    FOREIGN KEY (payment_id) REFERENCES PAYMENT(payment_id)
);
CREATE TABLE CARD_PAYMENT (
    payment_id INT PRIMARY KEY,
    card_last_four_digits CHAR(4) NOT NULL,
    transaction_reference VARCHAR(100) NOT NULL UNIQUE,
    FOREIGN KEY (payment_id) REFERENCES PAYMENT(payment_id)
);
INSERT INTO PATIENT
(patient_id, full_name, date_of_birth, gender, phone, email, address, blood_type)
VALUES
(1, 'Ahmed Ali', '1995-03-12', 'Male', '0501111111', 'ahmed.ali@email.com', 'Dammam', 'O+'),
(2, 'Sara Mohammed', '1998-07-21', 'Female', '0502222222', 'sara.m@email.com', 'Khobar', 'A+'),
(3, 'Khalid Hassan', '1987-11-05', 'Male', '0503333333', 'khalid.h@email.com', 'Jubail', 'B+'),
(4, 'Nora Abdullah', '2001-02-18', 'Female', '0504444444', 'nora.a@email.com', 'Dammam', 'AB+'),
(5, 'Fahad Salem', '1992-09-30', 'Male', '0505555555', 'fahad.s@email.com', 'Khobar', 'O-');

INSERT INTO DOCTOR
(doctor_id, full_name, specialty, phone, email, consultation_fee)
VALUES
(1, 'Yazid Alshehri', 'Cardiology', '0511111111', 'yazid.alshehri@clinic.com', 300.00),
(2, 'Mohammed Alsharif', 'Dermatology', '0522222222', 'mohammed.alsharif@clinic.com', 250.00),
(3, 'Hamzah Alattas', 'Pediatrics', '0533333333', 'hamzah.alattas@clinic.com', 200.00),
(4, 'Nansi Ajram', 'Internal Medicine', '0544444444', 'nansi.ajram@clinic.com', 275.00),
(5, 'Nuha Nabeel', 'Orthopedics', '0555555555', 'nuha.nabeel@clinic.com', 350.00);

INSERT INTO APPOINTMENT
(appointment_id, patient_id, doctor_id, appointment_date, appointment_time, status, reason)
VALUES
(1, 1, 1, '2026-08-11', '09:00:00', 'Scheduled', 'Chest pain'),
(2, 2, 2, '2026-08-11', '10:00:00', 'Completed', 'Skin rash'),
(3, 3, 3, '2026-08-12', '11:30:00', 'Scheduled', 'Child fever'),
(4, 4, 4, '2026-08-12', '13:00:00', 'Completed', 'General checkup'),
(5, 5, 5, '2026-08-13', '15:00:00', 'Scheduled', 'Knee pain');

INSERT INTO TREATMENT
(treatment_id, appointment_id, diagnosis, treatment_description, treatment_date, treatment_cost)
VALUES
(1, 1, 'Mild chest pain', 'ECG test and medication', '2026-08-11', 450.00),
(2, 2, 'Allergic skin rash', 'Topical cream treatment', '2026-08-11', 180.00),
(3, 3, 'Viral fever', 'Rest and fever medication', '2026-08-12', 120.00),
(4, 4, 'Routine checkup', 'General examination and blood test', '2026-08-12', 300.00),
(5, 5, 'Knee strain', 'Pain relief and physiotherapy recommendation', '2026-08-13', 400.00);

INSERT INTO PRESCRIPTION
(prescription_id, appointment_id, issue_date, notes)
VALUES
(1, 1, '2026-08-11', 'Take medication after meals'),
(2, 2, '2026-08-11', 'Apply cream twice daily'),
(3, 3, '2026-08-12', 'Drink plenty of fluids'),
(4, 4, '2026-08-12', 'Follow up after one week'),
(5, 5, '2026-08-13', 'Avoid heavy exercise');

INSERT INTO MEDICINE
(medicine_id, medicine_name, stock_quantity, unit_price, expiry_date)
VALUES
(1, 'Aspirin', 100, 15.00, '2027-12-31'),
(2, 'Hydrocortisone Cream', 60, 25.00, '2027-10-15'),
(3, 'Paracetamol', 150, 10.00, '2028-01-20'),
(4, 'Vitamin D', 80, 35.00, '2028-06-30'),
(5, 'Ibuprofen', 120, 18.00, '2027-11-25');

INSERT INTO PAYMENT
(payment_id, appointment_id, amount, payment_date, payment_status)
VALUES
(1, 1, 750.00, '2026-08-11', 'Paid'),
(2, 2, 430.00, '2026-08-11', 'Paid'),
(3, 3, 320.00, '2026-08-12', 'Paid'),
(4, 4, 575.00, '2026-08-12', 'Paid'),
(5, 5, 750.00, '2026-08-13', 'Paid');

INSERT INTO CONTAINS
(prescription_id, medicine_id, dosage, frequency, duration_days, quantity)
VALUES
(1, 1, '100 mg', 'Once daily', 7, 7),
(2, 2, 'Apply thin layer', 'Twice daily', 10, 1),
(3, 3, '500 mg', 'Every 8 hours', 5, 15),
(4, 4, '1000 IU', 'Once daily', 30, 30),
(5, 5, '400 mg', 'Twice daily', 7, 14);

INSERT INTO CASH_PAYMENT
(payment_id, received_by)
VALUES
(1, 'Receptionist A'),
(3, 'Receptionist B');

INSERT INTO CARD_PAYMENT
(payment_id, card_last_four_digits, transaction_reference)
VALUES
(2, '4821', 'TXN1002'),
(4, '7315', 'TXN1004'),
(5, '9264', 'TXN1005');

SELECT * FROM PATIENT;

SELECT * FROM DOCTOR;

SELECT * FROM APPOINTMENT;

SELECT * FROM TREATMENT;

SELECT * FROM PRESCRIPTION;

SELECT * FROM MEDICINE;

SELECT * FROM PAYMENT;

SELECT * FROM CONTAINS;

SELECT * FROM CASH_PAYMENT;

SELECT * FROM CARD_PAYMENT;

SELECT patient_id, full_name, blood_type
FROM PATIENT;
SHOW TABLES;

SELECT
    A.appointment_id,
    P.full_name AS patient_name,
    D.full_name AS doctor_name,
    A.appointment_date,
    A.status
FROM APPOINTMENT A
JOIN PATIENT P ON A.patient_id = P.patient_id
JOIN DOCTOR D ON A.doctor_id = D.doctor_id;

SELECT full_name
FROM PATIENT
WHERE patient_id IN (
    SELECT patient_id
    FROM APPOINTMENT
    WHERE status = 'Completed'
);

SELECT
    D.full_name AS doctor_name,
    COUNT(A.appointment_id) AS total_appointments
FROM DOCTOR D
JOIN APPOINTMENT A ON D.doctor_id = A.doctor_id
GROUP BY D.doctor_id, D.full_name;

UPDATE MEDICINE
SET stock_quantity = 90
WHERE medicine_id = 1;

SELECT medicine_id, medicine_name, stock_quantity
FROM MEDICINE
WHERE medicine_id = 1;

DELETE FROM CONTAINS
WHERE prescription_id = 5
  AND medicine_id = 5;

SELECT *
FROM CONTAINS
WHERE prescription_id = 5
  AND medicine_id = 5;
  
CREATE VIEW appointment_details AS
SELECT
    A.appointment_id,
    P.full_name AS patient_name,
    D.full_name AS doctor_name,
    A.appointment_date,
    A.appointment_time,
    A.status
FROM APPOINTMENT A
JOIN PATIENT P ON A.patient_id = P.patient_id
JOIN DOCTOR D ON A.doctor_id = D.doctor_id;

SELECT * FROM appointment_details;

CREATE TRIGGER reduce_medicine_stock
AFTER INSERT ON CONTAINS
FOR EACH ROW
UPDATE MEDICINE
SET stock_quantity = stock_quantity - NEW.quantity
WHERE medicine_id = NEW.medicine_id;

SELECT medicine_id, medicine_name, stock_quantity
FROM MEDICINE
WHERE medicine_id = 5;

INSERT INTO CONTAINS
(prescription_id, medicine_id, dosage, frequency, duration_days, quantity)
VALUES
(5, 5, '400 mg', 'Twice daily', 7, 14);

SELECT medicine_id, medicine_name, stock_quantity
FROM MEDICINE
WHERE medicine_id = 5;



