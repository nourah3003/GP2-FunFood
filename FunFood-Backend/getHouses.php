<?php
header('Content-Type: application/json');
include("connection.php");
$s = array();
	    

        $data = json_decode(file_get_contents("php://input"));
        $user_id = $data->user_id;

                        $sql = "SELECT * from city where user_id = ? and num>0 ";
                        $stmt1 = $conn ->prepare($sql);
                        $stmt1->execute([$user_id]);

                    if($stmt1->rowCount() == 0){


                        $s = array(
                            'code'=>"-1",
                            'message'=>'sorry there is no houses'
                        );
                        echo json_encode($s);

                    }
                    elseif($stmt1->rowCount() > 0){
                        $city = $stmt1->fetch();
                        $images = explode(",", $city['image']);
                        $c = count($images);

                        for ($x = 0; $x < $c; $x++) {
                            $s[] = array(
                                'user_id'=>"".$user_id,
                                'image_url'=>$images[$x]
                            );
                           
                          }
                          echo json_encode($s);

                    }      
        
?>