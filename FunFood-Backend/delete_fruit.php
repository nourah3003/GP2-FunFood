<?php
header('Content-Type: application/json');
include("connection.php");
$s = array();
	    

        $data = json_decode(file_get_contents("php://input"));
        $user_id = $data->user_id;
        $fruit_id = $data->fruit_id;

             
                    $sql = "delete from items where id =?";
                    $stmt = $conn->prepare($sql);
                    $stmt->execute([$fruit_id]);
                
                        $item = $stmt->fetch();

                            $s = array(
                                    'code'=>"1",
                                    'message'=>"fruit  was deleted"

                            );
                        echo json_encode($s);
                             
        
?>