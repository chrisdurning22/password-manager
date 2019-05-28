<?php
	session_start();

	if(!isset($_SESSION['username'])) {
		header("location:account_confirmation.php");
	} 

	$username = $_SESSION['username'];

	include('config.php');

	try {
		$resultsArray = array();

		$stmt = $pdo->prepare('SELECT * FROM account_data WHERE userName = ?');
		$stmt->execute([$username]);

		while($row = $stmt->fetch()) {
			array_push($resultsArray, $row);
		}

		echo $resultsArray[0][1];
		echo $resultsArray[1][1];
		echo json_encode($resultArray); 
	} 
	catch (Exception $e) {
		$pdo->rollBack();
		print "Error!: " . $e->getMessage() . "<br/>";
	}	


?>