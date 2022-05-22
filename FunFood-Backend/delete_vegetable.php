<?php
header('Content-Type: application/json');
include("connection.php");
$s = array();
	    

        $data = json_decode(file_get_contents("php://input"));
        $user_id = $data->user_id;
        $vegetable_id = $data->vegetable_id;

             
                    $sql = "delete from items where id =?";
                    $stmt = $conn->prepare($sql);
                    $stmt->execute([$vegetable_id]);
                
                        $item = $stmt->fetch();

                            $s = array(
                                    'code'=>"1",
                                    'message'=>"vegetable  was deleted"

                            );
                        echo json_encode($s);
                             
        
?>