--
-- Mysql Triggers
--
-- Audit Types
use new_university;
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

drop table if exists students_audit;
create table students_audit
(
    stuAuditId int AUTO_INCREMENT primary key,
    stuID int,
    lastName varchar(50),
    firstName varchar(50),
    majorId int,
    credits int,
    auditDate timestamp,
    modifyingUser varchar(50),
    auditId int references  audit_types (auditId)
);

-- Audit Trigger - Insert
DROP TRIGGER ins_students_audit;
delimiter //
CREATE TRIGGER ins_students_audit BEFORE INSERT ON students
    FOR EACH ROW
    BEGIN
        -- Insert new row
        insert into students_audit 
        (stuId, lastName, firstName, majorId,credits,
         auditDate,modifyingUser,auditId)
        values (
            NEW.stuId,NEW.lastName,NEW.firstName,
            NEW.majorId,NEW.credits,NOW(),CURRENT_USER(),1);
    END;//
delimiter ;

-- Audit Trigger - Update
DROP TRIGGER upd_students_audit;
delimiter //
CREATE TRIGGER upd_students_audit BEFORE UPDATE ON students
    FOR EACH ROW
    BEGIN
        -- Insert old row
        insert into students_audit
        (stuId, lastName, firstName, majorId,credits,
         auditDate,modifyingUser,auditId)
        values (
            OLD.stuId,OLD.lastName,OLD.firstName,
            OLD.majorId,OLD.credits,NOW(),CURRENT_USER(),2);
        
        -- Insert new row
        insert into students_audit
        (stuId, lastName, firstName, majorId,credits,
         auditDate,modifyingUser,auditId)
        values (
            NEW.stuId,NEW.lastName,NEW.firstName,
            NEW.majorId,NEW.credits,NOW(),CURRENT_USER(),3);
    END;//
delimiter ;

-- Audit Trigger - Update
DROP TRIGGER del_students_audit;
delimiter //
CREATE TRIGGER del_students_audit BEFORE DELETE ON students
    FOR EACH ROW
    BEGIN
        -- Insert deleted row
        insert into students_audit
        (stuId, lastName, firstName, majorId,credits,
         auditDate,modifyingUser,auditId)
        values (
            OLD.stuId,OLD.lastName,OLD.firstName,
            OLD.majorId,OLD.credits,NOW(),CURRENT_USER(),4);
   END;//
delimiter ;

-- Required by MySQL Workbench. 
-- A value of 0 is reuired to modify data
-- SET SQL_SAFE_UPDATES = 0;
-- SET SQL_SAFE_UPDATES = 1;

-- Test of insert trigger
-- select * from students where lastName = 'Buehrle';
-- insert into Students values (141000,'Buehrle','Mark',1,30);
-- select * from students_audit;

-- Student where we will update credits 
-- and save previous value in students_audit
--
-- select * from students where stuId = 141000;
-- update students set credits = credits + 12 where stuId = 141000;
-- select * from students_audit;

-- Test deleting student
-- select * from students where stuId = 141000;
-- delete from students where stuId = 141000;
-- select * from students_audit;

