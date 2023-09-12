-- MySQL Transaction testing
-- You should test both ROLLBACK and COMMIT
-- You should also test restarting MySQL before and after a COMMIT
--

-- use new_university;

--
-- Select queries
--

-- SELECT lastName, firstName, majorDesc from Students 
-- INNER JOIN Majors ON Majors.majorId Students.majorId 
-- WHERE Students.stuId = 100020;

-- SELECT * from Students
-- JOIN Enroll ON Enroll.stuId = Students.stuId
-- WHERE Students.stuId = 100020;

-- SELECT * FROM Students where stuId = 100020;
-- SELECT * FROM Enroll where stuId = 100020;

-- Used to allow changes but also how to demonstrate 
-- how transactions behave when a error is encountered
-- SET SQL_SAFE_UPDATES = 0;
-- SET SQL_SAFE_UPDATES = 1;

-- Insert Data
-- INSERT INTO Students VALUES (140100,'HOWER','Steven',2,48);

-- Update transaction 
-- START TRANSACTION;
-- UPDATE Student SET credits = credits + 12 WHERE stuId = 140100;
-- ROLLBACK;
-- COMMIT;

-- Delete transaction 
-- START TRANSACTION;
-- DELETE FROM Enroll WHERE stuId = 140100;
-- DELETE FROM Student WHERE stuId = 140100;
-- ROLLBACK;
-- COMMIT;

-- Put back data
-- INSERT INTO Student VALUES (140100,'HOWER','VEDA',2,48);
-- INSERT INTO Enroll VALUES (140100,1787,'B');

--
-- Multiple Table Transactions
--

-- Replace Data
-- INSERT INTO Student VALUES (140700,'DEVRY','GLORIA',1,0);
-- INSERT INTO Enroll VALUES (140700,571,'C');
-- INSERT INTO Enroll VALUES (140700,2238,'C');

-- START TRANSACTION;
-- DELETE FROM Enroll WHERE stuId = 140700;
-- DELETE FROM Student WHERE stuId = 140700;
-- ROLLBACK;
-- COMMIT;