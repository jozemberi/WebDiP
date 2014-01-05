<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<meta http-equiv='Content-Type' content='text/html; charset=UTF-8'/>
		<title>Upravljanje tablicama</title>
		<script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/1.5.2/jquery.min.js"></script>
		<script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jqueryui/1.8.11/jquery-ui.min.js"></script>
		<link type="text/css" rel="stylesheet" href="http://ajax.googleapis.com/ajax/libs/jqueryui/1.7/themes/smoothness/jquery-ui.css"/>
		
		<link rel='shortcut icon' href='img/wp_icon.ico' type='image/x-icon' />
		<link rel="stylesheet" href="ajaxCRUD/css/default.css" type="text/css"/>

	<script src="ajaxCRUD/javascript_functions.js" type="text/javascript"></script>
		<script src="ajaxCRUD/validation.js" type="text/javascript"></script>	
	<script type='text/javascript' src='chrome-extension://bfbmjmiodbnnpllbbbfblcplfjjepjdn/js/injected.js'></script>
	</head>
	<body>
<?php
	//session_start();
	//ob_start();
	
	include ('ajaxCRUD/preheader.php');
	include ('ajaxCRUD/ajaxCRUD.class.php');

	$boje = new ajaxCRUD("boje", "boje", "id_boje"); 
	$boje->omitPrimaryKey(); 
	$boje->showTable(); 
	
	$marka_automobila = new ajaxCRUD("marka_automobila", "marka_automobila", "id_marke");
	$marka_automobila->omitPrimaryKey(); 
	$marka_automobila->showTable(); 
	
	$kategorije_opreme = new ajaxCRUD("kategorije_opreme", "kategorije_opreme", "kategorije"); 
	$kategorije_opreme->omitPrimaryKey(); 
	$kategorije_opreme->showTable(); 
	//ob_flush(); 
?>
</body>
</html>