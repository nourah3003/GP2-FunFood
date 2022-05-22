<?php
 include 'connection.php';

$data = json_decode(file_get_contents("php://input"));
$email = $data->email;


$n=15;
function generatePassword($n) {
    $characters = '0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ';
    $randomString = '';
  
    for ($i = 0; $i < $n; $i++) {
        $index = rand(0, strlen($characters) - 1);
        $randomString .= $characters[$index];
    }
  
    return $randomString;
}

$password = generatePassword($n);

$query = "SELECT * FROM users WHERE email = ? ";
        $stmt = $conn->prepare($query);
        $stmt->execute([$email]);
        $user = $stmt->fetch();

        $count = $stmt->rowCount();

    if($count == 0){
        $s = array(
                            'code' => "-1",
                            'message' => 'email is invaild'
                        );
                        echo json_encode($s);
    }
else{
$sql = "update users SET password = ? WHERE email = ?";
$stmt = $conn->prepare($sql);
$stmt->execute([$password,$email]);
    $to      = $email;
    $subject = 'reset Fun Food account passowrd';
    $message = 'the new password is :'. "\r\n" .$password;
    $headers = 'From: funfood.nrj@gmail.com'       . "\r\n" .
                 'Reset your Password' . "\r\n" .
                 'by Fun Food';
                 
    mail($to, $subject, $message, $headers);
    $s = array(
                            'code' => "1",
                            'message' => 'the new password is sent successfully to your email'
                        );
                        echo json_encode($s);
   }
?>
