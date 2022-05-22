<?php
$d = date("Y/m/d H:i:s");
$date = explode('/', $d);
$time = explode(' ', $d);


echo $time[1];
?>