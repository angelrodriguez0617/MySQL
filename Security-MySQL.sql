-- These commands reference the Access Control matrix 
-- from Chapter 6. I added some additional commands as well

use new_university;
-- DROP PROCEDURE WrapUp;
-- Create WrapUp procedure for testing
DELIMITER //
CREATE PROCEDURE WrapUp
(IN myFirstName CHAR(20))
BEGIN
  SELECT firstName, lastName, credits FROM Student
  WHERE firstName = myFirstName;
END //
DELIMITER ;

-- Call MySQL Stored Procedure
Call WrapUp('Ann');

-- Create view for Student table
use new_university;
drop view if exists StuView1;
create view StuView1 as
select Student.stuId, lastName, firstName, credits
from Students;

-- Security (MySQL)
use new_university;
DROP USER IF EXISTS 'U101'@'localhost';
DROP USER IF EXISTS 'U102'@'localhost';
DROP USER IF EXISTS 'U103'@'localhost';
CREATE USER 'U101'@'localhost' IDENTIFIED BY '9a0BKFdFnWvy';
CREATE USER 'U102'@'localhost' IDENTIFIED BY 'HcoqsGbDroPT';
CREATE USER 'U103'@'localhost' IDENTIFIED BY 'y63OovPxET2r';
FLUSH privileges;

-- Grant permissions to user U01
-- READ = SELECT
use new_university;
GRANT SELECT, UPDATE ON new_university.Students TO 'U101'@'localhost';
GRANT SELECT ON new_university.StuView1 TO 'U101'@'localhost';
GRANT EXECUTE ON PROCEDURE new_university.WrapUp TO 'U101'@'localhost';
GRANT SELECT ON new_university.Faculty TO 'U101'@'localhost';
GRANT CREATE ON new_university TO 'U101'@'localhost';
-- This is required in MySQL for the change to take effect
FLUSH privileges;

-- Grant permissions to user U02
-- READ = SELECT
use new_university;
GRANT SELECT ON new_university.StuView1 TO 'U102'@'localhost';

-- Create Role and grant permission
use new_university;
CREATE ROLE 'AdvisorRole';
GRANT SELECT, INSERT,UPDATE, DELETE ON Enroll TO 'AdvisorRole';
GRANT SELECT ON Students TO 'AdvisorRole';
GRANT SELECT ON StuView1 TO 'AdvisorRole';

-- Add U03 to AdvisorRole
-- A role has to be activated in MySQL
-- The command 'SELECT CURRENT_ROLE();' will tell you if a role is active. None means no active role.
-- Set Default role is required to activate the Role for the user
use new_university;
GRANT 'AdvisorRole' TO 'U103'@'localhost';
SET DEFAULT ROLE ALL TO 'U103'@'localhost';

-- Show grants for each user
use new_university;
show grants for 'U101'@'localhost';
show grants for 'U102'@'localhost';
show grants for 'U103'@'localhost';