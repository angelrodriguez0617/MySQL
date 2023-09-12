-- 1. Partition One of the Tables
-- Run 'explain' on a select query before and after partitioning the table
-- Please copy the results and include them in you project 2 submission
-- Please note the partition value must include the keys. You may need to create a composite key.
use turbine_inspection;
explain select * from damageinspection;
drop table if exists  inspection_part;
create table inspection_part
(
    damageInspectionID int,
    MLModelID int,
    DamageID int,
    ImageID int
)
PARTITION BY RANGE(damageID) (
    PARTITION no_damage VALUES LESS THAN (1),
    PARTITION minor_damage VALUES LESS THAN (2),
    PARTITION intermediate_damage VALUES LESS THAN (3),
	PARTITION major_damage VALUES LESS THAN (4)
);
alter table inspection_part add primary key (damageInspectionID, damageID);
explain select * from inspection_part;
-- Load data
use turbine_inspection;
INSERT INTO inspection_part
SELECT * FROM damageinspection;

-- 2. Create a Stored Procedure / Function
-- Create a stored procedure / function to query a table and have it accept a parameter.
DROP PROCEDURE IF EXISTS get_flights_by_drone;
DELIMITER //
CREATE PROCEDURE get_flights_by_drone
(IN myDrone varchar(45))
BEGIN
  SELECT FlightID, DroneName, FlightDate FROM flight
  INNER JOIN drone ON drone.DroneID = flight.DroneID
  WHERE drone.DroneName like myDrone
  order by drone.DroneName;
END //
DELIMITER ;
-- Call the Stored Procedure
call get_flights_by_drone('Matrice%'); 
call get_flights_by_drone('DJI%'); 

-- 3. Database Views and User Access to Views
-- Create a view on every table
-- Create the role ViewAll and add select permission on all tables to this role
-- Create a user and grant them the ViewAll role 
drop view if exists damageView;
create view damageView as select * from damage; 
drop view if exists damageInspectionView;
create view damageInspectionView as select * from damageInspection; 
drop view if exists droneView;
create view droneView as select * from drone;
drop view if exists flightView; 
create view flightView as select * from flight; 
drop view if exists imageView;
create view imageView as select * from image; 
drop view if exists mlmodelView;
create view mlmodelView as select * from mlmodel; 
drop view if exists turbineSectionView;
create view turbineSectionView as select * from turbineSection; 
drop view if exists windTurbineView;
create view windTurbineView as select * from windTurbine; 

DROP USER IF EXISTS 'ViewAllUser'@'localhost';
CREATE USER 'ViewAllUser'@'localhost' IDENTIFIED BY 'password';
FLUSH privileges;
DROP ROLE IF EXISTS 'ViewAll';
CREATE ROLE 'ViewAll';
GRANT SELECT ON damageView TO 'ViewAll';
GRANT SELECT ON damageInspectionView TO 'ViewAll';
GRANT SELECT ON droneView TO 'ViewAll';
GRANT SELECT ON flightView TO 'ViewAll';
GRANT SELECT ON imageView TO 'ViewAll';
GRANT SELECT ON mlmodelView TO 'ViewAll';
GRANT SELECT ON turbineSectionView TO 'ViewAll';
GRANT SELECT ON windTurbineView TO 'ViewAll';
GRANT 'ViewAll' TO 'ViewAllUser'@'localhost';
SET DEFAULT ROLE ALL TO 'ViewAllUser'@'localhost';

-- 4. Create an Application Admin Role
-- Create a role called AppAdmin
-- The role should have references, select, insert, update and delete on all tables
-- Create a user and grant that user the role AppAdmin
DROP ROLE IF EXISTS 'AppAdmin';
CREATE ROLE 'AppAdmin';
DROP USER IF EXISTS 'AppAdminUser'@'localhost';
CREATE USER 'AppAdminUser'@'localhost' IDENTIFIED BY 'password';
FLUSH privileges;
GRANT SELECT, REFERENCES, INSERT, UPDATE, DELETE ON * TO 'AppAdmin';
GRANT 'AppAdmin' TO 'AppAdminUser'@'localhost';
SET DEFAULT ROLE ALL TO 'AppAdminUser'@'localhost';

-- 5. Alter Tables
-- Alter one of the tables by adding a new column
-- Alter a table and rename the table
ALTER TABLE flight ADD COLUMN flightDuration int;
ALTER TABLE flight DROP COLUMN flightDuration;
ALTER TABLE damageinspection RENAME damagePrediction;
ALTER TABLE damagePrediction RENAME damageInspection;

-- 6. Primary Key (PK) and Foreign Key (FK) Constraints
-- Create PK and FK constraints on all tables in your database
-- Already done in 'Turbine_Inspection_tables.sql'

-- 7. Table Auditing using Triggers
-- Create a "history" version for one of your tables
-- Create an update trigger that populates the "history" table
-- The "history" table should contain three extra columns
-- The user who made the change
-- A timestamp column containing a default of the current time
-- A column that indicates what is the new row and which is the old row
-- An additional PK (I suggest a sequence number) is probably required on the "history" table because the trigger should contain before and after values for all columns of the source table. 
-- There are other choices for the PK
use turbine_inspection;
drop table if exists audit_types;
create table audit_types
(
    auditId int primary key,
    auditName varchar(50)
);

-- Insert data
insert into  audit_types values (1, 'Insert');
insert into  audit_types values (2, 'Update - Old value');
insert into  audit_types values (3, 'Update - New Value');
insert into  audit_types values (4, 'Delete');

drop table if exists inspection_audit;
create table inspection_audit
(
    inspectionAuditId int AUTO_INCREMENT primary key,
    DamageInspectionID int,
    MLModelID int,
    DamageID int,
    ImageID int,
    auditDate timestamp,
    modifyingUser varchar(50),
    auditId int references  audit_types (auditId)
);

-- Audit Trigger - Insert
DROP TRIGGER IF EXISTS ins_inspection_audit;
delimiter //
CREATE TRIGGER ins_inspection_audit BEFORE INSERT ON damageinspection
    FOR EACH ROW
    BEGIN
        -- Insert new row
        insert into inspection_audit 
        (DamageInspectionID, MLModelID, DamageID, ImageID,
         auditDate,modifyingUser,auditId)
        values (
            NEW.DamageInspectionID,NEW.MLModelID,NEW.DamageID,
            NEW.ImageID,NOW(),CURRENT_USER(),1);
    END;//
delimiter ; 

-- Audit Trigger - Update
DROP TRIGGER IF EXISTS upd_inspection_audit;
delimiter //
CREATE TRIGGER upd_inspection_audit BEFORE UPDATE ON damageinspection
    FOR EACH ROW
    BEGIN
        -- Insert old row
        insert into inspection_audit
        (DamageInspectionID, MLModelID, DamageID, ImageID,
         auditDate,modifyingUser,auditId)
        values (
            OLD.DamageInspectionID,OLD.MLModelID,OLD.DamageID,
            OLD.ImageID,NOW(),CURRENT_USER(),2);
        
        -- Insert new row
        insert into inspection_audit
        (DamageInspectionID, MLModelID, DamageID, ImageID,
         auditDate,modifyingUser,auditId)
        values (
            NEW.DamageInspectionID,NEW.MLModelID,NEW.DamageID,
            NEW.ImageID,NOW(),CURRENT_USER(),3);
    END;//
delimiter ;

-- Audit Trigger - Delete
DROP TRIGGER IF EXISTS del_inspection_audit;
delimiter //
CREATE TRIGGER del_inspection_audit BEFORE DELETE ON damageinspection
    FOR EACH ROW
    BEGIN
        -- Insert deleted row
        insert into inspection_audit
        (DamageInspectionID, MLModelID, DamageID, ImageID,
         auditDate,modifyingUser,auditId)
        values (
            OLD.DamageInspectionID,OLD.MLModelID,OLD.DamageID,
            OLD.ImageID,NOW(),CURRENT_USER(),4);
   END;//
delimiter ;

-- 8. Check Constraints
-- Create a check constraint on at least two of your columns.
ALTER TABLE windturbine
DROP CONSTRAINT CHK_Turbine;
ALTER TABLE windturbine
ADD CONSTRAINT CHK_Turbine CHECK (TotalHeight>=20 AND HubHeight>=10);

-- 9. Schema Creation and User Access
-- Create a schema 
-- Create a copy of one of your tables in that schema
-- Populate the new table in the schema with the data from the original table
-- Create a user and give that user select, references, update, delete and update to the new table created in the schema
CREATE SCHEMA IF NOT EXISTS mySchema;
use mySchema;
DROP TABLE IF EXISTS mySchema.tablecopy;
CREATE TABLE IF NOT EXISTS `mySchema`.`tableCopy` (
  `DamageInspectionID` VARCHAR(45) NOT NULL,
  `MLModelID` INT NOT NULL,
  `DamageID` INT NOT NULL,
  `ImageID` INT NOT NULL,
  PRIMARY KEY (`DamageInspectionID`, `MLModelID`, `DamageID`, `ImageID`),
  INDEX `fk_WindTurbine_MissionLog_MLModel1_idx` (`MLModelID` ASC) VISIBLE,
  INDEX `fk_Analysis_Damage1_idx` (`DamageID` ASC) VISIBLE,
  INDEX `fk_DamageInspection_Image1_idx` (`ImageID` ASC) VISIBLE,
  CONSTRAINT `fk_Analysis_Damage1`
    FOREIGN KEY (`DamageID`)
    REFERENCES `turbine_inspection`.`Damage` (`DamageID`),
  CONSTRAINT `fk_DamageInspection_Image1`
    FOREIGN KEY (`ImageID`)
    REFERENCES `turbine_inspection`.`Image` (`ImageID`),
  CONSTRAINT `fk_WindTurbine_MissionLog_MLModel1`
    FOREIGN KEY (`MLModelID`)
    REFERENCES `turbine_inspection`.`MLModel` (`MLModelID`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;
INSERT INTO mySchema.tableCopy SELECT * from turbine_inspection.damageinspection;
DROP USER IF EXISTS 'MyUser'@'localhost';
CREATE USER 'MyUser'@'localhost' IDENTIFIED BY 'password';
FLUSH privileges;
GRANT SELECT, REFERENCES, INSERT, UPDATE, DELETE ON mySchema.tableCopy TO 'MyUser'@'localhost';

-- 10. Application Report
-- Create and describe in detail a query that functions as a report in your database.
-- This report should resemble a report a real user of your system would execute on a regular basis
-- Please create the query as a view
-- Take the MySQL or Postgres Python scripts I uploaded to Canvas
-- Modify the script to connect to your database
-- Create a query from your database and display the results

-- Which turbine(s) and their corresponding sections should be repaired immediately due to major damage?
use turbine_inspection;
DROP VIEW IF EXISTS majorDamage;
create view majorDamage as
select distinct windturbineid, turbinesectiondesc, FlightDate
from damageinspection 
natural join image
natural join windturbine
natural join turbinesection
natural join flight
where damageid = 3;
select * from majorDamage;