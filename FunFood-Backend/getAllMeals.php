<?php
header('Content-Type: application/json');
include("connection.php");
$s = array();
	    

        $data = json_decode(file_get_contents("php://input"));
        $user_id = $data->user_id;


                
            		$sql = "SELECT * from meals where user_id = ? ";
		            $stmt = $conn ->prepare($sql);
		            $stmt->execute([$user_id]);
                    $count = $stmt->rowCount();
                    if ($count > 0) {
		            $meals = $stmt->fetchAll();
                    foreach($meals as $meal){
                        if($meal['accepted'] == 0){
                            $s[] = array(
                                'code'=>"1",
                                    'serving_id'=>"".$meal['id'],
                                    'user_id'=>"".$meal['user_id'],
                                    'name'=>$meal['name'],
                                    'image_url'=>$meal['image'],
                                    'date'=>$meal['year']."/".$meal['mounth']."/".$meal['day'],
                                    'confirmed'=>"0"
                            ); 
                        }
                        elseif($meal['accepted'] == 1){
                            $s[] = array(
                                'code'=>"1",
                                    'serving_id'=>"".$meal['id'],
                                    'user_id'=>"".$meal['user_id'],
                                    'name'=>$meal['name'],
                                    'image_url'=>$meal['image'],
                                    'date'=>$meal['year']."/".$meal['mounth']."/".$meal['day'],
                                    'confirmed'=>"1"
                            ); 
                        }
                        
                    }
            		
                echo json_encode($s);}
                else{
                    $s[] = array(
                        'code'=>"-1",
                        'message'=>"there is no meals"
                    );
                }
            
        
?>