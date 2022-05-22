<?php
    include("connection.php");
    $s = array();
    $data = json_decode(file_get_contents("php://input"));
    $user_id = $data->user_id;
    $row = null;


        $query = "SELECT * FROM meals WHERE user_id = ? AND accepted = 0";
        $stmt = $conn->prepare($query);
        $stmt->execute([$user_id]);
        $count = $stmt->rowCount();
        if ($count > 0) {
           $row = $stmt->fetchAll();
         foreach($row as $r ){
              $s[] = array(
                        'code'=>1,
                        'url'=>$r['image'],
                        'text'=>$r['name']
                ); 
         }
        echo json_encode($s);
        }
        else{
            $s[] = array(
                        'code'=>2
                );
        }
        


?>