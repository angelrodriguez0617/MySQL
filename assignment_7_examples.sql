--
-- Assignment 4 Examples
--

-- Group by query
-- Count number of classes tought by a faculty member
select facultyId, count(*)
from classes
group by facultyId;

-- Between query
-- Select students with stuId between 100010 and 100001;
select stuId, lastName, firstName
from students where stuId between 100001 and 100010;

-- Same as between query but a pain if many values
-- Select students with stuId between 100000 and 100010;
select stuId, lastName, firstName
from student where stuId in
(100001,
100002,
100003,
100004,
100005,
100006,
100007,
100008,
100009,
100010
);

-- Create a new schema
create schema honors;
drop table if exists honors.Students;
create table honors.Students
(
    stuID int primary key,
    lastName varchar(50),
    firstName varchar(50),
    majorId int,
    credits int
);

-- Insert first 100 rows into the table
insert into honors.Student
select * from students limit 100;

-- Rename a column using ALTER TABLE 
ALTER TABLE Faculty RENAME COLUMN lastname TO fac_lastName;

-- Rename a column back ALTER TABLE 
ALTER TABLE Faculty RENAME COLUMN fac_lastname TO lastName;

-- Add  a column using ALTER TABLE 
ALTER TABLE Faculty ADD COLUMN fac_middleName varchar(100);

-- Drop column using ALTER TABLE 
ALTER TABLE Faculty DROP COLUMN fac_middleName;

-- MySQL Stored Procedure to get a student from the database
DELIMITER //
CREATE PROCEDURE get_student
(IN int_stuId int)
BEGIN
  SELECT lastName, firstName FROM students
  WHERE stuId = int_stuId;
END //
DELIMITER ;

-- Call the procedure MySQL
call get_faculty_department(100004);

-- Get a student from database (Postgres)
create or replace function get_student (
  var_stuId int
) 
	returns table (
		lastName varchar,
		firstName varchar
	) 
	language plpgsql
as $$
begin
	return query 
		select
			students.lastName,
			students.firstName
		from
			students
		where
			students.stuId = var_stuId;
end; $$

-- How to call the function
select get_student(100004)

-- Execute a Student Minus hone.Student
-- Hint: The query will need to display all non honors students
-- You will need to alias the Student table
select a.lastName, a.lastName, a.credits, a.majorid
from Students a
left join honors.Students on honors.Students.stuId  = a.stuId
where honors.Students.stuId is null;

-- Subqueries
-- Get all students that have an A in their class
select a.stuId,a.lastName, a.lastName, a.credits, a.major
from Students a
where stuId in (select stuId from enroll where grade = 'A');

-- Same as above with a join
select students.stuId, lastName, firstName, credits, majorid
from Students
INNER JOIN enroll ON enroll.stuId = student.stuId
where grade = 'A';

-- Students who have more credits than the average number of credits
select a.stuId,a.lastName, a.firstName, a.credits, a.majorid
from Students a
where credits > (select avg(credits) from students);

-- Subquery with an UPDATE statement
-- Change Serah Dunleavy's grade in class id 792 to an 'B'
UPDATE enroll SET grade = 'B'
where classId = 792 
and stuId = (select stuId from students where firstName = 'Serah' and lastName = 'Dunleavy');
