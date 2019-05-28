<?php
	$username = $_POST['a'];
	$password = password_hash($_POST['b'], PASSWORD_DEFAULT);

	include('config.php');

	try {

		$stmt = $pdo->prepare("SELECT * FROM users WHERE userName = ?");
		$stmt->execute($username);

		if($stmt->rowCount()) {
			$usernameExists = true;
		} else {
			$stmt = $pdo->prepare("INSERT INTO users (userName, userPassword) VALUES (?, ?)");
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
		$pdo->rollBack();
		print "Error!: " . $e->getMessage() . "<br/>";
	}
?>