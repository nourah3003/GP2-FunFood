<?php
header('Content-Type: application/json');
include("connection.php");
$s = array();
	    

        $data = json_decode(file_get_contents("php://input"));
        $name = $data->name;
        $email = $data->email;
        $password = $data->password;
        $pin = $data->pin;
        
      		$sql = "SELECT * from users where email = ?";
            $stmt = $conn ->prepare($sql);
            $stmt->execute([$email]);
            if($stmt->rowCount()>0){
                        $s = array(
                'code'=>"-1",
                'data'=>null,
                'message'=>'sorry this email number is already exists'
            ); 
            echo json_encode($s);
             }
            else{
             
                    $sql = "INSERT INTO users (`name`,`email`,`password`,`pin`) VALUES (?,?,?,?)";
                    $stmt = $conn->prepare($sql);
                    $stmt->execute([$name,$email,$password,$pin]);
                
            		$sql = "SELECT * from users where email = ?";
		            $stmt = $conn ->prepare($sql);
		            $stmt->execute([$email]);
		            $user = $stmt->fetch();

                    $sql = "SELECT * from items where user_id = ?";
		            $stmt = $conn ->prepare($sql);
		            $stmt->execute([0]);
		            $items = $stmt->fetchAll();

                    foreach($items as $i){
                        $sql = "INSERT INTO items (`user_id`,`image`,`audio`,`name`,`benefits`,`type`) VALUES (?,?,?,?,?,?)";
                        $stmt = $conn->prepare($sql);
                        $stmt->execute([$user['id'],$i['image'],$i['audio'],$i['name'],$i['benefits'],$i['type']]);
                    }

            		$s = array(
                    'code'=>"1",
                    	'user_id'=>"".$user['id'],
                        'name'=>$name,
                        'email'=>$email,
                        'password'=>$password,
                        'pin'=>"".$pin,
                    'message'=>'User Added successfully'
                );
                echo json_encode($s);
            
        }
?>