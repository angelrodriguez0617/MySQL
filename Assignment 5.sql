-- Question 1: Select stuid, Last Name and First Name for students associated with the CSC department. Order the data by Last Name.
select a.stuid, a.lastname, a.firstname
from students a, majors b
where a.majorId = b.majorId
and b.majorDesc = 'CSC'
order by lastName;

-- Question 2: Select the faculty id, Last Name, First Name and Class Number for all faculty in CSC. List the Class Number if applicable.
select a.facultyId, a.lastName, a.firstName, c.classNumber
from faculty a, departments b, classes c
where a.departmentId = b.departmentId
and a.facultyId = c.facultyId
and b.departmentDesc = 'CSC';

-- Question 3: List the faculty id, last name, first name, Department Description and Faculty Rank Description for all faculty in the CSC department.
select a.facultyId, a.lastName, a.firstName, b.departmentDesc, c.facultyRankDesc
from faculty a, departments b, facultyrank c
where b.departmentDesc = 'CSC'
and a.departmentId = b.departmentId
and c.facultyRankId = a.facultyRankId;

-- Question 4: What is the value (count(*)) of students * majors. Write as a query.
select count(*)
from students, majors;

-- Question 5: Write a natural join between students and majors where major description is 'CSC'
select * from students
natural join majors
where majors.majorDesc = 'CSC';
