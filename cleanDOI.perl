if (m/^[Dd][Oo][Ii]:\s?[\[\{]([^\][\]\}]*)/) { 
  $do=$1;
}else{ 
  if (m|^[Dd][Oo][Ii]:\s?([0-9A-Za-z\-_\./]*)|){
    $do=$1;$do=~s/\.$//;
  }else{ 
    if(m|["'][Dd][Oo][Ii]["']:\s?([0-9A-Za-z\-_\./\"']*)|){ 
	   $do = $1;
		$do = s/["']//g;
	 }else{
	   print;
	 }
  }
}
