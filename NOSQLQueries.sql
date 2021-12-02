-- THE FIRST FEW QUERIES ARE FOR PORTING DATA OVER TO NOSQL
-- Query for all the students with their covid status, vaccination status and daily temperature
-- This is conversted to student.csv
SELECT 
s.Student_ID, s.Student_Name, s.Student_Email, s.Gender, s.Age,
hs.Vaccinated,hs.CovidPositive,
dhd.Temperature,dhd.DateTaken
FROM 2103_tabledata.student s, 2103_tabledata.student_has sh, 2103_tabledata.healthstatus hs,
2103_tabledata.student_dhd sd, 2103_tabledata.dailyhealthdeclaration dhd
WHERE s.Student_ID = sh.Student_ID
AND hs.HealthStatus_ID = sh.HealthStatus_ID
AND sd.Student_ID = s.Student_ID
AND sd.HealthDeclaration_ID = dhd.HealthDeclaration_ID;

-- Query for all the professors with their covid status, vaccination status and daily temperature
-- This is converted to professor.csv
SELECT p.Professor_ID, p.Professor_Name, p.Gender, p.Professor_Email, p.Department, p.Contact_Number,
hs.Vaccinated, hs.CovidPositive,
dhd.Temperature, dhd.DateTaken
FROM 2103_tabledata.professor p, 2103_tabledata.professor_has ph, 2103_tabledata.healthstatus hs,
2103_tabledata.professor_dhd pd, 2103_tabledata.dailyhealthdeclaration dhd
WHERE p.Professor_ID = ph.Professor_ID
AND hs.HealthStatus_ID = ph.HealthStatus_ID
AND pd.Professor_ID = p.Professor_ID
AND pd.HealthDeclaration_ID = dhd.HealthDeclaration_ID; 

-- Query for all the students that attended the different lessons with the different professors
-- This is converted to ModuleScheduleInfo.csv
SELECT 
s.Student_ID, s.Student_Name, s.Student_Email, s.Gender, s.Age,
l.Lesson_ID, l.LessonDate, l.Start_Time, l.End_Time,
p.Professor_ID, p.Professor_Name, p.Professor_Email, p.Contact_Number, p.Department,
m.Module_ID, m.Module_Name,
cl.Classroom_Name,
bd.Building_Name
FROM 2103_tabledata.student s, 2103_tabledata.lesson l,  2103_tabledata.attend a,
2103_tabledata.professor p, 2103_tabledata.teach_by t,
2103_tabledata.module m, 2103_tabledata.contain c,
2103_tabledata.classroom cl, 2103_tabledata.take_place tp,
2103_tabledata.building bd, 2103_tabledata.belongs_to bt

WHERE s.Student_ID = a.Student_ID
AND l.Lesson_ID = a.Lesson_ID

AND p.Professor_ID = t.Professor_ID
AND l.Lesson_ID = t.Lesson_ID

AND c.module_ID = m.module_ID
AND l.Lesson_ID = c.Lesson_ID

AND cl.Classroom_ID = tp.Classroom_ID
AND l.Lesson_ID = tp.Lesson_ID

AND bd.Building_ID = bt.Building_ID
AND bt.Classroom_ID = cl.Classroom_ID;
