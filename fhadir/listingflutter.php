<?php
header('Content-Type: application/json'); //to make json format pretty
// code @GITHUB
// bit.ly/gitjson
// searchflutter.php
 
include "connect.php";
 
//keyword
if(!isset($_GET['key']))
	$key=null;
else 
	$key=$_GET['key'];
 
//generate JSON from table
$senaraikehadiran= array();
$response=array();
 
$sql="SELECT id,gpsdata,statusbekerja
FROM a_rekodhadir";
//WHERE trainingname LIKE '%$key%'
//OR trainingdesc LIKE  '%$key%' ";
 
//run query
$rs=mysqli_query($db,$sql);
if($rs==false){
	echo mysqli_error($rs);
}
 
//no record found
if (mysqli_num_rows($rs)==0){
	echo "rekod tidak dijumpai";
}
 
else{//found some records
	while($rec=mysqli_fetch_array($rs)){
		//capture one record
		$senaraikehadiran=array();
		$senaraikehadiran["id"] = $rec["id"];
		$senaraikehadiran["gpsdata"] = $rec["gpsdata"];
		$senaraikehadiran["statusbekerja"] = $rec["statusbekerja"];
		//push to response
		array_push($response, $senaraikehadiran);
 
	}//end while
 	echo json_encode($response); //output JSON format 
}//end found records
 
 
//generate JSON encoded data
//print_r $senaraikehadiran;

 
?>