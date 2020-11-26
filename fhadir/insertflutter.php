<?php 
include "connect.php";
//insertflutter.php

  
    $gpsdata = $_POST['gpsdata'];
    $statusbekerja = $_POST['statusbekerja'];
  
        $sql = "INSERT INTO a_rekodhadir (gpsdata , statusbekerja ) VALUES ('$gpsdata' , '$statusbekerja')";
        $result = mysqli_query($db,$sql);
        if ($result==true){echo "success";}
	    else {echo "error:".mysqli_error($db);}
        //$conn->close();    
    
    


    
    
    ?>