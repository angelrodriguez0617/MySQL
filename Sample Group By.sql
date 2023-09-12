--
-- Group By Examples
--

-- Number of students by credits earned;
SELECT credits, count(*) from Students
GROUP BY credits 
ORDER BY 1;

-- Number of Faculty by Faculty Rank
select facultyRankDesc, count(*)
from Faculty
JOIN FacultyRank 
ON Faculty.facultyRankId = FacultyRank.facultyRankId
GROUP BY facultyRankDesc;

-- Student count by majors
select Students.majorID, Majors.majorDesc, count(*) 
from Students
JOIN Majors
ON Students.majorId = Majors.majorId
GROUP BY Students.majorID, Majors.majorDesc;

-- Identify Duplicate Students by Last and First Name
select lastName, firstName, count(*)
from Students
GROUP BY lastName, firstName 
HAVING COUNT(*) > 1
ORDER BY 1;

-- Number of Faculty by Faculty Rank
select facultyRankDesc, count(*)
from Faculty
JOIN FacultyRank 
ON Faculty.facultyRankId = FacultyRank.facultyRankId
GROUP BY facultyRankDesc;

-- Get list of unique Student Last and First Names
select lastName, firstName, count(*)
from Students
GROUP BY lastName, firstName 
ORDER BY 1;

-- Count of Classes held on Monday at 9 AM
select count(*)
FROM Classes
JOIN StartTimes
ON Classes.startTimeId = StartTimes.startTimeId
JOIN DayOfTheWeek 
ON DayOfTheWeek.dayOfTheWeekId = Classes.dayOfTheWeekId
WHERE StartTimes.startTimeDesc = '9'
AND DayOfTheWeek.dayOfTheWeekDesc = 'Monday';