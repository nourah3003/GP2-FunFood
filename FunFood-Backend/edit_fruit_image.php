<?php
header('Content-Type: application/json');
include("connection.php");
$s = array();
	    

        $data = json_decode(file_get_contents("php://input"));
        $user_id = $data->user_id;
        $fruit_id = $data->fruit_id;
        $image = $data->image_base;


        $image = str_replace('data:image/png;base64,','',$image);
        $image = str_replace('data:image/jpg;base64,','',$image);
        $image = str_replace('data:image/jpeg;base64,','',$image);
        $image = str_replace(' ', '+', $image);
        $decoded_string = base64_decode($image);
        $path = 'images/'.$fruit_id.$user_id.'.jpg';
        $file = fopen($path,'wp');
        $is_written = fwrite($file,$decoded_string);
        fclose($file);


             
                    $sql = "update items set image=? where id =?";
                    $stmt = $conn->prepare($sql);
                    $stmt->execute([$path,$fruit_id]);
                
                        $item = $stmt->fetch();

                            $s = array(
                                    'code'=>"1",
                                    'message'=>"fruit image was updated"

                            );
                        echo json_encode($s);
                             
        
?>