CREATE TABLE Employee (Fname varchar(25), Minit varchar(1),Lname varchar(25),Ssn int(9) NOT NULL, Bdate date, Address varchar(100), Sex char(1), Salary int(5), Super_ssn int(9), Dno int(5), PRIMARY KEY (Ssn));

CREATE TABLE Department (Dname varchar(25), Dnumber int(5) NOT NULL, Mgr_ssn int(9) NOT NULL, Mgr_start_date date, PRIMARY KEY (Dnumber), FOREIGN KEY (Mgr_ssn) REFERENCES Employee (Ssn));

CREATE TABLE Dept_locations(DNumber int(5) NOT NULL, DLocation varchar(25) NOT NULL, FOREIGN KEY (DNumber) REFERENCES Department (Dnumber));

CREATE TABLE Project(Pname varchar(25), Pnumber int(5) NOT NULL, Plocation varchar(25), Dnum int(5), PRIMARY KEY (Pnumber), FOREIGN KEY (Dnum) REFERENCES Department (Dnumber));

CREATE TABLE Works_on(Essn int(9) NOT NULL, Pno int(5) NOT NULL, Hours decimal(3,1), FOREIGN KEY (Essn) REFERENCES Employee (Ssn), FOREIGN KEY (Pno) REFERENCES Project (Pnumber));

CREATE TABLE Dependent(Essn int(9) NOT NULL, Dependent_name varchar(25) NOT NULL, Sex char(1), Bdate date, Relationship varchar(10), FOREIGN KEY (Essn) REFERENCES Employee (Ssn));


INSERT INTO Employee (Fname, Minit, Lname, Ssn, Bdate, Address, Sex, Salary, Super_Ssn, Dno) VALUES ('John', 'B', 'Smith', 123456789, '1965-01-09', '731 Fondren, Houston, TX', 'M', 30000, 333445555, 5);
INSERT INTO Employee (Fname, Minit, Lname, Ssn, Bdate, Address, Sex, Salary, Super_Ssn, Dno) VALUES ('Franklin', 'T', 'Wong', 333445555, '1955-12-08', '638 Voss, Houston, TX', 'M', 40000, 888665555, 5);
INSERT INTO Employee (Fname, Minit, Lname, Ssn, Bdate, Address, Sex, Salary, Super_Ssn, Dno) VALUES ('Alicia', 'J', 'Zelaya', 999887777, '1968-01-19', '3321 Castle, Spring, TX', 'M', 25000, 987654321, 4);
INSERT INTO Employee (Fname, Minit, Lname, Ssn, Bdate, Address, Sex, Salary, Super_Ssn, Dno) VALUES ('Jennifer', 'S', 'Wallace', 987654321, '1941-06-20', '291 Borry, Bellaire, TX', 'F', 43000, 888665555, 4);
INSERT INTO Employee (Fname, Minit, Lname, Ssn, Bdate, Address, Sex, Salary, Super_Ssn, Dno) VALUES ('Ramesh', 'K', 'Narayan', 666884444, '1962-09-15', '975 Fire Oak, Humble, TX', 'M', 38000, 333445555, 5);
INSERT INTO Employee (Fname, Minit, Lname, Ssn, Bdate, Address, Sex, Salary, Super_Ssn, Dno) VALUES ('Joyce', 'A', 'English', 453453453, '1972-07-31', '5631 Rice, Houston, TX', 'F', 25000, 333445555, 5);
INSERT INTO Employee (Fname, Minit, Lname, Ssn, Bdate, Address, Sex, Salary, Super_Ssn, Dno) VALUES ('James', 'E', 'Borg', 888665555, '1937-11-10', '450 Stone, Houston, TX', 'M', 55000, NULL, 1);

INSERT INTO Department (Dname, Dnumber, Mgr_ssn, Mgr_start_date) VALUES ('Research', 5, 333445555, '1988-05-22');
INSERT INTO Department (Dname, Dnumber, Mgr_ssn, Mgr_start_date) VALUES ('Administration', 4, 987654321, '1995-01-01');
INSERT INTO Department (Dname, Dnumber, Mgr_ssn, Mgr_start_date) VALUES ('Headquarters', 1, 888665555, '1981-06-19');
INSERT INTO Department (Dname, Dnumber, Mgr_ssn, Mgr_start_date) VALUES ('Development', 2, 123456789, '1996-05-05');
INSERT INTO Department (Dname, Dnumber, Mgr_ssn, Mgr_start_date) VALUES ('Testing', 3, 999887777, '1988-07-01');
INSERT INTO Department (Dname, Dnumber, Mgr_ssn, Mgr_start_date) VALUES ('Pubic Relations', 6, 666884444, '1990-04-03');

INSERT INTO Dept_locations (Dnumber, Dlocation) VALUES (1, 'Houston');
INSERT INTO Dept_locations (Dnumber, Dlocation) VALUES (4, 'Stafford');
INSERT INTO Dept_locations (Dnumber, Dlocation) VALUES (5, 'Bellaire');
INSERT INTO Dept_locations (Dnumber, Dlocation) VALUES (5, 'Sugarland');
INSERT INTO Dept_locations (Dnumber, Dlocation) VALUES (5, 'Houston');
INSERT INTO Dept_locations (Dnumber, Dlocation) VALUES (2, 'Dallas');
INSERT INTO Dept_locations (Dnumber, Dlocation) VALUES (3, 'Humble');
INSERT INTO Dept_locations (Dnumber, Dlocation) VALUES (6, 'Rice');

INSERT INTO Project (Pname, Pnumber, Plocation, Dnum) VALUES ('ProductX', 1, 'Bellaire', 5);
INSERT INTO Project (Pname, Pnumber, Plocation, Dnum) VALUES ('ProductY', 2, 'Sugarland', 5);
INSERT INTO Project (Pname, Pnumber, Plocation, Dnum) VALUES ('ProductZ', 3, 'Houston', 5);
INSERT INTO Project (Pname, Pnumber, Plocation, Dnum) VALUES ('Computerization', 10, 'Stafford', 4);
INSERT INTO Project (Pname, Pnumber, Plocation, Dnum) VALUES ('Reorganization', 20, 'Houston', 1);
INSERT INTO Project (Pname, Pnumber, Plocation, Dnum) VALUES ('Newbenefits', 30, 'Stafford', 4);

INSERT INTO Works_on (Essn, Pno, Hours) VALUES (123456789, 1, 32.5);
INSERT INTO Works_on (Essn, Pno, Hours) VALUES (123456789, 2, 7.5);
INSERT INTO Works_on (Essn, Pno, Hours) VALUES (666884444, 3, 40.0);
INSERT INTO Works_on (Essn, Pno, Hours) VALUES (453453453, 1, 20.0);
INSERT INTO Works_on (Essn, Pno, Hours) VALUES (453453453, 2, 20.0);
INSERT INTO Works_on (Essn, Pno, Hours) VALUES (333445555, 2, 10.0);

INSERT INTO Dependent (Essn, Dependent_name, Sex, Bdate, Relationship) VALUES (333445555, 'Alice', 'F', '1986-04-05', 'Daughter');
INSERT INTO Dependent (Essn, Dependent_name, Sex, Bdate, Relationship) VALUES (333445555, 'Theodore', 'M', '1983-10-25', 'Son');
INSERT INTO Dependent (Essn, Dependent_name, Sex, Bdate, Relationship) VALUES (333445555, 'Joy', 'F', '1958-05-03', 'Spouse');
INSERT INTO Dependent (Essn, Dependent_name, Sex, Bdate, Relationship) VALUES (987654321, 'Abnar', 'M', '1942-02-28', 'Spouse');
INSERT INTO Dependent (Essn, Dependent_name, Sex, Bdate, Relationship) VALUES (123456789, 'Michael', 'M', '1988-01-04', 'Son');
INSERT INTO Dependent (Essn, Dependent_name, Sex, Bdate, Relationship) VALUES (123456789, 'Alice', 'F', '1988-12-30', 'Daughter');