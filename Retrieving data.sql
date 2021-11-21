-- Retrieving Students currently studying in SIT with that are Covid Positive (lol everyone has covid)
SELECT student.Student_ID, student.Student_Name
FROM student
INNER JOIN student_has ON student.Student_ID = student_has.Student_ID
INNER JOIN healthstatus ON student_has.HealthStatus_ID = healthstatus.HealthStatus_ID
WHERE healthstatus.CovidPositive = 1;

-- Retrieving Profs currently teaching in SIT that are Covid Positive (everyone has covid here lol)
SELECT professor.Professor_ID, professor.Professor_Name
FROM professor
INNER JOIN professor_has ON professor.Professor_ID = professor_has.Professor_ID
INNER JOIN healthstatus ON professor_has.HealthStatus_ID = healthstatus.HealthStatus_ID
WHERE healthstatus.CovidPositive = 1;

-- Students that are covid positive
SELECT student.Student_ID, student.Student_Name
FROM student
INNER JOIN student_has ON student.Student_ID = student_has.Student_ID
INNER JOIN healthstatus ON student_has.HealthStatus_ID = healthstatus.HealthStatus_ID
WHERE healthstatus.CovidPositive = 1
UNION
-- The lesson that they have went to
SELECT student.Student_ID, student.Student_Name
FROM student
INNER JOIN attend ON student.Student_ID = attend.Student_ID
INNER JOIN lesson ON attend.Lesson_ID = lesson.Lesson_ID; -- Can add a between clause here for the date range you want to find