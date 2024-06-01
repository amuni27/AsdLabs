use dentalsergerydb;
CREATE TABLE address
(
    id      INT NOT NULL AUTO_INCREMENT,
    street  VARCHAR(255),
    state   VARCHAR(255),
    city    VARCHAR(255),
    zipcode INT,
    PRIMARY KEY (id)
);

CREATE TABLE dentist
(
    id             INT NOT NULL AUTO_INCREMENT,
    firstname      VARCHAR(255),
    lastname       VARCHAR(255),
    contactphone   VARCHAR(20),
    email          VARCHAR(255),
    specialization VARCHAR(255),
    PRIMARY KEY (id)
);

CREATE TABLE patient
(
    id        INT NOT NULL AUTO_INCREMENT,
    firstname VARCHAR(255),
    lastname  VARCHAR(255),
    phone     VARCHAR(20),
    email     VARCHAR(255),
    dob       DATE,
    a_id      INT,
    PRIMARY KEY (id),
    FOREIGN KEY (a_id) REFERENCES address (id)
);

CREATE TABLE surgerylocation
(
    id          INT NOT NULL AUTO_INCREMENT,
    name        VARCHAR(255),
    phonenumber VARCHAR(20),
    a_id        INT,
    PRIMARY KEY (id),
    FOREIGN KEY (a_id) REFERENCES address (id)
);

CREATE TABLE appointment
(
    id         INT NOT NULL AUTO_INCREMENT,
    appdate    DATE,
    location   VARCHAR(255), -- 'location' is a reserved keyword, better avoid using it as a column name
    status     VARCHAR(50),
    a_id       INT,
    d_id       INT,
    p_id       INT,
    PRIMARY KEY (id),
    FOREIGN KEY (a_id) REFERENCES address (id),
    FOREIGN KEY (d_id) REFERENCES dentist (id),
    FOREIGN KEY (p_id) REFERENCES patient (id)
);

INSERT INTO address (street, state, city, zipcode) VALUES ('123 Main St', 'California', 'Los Angeles', 90001);
INSERT INTO address (street, state, city, zipcode) VALUES ('456 Elm St', 'New York', 'New York City', 10001);
INSERT INTO address (street, state, city, zipcode) VALUES ('789 Oak St', 'Texas', 'Houston', 77001);

INSERT INTO dentist (firstname, lastname, contactphone, email, specialization) VALUES ('John', 'Smith', '555-1234', 'john.smith@example.com', 'General Dentistry');
INSERT INTO dentist (firstname, lastname, contactphone, email, specialization) VALUES ('Emily', 'Johnson', '555-5678', 'emily.johnson@example.com', 'Orthodontics');
INSERT INTO dentist (firstname, lastname, contactphone, email, specialization) VALUES ('Michael', 'Williams', '555-9012', 'michael.williams@example.com', 'Endodontics');

INSERT INTO patient (firstname, lastname, phone, email, dob, a_id) VALUES ('Alice', 'Brown', '555-1111', 'alice.brown@example.com', '1990-05-15', 1);
INSERT INTO patient (firstname, lastname, phone, email, dob, a_id) VALUES ('Bob', 'Johnson', '555-2222', 'bob.johnson@example.com', '1985-10-20', 2);
INSERT INTO patient (firstname, lastname, phone, email, dob, a_id) VALUES ('Charlie', 'Davis', '555-3333', 'charlie.davis@example.com', '1978-03-25', 3);

INSERT INTO surgerylocation (name, phonenumber, a_id) VALUES ('City Hospital', '555-123-4567', 1);
INSERT INTO surgerylocation (name, phonenumber, a_id) VALUES ('County Medical Center', '555-987-6543', 2);
INSERT INTO surgerylocation (name, phonenumber, a_id) VALUES ('Community Clinic', '555-456-7890', 3);

INSERT INTO appointment (appdate, location, status, a_id, d_id, p_id) VALUES ('2024-06-10', 'City Hospital', 'Scheduled', 1, 1, 1);
INSERT INTO appointment (appdate, location, status, a_id, d_id, p_id) VALUES ('2024-06-15', 'County Medical Center', 'Confirmed', 2, 2, 2);
INSERT INTO appointment (appdate, location, status, a_id, d_id, p_id) VALUES ('2024-06-20', 'Community Clinic', 'Canceled', 3, 3, 3);

-- 1. Display the list of ALL Dentists registered in the system, sorted in ascending order of their lastNames
SELECT * FROM Dentist ORDER BY lastname  ASC;

-- 2. Display the list of ALL Appointments for a given Dentist by their dentist_Id number. Include in the result, the Patient information.
SELECT A.*, P.firstname  AS patient_first_name, P.lastname  AS patient_last_name
FROM Appointment A
JOIN Patient P ON A.p_id  = P.id 
JOIN dentist d ON A.d_id = d.id 
WHERE A.d_id = d.id;


-- 3. Display the list of ALL Appointments that have been scheduled at a Surgery Location
SELECT * FROM Appointment WHERE location = 'City Hospital';

-- 4. Display the list of the Appointments booked for a given Patient on a given Date.
SELECT * 
FROM Appointment A
JOIN patient p on a.p_id  = p.id 
WHERE appdate  = '2024-06-20';
