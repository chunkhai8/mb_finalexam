<?php
if (!isset($_POST)) {
    $response = array('status' => 'failed', 'data' => null);
    sendJsonResponse($response);
    die();
}
include_once("dbconnect1.php");
$results_per_page = 5;
$pageno = (int)$_POST['pageno'];
$page_first_result = ($pageno - 1) * $results_per_page;
$search = $_POST['search'];

$sqlloadsubject = "SELECT tbl_subjects.subject_id, tbl_subjects.subject_name, tbl_subjects.subject_description, tbl_subjects.subject_price, tbl_subjects.subject_sessions, tbl_subjects.subject_rating, tbl_subjects.tutor_id,tbl_tutors.tutor_name FROM tbl_subjects INNER JOIN tbl_tutors ON tbl_subjects.tutor_id = tbl_tutors.tutor_id WHERE subject_name LIKE '%$search%' ORDER BY subject_id DESC";
$result = $conn->query($sqlloadsubject);
$number_of_result = $result->num_rows;
$number_of_page = ceil($number_of_result / $results_per_page);
$sqlloadsubject = $sqlloadsubject . " LIMIT $page_first_result , $results_per_page";
$result = $conn->query($sqlloadsubject);

if ($result->num_rows > 0) {
    $subjects["subjects"] = array();
    while ($row = $result->fetch_assoc()) {
        $sublist = array();
        $sublist['subject_id'] = $row['subject_id'];
        $sublist['subject_name'] = $row['subject_name'];
        $sublist['subject_description'] = $row['subject_description'];
        $sublist['subject_price'] = $row['subject_price'];
        $sublist['tutor_id'] = $row['tutor_id'];
        $sublist['tutor_name'] = $row['tutor_name'];
        $sublist['subject_sessions'] = $row['subject_sessions'];
        $sublist['subject_rating'] = $row['subject_rating'];
        array_push($subjects['subjects'], $sublist);
    }
    $response = array('status' => 'success',  'pageno'=>"$pageno",'numofpage'=>"$number_of_page", 'data' => $subjects);
    sendJsonResponse($response);
} else {
    $response = array('status' => 'failed','pageno'=>"$pageno",'numofpage'=>"$number_of_page", 'data' => null);
    sendJsonResponse($response);
}

function sendJsonResponse($sentArray)
{
    header('Content-Type: application/json');
    echo json_encode($sentArray);
}

?>