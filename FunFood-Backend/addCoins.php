<?php
    include("connection.php");
    $s = array();
    $data = json_decode(file_get_contents("php://input"));
    $user_id = $data->user_id;



            $query = "SELECT * FROM users WHERE id = ?";
            $stmt = $conn->prepare($query);
            $stmt->execute([$user_id]);
            $row = $stmt->fetch();

            $coins = $row['coins'] + 5;
            $query = "update users set coins = ? WHERE id = ? ";
            $stmt = $conn->prepare($query);
            $stmt->execute([$coins,$user_id]);
            $s = array(
                'code'=>"1",
                'message'=>'coins added successfully'
            );
            echo json_encode($s);
       

?>