--------------------------------------------------------
--  File created - Friday-July-13-2018
--------------------------------------------------------
--------------------------------------------------------
--  DDL for Table DEPENDENT
--------------------------------------------------------

  CREATE TABLE dependent
   (	"essn" INTEGER,
	"dependent_name" VARCHAR(16), 
	"sex" VARCHAR(1),
	"bdate" DATE,
	"relationship" VARCHAR(16)
);
Insert into dependent (essn,dependent_name,sex,bdate,relationship) values (333445555,'Alice','F',to_date('19860405','YYYYMMDD'),'Daughter');
Insert into dependent (essn,dependent_name,sex,bdate,relationship) values (333445555,'Theodore','M',to_date('19831025','YYYYMMDD'),'Son');
Insert into dependent (essn,dependent_name,sex,bdate,relationship) values (333445555,'Joy','F',to_date('19580503','YYYYMMDD'),'Spouse');
Insert into dependent (essn,dependent_name,sex,bdate,relationship) values (987654321,'Abner','M',to_date('19420228','YYYYMMDD'),'Spouse');
Insert into dependent (essn,dependent_name,sex,bdate,relationship) values (123456789,'Michael','M',to_date('19880104','YYYYMMDD'),'Son');
Insert into dependent (essn,dependent_name,sex,bdate,relationship) values (123456789,'Alice','F',to_date('19881230','YYYYMMDD'),'Daughter');
Insert into dependent (essn,dependent_name,sex,bdate,relationship) values (123456789,'Elisabeth','F',to_date('19670505','YYYYMMDD'),'Spouse');
