<?php
header('Content-Type: application/json');
include("connection.php");
$s = array();
	    

        $data = json_decode(file_get_contents("php://input"));
        $user_id = $data->user_id;
        $id = $data->id;
       

             
                
            		$sql = "SELECT * from fruits where id = ? and user_id = ?";
		            $stmt = $conn ->prepare($sql);
		            $stmt->execute([$id,$user_id]);
                    $count = $stmt->rowCount();
                    if ($count > 0) {
                        $fruit = $stmt->fetch();
                        
                    $s= array(
                        'code'=>"1",
                        'id'=>$fruit['id'],
                        'user_id'=>$user_id,
                        'name'=>$fruit['name'],
                        'content'=>$fruit['content'],
                        'URL'=>$fruit['image'],
                        'message'=>'fruit featched successfully'
                );
                        
                       
                echo json_encode($s);
                    }
		            
            		else{
                           $s = array(
                    'code'=>"-1",
                    'message'=>'sorry there is no fruits '
                );
                echo json_encode($s);
                    }
            
        
?>