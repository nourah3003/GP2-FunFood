<?php
    include("connection.php");
    $s = array();
    $data = json_decode(file_get_contents("php://input"));
    $user_id = $data->user_id;
    $mounth = $data->mounth;
        $day = $data->day;
        $year = $data->year;
    $row = null;


    $sql = "SELECT * from meals where user_id =? and  year = ? and mounth = ? and day = ?";
    $stmt = $conn ->prepare($sql);
    $stmt->execute([$user_id,$year,$mounth,$day]);
        $count = $stmt->rowCount();
                        $s = array(
                            'code' => "1",
                            'num' => $count,
                            'message' => 'the number of unaproved meals'
                        );
                        echo json_encode($s);


?>