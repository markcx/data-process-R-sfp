<?php
	/**
	 * This script use google geocode reverse public api
	 * @access
	 * example: http://maps.googleapis.com/maps/api/geocode/json?latlng=40.714224,-73.961452&sensor=true_or_false
	 * 
	 * @author markcx@stanford.edu
	 * @since 10/03/2013  
	 * 
	 */

class GeoToZipGoogle {
	
	private $cachedDictionary = array();
	private $zoneList=array();
	private static $GOOGLE_MAP_API_LINK = 'http://maps.googleapis.com/maps/api/geocode/json?';
	
	
	public function __construct($arrayInput){
		$this->cachedDictionary = $arrayInput;	
	}
	
	public function process(){
		for($i=0;$i<count($this->cachedDictionary); $i++){ //count($this->cachedDictionary)
		 	$googleAPIquery = $this->filterLatLng($this->cachedDictionary[$i]);
		 	
		 	$parkCellID = $this->getCellID($this->cachedDictionary[$i]);
		 	//if($parkCellID=="467001"){
			$zipCode = $this->qGoogleGeoReverseAPI($googleAPIquery);
			$this->zoneList[$parkCellID] = $zipCode;
		 	//}
		 }
		
	}
	
	private function getCellID($pCell){
		return $pCell->cellID;
	}
	
	
	private function filterLatLng($pCell){
		$latlngStr=$pCell->geoLoc;
		$a = split(',', $latlngStr);	//split the string of geolocation
		//print_r($a);
		$lng=$a[0];			//first element is lng
		$lat=$a[1];			//second element is lat
		$q = self::$GOOGLE_MAP_API_LINK ."latlng=".$lat.",".$lng."&sensor=false" ;
		return $q;			//return api link
	}
	
	private function qGoogleGeoReverseAPI($link){
		$_zipCode = "00001";
		$loopCount=0;
		$response = file_get_contents($link);
		while($loopCount<2){
		  if(preg_match('/200/',$http_response_header['0'])){
			$result=json_decode($response);
			print_r($result);
			//print("==================\n");
			$addrComponents=$result->results[0]->address_components;
			//print_r($addrComponents);
			for($i=0; $i<count($addrComponents); $i++){
				if($addrComponents[$i]->types[0] =="postal_code"){
				//print($addrComponents[$i]->long_name ." ===\n");
					$_zipCode = $addrComponents[$i]->long_name;
					return $_zipCode;
				}
			}
		  }
		  sleep(0.5);
		  $loopCount +=1;	
		}
		return $_zipCode;
	}
	
	
	public function showLatLng($unit){
		print_r($unit->geoLoc);
		
	}
	
	public function display(){
		print_r($this->cachedDictionary);
	}
	
	public function displayList(){
		print_r($this->zoneList);
	}
	
	
	
}	  
	


?>