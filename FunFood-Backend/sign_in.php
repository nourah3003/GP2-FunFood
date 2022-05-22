<?php
    header('Content-Type: application/json');
    include("connection.php");
    $s = array();
    $data = json_decode(file_get_contents("php://input"));
    $email = $data->email;
    $password = $data->password;
    $row = null;


     if (!empty($email) && !empty($password))
    {


        $query = "SELECT * FROM users WHERE email = ? AND password = ?";
        $stmt = $conn->prepare($query);
        $stmt->execute([$email, $password ]);
        $count = $stmt->rowCount();
        
        if($count > 0){
            $row = $stmt->fetch();
                        $s = array(
                            'code' => "1",
                            'user_id' => "".$row['id'],
                            'name' => $row['name'],
                            'email' => $row['email'],
                            'pin' => $row['pin'],
                            'message' => 'Login successfully'
                        );
                        echo json_encode($s);

                }
                else{
                        $s = array(
                        'code'=>"-1",
                        'data'=>null,
                        'message'=>'email and/or password is wrong'
                            );
                        echo json_encode($s);
                }
}
else{
        $s = array(
        'code'=>"-1",
        'data'=>null,
        'message'=>'you have to enter email & password'
        );
        echo json_encode($s); 
}

?>