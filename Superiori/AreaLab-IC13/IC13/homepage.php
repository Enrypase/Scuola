<?php
session_start();
include 'libs/util.php';
$user=getArr($_SESSION,'username');
$id=getArr($_SESSION,'id');
?>
<?php
if ($user="adminuser"){
<!DOCTYPE HTML>
<html>
    <head>
        <title> IC13 </title>
  
    </head>
<body>

<?php
if ($user!="")
	print("<H3> Ciao $user! </h3>");
	echo "<b>Persone che devono svolgere dei corsi:</b>";
	$query = "select * from personale p join frequentazioni f o n f.codFiscPersona=p.codFiscPersona where f.oreEffettuate<6 group by(f.idCorso)";
	try{
		$num=0;
		$stmt = $con->prepare( $query );
		$stmt->execute();
		$num = $stmt->rowCount();
	}catch(PDOException $ex) {
	    echo "Errore !".$ex->getMessage();
	}
	if($num>0){
		echo "<table border='1'>";
	    echo "<tr>";
	    echo "<th>nome</th>";
	    echo "<th>cognome</th>";
	    echo "<th>codice fiscale</th>";
	    echo "</tr>";
	    while ($row = $stmt->fetch(PDO::FETCH_ASSOC)){
	        echo "<tr>";
	        echo "<td>".$row['p.nomePersona']."</td>";
	        echo "<td>".$row['p.cognomePersona']."</td>";
	        echo "<td>".$row['p.codFiscPersona']."</td>";
			echo "</tr>";
	        }
	    echo "</table>";
	}
	else{
	    echo "No results.";
	}
?>

<a href="index.php"><button onClick="index.php"> logout</button></a><br>
<a href="AggiornaCorsi.php"><button onClick="AggiornaCorsi.php"> aggiorna corsi</button></a><br>
<a href="Consulta.php"><button onClick="index.php"> consulta</button></a><br>
<a href="AggiornaAnagrafica.php"><button onClick="AggiornaAnagrafica.php"> aggiorna anagrafica</button></a><br>
<a href="Backup.php"><button onClick="Backup.php"> ottieni backup</button></a><br>
<a href="FoglioFirme.php"><button onClick="FoglioFirme.php"> ottieni foglio firme</button></a><br>


</body>
</html>
}?>
