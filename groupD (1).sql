DROP TABLE Owner CASCADE CONSTRAINTS;
DROP TABLE Pet CASCADE CONSTRAINTS;
DROP TABLE Doctor CASCADE CONSTRAINTS;
DROP TABLE Appointment CASCADE CONSTRAINTS;
DROP TABLE Fee CASCADE CONSTRAINTS;
DROP TABLE Nurse CASCADE CONSTRAINTS;
DROP TABLE NurseAppointment CASCADE CONSTRAINTS;
DROP TABLE Diagnosis CASCADE CONSTRAINTS;
DROP TABLE Prescription CASCADE CONSTRAINTS;
DROP TABLE Medication CASCADE CONSTRAINTS;
DROP TABLE Supply CASCADE CONSTRAINTS;
DROP TABLE Pharmacy CASCADE CONSTRAINTS;

CREATE TABLE Owner (
owner_id NUMBER (4) PRIMARY KEY,
owner_name VARCHAR2 (15),
owner_address VARCHAR2 (30),
pet_name VARCHAR2 (15),
pet_id NUMBER (4)
);

CREATE TABLE Pet (
pet_id NUMBER (4) GENERATED ALWAYS AS IDENTITY (START WITH 1000 INCREMENT BY 1),
owner_id NUMBER (4),
owner_name VARCHAR2 (15),
pet_name VARCHAR2 (15),
pet_type VARCHAR2 (20),
pet_gender CHAR (1) NOT NULL,
pet_age NUMBER (2) NOT NULL,
pet_color VARCHAR2 (20),
pet_weight NUMBER (4,2),
CONSTRAINT own_fk FOREIGN KEY (owner_id) 
REFERENCES  Owner (owner_id),
CONSTRAINT pet_id_pk PRIMARY KEY (pet_id),
CONSTRAINT gender_ck CHECK (pet_gender IN ('M', 'F', 'm', 'f')),
CONSTRAINT age_ck CHECK (pet_age > 0 AND pet_age <= 12),
CONSTRAINT pet_id_ck CHECK (pet_id BETWEEN 1000 AND 3000)
);

CREATE TABLE Doctor (
doc_id NUMBER (4) PRIMARY KEY,
doc_name VARCHAR2 (10),
doc_office NUMBER (2),
doc_phone NUMBER (15),
doc_email VARCHAR2 (25),
doc_contract VARCHAR2 (15),
CONSTRAINT email_ck UNIQUE (doc_email)
);

CREATE TABLE Fee (
fee_id NUMBER (4) PRIMARY KEY,
fee_amount NUMBER (2),
cancel_fee NUMBER (1) DEFAULT '0',
total_fee NUMBER (2),
CONSTRAINT fee_ck CHECK (total_fee IN ('10', '15', '20', '25'))                         
);

CREATE TABLE Appointment (
consultation_id NUMBER (6) PRIMARY KEY,
app_date DATE,
app_day CHAR (3),
doc_id NUMBER (4),
pet_id NUMBER (4),
owner_id NUMBER (4), 
fee_id NUMBER (4),
CONSTRAINT own_fk2 FOREIGN KEY (owner_id)
REFERENCES Owner (owner_id),
CONSTRAINT pet_id_fk FOREIGN KEY (pet_id)
REFERENCES Pet (pet_id),
CONSTRAINT doc_id_fk FOREIGN KEY (doc_id)
REFERENCES Doctor (doc_id),
CONSTRAINT fee_id_fk FOREIGN KEY (fee_id)
REFERENCES Fee (fee_id),
CONSTRAINT date_ck CHECK (app_day IN ('Mon', 'Fri'))
);

CREATE TABLE Nurse (
nurse_id NUMBER (4) PRIMARY KEY,
nurse_name VARCHAR2 (10),
nurse_room NUMBER (2) DEFAULT '00',
nurse_phone NUMBER (15),
nurse_email VARCHAR2 (25)
);

CREATE TABLE NurseAppointment (
consultation_id NUMBER (6),
nurse_id NUMBER (4),
CONSTRAINT nur_app_pk PRIMARY KEY (consultation_id, nurse_id),
CONSTRAINT cons_fk FOREIGN KEY (consultation_id)
REFERENCES Appointment (consultation_id),
CONSTRAINT nur_fk FOREIGN KEY (nurse_id)
REFERENCES Nurse (nurse_id)
);

CREATE TABLE Diagnosis (
pet_id NUMBER (4),
pet_age NUMBER (2),
doc_id NUMBER (4),
diag_date DATE,
consultation_id NUMBER (6),
diag_desc VARCHAR2 (40),
CONSTRAINT diag_pk PRIMARY KEY (diag_desc, consultation_id),
CONSTRAINT cons_fk2 FOREIGN KEY (consultation_id)
REFERENCES Appointment (consultation_id),
CONSTRAINT doc_id_fk2 FOREIGN KEY (doc_id)
REFERENCES Doctor (doc_id)
);

CREATE TABLE Medication (
med_id NUMBER (10) PRIMARY KEY,
med_name VARCHAR2 (20),
med_cost NUMBER (3)
);


CREATE TABLE Prescription (
diag_desc VARCHAR2 (40),
consultation_id NUMBER (6),
med_id NUMBER (10),
presc_date DATE,
CONSTRAINT presc_pk PRIMARY KEY (diag_desc, consultation_id, med_id, presc_date),
CONSTRAINT diag_pk_fk FOREIGN KEY (diag_desc, consultation_id)
REFERENCES Diagnosis (diag_desc, consultation_id),
CONSTRAINT med_id_fk FOREIGN KEY (med_id)
REFERENCES Medication (med_id)
);

CREATE TABLE Pharmacy (
phar_id NUMBER (4) PRIMARY KEY,
phar_name VARCHAR2 (20),
phar_address VARCHAR2 (30)
);

CREATE TABLE Supply (
med_id NUMBER (10),
phar_id NUMBER (4),
supply_amount NUMBER (4),
CONSTRAINT sup_pk PRIMARY KEY (med_id, phar_id),
CONSTRAINT med_id_fk2 FOREIGN KEY (med_id)
REFERENCES Medication (med_id),
CONSTRAINT phar_fk FOREIGN KEY (phar_id)
REFERENCES Pharmacy (phar_id)
);

INSERT INTO Owner (owner_id, owner_name, owner_address, pet_name, pet_id) VALUES (0001, 'David', '2 Privet Drive', 'chappyDog', 1000);
INSERT INTO Owner (owner_id, owner_name, owner_address, pet_name, pet_id) VALUES (0002, 'Sam', '3 Alott Drive', 'chiwado', 1001);
INSERT INTO Owner (owner_id, owner_name, owner_address, pet_name, pet_id) VALUES (0003, 'Craig', '56 Imp Street', 'bullyTom', 1002);
INSERT INTO Owner (owner_id, owner_name, owner_address, pet_name, pet_id) VALUES (0004, 'George', '37 Twin Road', 'terryToe', 1003);
INSERT INTO Owner (owner_id, owner_name, owner_address, pet_name, pet_id) VALUES (0005, 'Kylie', '24 Ian Street', 'poody', 1004);
INSERT INTO Owner (owner_id, owner_name, owner_address, pet_name, pet_id) VALUES (0006, 'Chabbu', '16 Harambe Street', 'dood', 1005);
INSERT INTO Owner (owner_id, owner_name, owner_address, pet_name, pet_id) VALUES (0007, 'Sarah', '4 Pale Road', 'dood', 1006);
INSERT INTO Owner (owner_id, owner_name, owner_address, pet_name, pet_id) VALUES (0008, 'Kylie', '10 East Legon Street', 'labbyDee', 1007);
INSERT INTO Owner (owner_id, owner_name, owner_address, pet_name, pet_id) VALUES (0009, 'Kylie', '55 Molten Avenue', 'shiTzo', 1008);
INSERT INTO Owner (owner_id, owner_name, owner_address, pet_name, pet_id) VALUES (0010, 'Gabby', '1052 Jericho Road', 'jake', 1009);
INSERT INTO Owner (owner_id, owner_name, owner_address, pet_name, pet_id) VALUES (0011, 'Kylie', '32 Trust Road', 'gotty', 1010);
INSERT INTO Owner (owner_id, owner_name, owner_address, pet_name, pet_id) VALUES (0012, 'Derek', '56 Hassall Avenue', 'betty', 1011);
INSERT INTO Owner (owner_id, owner_name, owner_address, pet_name, pet_id) VALUES (0013, 'Zee', '89 Gill Street', 'teriyaki', 1012);
INSERT INTO Owner (owner_id, owner_name, owner_address, pet_name, pet_id) VALUES (0014, 'Falan', '17 Antony Avenue', 'govu', 1013);
INSERT INTO Owner (owner_id, owner_name, owner_address, pet_name, pet_id) VALUES (0015, 'Bach', '2 Chalon Street', 'rex', 1014);
INSERT INTO Owner (owner_id, owner_name, owner_address, pet_name, pet_id) VALUES (0016, 'Momo', '60 Gates Road', 'shatten', 1015);

INSERT INTO Pet (owner_id, pet_name, pet_type, pet_gender, pet_age,pet_color, pet_weight, owner_name) VALUES (0001, 'chappyDog', 'Alsation', 'M', 2, 'beige', 3, 'David');
INSERT INTO Pet (owner_id, pet_name, pet_type, pet_gender, pet_age,pet_color, pet_weight, owner_name) VALUES (0002, 'chiwado', 'Chiwawa', 'F', 10, 'black', 1, 'Sam');
INSERT INTO Pet (owner_id, pet_name, pet_type, pet_gender, pet_age,pet_color, pet_weight, owner_name) VALUES (0003, 'bullyTom', 'BullDog', 'F', 6, 'grey', 4.5, 'Craig');
INSERT INTO Pet (owner_id, pet_name, pet_type, pet_gender, pet_age,pet_color, pet_weight, owner_name) VALUES (0004, 'terryToe', 'Terrier', 'F', 4, 'white', 1.2, 'George');
INSERT INTO Pet (owner_id, pet_name, pet_type, pet_gender, pet_age,pet_color, pet_weight, owner_name) VALUES (0005, 'poody', 'Boxer', 'M', 8, 'black', 1, 'Kylie');
INSERT INTO Pet (owner_id, pet_name, pet_type, pet_gender, pet_age,pet_color, pet_weight, owner_name) VALUES (0006, 'dood', 'Dalmation', 'F', 3, 'spotted', 7, 'Chabbu');
INSERT INTO Pet (owner_id, pet_name, pet_type, pet_gender, pet_age,pet_color, pet_weight, owner_name) VALUES (0007, 'dood', 'SheepWolf', 'M', 11, 'brown', 10, 'Sarah');
INSERT INTO Pet (owner_id, pet_name, pet_type, pet_gender, pet_age,pet_color, pet_weight, owner_name) VALUES (0008, 'labbyDee', 'Labrador', 'M', 12, 'white', 11, 'Kylie');
INSERT INTO Pet (owner_id, pet_name, pet_type, pet_gender, pet_age,pet_color, pet_weight, owner_name) VALUES (0009, 'shiTzo', 'Shih Tzu', 'F', 7, 'mixed_brown', 1, 'Kylie');
INSERT INTO Pet (owner_id, pet_name, pet_type, pet_gender, pet_age,pet_color, pet_weight, owner_name) VALUES (0010, 'jake', ' ', 'M', 3, 'greyish_white', 4, 'Gabby');
INSERT INTO Pet (owner_id, pet_name, pet_type, pet_gender, pet_age,pet_color, pet_weight, owner_name) VALUES (0011, 'gotty', ' ', 'M', 4, 'mixed_brown', 1, 'Kylie');
INSERT INTO Pet (owner_id, pet_name, pet_type, pet_gender, pet_age,pet_color, pet_weight, owner_name) VALUES (0012, 'betty', ' ', 'F', 5, 'brown', 2.5, 'Derek');
INSERT INTO Pet (owner_id, pet_name, pet_type, pet_gender, pet_age,pet_color, pet_weight, owner_name) VALUES (0013, 'teriyaki', 'Terrier', 'M', 7, 'black', 4, 'Zee');
INSERT INTO Pet (owner_id, pet_name, pet_type, pet_gender, pet_age,pet_color, pet_weight, owner_name) VALUES (0014, 'govu', ' ', 'M', 4, ' ', 2.6, 'Falan');
INSERT INTO Pet (owner_id, pet_name, pet_type, pet_gender, pet_age,pet_color, pet_weight, owner_name) VALUES (0015, 'rex', ' ', 'M', 9, ' ', 10, 'Bach');
INSERT INTO Pet (owner_id, pet_name, pet_type, pet_gender, pet_age,pet_color, pet_weight, owner_name) VALUES (0016, 'shatten', 'German_shepherd', 'M', 5, 'brown', 10, 'Momo');

INSERT INTO Doctor (doc_id, doc_name, doc_office, doc_phone, doc_email, doc_contract) VALUES (2200, 'Cleverly', 12, 07323456230, 'cleverly_cl@noahs.com', 'part-time');
INSERT INTO Doctor (doc_id, doc_name, doc_office, doc_phone, doc_email, doc_contract) VALUES (2201, 'Mike', 34, 07323456442, 'mikeK@noahs.com', 'full-time');
INSERT INTO Doctor (doc_id, doc_name, doc_office, doc_phone, doc_email, doc_contract) VALUES (2202, 'Farraday', 34, 07323456253, 'farradayF@noahs.com', 'full-time');
INSERT INTO Doctor (doc_id, doc_name, doc_office, doc_phone, doc_email, doc_contract) VALUES (2203, 'Fred', 41, 07323456579, 'fredF@noahs.com', 'full-time');
INSERT INTO Doctor (doc_id, doc_name, doc_office, doc_phone, doc_email, doc_contract) VALUES (2204, 'Watson', 1, 07323456570, 'watsS@noahs.com', 'full-time');
INSERT INTO Doctor (doc_id, doc_name, doc_office, doc_phone, doc_email, doc_contract) VALUES (2205, 'Freeman', 2, 07323456001, 'freemanF@noahs.com', 'full-time');
INSERT INTO Doctor (doc_id, doc_name, doc_office, doc_phone, doc_email, doc_contract) VALUES (2206, 'Crowley', 10, 07323456595, 'crowleyC@noahs.com', 'full-time');
INSERT INTO Doctor (doc_id, doc_name, doc_office, doc_phone, doc_email, doc_contract) VALUES (2207, 'Rahib', 16, 07323456052, 'rahibB@noahs.com', 'full-time');
INSERT INTO Doctor (doc_id, doc_name, doc_office, doc_phone, doc_email, doc_contract) VALUES (2208, 'Percy', 2, 07323454561, 'percyS@noahs.com', 'part-time');
INSERT INTO Doctor (doc_id, doc_name, doc_office, doc_phone, doc_email, doc_contract) VALUES (2209, 'Roy', 45, 07323455553, 'royK@noahs.com', 'full-time');
INSERT INTO Doctor (doc_id, doc_name, doc_office, doc_phone, doc_email, doc_contract) VALUES (2210, 'Armstrong', 15, 07323456577, 'arms_L@noahs.com', 'full-time');
INSERT INTO Doctor (doc_id, doc_name, doc_office, doc_phone, doc_email, doc_contract) VALUES (2211, 'Chester', 16, 07323456573, 'chesterB@noahs.com', 'part-time');
INSERT INTO Doctor (doc_id, doc_name, doc_office, doc_phone, doc_email, doc_contract) VALUES (2212, 'Amy', 11, 07323456582, 'AmyL@noahs.com', 'full-time');

INSERT INTO Fee (fee_id, fee_amount, cancel_fee, total_fee) VALUES (0100, 10, 0, 10);
INSERT INTO Fee (fee_id, fee_amount, cancel_fee, total_fee) VALUES (0101, 10, 0, 10);
INSERT INTO Fee (fee_id, fee_amount, cancel_fee, total_fee) VALUES (0103, 15, 0, 15);
INSERT INTO Fee (fee_id, fee_amount, cancel_fee, total_fee) VALUES (0108, 15, 0, 15);
INSERT INTO Fee (fee_id, fee_amount, cancel_fee, total_fee) VALUES (0116, 10, 0, 10);
INSERT INTO Fee (fee_id, fee_amount, cancel_fee, total_fee) VALUES (0122, 15, 0, 15);
INSERT INTO Fee (fee_id, fee_amount, cancel_fee, total_fee) VALUES (0123, 10, 0, 10);
INSERT INTO Fee (fee_id, fee_amount, cancel_fee, total_fee) VALUES (0126, 10, 0, 10);
INSERT INTO Fee (fee_id, fee_amount, cancel_fee, total_fee) VALUES (0132, 20, 0, 20);
INSERT INTO Fee (fee_id, fee_amount, cancel_fee, total_fee) VALUES (0135, 15, 0, 15);
INSERT INTO Fee (fee_id, fee_amount, cancel_fee, total_fee) VALUES (0146, 20, 0, 20);
INSERT INTO Fee (fee_id, fee_amount, cancel_fee, total_fee) VALUES (0150, 20, 0, 20);
INSERT INTO Fee (fee_id, fee_amount, cancel_fee, total_fee) VALUES (0177, 15, 0, 15);

INSERT INTO Appointment (consultation_id, app_date, app_day, doc_id, pet_id, owner_id, fee_id) VALUES (105005, '05-Aug-19', 'Mon', 2201, 1000, 0001, 0100);
INSERT INTO Appointment (consultation_id, app_date, app_day, doc_id, pet_id, owner_id, fee_id) VALUES (105006, '05-Aug-19', 'Mon', 2200, 1003, 0004, 0101);
INSERT INTO Appointment (consultation_id, app_date, app_day, doc_id, pet_id, owner_id, fee_id) VALUES (105008, '09-Aug-19', 'Fri', 2201, 1004, 0005, 0103);
INSERT INTO Appointment (consultation_id, app_date, app_day, doc_id, pet_id, owner_id, fee_id) VALUES (105012, '16-Aug-19', 'Fri', 2202, 1001, 0002, 0108);
INSERT INTO Appointment (consultation_id, app_date, app_day, doc_id, pet_id, owner_id, fee_id) VALUES (105060, '02-Sep-19', 'Mon', 2206, 1005, 0006, 0116);
INSERT INTO Appointment (consultation_id, app_date, app_day, doc_id, pet_id, owner_id, fee_id) VALUES (105077, '06-Sep-19', 'Fri', 2202, 1008, 0009, 0122);
INSERT INTO Appointment (consultation_id, app_date, app_day, doc_id, pet_id, owner_id, fee_id) VALUES (105078, '06-Sep-19', 'Fri', 2201, 1000, 0001, 0123);
INSERT INTO Appointment (consultation_id, app_date, app_day, doc_id, pet_id, owner_id, fee_id) VALUES (105091, '09-Sep-19', 'Mon', 2202, 1003, 0004, 0126);
INSERT INTO Appointment (consultation_id, app_date, app_day, doc_id, pet_id, owner_id, fee_id) VALUES (105098, '27-Sep-19', 'Fri', 2204, 1006, 0007, 0132);
INSERT INTO Appointment (consultation_id, app_date, app_day, doc_id, pet_id, owner_id, fee_id) VALUES (105187, '29-Sep-19', 'Mon', 2203, 1002, 0003, 0135);
INSERT INTO Appointment (consultation_id, app_date, app_day, doc_id, pet_id, owner_id, fee_id) VALUES (105215, '04-Oct-19', 'Fri', 2203, 1007, 0008, 0146);
INSERT INTO Appointment (consultation_id, app_date, app_day, doc_id, pet_id, owner_id, fee_id) VALUES (105235, '07-Oct-19', 'Mon', 2204, 1006, 0007, 0150);
INSERT INTO Appointment (consultation_id, app_date, app_day, doc_id, pet_id, owner_id, fee_id) VALUES (105244, '11-Oct-19', 'Fri', 2203, 1002, 0003, 0177);

INSERT INTO Diagnosis (pet_id, pet_age, doc_id, diag_date, consultation_id, diag_desc) VALUES (1000, 2, 2201, '05-Aug-19', 105005, 'Bring him Tuesdays 10 to 12:00pm');
INSERT INTO Diagnosis (pet_id, pet_age, doc_id, diag_date, consultation_id, diag_desc) VALUES (1003, 4, 2200, '05-Aug-19', 105006, 'Get Drug AA from Smiths Pharmacy');
INSERT INTO Diagnosis (pet_id, pet_age, doc_id, diag_date, consultation_id, diag_desc) VALUES (1006, 11, 2204, '07-Oct-19', 105235, 'Take Park walks every evening');
INSERT INTO Diagnosis (pet_id, pet_age, doc_id, diag_date, consultation_id, diag_desc) VALUES (1002, 6, 2203, '11-Oct-19',105244, 'Surgery on 21 Nov 2019');
INSERT INTO Diagnosis (pet_id, pet_age, doc_id, diag_date, consultation_id, diag_desc) VALUES (1000, 2, 2201, '06-Sep-19', 105078, 'Needs socialisation treats');
INSERT INTO Diagnosis (pet_id, pet_age, doc_id, diag_date, consultation_id, diag_desc) VALUES (1003, 4, 2202, '09-Sep-19', 105091, 'Ultrasonic dental scaling in two weeks');
INSERT INTO Diagnosis (pet_id, pet_age, doc_id, diag_date, consultation_id, diag_desc) VALUES (1002, 6, 2203, '29-Sep-19', 105187, 'Needs socialisation treats and worming');
INSERT INTO Diagnosis (pet_id, pet_age, doc_id, diag_date, consultation_id, diag_desc) VALUES (1006, 11, 2204, '07-Oct-19', 105235, 'Overgrown Skin');

INSERT INTO Nurse (nurse_id, nurse_name, nurse_room, nurse_phone, nurse_email) VALUES (0012, 'Margareth', 00, 07463467790, 'magM@noahs.com');
INSERT INTO Nurse (nurse_id, nurse_name, nurse_room, nurse_phone, nurse_email) VALUES (007, 'Fiona', 00, 07463467754, 'fioD@noahs.com');
INSERT INTO Nurse (nurse_id, nurse_name, nurse_room, nurse_phone, nurse_email) VALUES (003, 'Daniele', 00, 07463467732, 'danO@noahs.com');
INSERT INTO Nurse (nurse_id, nurse_name, nurse_room, nurse_phone, nurse_email) VALUES (005, 'Amiel', 00, 07463445738, 'amiL@noahs.com');
INSERT INTO Nurse (nurse_id, nurse_name, nurse_room, nurse_phone, nurse_email) VALUES (008, 'Ruhina', 00, 074612465950, 'ruhiM@noahs.com');

INSERT INTO NurseAppointment (consultation_id, nurse_id) VALUES (105005, 0012);
INSERT INTO NurseAppointment (consultation_id, nurse_id) VALUES (105005, 0007);
INSERT INTO NurseAppointment (consultation_id, nurse_id) VALUES (105005, 0003);
INSERT INTO NurseAppointment (consultation_id, nurse_id) VALUES (105235, 0005);
INSERT INTO NurseAppointment (consultation_id, nurse_id) VALUES (105235, 0008);

INSERT INTO Medication (med_id, med_name, med_cost) VALUES (1003245645, 'AAA Relief', 12);
INSERT INTO Medication (med_id, med_name, med_cost) VALUES (1003245636, 'Promera Experts', 8);
INSERT INTO Medication (med_id, med_name, med_cost) VALUES (1003245621, 'X-Files', 5);
INSERT INTO Medication (med_id, med_name, med_cost) VALUES (1003245619, 'Battling Beast', 10);
INSERT INTO Medication (med_id, med_name, med_cost) VALUES (1003245612, 'Forvalax', 15);

INSERT INTO Prescription (diag_desc, consultation_id, med_id, presc_date) VALUES ('Get Drug AA from Smiths Pharmacy', 105006, 1003245645, '05-Aug-19');
INSERT INTO Prescription (diag_desc, consultation_id, med_id, presc_date) VALUES ('Overgrown Skin', 105235, 1003245621, '07-Oct-19');
INSERT INTO Prescription (diag_desc, consultation_id, med_id, presc_date) VALUES ('Bring him Tuesdays 10 to 12:00pm', 105005, 1003245636 , '05-Aug-19');
INSERT INTO Prescription (diag_desc, consultation_id, med_id, presc_date) VALUES ('Needs socialisation treats', 105078, 1003245619, '06-Sep-19');
INSERT INTO Prescription (diag_desc, consultation_id, med_id, presc_date) VALUES ('Ultrasonic dental scaling in two weeks', 105091, 1003245612, '09-Sep-19');

INSERT INTO Pharmacy (phar_id, phar_name, phar_address) VALUES (2050, 'Smiths Pharmacy', '36 Avalon Park Road');
INSERT INTO Pharmacy (phar_id, phar_name, phar_address) VALUES (2012, 'Jericho Pharmacy', '18 Jericho Avenue');
INSERT INTO Pharmacy (phar_id, phar_name, phar_address) VALUES (2038, 'HHH Pharmacy', '15 The Game Road');
INSERT INTO Pharmacy (phar_id, phar_name, phar_address) VALUES (2099, 'St.Ann Pharmacy', '42 Barabban Street');
INSERT INTO Pharmacy (phar_id, phar_name, phar_address) VALUES (2550, 'Golden Pharmacy', '7 Lower Sheriff Road');

INSERT INTO Supply (med_id, phar_id, supply_amount) VALUES (1003245645, 2050, 700);
INSERT INTO Supply (med_id, phar_id, supply_amount) VALUES (1003245636, 2050, 300);
INSERT INTO Supply (med_id, phar_id, supply_amount) VALUES (1003245621, 2038, 150);
INSERT INTO Supply (med_id, phar_id, supply_amount) VALUES (1003245619, 2099, 500);
INSERT INTO Supply (med_id, phar_id, supply_amount) VALUES (1003245612, 2550, 200);

--Part 3 - question 1
SELECT pet_id AS "ID", pet_name AS "Name", pet_age AS "Age"
FROM Pet
WHERE pet_name BETWEEN 'a' AND 'm'
ORDER BY pet_id DESC, pet_name;

--alternatively,this one works too:

SELECT pet_id AS "ID", pet_name AS "Name", pet_age AS "Age"
FROM Pet
WHERE pet_name < 'n'
ORDER BY pet_id DESC, pet_name;


--Part 3 - question 2
SELECT doc_id, doc_name, doc_office, doc_contract, (SELECT COUNT (doc_id) 
FROM Appointment
WHERE Appointment.doc_id = Doctor.doc_id
) AS Workload
FROM Doctor
WHERE (SELECT COUNT (doc_id) 
FROM Appointment
WHERE Appointment.doc_id = Doctor.doc_id) = 3 AND doc_contract = 'part-time' OR (SELECT COUNT (doc_id) 
FROM Appointment
WHERE Appointment.doc_id = Doctor.doc_id) > 3 AND doc_contract = 'part-time'
;

--Above is what we have been asked in the document. However, based on those parameters, no data will be found (based on our design). 
--It is not a mistake in our coding. For proof, consider the following below, replacing "part-time" parameter in the WHERE with "full-time" and 3 results will be found:

SELECT doc_id, doc_name, doc_office, doc_contract, (SELECT COUNT (doc_id) 
FROM Appointment
WHERE Appointment.doc_id = Doctor.doc_id
) AS Workload
FROM Doctor
WHERE (SELECT COUNT (doc_id) 
FROM Appointment
WHERE Appointment.doc_id = Doctor.doc_id) = 3 AND doc_contract = 'full-time' OR (SELECT COUNT (doc_id) 
FROM Appointment
WHERE Appointment.doc_id = Doctor.doc_id) > 3 AND doc_contract = 'full-time'
;


--Part 3 - question 3
SELECT Pet.pet_id, Pet.pet_name, Appointment.app_date, (SELECT COUNT (pet_id) 
FROM Appointment
WHERE Appointment.pet_id = Pet.pet_id
) AS Number_of_Appointments 
FROM Pet
INNER JOIN Appointment
ON Pet.pet_id = Appointment.pet_id
WHERE app_date BETWEEN '02-Jan-19' AND '26-Sep-19' AND (SELECT COUNT (pet_id) 
FROM Appointment
WHERE Appointment.pet_id = Pet.pet_id) = 2 OR
app_date BETWEEN '02-Jan-19' AND '26-Sep-19' AND (SELECT COUNT (pet_id) 
FROM Appointment
WHERE Appointment.pet_id = Pet.pet_id) > 2
; 

--On a personal note, this was by far the hardest query of them all.


--Part 3 - question 4
SELECT Appointment.pet_id, (SELECT pet_name FROM Pet WHERE Appointment.pet_id = Pet.pet_id) AS PetName, Fee.fee_id
FROM Appointment
INNER JOIN Fee
ON Appointment.fee_id = Fee.fee_id
WHERE total_fee < (SELECT AVG(total_fee) FROM Fee)
;

--the following code gives us even more details on screen, such as the actual average value displayed on screen:

SELECT Appointment.pet_id, (SELECT pet_name FROM Pet WHERE Appointment.pet_id = Pet.pet_id) AS PetName, Fee.fee_id, Fee.total_fee, (SELECT AVG(total_fee) FROM Fee) AS Fee_Average
FROM Appointment
INNER JOIN Fee
ON Appointment.fee_id = Fee.fee_id
WHERE total_fee < (SELECT AVG(total_fee) FROM Fee)
;


--part 3 - question 5
SELECT diag_date, pet_id, (SELECT pet_name FROM Pet WHERE Diagnosis.pet_id = Pet.pet_id) AS PetName, doc_id, (SELECT doc_contract FROM Doctor WHERE Diagnosis.doc_id = Doctor.doc_id) AS DocStatus,
(SELECT COUNT (doc_id) FROM Appointment WHERE Appointment.doc_id = Diagnosis.doc_id) AS Doc_Case_handled, diag_desc 
FROM Diagnosis
WHERE diag_desc LIKE '%soc%' OR diag_desc LIKE '%den%'
;


--part 3 - question 6
SELECT pet_id, pet_name 
FROM Pet
WHERE Pet.pet_id NOT IN (SELECT Appointment.pet_id FROM Appointment WHERE Pet.pet_id = Appointment.pet_id)
OR Pet.pet_id NOT IN (SELECT Diagnosis.pet_id FROM Diagnosis WHERE Pet.pet_id = Diagnosis.pet_id)
;


--Thank you, I learned a lot. :)


--An extra (Bonus) query displaying the nurses present at an appointment (we didn't get to do much with them), their number and names.
SELECT pet_id, app_day, app_date, doc_id, (SELECT COUNT (nurse_id) FROM NurseAppointment WHERE NurseAppointment.consultation_id = Appointment.consultation_id) AS "Number of nurses",
(SELECT nurse_name FROM Nurse WHERE NurseAppointment.nurse_id = Nurse.nurse_id) AS "Nurse name"
FROM Appointment
INNER JOIN NurseAppointment
ON NurseAppointment.consultation_id = Appointment.consultation_id
;





