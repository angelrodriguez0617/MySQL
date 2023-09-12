 /*
-- Error recived if partition column is not part of primary key:
Error Code: 1503. A PRIMARY KEY must include all columns in the table's partitioning function (prefixed columns are not considered).	0.0048 sec
*/
-- use new_university;
use new_university;
drop table if exists student_part;
create table student_part
(
    stuID int,
    lastName varchar(50),
    firstName varchar(50),
    major int,
    credits int
)
PARTITION BY RANGE(credits) (
    PARTITION p_freshman VALUES LESS THAN (30),
    PARTITION p_sophmore VALUES LESS THAN (60),
    PARTITION p_junior VALUES LESS THAN (90),
    PARTITION p_senior VALUES LESS THAN (120)
);
alter table student_part add primary key (stuId, credits);

-- Load data
use new_university;
INSERT INTO Student_Part
SELECT * FROM Students;

-- Query uses the one parition p_freshman and p_sophmore
explain select * from student_part where credits < 60;

-- Query uses all the partitions. Partitions are searched instead of the table
explain select * from student_part where stuId = 100013;
explain select * from student_part where lastName like 'B%';
explain select count(*) from student_part;


