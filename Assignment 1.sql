-- select max(stuID) from students;

-- 1. Insert yourself as a Student and add your major
-- You will need to define a unique value for stuId
-- Explain insert into students 
-- select max(stuid)+1, 'Angel', 'Rodriguez', 1, 140 from students;
# id, select_type, table, partitions, type, possible_keys, key, key_len, ref, rows, filtered, Extra
-- '1', 'INSERT', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Select tables optimized away'

-- 2.  Insert (Enroll) yourself in classId 112. Give yourself an 'A'
-- Explain insert into enroll 
-- select max(stuid), 112, 'A' from students;
# id, select_type, table, partitions, type, possible_keys, key, key_len, ref, rows, filtered, Extra
-- '1', 'INSERT', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Select tables optimized away'

-- 3. Select every Class that meets on Monday
-- Explain SELECT * FROM classes WHERE dayoftheweekid = 1;
# id, select_type, table, partitions, type, possible_keys, key, key_len, ref, rows, filtered, Extra
-- '1', 'SIMPLE', 'classes', NULL, 'ALL', NULL, NULL, NULL, NULL, '2500', '10.00', 'Using where'

-- 4. Delete student with the stuId 129353 and Class Id 769 from the Enroll table
-- Explain delete from Enroll where stuId = 129353 and classid = 769;
# id, select_type, table, partitions, type, possible_keys, key, key_len, ref, rows, filtered, Extra
-- '1', 'DELETE', 'Enroll', NULL, 'range', 'PRIMARY', 'PRIMARY', '8', 'const,const', '1', '100.00', 'Using where'
-- Explain select * from Enroll where stuId = 129353 and classid = 769;
# id, select_type, table, partitions, type, possible_keys, key, key_len, ref, rows, filtered, Extra
-- '1', 'SIMPLE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'no matching row in const table'

-- 5. Update the grade for the student with stuId 134490 with class Id 535 to a 'B'
-- update enroll set grade = 'B' where stuID = 134490 and classId = 535;
-- Explain select * from Enroll where stuId = 134490;
# id, select_type, table, partitions, type, possible_keys, key, key_len, ref, rows, filtered, Extra
-- '1', 'SIMPLE', 'Enroll', NULL, 'ref', 'PRIMARY', 'PRIMARY', '4', 'const', '3', '100.00', NULL

-- 6. CSC Major Deaven Stonge has graduated. Delete the data from both the Students and Enroll (if applicable) tables
--  select stuID from students where lastName = 'Stonge' and firstName = 'Deaven';
 -- studID = 100004
-- Explain delete from students where lastName = 'Stonge' and firstName = 'Deaven';
# id, select_type, table, partitions, type, possible_keys, key, key_len, ref, rows, filtered, Extra
-- '1', 'DELETE', 'students', NULL, 'ALL', NULL, NULL, NULL, NULL, '40283', '100.00', 'Using where'
-- Explain delete from enroll where stuID = 100004;
# id, select_type, table, partitions, type, possible_keys, key, key_len, ref, rows, filtered, Extra
-- '1', 'DELETE', 'enroll', NULL, 'range', 'PRIMARY', 'PRIMARY', '4', 'const', '4', '100.00', 'Using where'

-- 7. Math student Dannon Dillow changed their major from Math to CSC and earned 12 more credits
-- Update the students information
-- select * from majors;
-- majorID = 1 for CSC
-- SET SQL_SAFE_UPDATES=0;
-- Explain update students set majorID = '1' where firstName = 'Dannon' and lastName = 'Dillow';
# id, select_type, table, partitions, type, possible_keys, key, key_len, ref, rows, filtered, Extra
-- '1', 'UPDATE', 'students', NULL, 'index', NULL, 'PRIMARY', '4', NULL, '40283', '100.00', 'Using where'

-- 8. What classroom is used by classNumber MTH1855C?
-- Explain select * from classes where classNumber = 'MTH1855C';
# id, select_type, table, partitions, type, possible_keys, key, key_len, ref, rows, filtered, Extra
-- '1', 'SIMPLE', 'classes', NULL, 'ALL', NULL, NULL, NULL, NULL, '2500', '10.00', 'Using where'
-- room = M1855

-- 9. A new Art teacher has joined the faculty and her last name is Basquiat and her first name is Marie. Basquiat's faculty rank is Instructor
-- Insert the the n```````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````ew teacher into the Faculty table
-- select * from facultyrank;
-- facultyRankId = 2 for Instructor
-- select * from departments;
-- departmentId = 3 for Art
-- Explain insert into faculty
-- select max(facultyId)+1, 'Marie', 'Basquiat', 3, 2 from faculty;
# id, select_type, table, partitions, type, possible_keys, key, key_len, ref, rows, filtered, Extra
-- '1', 'INSERT', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Select tables optimized away'

-- 10. select all students that are CSC majors
-- Explain select * from students where majorId = 1;
# id, select_type, table, partitions, type, possible_keys, key, key_len, ref, rows, filtered, Extra
#'1', 'SIMPLE', 'students', NULL, 'ALL', NULL, NULL, NULL, NULL, '40283', '10.00', 'Using where'
