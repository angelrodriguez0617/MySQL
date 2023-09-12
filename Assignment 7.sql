-- Question 1:
-- Group all students by major in the Students table
-- The query should also return the total count of students where more than 10000 are of that major
select majorDesc, count(*) 
from Students
JOIN Majors ON Students.majorId = Majors.majorId
GROUP BY majorDesc
HAVING COUNT(majorDesc) > 10000;

-- Question 2:
-- Get the total count of Faculty by grouped by faculty rank order and order from largest  to smallest
select facultyRankDesc, count(*)
from Faculty
JOIN FacultyRank 
ON Faculty.facultyRankId = FacultyRank.facultyRankId
GROUP BY facultyRankDesc
order by count(*);

-- Question 3:
-- Create a stored procedure (function in Postgresql) that performs the following:
-- Selects the facultyId, lastName, FirstName, department and faculty rank
-- The procedure accepts as input (parameter) the name of the department (I.E. CSC)
-- Call the stored procedure passing the 'History' department
DROP PROCEDURE IF EXISTS get_faculty_by_department;
DELIMITER //
CREATE PROCEDURE get_faculty_by_department
(IN myDepartment varchar(50))
BEGIN
  SELECT facultyId, lastName, firstName, departmentDesc, facultyRankDesc FROM faculty
  INNER JOIN departments ON faculty.departmentId = departments.departmentId
  INNER JOIN facultyRank ON faculty.facultyRankId = facultyRank.facultyRankId
  WHERE departments.departmentDesc = myDepartment
  order by facultyId;
END //
DELIMITER ;
-- Call the Stored Procedure
call get_faculty_by_department('History'); 

-- Question 4:
-- Select the Last Name and First Name for all CSC majors with between 0 and 59 credits from the Students table
select lastName, firstName, majorDesc, credits from students
inner join majors on students.majorId = majors.majorId
where 59 > credits > 0 and majors.majorDesc = 'CSC'
order by credits;

-- Question 5:
-- The CSC department requires a separate table for only students who are CSC majors
-- Create a schema named CSC and create a copy of the Students table in the CSC schema
-- Select all CSC majors from the original Student table and insert the data into the new Students table in the CSC schema
-- Create a schema in the database
DROP SCHEMA IF EXISTS CSC;
CREATE SCHEMA CSC;
-- Create table in the schema
CREATE TABLE CSC.Students
(
    stuID int,
    lastName varchar(50),
    firstName varchar(50),
    majorId int,
    credits int
);
-- Insert data for CSC Majors
insert into CSC.Students(stuID,lastName,firstName,majorId,credits)
select stuID,lastName,firstName,Students.majorId, credits
from Students
join Majors ON Majors.majorId = Students.majorId
where Majors.majorDesc = 'CSC';

-- Question 6:
-- Rename the column "credits" in the original Students table to "totalCredits"
ALTER TABLE students RENAME COLUMN credits TO totalCredits;

-- Question 7:
-- Using the new column in the original Student table named totalCredits:
-- List all students who have the maximum number of credits (most credits) in the Student table and are Math majors
-- Rename the column "totalCredits" in the original Students table back to "credits"
select * 
from students join majors on students.majorId = majors.majorId
where totalCredits = (select max(totalCredits) from students) and majorDesc = 'Math';
-- -- Rename the column back to "credits"
ALTER TABLE students RENAME COLUMN totalCredits TO credits;

-- Question 8:
-- Create an index on the Students table for the last name column
-- DROP INDEX lastNameIndex ON students;
CREATE INDEX lastNameIndex
on students (lastName);

-- Question 9:
-- Add the column is_tenured with a default of "N" on the Faculty table
-- Update the Faculty table by changing the is_tenured column to 'Y' for all Faculty with the rank of Professor or Associate
-- Update the Faculty table by changing the is_tenured column to 'N' for all other Faculty ranks
-- Add a new Instructor (Your choice) and do not include the is_tenured column in the insert
-- Add  a column using ALTER TABLE 
-- ALTER TABLE Faculty DROP COLUMN is_tenured;
ALTER TABLE Faculty ADD COLUMN  is_tenured  varchar(100);
SET SQL_SAFE_UPDATES = 0;
update faculty join facultyRank on faculty.facultyRankId = facultyRank.facultyRankId 
set is_tenured = case when facultyRank.facultyRankDesc = 'Professor' or  facultyRank.facultyRankDesc = 'Associate' then 'Y' else 'N' end;
select * from faculty join facultyRank on faculty.facultyRankId = facultyRank.facultyRankId; 
-- delete from faculty where firstName = 'Craig' and lastName = 'Bell'; 
insert into faculty (facultyId, firstName, lastName, departmentId, facultyrankId)
values ((select max(facultyID) + 1), 'Craig', 'Bell', 1, 1) ;
select * from faculty;

-- Question 10:
-- Execute a Students Minus CSC.Students join
-- Hint: The query is correct if it displays all non CSC students
-- Hint 2: You will need to alias the original Students table
select *
from university.students join university.majors on university.students.majorId = university.majors.majorId
where stuID not in (select stuID from CSC.students)
order by majorDesc;

