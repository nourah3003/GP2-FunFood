<?php
header('Content-Type: application/json');
include("connection.php");
$s = array();
	    

        $data = json_decode(file_get_contents("php://input"));
        $user_id = $data->user_id;

        $image = $data->image_url;

        $image = str_replace('data:image/png;base64,','',$image);
        $image = str_replace('data:image/jpg;base64,','',$image);
        $image = str_replace('data:image/jpeg;base64,','',$image);
        $image = str_replace(' ', '+', $image);
        $decoded_string = base64_decode($image);
        $rand = rand(1000,2000);
        $path = 'houses/'.$user_id.$rand.'.jpg';
        $file = fopen($path,'wp');
        $is_written = fwrite($file,$decoded_string);
        fclose($file);

                    $sql = "SELECT * from users where id = ? ";
                    $stmt = $conn ->prepare($sql);
                    $stmt->execute([$user_id]);
                    $user = $stmt->fetch();

                    if($user['coins'] > 5){
                        $sql = "SELECT * from palaces where user_id = ? ";
                        $stmt1 = $conn ->prepare($sql);
                        $stmt1->execute([$user_id]);

                    if($stmt->rowCount() == 0){
                        $sql = "INSERT INTO palaces (`user_id`,`image`,`num`) VALUES (?,?,?)";
                        $stmt = $conn->prepare($sql);
                        $stmt->execute([$user_id,$url,1]);

                        $h = $user['coins'] - 5;
                        $sql = "update users set coins=? where id=?";
                        $stmt = $conn ->prepare($sql);
                        $stmt->execute([$h,$user_id]);

                        $s = array(
                            'code'=>"1",
                            'message'=>'palace Added successfully'
                        );
                        echo json_encode($s);

                    }
                    elseif($stmt->rowCount() > 0){
                        $city = $stmt1->fetch();
                        if($city['num'] == 5){
                            $sql = "update palaces set image=?,num=? where user_id=?";
                            $stmt = $conn->prepare($sql);
                            $stmt->execute(["",0,$user_id]);

                            $h = $user['coins'] - 5;
                            $sql = "update users set coins=? where id=?";
                            $stmt = $conn ->prepare($sql);
                            $stmt->execute([$h,$user_id]);

                            $s = array(
                                'code'=>"2",
                                'message'=>'palace Added successfully'
                            );
                            echo json_encode($s);

                        }
                        else{

                        $img = $city['image'].",".$path;
                        $n = $city['num']+1;
                        $sql = "update palaces set image=?,num=? where user_id=?";
                        $stmt = $conn->prepare($sql);
                        $stmt->execute([$img,$n ,$user_id]);

                        $h = $user['coins'] - 5;
                        $sql = "update users set coins=? where id=?";
                        $stmt = $conn ->prepare($sql);
                        $stmt->execute([$h,$user_id]);
                        $s = array(
                            'code'=>"1",
                            'message'=>'palace Added successfully'
                        );
                        echo json_encode($s);
                    }

                    }
                    }
                    else{
                        $s = array(
                            'code'=>"0",
                            'message'=>'Sorry you do not have any coins to add'
                        );
                        echo json_encode($s);
                    }            
        
?>