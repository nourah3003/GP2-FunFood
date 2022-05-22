<?php
header('Content-Type: application/json');
include("connection.php");
$s = array();
	    

        $data = json_decode(file_get_contents("php://input"));
        $user_id = $data->user_id;
        $benefits = $data->benefits;
        $audio = $data->audio_base;
        $image = $data->image_base;
        $type = $data->type;
        $name = $data->name;


        $sql = "select * from items where name = ? ";
        $stmt = $conn->prepare($sql);
        $stmt->execute([$name]);
        if($stmt->rowCount() > 0){
            $s = array(
                'code'=>"-1",
                'message'=>'sorry this name is already exist'
            );
            echo json_encode($s);
        }
        else{
        
        $image = str_replace('data:image/png;base64,','',$image);
        $image = str_replace('data:image/jpg;base64,','',$image);
        $image = str_replace('data:image/jpeg;base64,','',$image);
        $image = str_replace(' ', '+', $image);
        $decoded_string = base64_decode($image);
        $path = 'images/'.$name.$user_id.'.jpg';
        $file = fopen($path,'wp');
        $is_written = fwrite($file,$decoded_string);
        fclose($file);

        $rand = rand(1000,2000);
        $audio_name = 'audio/'.$user_id.''.$rand;

        file_put_contents($audio_name, base64_decode($audio));
             
                    $sql = "INSERT INTO items (`user_id`,`image`,`audio`,`name`,`benefits`,`type`) VALUES (?,?,?,?,?,?)";
                    $stmt = $conn->prepare($sql);
                    $stmt->execute([$user_id,$path,$audio_name,$name,$benefits,$type]);
                
            		$sql = "SELECT * from items where user_id = ? and image = ?";
		            $stmt = $conn ->prepare($sql);
		            $stmt->execute([$user_id,$path]);
		            $item = $stmt->fetch();
            		$s = array(
                    'code'=>"1",
                    	'id'=>"".$item['id'],
                        'user_id'=>"".$user_id,
                        'image_url'=>$path,
                        'audio_url'=>$audio_name,
                        'name'=>$name,
                        'benefits'=>$benefits,
                        'type'=>"".$type,
                    'message'=>'item Added successfully'
                );
                echo json_encode($s);}
            
        
?>