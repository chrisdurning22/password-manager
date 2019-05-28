<?php
	$servername = "localhost";
	$user = "root";
	$pass = "chrisdurning";
	$dbname = "pw_manager";

	$usernameExists = false;

	try {
		$pdo = new PDO("mysql:host=$servername;dbname=$dbname", $user, $pass);
	}
	catch(PDOException $e) {
		print "Error!: " . $e->getMessage() . "<br/>";
    	die();
	}
?>