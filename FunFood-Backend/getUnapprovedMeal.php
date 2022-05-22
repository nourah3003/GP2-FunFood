<?php
header('Content-Type: application/json');
include("connection.php");
$s = array();
	    

        $data = json_decode(file_get_contents("php://input"));
        $user_id = $data->user_id;


                
            		$sql = "SELECT * from meals where user_id = ? and accepted = 0";
		            $stmt = $conn ->prepare($sql);
		            $stmt->execute([$user_id]);
                    $count = $stmt->rowCount();
                    if ($count > 0) {
		            $meals = $stmt->fetchAll();
                    foreach($meals as $meal){
                        $s[] = array(
                            'code'=>"1",
                                'serving_id'=>"".$meal['id'],
                                'user_id'=>"".$meal['user_id'],
                                'name'=>$meal['name'],
                                'number_of_servings'=>$meal['num'],
                                'image_url'=>$meal['image'],
                                'date'=>$meal['year']."/".$meal['mounth']."/".$meal['day'],
                                'time'=>"11:19:00"
                        );
                    }
            		
                echo json_encode($s);}
                else{
                    $s[] = array(
                        'code'=>"-1",
                        'message'=>"there is no unapproved meals"
                    );
                }
            
        
?>