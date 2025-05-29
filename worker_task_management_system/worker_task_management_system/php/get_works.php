<?php
error_reporting(0);
header("Access-Control-Allow-Origin: *");

if (!isset($_POST)) {
    $response = array('status' => 'failed', 'data' => null);
    sendJsonResponse($response);
    die;
}

include_once("dbconnect.php");

$worker_id = $_POST['worker_id'];

$sql = "SELECT title, description, due_date, status，assigned_to, id FROM tbl_works WHERE assigned_to = '$worker_id'";
$result = $conn->query($sql);

if ($result->num_rows > 0) {
    $taskArray = array();
    while ($row = $result->fetch_assoc()) {
        $taskArray[] = $row;
    }
    $response = array('status' => 'success', 'data' => $taskArray);
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
