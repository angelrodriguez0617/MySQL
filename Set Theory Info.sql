-- Set Theory

-- Sample values for testing the data in the PowerPoint Presentation
-- SQL is for PostgreSQL
create database set_theory;
-- use set_theory; -- for MySQL
drop table if exists A;
drop table if exists B;

create table A (id int, value varchar(10));
create table B (id int, value varchar(10));

-- Insert into table A
Insert into A values (1, 'One');
Insert into A values (2, 'Two');
Insert into A values (3, 'Three');
Insert into A values (4, 'Four');
Insert into A values (5, 'Five');

-- Insert into table B
Insert into B values (2, 'Two');
Insert into B values (3, 'Three');
Insert into B values (5, 'Five');
Insert into B values (6, 'Six');
Insert into B values (7, 'Seven');

-- Inner join
select A.* from A inner join B on A.id = B.id; 
select B.* from A inner join B on A.id = B.id; 

-- Left outer join
select A.* from A left outer join B on A.id = B.id; 
select B.* from A left outer join B on A.id = B.id; 

-- Right outer join
select A.* from A right outer join B on A.id = B.id; 
select B.* from A right outer join B on A.id = B.id; 

-- Full outer join
select A.* from A full outer join B on A.id = B.id; 
select B.* from A full outer join B on A.id = B.id; 

-- Union
select * from A union select * from B;

-- Union all
select * from A union all select * from B;

-- Minus (Except)
select * from A except select * from B;

