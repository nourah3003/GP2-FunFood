<?php
header('Content-Type: application/json');
include("connection.php");
$s = array();
	    

        $data = json_decode(file_get_contents("php://input"));
        $user_id = $data->user_id;
        $vegetable_id = $data->vegetable_id;

             
                    $sql = "select * from items where id = ? ";
                    $stmt = $conn->prepare($sql);
                    $stmt->execute([$vegetable_id]);
                
                        $item = $stmt->fetch();

                            $s = array(
                                    'vegetable_id'=>"".$item['id'],
                                    'user_id'=>"".$item['user_id'],
                                    'image_url'=>$item['image'],
                                    'audio_url'=>$item['audio'],
                                    'name'=>$item['name'],
                                    'benefits'=>$item['benefits'],
                                    'type'=>"".$item['type']

                            );
                        echo json_encode($s);
                  
		            
            		
               
            
        
?>