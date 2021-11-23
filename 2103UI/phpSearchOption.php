<?php

$search = $_POST['search'];
$column = $_POST['column'];

$servername = "localhost";
$username = "root";
$password = "";
$db = "2103_tabledata";

$conn = new mysqli($servername, $username, $password, $db);

if ($conn->connect_error){
	die("Connection failed: ". $conn->connect_error);
}

$sql = "SELECT student.Student_ID, student.Student_Name
FROM student
INNER JOIN student_has ON student.Student_ID = student_has.Student_ID
INNER JOIN healthstatus ON student_has.HealthStatus_ID = healthstatus.HealthStatus_ID
WHERE healthstatus.CovidPositive = 1;";

$result = $conn->query($sql);

if ($result->num_rows > 0){
while($row = $result->fetch_assoc() ){
	echo $row["Student_ID"]."  ".$row["Student_Name"]."  <br>";
}
} else {
	echo "0 records";
}

$conn->close();

?>