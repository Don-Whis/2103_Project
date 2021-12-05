-- This is all the queries for SQL implementation

-- Retrieving Students currently studying in SIT with that are Covid Positive
-- BUTTON in UI: Student with COVID
SELECT student.Student_ID, student.Student_Name
FROM student
INNER JOIN student_has ON student.Student_ID = student_has.Student_ID
INNER JOIN healthstatus ON student_has.HealthStatus_ID = healthstatus.HealthStatus_ID
WHERE healthstatus.CovidPositive = 1;

-- Find all students that are covidpositive (NESTED; FOR SPEED COMPARISON AGAINST PRVEIOUS QUERY)
SELECT student.Student_ID, student.Student_Name 
FROM student 
WHERE student.Student_ID 
IN(
	SELECT student_has.Student_ID 
	FROM student_has 
	LEFT JOIN healthstatus 
	ON student_has.HealthStatus_ID = healthstatus.HealthStatus_ID 
	WHERE healthstatus.CovidPositive=1
	);

-- Retrieving Profs currently teaching in SIT that are Covid Positive
-- BUTTON in UI: Professor with COVID
SELECT professor.Professor_ID, professor.Professor_Name
FROM professor
INNER JOIN professor_has ON professor.Professor_ID = professor_has.Professor_ID
INNER JOIN healthstatus ON professor_has.HealthStatus_ID = healthstatus.HealthStatus_ID
WHERE healthstatus.CovidPositive = 1;

-- Find all lessons that had infected students
-- BUTTON in UI: Lesson with COVID
SELECT DISTINCT attend.Lesson_ID 
FROM attend 
WHERE attend.Student_ID 
IN(
	SELECT student_has.Student_ID 
	FROM student_has 
	LEFT JOIN healthstatus 
	ON student_has.HealthStatus_ID = healthstatus.HealthStatus_ID 
	WHERE healthstatus.CovidPositive=1
	);

-- Find all students whose daily health declaration temperature taking is higher than 37.5
-- BUTTON in UI: Abnormal Temperature Student
SELECT student.Student_ID, student.Student_Name 
FROM student 
WHERE student.Student_ID 
IN( 
	SELECT student_dhd.Student_ID 
	FROM student_dhd 
	LEFT JOIN dailyhealthdeclaration 
	ON student_dhd.HealthDeclaration_ID = dailyhealthdeclaration.HealthDeclaration_ID 
	WHERE dailyhealthdeclaration.Temperature > 37.5
	);

-- Find all classrooms that had infected students
-- BUTTON in UI: Classroom with COVID
SELECT * FROM classroom 
WHERE classroom.Classroom_ID 
IN(
	SELECT take_place.Classroom_ID 
	FROM take_place 
	WHERE take_place.Lesson_ID 
	IN (
		SELECT DISTINCT attend.Lesson_ID 
		FROM attend 
		WHERE attend.Student_ID 
			IN(
				SELECT student_has.Student_ID 
				FROM student_has 
				LEFT JOIN healthstatus 
				ON student_has.HealthStatus_ID = healthstatus.HealthStatus_ID 
				WHERE healthstatus.CovidPositive=1)
					)
				);

-- Count the total number of students with covid 
-- BUTTON in UI: Total students with COVID
SELECT count(student.Student_ID) As StudentsWithCovid
FROM student
INNER JOIN student_has ON student.Student_ID = student_has.Student_ID
INNER JOIN healthstatus ON student_has.HealthStatus_ID = healthstatus.HealthStatus_ID
WHERE healthstatus.CovidPositive = 1;

-- Count the total number of professors with covid
-- BUTTON in UI: Total profs with COVID
SELECT count(professor.Professor_ID) As ProfessorsWithCovid
FROM professor
INNER JOIN professor_has ON professor.Professor_ID = professor_has.Professor_ID
INNER JOIN healthstatus ON professor_has.HealthStatus_ID = healthstatus.HealthStatus_ID
WHERE healthstatus.CovidPositive = 1;

-- Count the number of lessons that is taught by professors
-- BUTTON in UI: NULL
SELECT professor_ID,count(Lesson_ID) 
AS NumberOfLessonsTaught 
FROM 2103_tabledata.teach_by 
GROUP BY professor_ID;


-- Count the number of lessons that is attended by students
-- BUTTON in UI: NULL
SELECT Student_ID,count(Lesson_ID) 
AS NumberOfLessonsAttended 
FROM 2103_tabledata.attend teach_by 
GROUP BY student_ID;

-- Average age of students affected by covid
-- BUTTON in UI: NULL
SELECT AVG(age)
FROM 2103_tabledata.student
INNER JOIN 2103_tabledata.student_has ON 2103_tabledata.student_has.Student_ID = 2103_tabledata.student.Student_ID
INNER JOIN 2103_tabledata.healthstatus ON 2103_tabledata.student_has.HealthStatus_ID = 2103_tabledata.healthstatus.HealthStatus_ID
WHERE 2103_tabledata.healthstatus.CovidPositive = 1;

-- Amount of covid positive cases
-- BUTTON in UI: NULL
SELECT SUM(CovidPositive)
FROM 2103_tabledata.healthstatus
WHERE CovidPositive = 1;

-- Update covid positive of a particular student/professor
-- BUTTON in UI: NULL
UPDATE 2103_tabledata.healthstatus
SET 2103_tabledata.healthstatus.CovidPositive = 1
WHERE 2103_tabledata.healthstatus.HealthStatus_ID = 210001;

-- Delete the daily health declaration data that is before january 2021
-- BUTTON in UI: NULL
DELETE FROM dailyhealthdeclaration 
WHERE DateTaken < '2021-01-01';
