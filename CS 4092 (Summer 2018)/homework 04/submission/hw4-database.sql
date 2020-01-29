-- DATABASE DUMP FOR HOMEWORK 4
-- CS 4092, Summer 2018
-- Martina Desender (M07771641) and Hayden Schiff (M12752592)

CREATE TABLE department (
    dname VARCHAR(15),
    dnumber INTEGER,
    mgr_ssn INTEGER,
    mgr_start_date INTEGER
);

CREATE TABLE dependent (
    essn INTEGER,
    dependent_name VARCHAR(16),
    sex VARCHAR(1),
    bdate DATE,
    relationship VARCHAR(16)
);

CREATE TABLE dept_locations (
    dnumber INTEGER,
    dlocation VARCHAR(16)
);

CREATE TABLE employee (
    fname VARCHAR(15),
    minit VARCHAR(1),
    lname VARCHAR(15),
    ssn INTEGER,
    bdate DATE,
    address VARCHAR(255),
    sex VARCHAR(1),
    salary INTEGER,
    super_ssn INTEGER,
    dno INTEGER
);

CREATE TABLE project (
    pname VARCHAR(16),
    pnumber INTEGER,
    plocation VARCHAR(16),
    dnum INTEGER
);

CREATE TABLE works_on (
    essn INTEGER,
    pno INTEGER,
    hours INTEGER
);

INSERT INTO department VALUES ('Research', 5, 333445555, 19880522);
INSERT INTO department VALUES ('Administration', 4, 987654321, 19550101);
INSERT INTO department VALUES ('Headquarters', 1, 888665555, 19810619);

INSERT INTO dependent VALUES (333445555, 'Alice', 'F', '1986-04-05', 'Daughter');
INSERT INTO dependent VALUES (333445555, 'Theodore', 'M', '1983-10-25', 'Son');
INSERT INTO dependent VALUES (333445555, 'Joy', 'F', '1958-05-03', 'Spouse');
INSERT INTO dependent VALUES (987654321, 'Abner', 'M', '1942-02-28', 'Spouse');
INSERT INTO dependent VALUES (123456789, 'Michael', 'M', '1988-01-04', 'Son');
INSERT INTO dependent VALUES (123456789, 'Alice', 'F', '1988-12-30', 'Daughter');
INSERT INTO dependent VALUES (123456789, 'Elisabeth', 'F', '1967-05-05', 'Spouse');

INSERT INTO dept_locations VALUES (1, 'Houston');
INSERT INTO dept_locations VALUES (4, 'Stafford');
INSERT INTO dept_locations VALUES (5, 'Bellaire');
INSERT INTO dept_locations VALUES (5, 'Houston');
INSERT INTO dept_locations VALUES (5, 'Sugarland');

INSERT INTO employee VALUES ('John', 'B', 'Smith', 123456789, '1965-01-09', '731 Fondren, Houston, TX', 'M', 30000, 333445555, 5);
INSERT INTO employee VALUES ('Franklin', 'T', 'Wong', 333445555, '1955-12-08', '638 Voss, Houston, TX', 'M', 40000, 888665555, 5);
INSERT INTO employee VALUES ('Alicia', 'J', 'Zelaya', 999887777, '1968-01-19', '3321 Castle, Spring, TX', 'F', 25000, 987654321, 4);
INSERT INTO employee VALUES ('Jennifer', 'S', 'Wallace', 987654321, '1941-06-20', '291 Berry, Bellaire, TX', 'F', 43000, 888665555, 4);
INSERT INTO employee VALUES ('Ramesh', 'K', 'Narayan', 666884444, '1962-09-15', '975 Fire Oak, Humble, TX', 'M', 38000, 333445555, 5);
INSERT INTO employee VALUES ('Joyce', 'A', 'English', 453453453, '1972-07-31', '5631 Rice, Houston, TX', 'F', 25000, 333445555, 5);
INSERT INTO employee VALUES ('Ahmad', 'V', 'Jabbar', 987987987, '1969-03-29', '980 Dallas, Houston, TX', 'M', 25000, 987654321, 4);
INSERT INTO employee VALUES ('James', 'E', 'Borg', 888665555, '1937-11-10', '450 Stone, Houston, TX', 'M', 55000, NULL, 1);

INSERT INTO project VALUES ('ProductX', 1, 'Bellaire', 5);
INSERT INTO project VALUES ('ProductY', 2, 'Sugarland', 5);
INSERT INTO project VALUES ('ProductZ', 3, 'Houston', 5);
INSERT INTO project VALUES ('Computerization', 10, 'Stafford', 4);
INSERT INTO project VALUES ('Reorganization', 20, 'Houston', 1);
INSERT INTO project VALUES ('Newbenefits', 30, 'Stafford', 4);

INSERT INTO works_on VALUES (123456789, 1, 33);
INSERT INTO works_on VALUES (123456789, 2, 8);
INSERT INTO works_on VALUES (666884444, 3, 40);
INSERT INTO works_on VALUES (453453453, 1, 20);
INSERT INTO works_on VALUES (453453453, 2, 20);
INSERT INTO works_on VALUES (333445555, 2, 10);
INSERT INTO works_on VALUES (333445555, 3, 10);
INSERT INTO works_on VALUES (333445555, 10, 10);
INSERT INTO works_on VALUES (333445555, 20, 10);
INSERT INTO works_on VALUES (999887777, 30, 30);
INSERT INTO works_on VALUES (999887777, 10, 10);
INSERT INTO works_on VALUES (987987987, 10, 35);
INSERT INTO works_on VALUES (987987987, 30, 5);
INSERT INTO works_on VALUES (987654321, 30, 20);
INSERT INTO works_on VALUES (987654321, 20, 15);
INSERT INTO works_on VALUES (888665555, 20, NULL);
