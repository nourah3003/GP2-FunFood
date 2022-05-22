<?php
    include("connection.php");
    $s = array();
    $data = json_decode(file_get_contents("php://input"));
    $user_id = $data->user_id;
    $row = null;
    $d = date("Y/m/d");
    $date = explode('/', $d);

        $query = "SELECT * FROM meals WHERE user_id = ? AND accepted = 0 AND year=? AND mounth=? AND day=?";
        $stmt = $conn->prepare($query);
        $stmt->execute([$user_id,ltrim($date[0],"0"),ltrim($date[1],"0"),ltrim($date[2],"0")]);
        $count = $stmt->rowCount();
                        $s = array(
                            'code' => "1",
                            'num' => $count,
                            'user_id' => "".$user_id,
                            'year' => ltrim($date[0],"0"),
                            'mounth' => ltrim($date[1],"0"),
                            'day' => ltrim($date[2],"0"),
                            'message' => 'the number of unaproved meals'
                        );
                        echo json_encode($s);


?>