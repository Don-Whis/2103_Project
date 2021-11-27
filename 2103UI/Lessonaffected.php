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

$sql = "SELECT DISTINCT attend.Lesson_ID 
FROM attend 
WHERE attend.Student_ID 
IN(
	SELECT student_has.Student_ID 
	FROM student_has 
	LEFT JOIN healthstatus 
	ON student_has.HealthStatus_ID = healthstatus.HealthStatus_ID 
	WHERE healthstatus.CovidPositive=1
	);";   //change query here

$result = $conn->query($sql);
    ?>

    <div class="container">
        <h1>Lesson with covid</h1>
        <div>
            
            <table class="table table-striped" id="myTable">
                <thead class="thead-light">
                    <tr class="table-dark">
                    <th scope="col">Lesson infected</th>
                    
                    
                  
                    
                    
                    </tr>
                </thead>

                <tbody>

                <?php
                if ($result->num_rows > 0){
					while($row = $result->fetch_assoc() ){
                    echo "<tr>
                       
                        <td>" . $row['Lesson_ID'] . "</td>
						
                      
                      
                     
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



