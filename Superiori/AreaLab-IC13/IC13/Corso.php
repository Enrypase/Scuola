<?php 
session_start();
include 'libs/db_connect.php';
$user=getArr($_SESSION,'username');
$id=getArr($_SESSION,'id');
?>

<!DOCTYPE HTML>
<html>
    <head>
        <title> IC13 </title>
  
    </head>
<body>

<a href="Consulta.php">Home</a><br>

<?php
	//select all data
	$query = " ";
	try {
		$num=0;
		$stmt = $con->prepare( $query );
		$stmt->execute();
		//Lettura numero righe risultato 
		$num = $stmt->rowCount();
	  
	} catch(PDOException $ex) {
	    echo "Errore !".$ex->getMessage();
	}
	//se num > 0 recordset vuoto o errore 
	if($num>0){
	  
	    echo "<table border='1'>";
	        echo "<tr>";
	            echo "<th>id</th>";
	            echo "<th>nome</th>";
	            echo "<th>descrizione</th>";
				echo "<th>durata</th>";
	        echo "</tr>";
	  
	
	        while ($row = $stmt->fetch(PDO::FETCH_ASSOC)){
	            echo "<tr>";
	                echo "<td>".$row['idCorso']."</td>";
	                echo "<td>".$row['nomeCorso']."</td>";
	                echo "<td>".$row['descrizioneCorso']."</td>";
					echo "<td>".$row['durataOreCorso']."</td>";
	            echo "</tr>";
	        }
	    echo "</table>";
	}
	else{
	    echo "No records found.";
	}

?> 
 
</body>
</html>
