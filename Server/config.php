<?php
	// Create connection
	$conn = new mysqli("localhost","root","chrisdurning","pw_manager");
	
	// Check connection
	if ($conn->connect_error) {
	    die("Connection failed: " . $conn->connect_error);
	} 
?>