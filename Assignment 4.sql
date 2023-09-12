-- 1. (students  ⨝ enroll.stuid = students.stuid (enroll))
select * from students
natural join enroll;

-- 2. facultyrank U departments
select * from facultyrank
union
select * from departments;

-- 3. π stuid stuid = 100425 (students )
select stuID from students
where stuID = 100425;

-- 4. (students  ⨝ majors.majorid = students.majorid (majors))
select * from students
natural join majors;

-- 5. π stuid,firstname,lastname credits > 30 (students )
select stuID, firstName, lastName from students
where credits > 30;

-- 6.  (students  ]⨝ enroll.stuid = students.stuid (enroll))
select *
from students
left join enroll
on students.stuID = enroll.stuId;