--
-- SQL Views
--

-- List our views
select * from information_schema.views where table_schema = 'university';

create view math_students
as
select Students.* from Students 
inner join Majors
on Students.majorid = Majors.majorid
where majordesc = 'Math';

-- Query the whole table
select * from math_students;

-- Query with a 'where' clause
select * from math_students where lastname = 'Driver';

create view juniors
as
select * from Students 
where credits between 60 and 89;

-- Select whole table
select * from juniors;

-- Join to another table
select juniors.* 
from juniors
inner join majors
on juniors.majorid = Majors.majorid;

-- Another view
create view class_MTH2387B
as
select students.lastname, students.firstname, classes.*, enroll.grade
from enroll 
inner join students
on enroll.stuid = students.stuid
inner join classes
on enroll.classid = classes.classid
where enroll.classid = 2269
order by grade;

-- view with aggregate function
create view faculty_count
as 
select count(*) from faculty;

-- Queries against view
select * from faculty_count;
select count(*) from faculty_count;

-- Group by view
create view math_students
as
select Students.* from Students 
inner join Majors
on Students.majorid = Majors.majorid
where majordesc = 'Math';