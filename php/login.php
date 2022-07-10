<?php
if (!isset($_POST)) {
    $response = array('status' => 'failed', 'data' => null);
    sendJsonResponse($response);
    die();
}

include_once("dbconnect1.php");
$email = $_POST['email'];
$password = sha1($_POST['password']);
$sqllogin = "SELECT * FROM `user_register` WHERE email = '$email' AND passwor = '$password'";
$result = $conn->query($sqllogin);
$numrow = $result->num_rows;

if ($numrow > 0) {
    while ($row = $result->fetch_assoc()) {
        $user['id'] = $row['id'];
        $user['name'] = $row['name'];
        $user['email'] = $row['email'];
        $user['password'] = $row['passwor'];
        $user['phoneno'] = $row['phoneno'];
        $user['address'] = $row['address'];
    }
    $sqlgetqty = "SELECT * FROM tbl_carts WHERE customer_email = '$email' AND cart_status IS NULL";
    $result = $conn->query($sqlgetqty);
    $number_of_result = $result->num_rows;
    $carttotal = 0;
    while($row = $result->fetch_assoc()) {
        $carttotal = $row['cart_qty'] + $carttotal;
    }
    $mycart = array();
    $user['cart'] =$carttotal;

    $response = array('status' => 'success', 'data' => $user);
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