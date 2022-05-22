<?php
header('Content-Type: application/json');
include("connection.php");
$s = array();
	    

        $data = json_decode(file_get_contents("php://input"));
        $user_id = $data->user_id;
        $vegetable_id = $data->vegetable_id;
        $audio_base = $data->audio_base;

        $rand = rand(1000,2000);
        $audio_name = 'audio/'.$user_id.''.$rand;

        file_put_contents($audio_name, base64_decode($audio_base));

             
                    $sql = "update items set audio=? where id =?";
                    $stmt = $conn->prepare($sql);
                    $stmt->execute([$audio_name,$vegetable_id]);
                
                        $item = $stmt->fetch();

                            $s = array(
                                    'code'=>"1",
                                    'message'=>"vegetable audio was updated"

                            );
                        echo json_encode($s);
                             
        
?>