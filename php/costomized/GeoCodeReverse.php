<?php
	/**
	 * @internal
	 * the script is ought to display all the available parking info as JSON format file 
	 * use 'get' request: http://54.214.235.113/sfpark/www/docs/datafetcher.php?parklist=all
	 * @author markcx@stanford.edu
	 * @since 10/02/2013
	 */
	include 'plugin/GeoToZipGoogle.php';
	
	$qStr = 'http://54.214.235.113/sfpark/www/docs/datafetcher.php?parklist=all';
	 
	$response = file_get_contents($qStr);
	$pattern_HTTP_CODE_SUCCESS = "/200/";		//normal http request status
	if(preg_match($pattern_HTTP_CODE_SUCCESS,$http_response_header['0'])){
		//display($response);
		$list = new GeoToZipGoogle(json_decode($response));
		//$list->display();
		$list->process();
		$list->displayList();
	} 
	
	function display(&$content){
		print_r(json_decode($content));		
		
	}
	
	
?>