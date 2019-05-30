<?php
		//REMEMBER TO UNCOMMENT WHEN TESTING IN XCODE
	 	if(isset($_GET['user']) and isset($_GET['pass'])) {
	 		$username = $_GET['user'];
			$password = $_GET['pass'];
			
			// $username = "chris@hotmail.com";
			// $password = "qwerty";
	
			// use to post data
			// $_POST['user'];
	 	 
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