--------------------------------------------------------
--  File created - Friday-July-13-2018
--------------------------------------------------------
--------------------------------------------------------
--  DDL for Table employee
--------------------------------------------------------

  CREATE TABLE employee
   (	"fname" VARCHAR(15),
	"minit" VARCHAR(1),
	"lname" VARCHAR(15), 
	"ssn" INTEGER,
	"bdate" DATE,
	"address" VARCHAR(255),
	"sex" VARCHAR(1),
	"salary" INTEGER,
	"super_ssn" INTEGER,
	"dno" INTEGER
);
Insert into employee (fname,minit,lname,ssn,bdate,address,sex,salary,super_ssn,dno) values ('John','B','Smith',123456789,to_date('19650109','YYYYMMDD'),'731 Fondren, Houston, TX','M',30000,333445555,5);
Insert into employee (fname,minit,lname,ssn,bdate,address,sex,salary,super_ssn,dno) values ('Franklin','T','Wong',333445555,to_date('19551208','YYYYMMDD'),'638 Voss, Houston, TX','M',40000,888665555,5);
Insert into employee (fname,minit,lname,ssn,bdate,address,sex,salary,super_ssn,dno) values ('Alicia','J','Zelaya',999887777,to_date('19680119','YYYYMMDD'),'3321 Castle, Spring, TX','F',25000,987654321,4);
Insert into employee (fname,minit,lname,ssn,bdate,address,sex,salary,super_ssn,dno) values ('Jennifer','S','Wallace',987654321,to_date('19410620','YYYYMMDD'),'291 Berry, Bellaire, TX','F',43000,888665555,4);
Insert into employee (fname,minit,lname,ssn,bdate,address,sex,salary,super_ssn,dno) values ('Ramesh','K','Narayan',666884444,to_date('19620915','YYYYMMDD'),'975 Fire Oak, Humble, TX','M',38000,333445555,5);
Insert into employee (fname,minit,lname,ssn,bdate,address,sex,salary,super_ssn,dno) values ('Joyce','A','English',453453453,to_date('19720731','YYYYMMDD'),'5631 Rice, Houston, TX','F',25000,333445555,5);
Insert into employee (fname,minit,lname,ssn,bdate,address,sex,salary,super_ssn,dno) values ('Ahmad','V','Jabbar',987987987,to_date('19690329','YYYYMMDD'),'980 Dallas, Houston, TX','M',25000,987654321,4);
Insert into employee (fname,minit,lname,ssn,bdate,address,sex,salary,super_ssn,dno) values ('James','E','Borg',888665555,to_date('19371110','YYYYMMDD'),'450 Stone, Houston, TX','M',55000,null,1);
