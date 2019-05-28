<?php
	$username = $_POST['a'];
	$password = password_hash($_POST['b'], PASSWORD_DEFAULT);

	$servername = "localhost";
	$user = "root";
	$pass = "chrisdurning";
	$dbname = "pw_manager";

	$usernameExists = false;

	try {
		$DBH = new PDO("mysql:host=$servername;dbname=$dbname", $user, $pass);
	}
	catch(PDOException $e) {
		print "Error!: " . $e->getMessage() . "<br/>";
    	die();
	}

	try {

		$stmt = $DBH->prepare("SELECT * FROM users WHERE userName = ?");
		$stmt->execute($username);

		if($stmt->rowCount()) {
			$usernameExists = true;
		} else {
			$stmt = $DBH->prepare("INSERT INTO users (userName, userPassword) VALUES (?, ?)");
			$stmt->bindParam(1, $name);
			$stmt->bindParam(2, $value);

			// insert one row
			$name = $username;
			$value = $password;
			$stmt->execute(); 
		}

		echo json_encode($usernameExists);
	}
	catch (Exception $e) {
		$DBH->rollBack();
		print "Error!: " . $e->getMessage() . "<br/>";
	}
?>