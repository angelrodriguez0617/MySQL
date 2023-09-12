--
-- Sample queries
--

-- Classes taken by Ane Weiss
select * from Student, Enroll
where Student.stuID = Enroll.stuID
and Student.lastName = 'Weiss'
and Student.firstName = 'Ane';

-- All classes enrolled that had a 'C' or better
select * from Enroll, Students 
where Enroll.stuID = Students.stuID
and grade  >= 'C' and grade <> '';

-- Student who has earned the most credits
select firstName, lastName, credits
from Students 
where credits = (select max(credits) from Students);

--  All students where last name starts with 'C'
select lastName, firstName
from Students
where lastName like 'C%';

-- Insert a new Faculty member named Dennis Johnson
insert into Faculty 
    (facultyid,lastname,firstname,departmentid,facultyrankid) 
values 
    (10301,'Johnson','Dennis',1,1);
    
-- Change the room to 'HST1124A' for class ID 106
 update Classes SET room = 'HST1124A' where classid = 106;
 
-- Student  100182 is no longer enrolled in classid 1304.
-- Delete them from the Enroll table.
 delete from Enroll where stuId = 100182 and classid = 1304;
  
-- How many students are enrolled in classid 100182?
select count(*) from Enroll where classid = 100182;

-- Insert a new student named Arthur Dent 
-- Arthur has completed 60 credits.
-- Enroll Arthur in class id  1304 and he has a 'B'
insert into Student 
    (stuId,lastName,firstName,major,credits) 
values 
    (140001, 'Dent', 'Arthur', 2, 60);

insert into Enroll 
    (stuId, classNumber, grade) 
values 
    (140001,1304,'B');
    
-- Student Shonda Mikell finished the semester and earned 60 total credits. 
-- Update the number of credits earned
update Student set credits = 60 where stuId = 100156;
update Student set credits = 60 where lastName = 'Mikell' and firstName = 'Shonda';

-- Lakoya Kingsley decides to change his major to CSC and enrolled in 100739 and has a grade of a 'C'
update Student set majorid = 1 where stuId = 100007;
update Student set majorid = 1 where lastName = 'Kingsley' and firstName = 'Lakoya';

-- Enroll student 100007 into Classid 100739 and they currently have a grade of 'C'
insert into Enroll 
    (stuId, classid, grade) 
values 
    (100007,100739,'C'); 


