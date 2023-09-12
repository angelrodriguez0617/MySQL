-- MySQL Stored Procedures

-- Stored  procedure list students enrolled in a class
-- DELIMITER //
-- CREATE PROCEDURE get_enrolled()
-- BEGIN
--     SELECT Enroll.StuId, Students.LastName, Students.firstName
--     FROM Enroll
--     INNER JOIN Students ON Enroll.StuId = Students.StuId
--     GROUP BY Enroll.StuId, Students.LastName, Students.firstName
--     ORDER BY 1;
-- END //
-- DELIMITER ;

-- Call stored procedure
call get_enrolled();

-- Sample MySQL Stored Procedure passing a parameter
-- Students by studId 
-- DELIMITER //
-- CREATE PROCEDURE get_student
-- (IN mystuId INT)
-- BEGIN
--   SELECT lastName, FirstName, majorDesc, credits FROM Students
--   INNER JOIN Majors ON Students.majorId = Majors.majorId
--   WHERE Students.stuId = mystuId;
-- END //
-- DELIMITER ;

-- Call the Stored Procedure
call get_student(100613);
