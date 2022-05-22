<?php
header('Content-Type: application/json');
include("connection.php");
$s = array();
	    

        $data = json_decode(file_get_contents("php://input"));
        $user_id = $data->user_id;



        $path = $data->image_url;


                    $sql = "SELECT * from users where id = ? ";
                    $stmt = $conn ->prepare($sql);
                    $stmt->execute([$user_id]);
                    $user = $stmt->fetch();

                    if($user['houses'] > 0){
                        $sql = "SELECT * from city where user_id = ? ";
                        $stmt1 = $conn ->prepare($sql);
                        $stmt1->execute([$user_id]);

                    if($stmt1->rowCount() == 0){
                        $sql = "INSERT INTO city (`user_id`,`image`,`num`) VALUES (?,?,?)";
                        $stmt = $conn->prepare($sql);
                        $stmt->execute([$user_id,$path,1]);

                        $h = $user['houses'] - 1;
                        $sql = "update users set houses=? where id=?";
                        $stmt = $conn ->prepare($sql);
                        $stmt->execute([$h,$user_id]);

                        $s = array(
                            'code'=>"1",
                            'message'=>'house Added successfully'
                        );
                        echo json_encode($s);

                    }
                    elseif($stmt1->rowCount() > 0){
                        $city = $stmt1->fetch();
                        if($city['num'] == 5){
                            $sql = "DELETE FROM city  where user_id=?";
                            $stmt = $conn->prepare($sql);
                            $stmt->execute([$user_id]);

                            $h = $user['houses'] - 1;
                            $sql = "update users set houses=? where id=?";
                            $stmt = $conn ->prepare($sql);
                            $stmt->execute([$h,$user_id]);

                            $s = array(
                                'code'=>"2",
                                'message'=>'house Added successfully'
                            );
                            echo json_encode($s);

                        }
                        else{

                        $img = $city['image'].",".$path;
                        $n = $city['num']+1;
                        $sql = "update city set image=?,num=? where user_id=?";
                        $stmt = $conn->prepare($sql);
                        $stmt->execute([$img,$n ,$user_id]);

                        $h = $user['houses'] - 1;
                        $sql = "update users set houses=? where id=?";
                        $stmt = $conn ->prepare($sql);
                        $stmt->execute([$h,$user_id]);
                        $s = array(
                            'code'=>"1",
                            'message'=>'house Added successfully'
                        );
                        echo json_encode($s);
                    }

                    }
                    }
                    else{
                        $s = array(
                            'code'=>"0",
                            'message'=>'Sorry you do not have any houses to add'
                        );
                        echo json_encode($s);
                    }            
        
?>