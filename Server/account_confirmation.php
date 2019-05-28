<?php
		//REMEMBER TO UNCOMMENT WHEN TESTING IN XCODE
	 	if(isset($_POST['user']) and isset($_POST['pass'])) {
	 		$username = $_POST['user'];
			$password = $_POST['pass'];
	
			// for testing (using URL variables)
			// $username = $_GET['user'];
			// $password = $_GET['pass'];
			//
	 	 
	 		include('config.php');

	 		try {
	 			$stmt = $pdo->prepare('SELECT * FROM users WHERE userName = ?');
				$stmt->execute([$username]);
				$row = $stmt->fetch();

				$correctPassword = password_verify($password, $row["userPassword"]);
				
				if($row and $correctPassword) {
					session_start();
				    $_SESSION['username']=$username;
				    header('location:account.php');
				} 
	 		} 
			catch (Exception $e) {
				$pdo->rollBack();
				print "Error!: " . $e->getMessage() . "<br/>";
			}		
	 	}
?>