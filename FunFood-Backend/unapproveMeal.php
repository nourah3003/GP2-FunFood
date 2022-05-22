<?php
    include("connection.php");
    $s = array();
    $data = json_decode(file_get_contents("php://input"));
    $user_id = $data->user_id;
    $serving_id = $data->serving_id;
    


        $query = "delete from meals WHERE id = ? ";
        $stmt = $conn->prepare($query);
        $stmt->execute([$serving_id]);
            $s = array(
                'code'=>"1",
                'message'=>'meal was unapproved'
            );
            echo json_encode($s);

?>