<?php
if (!isset($_POST)) {
    $response = array('status' => 'failed', 'data' => null);
    sendJsonResponse($response);
    die();
}

include_once("dbconnect1.php");
$subjectid = $_POST['subjid'];
$useremail = $_POST['email'];
$cartqty = "1";
$carttotal = 0;

$sqlcheckqty = "SELECT * FROM tbl_subjects where subject_id = '$subjectid'";
$resultqty = $conn->query($sqlcheckqty);
$num_of_qty = $resultqty->num_rows;
if ($num_of_qty>1){
    $response = array('status' => 'failed', 'data' => null);
	sendJsonResponse($response);
	return;
}

$sqlinsert = "SELECT * FROM tbl_carts WHERE customer_email = '$useremail' AND subject_id = '$subjectid' AND cart_status IS NULL";
$result = $conn->query($sqlinsert);
$number_of_result = $result->num_rows;

$addcart = "INSERT INTO `tbl_carts`(`customer_email`, `subject_id`, `cart_qty`) VALUES ('$useremail','$subjectid','$cartqty')";
if ($conn->query($addcart) === TRUE) {

}else{
    $response = array('status' => 'failed', 'data' => null);
	sendJsonResponse($response);
	return;
}

$sqlgetqty = "SELECT * FROM tbl_carts WHERE customer_email = '$useremail' AND cart_status IS NULL";
$result = $conn->query($sqlgetqty);
$number_of_result = $result->num_rows;
$carttotal = 0;
while($row = $result->fetch_assoc()) {
    $carttotal = $row['cart_qty'] + $carttotal;
}
$mycart = array();
$mycart['carttotal'] =$carttotal;
$response = array('status' => 'success', 'data' => $mycart);
sendJsonResponse($response);

function sendJsonResponse($sentArray)
{
    header('Content-Type: application/json');
    echo json_encode($sentArray);
}

?>