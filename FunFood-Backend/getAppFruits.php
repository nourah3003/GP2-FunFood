<?php
header('Content-Type: application/json');
include("connection.php");
$s = array();
	    



             
                    $sql = "select * from items where user_id = 0 and type = 1";
                    $stmt = $conn->prepare($sql);
                    $stmt->execute();
                
            		if($stmt->rowCount() > 0){
                        $items = $stmt->fetchAll();

                        foreach($items as $item){
                            $s[] = array(
                                    'fruit_id'=>"".$item['id'],
                                    'user_id'=>"".$item['user_id'],
                                    'image_url'=>$item['image'],
                                    'audio_url'=>$item['audio'],
                                    'name'=>$item['name'],
                                    'benefits'=>$item['benefits'],
                                    'type'=>"".$item['type']

                            );
                        }
                        echo json_encode($s);
                    }
                    else{
                        $s[] = array(
                            'code'=>"-1",
                            'message'=>"there is no fruits"

                    ); 
                    echo json_encode($s);
                    }
		            
            		
               
            
        
?>