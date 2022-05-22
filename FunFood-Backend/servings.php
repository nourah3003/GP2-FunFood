<?php
header('Content-Type: application/json');
include("connection.php");
$s = array();
	    

        $data = json_decode(file_get_contents("php://input"));
        $user_id = $data->user_id;
        $day = $data->day;
        $mounth = $data->mounth;
        $year = $data->year;
       

             
                
            		$sql = "SELECT * from meals where user_id = ? and day = ? and mounth = ? and year = ?";
		            $stmt = $conn ->prepare($sql);
		            $stmt->execute([$user_id,$day,$mounth,$year]);
                    $count = $stmt->rowCount();
                    if ($count > 0) {
                        $meal = $stmt->fetch();
                        $s = array(
                    'code'=>"1",
                        'meal_id'=>$meal['id'],
                        'user_id'=>$user_id,
                        'serving'=>$meal['name'],
                        'num'=>$meal['num'],
                        'URL'=>$meal['image'],
                        'year'=>$year,
                        'mounth'=>$mounth,
                        'day'=>$day,
                    'message'=>'meals featched successfully'
                );
                echo json_encode($s);
                    }
		            
            		else{
                           $s = array(
                    'code'=>"-1",
                    'message'=>'sorry there is no meals '
                );
                echo json_encode($s);
                    }
            
        
?>