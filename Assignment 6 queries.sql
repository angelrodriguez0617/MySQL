-- --
-- -- Database Tables
-- --

-- create database if not exists assignment6;
-- use assignment6;
-- CREATE TABLE if not exists relationA
-- (
--     facultyid int,
--     firstname varchar(255),
--     lastname varchar(255)
-- );

-- use assignment6;
-- CREATE TABLE if not exists relationB
-- (
--     facultyid int,
--     firstname varchar(255),
--     lastname varchar(255)
-- );

-- -- Inserts of data
-- -- INSERT INTO relationA VALUES
-- -- (301,'Messier',	'Jacqualyn'),
-- -- (302,'Machuca',	'Rebbeca'),
-- -- (303,'Krull',	'Manna'),
-- -- (304,'Orona',	'Jamiel'),
-- -- (305,'Hardison',	'Darroll'),
-- -- (328,'Blue',	'Dung'),
-- -- (329,'Dane',	'Latishia'),
-- -- (330,'Naccarato',	'Naureen'),
-- -- (331,'Mayle',	'Sateria'),
-- -- (332,'Patten',	'Kristel');

-- -- INSERT INTO relationB VALUES
-- -- (301,'Messier',	'Jacqualyn'),
-- -- (302,'Machuca',	'Rebbeca'),
-- -- (303,'Krull',	'Manna'),
-- -- (304,'Orona',	'Jamiel'),
-- -- (305,'Hardison',	'Darroll'),
-- -- (306,'Olivier',	'Courtnie'),
-- -- (307,'Charette',	'Stephan'),
-- -- (308,'Grand',	'Roshelle'),
-- -- (309,'Cassity',	'Sandy'),
-- -- (310,'Clarke',	'Terea');

-- 1. A U B (Union)
select * from relationA 
union 
select * from relationB
order by facultyid;

-- 2. A ⩀ B ((Union All))
select * from relationA 
union all
select * from relationB
order by facultyid;

-- 3. A - B (Minus)
SELECT * 
FROM relationA
where facultyid NOT IN 
(select facultyid from relationB);

-- -- 4. A ⨝ B (Natural Join)
select * from relationA
natural join
relationB;

-- -- 5. A ]⨝ B (Left Outer Join)
select * from relationA a
left join relationB b 
on a.facultyid = b.facultyid;

-- -- 6. A⨝[ B (Right Outer Join)
select * from relationA a
right join relationB b
on a.facultyid = b.facultyid;

-- INTO OUTFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/assignment6_output1.csv' 
-- FIELDS ENCLOSED BY '"' 
-- TERMINATED BY ';' 
-- ESCAPED BY '"' 
-- LINES TERMINATED BY '\r\n';




