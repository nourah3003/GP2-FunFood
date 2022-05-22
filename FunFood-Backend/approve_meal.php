<?php
    include("connection.php");
    $s = array();
    $data = json_decode(file_get_contents("php://input"));
    $user_id = $data->user_id;
    $serving_id = $data->serving_id;
    $d = date("Y/m/d");
        $date = explode('/', $d);
        $ss = "";
        

        $query = "update meals set accepted = 1 WHERE id = ? ";
        $stmt = $conn->prepare($query);
        $stmt->execute([$serving_id]);

        $query = "SELECT * FROM meals WHERE user_id = ? AND accepted = 1 and day = ?";
        $stmt = $conn->prepare($query);
        $stmt->execute([$user_id,ltrim($date[2],"0")]);
        $count = $stmt->rowCount();

        if($count == 5){
            $query = "SELECT * FROM users WHERE id = ?";
            $stmt = $conn->prepare($query);
            $stmt->execute([$user_id]);
            $row = $stmt->fetch();

            $houses = $row['houses'] + 1;
            $query = "update users set houses = ? WHERE id = ? ";
            $stmt = $conn->prepare($query);
            $stmt->execute([$houses,$user_id]);
            $s = array(
                'code'=>"1",
                'message'=>'meal was upproved successfully'
            );
            echo json_encode($s);
        }
        elseif($count == 10){
            $query = "SELECT * FROM users WHERE id = ?";
            $stmt = $conn->prepare($query);
            $stmt->execute([$user_id]);
            $row = $stmt->fetch();

            $houses = $row['houses'] + 1;
            $query = "update users set houses = ? WHERE id = ? ";
            $stmt = $conn->prepare($query);
            $stmt->execute([$houses,$user_id]);
            $s = array(
                'code'=>"1",
                'message'=>'meal was upproved successfully'
            );
            echo json_encode($s);
        }
        elseif($count == 15){
            $query = "SELECT * FROM users WHERE id = ?";
            $stmt = $conn->prepare($query);
            $stmt->execute([$user_id]);
            $row = $stmt->fetch();

            $houses = $row['houses'] + 1;
            $query = "update users set houses = ? WHERE id = ? ";
            $stmt = $conn->prepare($query);
            $stmt->execute([$houses,$user_id]);
            $s = array(
                'code'=>"1",
                'message'=>'meal was upproved successfully'
            );
            echo json_encode($s);
        }
        else{
            $s = array(
                'code'=>"1",
                'message'=>'meal was upproved successfully'
            );
            echo json_encode($s);
        }

?>