<?php
    include("connection.php");
    $s = array();
    $data = json_decode(file_get_contents("php://input"));
    $user_id = $data->user_id;



            $query = "SELECT * FROM users WHERE id = ?";
            $stmt = $conn->prepare($query);
            $stmt->execute([$user_id]);
            $row = $stmt->fetch();

            
            $s = array(
                'code'=>"1",
                'user_id'=>"".$user_id,
                'coins'=>"".$row['coins'],
                'message'=>'coins fetched successfully'
            );
            echo json_encode($s);
       

?>