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

		while($row = $stmt->fetchObject()) {
			array_push($resultsArray, $row);
		}

		echo json_encode($resultsArray); 
	} 
	catch (Exception $e) {
		$pdo->rollBack();
		print "Error!: " . $e->getMessage() . "<br/>";
	}	


?>