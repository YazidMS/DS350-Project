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