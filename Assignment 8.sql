-- 1. Create Database Roles for the CSC, History, Art and Math departments
-- The role for CSC is CSCAdminRole
-- The role for History is HistoryAdminRole
-- The role for Art is ArtAdminRole
-- The role for Math is MathAdminRole
-- Create Role and grant permission
use university;
DROP ROLE IF EXISTS 'CSCAdminRole';
DROP ROLE IF EXISTS 'HistoryAdminRole';
DROP ROLE IF EXISTS 'ArtAdminRole';
DROP ROLE IF EXISTS 'MathAdminRole';
CREATE ROLE 'CSCAdminRole';
CREATE ROLE 'HistoryAdminRole';
CREATE ROLE 'ArtAdminRole';
CREATE ROLE 'MathAdminRole';

-- 2. Create Database Accounts for the Department Deans
-- Each Dean should be granted the role for their respective department
-- Please use these database user names for each Dean:
-- CSC - Juan Villanueva (User Name: JVillanueva)
-- Art - Amy Elliot (User Name: AElliot)
-- History - Susan Yong (User Name: SYong)
-- Math - Barbara Larson (User Name: BLarson)
use university;
DROP USER IF EXISTS 'JVillanueva'@'localhost';
DROP USER IF EXISTS 'AElliot'@'localhost';
DROP USER IF EXISTS 'SYong'@'localhost';
DROP USER IF EXISTS 'BLarson'@'localhost';
CREATE USER 'JVillanueva'@'localhost' IDENTIFIED BY '9a0BKFdFnWvy';
CREATE USER 'AElliot'@'localhost' IDENTIFIED BY 'HcoqsGbDroPT';
CREATE USER 'SYong'@'localhost' IDENTIFIED BY 'y63OovPxET2r';
CREATE USER 'BLarson '@'localhost' IDENTIFIED BY 'ks2YE0NpeqV0';
FLUSH privileges;
GRANT 'CSCAdminRole' TO 'JVillanueva'@'localhost';
GRANT 'ArtAdminRole' TO 'AElliot'@'localhost';
GRANT 'HistoryAdminRole' TO 'SYong'@'localhost';
GRANT 'MathAdminRole' TO 'BLarson'@'localhost';

-- 3, Create views for the Deans of the CSC, History, Art and Math departments
-- The views should only allow the Deans to view the data from their respective department
-- Requirements and scenarios:
-- A view will allow the Dean to select all students who major in their department
-- A view will allow the Dean to select which students are enrolled in classes in their department
-- A view will allow the Dean to select what classes their staff are teaching
-- A view where the Dean can look at the faculty in their respective department
drop view if exists CSCView1;
create view CSCView1 as
select stuid, lastname, firstname, credits, majorDesc
from students a 
join majors b on a.majorId = b.majorId
where majorDesc = 'CSC'; 
select * from CSCView1;
drop view if exists CSCView2;
create view CSCView2 as
select stuid, grade, buildingid, classnumber, facultyid, dayoftheweekid, starttimeid, room
from enroll a 
join classes b on a.classid = b.classid
where buildingid = 'CSC';
select * from CSCView2;
drop view if exists CSCView3;
create view CSCView3 as
select classid, buildingid, classnumber, dayoftheweekid, starttimeid, room, firstname, lastname, facultyrankid, departmentdesc
from classes a 
join faculty b on a.facultyid = b.facultyid
join departments c on b.departmentid = c.departmentid
where departmentdesc = 'CSC';
select * from CSCView3;
drop view if exists CSCView4;
create view CSCView4 as
select facultyid, firstname, lastname, facultyrankid, departmentdesc
from faculty a 
join departments b on a.departmentid = b.departmentid
where departmentdesc = 'CSC';
select * from CSCView4;

drop view if exists historyView1;
create view historyView1 as
select stuid, lastname, firstname, credits, majorDesc
from students a 
join majors b on a.majorId = b.majorId
where majorDesc = 'History'; 
select * from historyView1;
drop view if exists historyView2;
create view historyView2 as
select stuid, grade, buildingid, classnumber, facultyid, dayoftheweekid, starttimeid, room
from enroll a 
join classes b on a.classid = b.classid
where buildingid = 'HST';
select * from historyview2;
drop view if exists historyView3;
create view historyView3 as
select classid, buildingid, classnumber, dayoftheweekid, starttimeid, room, firstname, lastname, facultyrankid, departmentdesc
from classes a 
join faculty b on a.facultyid = b.facultyid
join departments c on b.departmentid = c.departmentid
where departmentdesc = 'History';
select * from historyView3;
drop view if exists historyView4;
create view historyView4 as
select facultyid, firstname, lastname, facultyrankid, departmentdesc
from faculty a 
join departments b on a.departmentid = b.departmentid
where departmentdesc = 'History';
select * from historyView4;

drop view if exists artView1;
create view artView1 as
select stuid, lastname, firstname, credits, majorDesc
from students a 
join majors b on a.majorId = b.majorId
where majorDesc = 'Art'; 
select * from artView1;
drop view if exists artView2;
create view artView2 as
select stuid, grade, buildingid, classnumber, facultyid, dayoftheweekid, starttimeid, room
from enroll a 
join classes b on a.classid = b.classid
where buildingid = 'ART';
select * from artview2;
drop view if exists artView3;
create view artView3 as
select classid, buildingid, classnumber, dayoftheweekid, starttimeid, room, firstname, lastname, facultyrankid, departmentdesc
from classes a 
join faculty b on a.facultyid = b.facultyid
join departments c on b.departmentid = c.departmentid
where departmentdesc = 'Art';
select * from artView3;
drop view if exists artView4;
create view artView4 as
select facultyid, firstname, lastname, facultyrankid, departmentdesc
from faculty a 
join departments b on a.departmentid = b.departmentid
where departmentdesc = 'Art';
select * from artView4;

drop view if exists MathView1;
create view MathView1 as
select stuid, lastname, firstname, credits, majorDesc
from students a 
join majors b on a.majorId = b.majorId
where majorDesc = 'Math'; 
select * from MathView1;
drop view if exists MathView2;
create view MathView2 as
select stuid, grade, buildingid, classnumber, facultyid, dayoftheweekid, starttimeid, room
from enroll a 
join classes b on a.classid = b.classid
where buildingid = 'MTH';
select * from Mathview2;
drop view if exists MathView3;
create view MathView3 as
select classid, buildingid, classnumber, dayoftheweekid, starttimeid, room, firstname, lastname, facultyrankid, departmentdesc
from classes a 
join faculty b on a.facultyid = b.facultyid
join departments c on b.departmentid = c.departmentid
where departmentdesc = 'Math';
select * from MathView3;
drop view if exists MathView4;
create view MathView4 as
select facultyid, firstname, lastname, facultyrankid, departmentdesc
from faculty a 
join departments b on a.departmentid = b.departmentid
where departmentdesc = 'Math';
select * from MathView4;

GRANT SELECT ON CSCView1 TO 'JVillanueva'@'localhost';
GRANT SELECT ON CSCView2 TO 'JVillanueva'@'localhost';
GRANT SELECT ON CSCView3 TO 'JVillanueva'@'localhost';
GRANT SELECT ON CSCView4 TO 'JVillanueva'@'localhost';

GRANT SELECT ON artView1 TO 'AElliot'@'localhost';
GRANT SELECT ON artView2 TO 'AElliot'@'localhost';
GRANT SELECT ON artView3 TO 'AElliot'@'localhost';
GRANT SELECT ON artView4 TO 'AElliot'@'localhost';

GRANT SELECT ON historyView1 TO 'SYong'@'localhost';
GRANT SELECT ON historyView2 TO 'SYong'@'localhost';
GRANT SELECT ON historyView3 TO 'SYong'@'localhost';
GRANT SELECT ON historyView4 TO 'SYong'@'localhost';

GRANT SELECT ON mathView1 TO 'BLarson'@'localhost';
GRANT SELECT ON mathView2 TO 'BLarson'@'localhost';
GRANT SELECT ON mathView3 TO 'BLarson'@'localhost';
GRANT SELECT ON mathView4 TO 'BLarson'@'localhost';

-- 4. Create an Admin User
-- Create an administrative user on the new_university database named AppAdminUser
-- Create the role AppAdminRole which has select, references, insert, update and delete on all tables
-- Create the user AppAdminUser and add it to the Role AppAdminRole
DROP USER IF EXISTS 'AppAdminUser'@'localhost';
CREATE USER 'AppAdminUser'@'localhost' IDENTIFIED BY 'password';
FLUSH privileges;
DROP ROLE IF EXISTS 'AppAdminRole';
CREATE ROLE 'AppAdminRole';
GRANT SELECT, REFERENCES, INSERT, UPDATE, DELETE ON * TO 'AppAdminRole';
GRANT 'AppAdminRole' TO 'AppAdminUser'@'localhost';
SET DEFAULT ROLE ALL TO 'AppAdminUser'@'localhost';

-- 5. Delete Data / drop objects from the Application
-- The university will no longer offer Art as a major
-- Login as postgres (Postgresql) or root (MySQL) and drop the ArtAdminRole role and the user AElliot
-- Drop all the views related to Art created in Question 1
-- Login in as AppAdminUser:
-- Run a command to verify you are connected as AppAdminUser
-- Delete all data from all tables related to 'Art' (Student Art majors, Art faculty members, Art classes and Art enrolled students)
-- The delete queries should be written as a transaction where either all deletes succeed or all fail and rollback
-- Do not use a FK constraint or trigger for this exercise
DROP ROLE IF EXISTS 'ArtAdminRole';
DROP USER IF EXISTS 'AElliot'@'localhost';
drop view if exists artView;
-- system mysql -u AppAdminUser -p
select CURRENT_USER();
SET SQL_SAFE_UPDATES = 0;

SAVEPOINT before_deleting_art;

START TRANSACTION;
    delete a from enroll a inner join classes b on a.classId = b.classId where buildingId = 'ART';
	delete from classes where buildingId = 'ART';
    delete a from faculty a inner join departments b on a.departmentId = b.departmentId where departmentDesc = 'Art';
    delete a from students a inner join majors b on a.majorId = b.majorId where majorDesc = 'Art';
COMMIT;

SELECT * FROM 
students natural join majors
where majorDesc = 'art';
