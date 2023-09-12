-- Create a schema in the database
CREATE SCHEMA history;

-- Create table in the schema
CREATE TABLE history.Students
(
    stuID int,
    lastName varchar(50),
    firstName varchar(50),
    majorId int,
    credits int
);

-- Insert data for History Majors
insert into history.Students(stuID,lastName,firstName,majorId,credits)
select stuID,lastName,firstName,Students.majorId, credits
from Students
join Majors ON Majors.majorId = Students.majorId
where Majors.majorDesc = 'History';

-- Create Faculty table in the History schema
create table history.Faculty
(
    facultyId int,
    firstName varchar(50),
    lastName varchar(50),
    departmentId int,
    facultyRankId int
);

-- Load data for History Department
insert into history.Faculty
(facultyId,firstName,lastName,departmentId,facultyRankId)
select facultyId,firstName,lastName,Faculty.departmentId,facultyRankId
FROM Faculty
INNER JOIN Departments ON Departments.departmentId = Faculty.departmentID
where Departments.departmentDesc = 'History';

-- Create Classes table in History Schema
create table history.Classes
(
    classID int,
    buildingID char(3),
    classNumber char(10),
    facultyId int,
    dayOfTheWeekId int,
    startTimeId int,
    room varchar(10)
);

-- Insert History Classes 
insert into history.Classes
(classID,buildingID,classNumber,facultyId,
 	dayOfTheWeekId,startTimeId,room
)
select classID,buildingID,classNumber,Classes.facultyId,
 	dayOfTheWeekId,startTimeId,room
From Classes
JOIN history.Faculty ON Classes.facultyId = history.Faculty.facultyId;

-- Create Enroll Table in history Schema
create table history.Enroll
(
    stuId int,
    classId int,
    grade char(1) null
);

-- Load enrolled student in history classes
insert into history.Enroll 
(stuId, classId, grade)
select Enroll.stuId, Enroll.classId, grade
from Enroll
JOIN history.Classes
ON Enroll.classId = history.Classes.classId
JOIN history.Students
ON Enroll.stuId = history.Students.stuId;

-- The tables are different because of they are different schemas
select count(*) from public.Students;
select count(*) from history.Students;
