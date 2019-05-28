<?php
	 	if(isset($_POST['user']) and isset($_POST['pass'])) {
	 		$username = $_POST['user'];
			$password = $_POST['pass'];
	 	 
	 		include('config.php');

	 		$sql = "SELECT * FROM users WHERE username='$username' ";
			$result = $conn->query($sql);
			$row = mysqli_fetch_assoc($result);

			$correctPassword = password_verify($password, $row["userPassword"]);
			
			if($row and $correctPassword) {
				session_start();
			    $_SESSION['username']=$username;
			    header('location:account.php');
			}
		
			$conn->close();
	 	}
?>