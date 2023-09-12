-- ALTER TABLE enroll DROP COLUMN gradePoints;
ALTER TABLE enroll ADD COLUMN gradePoints int;
SET SQL_SAFE_UPDATES = 0;
update enroll
set gradePoints = case 
when enroll.grade = 'A' then 4
when enroll.grade = 'B' then 3
when enroll.grade = 'C' then 2 end;

-- Query to get all the grades of all CSC majored students who are enrolled in more than 2 classes the GPA magic stuff is all done in Python
select enroll.stuid, lastname, firstname, classid, grade, gradepoints 
from enroll join students on enroll.stuid = students.stuid where enroll.stuid in 
(select students.stuid from enroll join students on students.stuid = enroll.stuid
where majorid = (select majorid from majors where majordesc = 'CSC')
group by enroll.stuId having count(*) > 2);

-- Query to get stuid, lastname, firstname, and GPA of all CSC majored students who are enrolled in more than 2 classes
SELECT enroll.stuid, lastName, firstname, SUM(enroll.gradePoints)/count(enroll.classid) as GPA
FROM enroll join students on students.stuid = enroll.stuid
where majorid = (select majorid from majors where majordesc = 'CSC')
GROUP BY enroll.stuId having count(*) > 2 and GPA > 3.5;




