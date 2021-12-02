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

-- Students who are close contact with covid-positive individuals
-- BUTTON in UI: High-Risk Individual
SELECT student.Student_ID, student.Student_Name
FROM student
INNER JOIN student_has ON student.Student_ID = student_has.Student_ID
INNER JOIN healthstatus ON student_has.HealthStatus_ID = healthstatus.HealthStatus_ID
WHERE healthstatus.CovidPositive = 1
UNION
SELECT student.Student_ID, student.Student_Name
FROM student
INNER JOIN attend ON student.Student_ID = attend.Student_ID
INNER JOIN lesson ON attend.Lesson_ID = lesson.Lesson_ID;

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
