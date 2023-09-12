select a.stuid, a.lastname, a.firstname
from students a, majors b
where a.majorId = b.majorId
and b.majorDesc = 'CSC'
order by lastName;

-- select a.stuID, a.lastName, a.firstName
-- from students a
-- inner join majors b
-- on a.majorId = b.majorId
-- where b.majorDesc = 'CSC'
-- order by lastname;