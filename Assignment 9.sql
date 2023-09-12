-- Query:
select firstname, lastname, departmentdesc from faculty
inner join departments on faculty.departmentId = departments.departmentId
where departmentdesc = 'CSC';
-- Questions:
-- Convert this query to use a SELECT subquery
select firstname, lastname, (select departmentdesc from departments where departments.departmentid = faculty.departmentid) as departmentdesc
from faculty 
where  departmentid = 1;
-- Convert this query to use a FROM subquery
select firstname, lastname, departmentdesc
from faculty
inner join departments on faculty.departmentid = departments.departmentid
inner join (select facultyid from faculty where departmentid = 1) as csc_table on csc_table.facultyid = faculty.facultyid;
-- Convert this query to use a WHERE subquery
select firstname, lastname, (select departmentdesc from departments where departments.departmentid = faculty.departmentid) as deparmentdesc
from faculty
where departmentid = (select departmentid from departments where departmentdesc = 'CSC');

-- Query
select classnumber, room, buildingdesc, dayoftheweekdesc from classes
inner join buildings on buildings.buildingid = classes.buildingid
inner join dayoftheweek on dayoftheweek.dayoftheweekid = classes.dayoftheweekid
where dayoftheweekdesc = 'Friday';
-- Questions:
-- Convert this query to use a SELECT subquery
select  classnumber, room, (select buildingdesc from buildings b where a.buildingid = b.buildingid) as buildingdesc, 
(select dayoftheweekdesc from dayoftheweek c where c.dayoftheweekid = a.dayoftheweekid) as dayoftheweekdesc
from classes a
where  dayoftheweekid = 5;
-- Convert this query to use a FROM subquery
select classnumber, room, buildingdesc, dayoftheweekdesc
from classes a
inner join buildings b on a.buildingid = b.buildingid
inner join dayoftheweek c on a.dayOfTheWeekId = c.dayOfTheWeekId
inner join (select classid from classes where dayOfTheWeekId = 5) as friday_table on friday_table.classid = a.classid;
-- Convert this query to use a WHERE subquery
select  classnumber, room, (select buildingdesc from buildings b where a.buildingid = b.buildingid) as buildingdesc, 
(select dayoftheweekdesc from dayoftheweek c where c.dayoftheweekid = a.dayoftheweekid) as dayoftheweekdesc
from classes a
where  dayoftheweekid = (select dayOfTheWeekId from dayoftheweek where dayOfTheWeekDesc = 'Friday');