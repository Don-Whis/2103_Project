<head>
    <?php include 'head.php'; ?>
    <title>This is data</title>
    <style>
.redcolorselect {
    background-color: #E60000;
    
}
.greencolorselect{
    background-color: #33CC33;
}

</style>

</head>

<body>
    <?php 

 
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
WHERE healthstatus.CovidPositive = 1;";   //change query here

$result = $conn->query($sql);
    ?>

    <div class="container">
        <h1>data present</h1>
        <div>
            
            <table class="table table-striped" id="myTable">
                <thead class="thead-light">
                    <tr class="table-dark">
                    <th scope="col">Student name</th>
                    <th scope="col">Infectious time</th>
                    <th scope="col">student id</th>
                    <th scope="col">course</th>
                    <th scope="col">time he has</th>
                  
                    
                    
                    </tr>
                </thead>

                <tbody>

                <?php
                if ($result->num_rows > 0){
					while($row = $result->fetch_assoc() ){
                    echo "<tr>
                        <td>" . $row['Student_ID'] . "</td>
                        <td>" . $row['Student_Name'] . "</td>
						<td>" . $row['Student_ID'] . "</td>
                        <td>" . $row['Student_Name'] . "</td>
						<td>" . $row['Student_ID'] . "</td>
                      
                      
                     
                        </tr>";
                }}else {
					echo "0 records";
				}
                ?>
                </tbody>
            </table>
        </div>
        
    </div>
	<?php
    $conn->close();
?>
    <script>
        $(document).ready( function () {
            $('#myTable').DataTable();
        });
    </script>


    </body>
</html>



