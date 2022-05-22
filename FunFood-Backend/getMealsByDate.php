<?php
header('Content-Type: application/json');
include("connection.php");
$s = array();
	    

        $data = json_decode(file_get_contents("php://input"));
        $user_id = $data->user_id;
        $mounth = $data->mounth;
        $day = $data->day;
        $year = $data->year;


                
            		$sql = "SELECT * from meals where user_id= ? and year = ? and mounth = ? and day = ?";
		            $stmt = $conn ->prepare($sql);
		            $stmt->execute([$user_id,$year,$mounth,$day]);
                    $count = $stmt->rowCount();
                 
		            $meals = $stmt->fetchAll();
                    foreach($meals as $meal){
                        $s[] = array(
                            'code'=>"1",
                                'serving_id'=>"".$meal['id'],
                                'user_id'=>"".$meal['user_id'],
                                'name'=>$meal['name'],
                                'image_url'=>$meal['image'],
                                'date'=>$meal['year']."/".$meal['mounth']."/".$meal['day'],
                                'time'=>$meal['m_time'],
                                'confirmed' => $meal['accepted'],
                                'num' => $meal['num']
                        );
                    }
            		
                echo json_encode($s);
              
            
        
?>