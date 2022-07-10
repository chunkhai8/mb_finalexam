<?php
if (!isset($_POST)) {
    $response = array('status' => 'failed', 'data' => null);
    sendJsonResponse($response);
    die();
}
include_once("dbconnect1.php");
$name = $_POST['name'];
$email = $_POST['email'];
$password = sha1($_POST['password']);
$phoneno = $_POST['phoneno'];
$address = $_POST['address'];
$base64image = $_POST['image'];

$sqlinsert = "INSERT INTO `user_register`(`name`, `email`, `passwor`, `phoneno`, `address`)
VALUES ('$name','$email','$password','$phoneno','$address')";
if ($conn->query($sqlinsert) == TRUE) {
    $response = array('status' => 'success', 'data' => null);
    $filename = mysqli_insert_id($conn);
    $decoded_string = base64_decode($base64image);
    $path = '../mytutor/images/' . $filename . '.png';
    $is_written = file_put_contents($path, $decoded_string);
    sendJsonResponse($response);
} else {
    $response = array('status' => 'failed', 'data' => null);
    sendJsonResponse($response);
}

function sendJsonResponse($sentArray)
{
    header('Content-Type: application/json');
    echo json_encode($sentArray);
}
?>