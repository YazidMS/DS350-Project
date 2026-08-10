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
