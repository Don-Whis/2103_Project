<?php

$search = $_POST['search'];
$column = $_POST['column'];

$servername = "localhost";
$username = "root";
$password = "";
$db = "2102_db";

$conn = new mysqli($servername, $username, $password, $db);

if ($conn->connect_error){
	die("Connection failed: ". $conn->connect_error);
}

$sql = "UPDATE leaveoverview SET name='$search' WHERE name = '$column'";
//$sql = "UPDATE leaveoverview SET name='gh' WHERE name='yujing'";
$result = $conn->query($sql);
if ($conn->query($sql) === TRUE) {
    echo "New record created successfully";
  } else {
    echo "Error: " . $sql . "<br>" . $conn->error;
  }

$conn->close();

?>