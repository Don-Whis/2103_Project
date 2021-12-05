<?php
$name = $_POST['name'];
$startdate = $_POST['startdate'];          //modify the input here
$enddate = $_POST['enddate'];          

$servername = "localhost";
$username = "root";
$password = "";
$db = "2102_db";

$conn = new mysqli($servername, $username, $password, $db);

if ($conn->connect_error){
	die("Connection failed: ". $conn->connect_error);
}


$sql = "INSERT INTO leaveoverview (name, startingDate, endingDate, duration, leaveType, leave_status, detail, reason) VALUES ('$name', '$name', '$name', '$startdate', '$startdate', '$startdate', '$enddate', '$enddate')";
 // modify the query here to insert as ur wish 
$result = $conn->query($sql);
if ($conn->query($sql) === TRUE) {
    echo "New record created successfully";
  } else {
    echo "Error: " . $sql . "<br>" . $conn->error;
  }


$conn->close();

?>