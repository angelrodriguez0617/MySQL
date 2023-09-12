-- Basic SQL Select Statements
-- Uncomment query to test

-- Row count for all rows in a table
-- SELECT count(*) FROM classes;
-- SELECT count(*) FROM faculty;
-- SELECT count(*) FROM students;
-- SELECT count(*) FROM enroll;

-- Selecting all rows and all columns
-- SELECT * FROM classes;
-- SELECT * FROM faculty;
-- SELECT * FROM students;
-- SELECT * FROM enroll;

-- Selecting all rows and a specific column(s)
-- SELECT room FROM classes;
-- SELECT lastName, firstName FROM faculty;
-- SELECT lastName, firstName FROM students;
-- SELECT stuId FROM enroll;

-- The WHERE clause is used to filter rows from the table
-- SELECT * FROM classes WHERE classId = 227;
-- SELECT * FROM faculty WHERE lastName = 'Nokes'; 
-- SELECT * FROM students WHERE lastName = 'Frame'; 
-- SELECT * FROM enroll WHERE classId = 1197;
-- SELECT * FROM classes WHERE classId = 1197;

-- The AND clause adds multiple conditions
-- SELECT * FROM students WHERE lastName = 'Pyne' AND firstName = 'Marlissa';

-- The OR clause is used to check one condition or another condition
-- Only one of the conditions must be True to return a row (record) 
-- SELECT * FROM enroll WHERE grade = 'C' OR grade = 'B';

-- The NOT clause creates a false condition (Not True)(False)
-- SELECT * FROM majors WHERE majorDesc NOT IN ('CSC');

-- ORDER BY by is used to return data in a certain order. Example (A to Z) or (1 to 10)
-- SELECT lastName FROM students ORDER BY lastName; 

-- The ORDER BY DESC clause will return data in opposite order. 
-- Example (Z to A) or (10 to 1)
-- SELECT lastName FROM students ORDER BY lastName Desc; 

-- ORDER BY can sort by multiple columns
-- SELECT lastName, firstName FROM students ORDER BY lastName, firstName; 

-- ORDER BY can sort by position in the SELECT statement
-- SELECT lastName, firstName FROM students ORDER BY 1; 

-- The symbols '<>' are equal to NOT
-- SELECT * FROM enroll WHERE grade <> 'C' AND grade  <> 'B';

-- In is inclusive. Items are separated by a comma and surrounded by parenthesis
-- SELECT * FROM enroll WHERE grade IN ('C', 'B');

-- IN can be used with Not to exclude the items used by IN
-- SELECT * FROM enroll WHERE grade NOT IN ('C', 'B');

-- Between is inclusive and will display data between the two values
-- SELECT * FROM students where credits between 60 and 90;

-- Simple aggregate function queries
-- Get min, max and average value
-- select min(credits), max(credits), avg(credits) from students;

-- Get the sum of all credits
-- select sum(credits) from students;

-- Get the count of the number of rows in students
-- select count(*) from students;