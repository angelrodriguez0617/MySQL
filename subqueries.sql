-- Subquery to return all students with the maximum number of credits
select firstname, lastname, majordesc, credits 
from students 
inner join majors on majors.majorid = students.majorid
where credits = (select max(credits) from students);

-- Subquery to return all students with the minimum number of credits
select firstname, lastname, majordesc, credits 
from students 
inner join majors on majors.majorid = students.majorid
where credits = (select min(credits) from students);

-- Subquery and join are equavalent
select count(*)
from students 
where majorid = (select majorid from majors where majordesc = 'CSC');

select count(*)
from students 
inner join majors on majors.majorid = students.majorid
where  majordesc = 'CSC';

--
-- Subqueries and joins are equavalent
-- All queries return the list of CSC majors
--
-- Join
select firstname, lastname, majordesc, credits 
from students 
inner join majors on majors.majorid = students.majorid
where  majordesc = 'CSC';

-- Subquery in in SELECT statement. Assumes you know the majorid value.
select firstname, lastname, (select majordesc from majors where majors.majorid = students.majorid) as majordesc, credits 
from students 
where  majorid = 1;

-- Subquery in the FROM clause. Assumes you know the majorid value.
select firstname, lastname, majordesc, credits 
from students
inner join majors on majors.majorid = students.majorid
inner join (select stuid from students where majorid = 1) as csc_table on csc_table.stuid = students.stuid;

-- Subquery in in WHERE clause.
select firstname, lastname, (select majordesc from majors where majors.majorid = students.majorid) as majordesc, credits 
from students 
where departmentid = (select departmentid from departments where departmentdesc = 'CSC');

-- All of these queries return the same results
-- The query is then number of classes not in the "CSC" building
select count(*) from classes where buildingid <> 'CSC';
select count(*) from classes where buildingid not in ('CSC');
select count(*) from classes where buildingid not in (select 'CSC');
select count(*) from classes where buildingid in (select buildingid from classes where buildingid <> 'CSC');
select count(*) from classes a where exists (select 1 from classes b where a.classid = b.classid and buildingid <> 'CSC');

-- select students lastname, firstname, grade and classnumber where the student is taking more than 1 class.
select students.stuid, students.firstname, students.lastname, enroll.grade, classnumber 
from enroll 
inner join students on students.stuid = enroll.stuid
inner join classes on classes.classid = enroll.classid
where students.stuid in (select stuid from enroll group by stuid having count(*) > 1) 
order by 1;
