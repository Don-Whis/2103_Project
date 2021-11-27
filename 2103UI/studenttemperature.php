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
WHERE student.Student_ID 
IN( 
	SELECT student_dhd.Student_ID 
	FROM student_dhd 
	LEFT JOIN dailyhealthdeclaration 
	ON student_dhd.HealthDeclaration_ID = dailyhealthdeclaration.HealthDeclaration_ID 
	WHERE dailyhealthdeclaration.Temperature > 37.5
	);";   //change query here

$result = $conn->query($sql);
    ?>

    <div class="container">
        <h1>Student with covid</h1>
        <div>
            
            <table class="table table-striped" id="myTable">
                <thead class="thead-light">
                    <tr class="table-dark">
                    <th scope="col">Student name</th>
                    <th scope="col">student id</th>
                    
                  
                    
                    
                    </tr>
                </thead>

                <tbody>

                <?php
                if ($result->num_rows > 0){
					while($row = $result->fetch_assoc() ){
                    echo "<tr>
                       
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



