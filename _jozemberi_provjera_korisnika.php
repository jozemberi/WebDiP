<?php
	header('Content-Type: text/xml');
	$kor=$_GET['kor'];
	require_once('_jozemberi_baza.php');
	bazaConnect();
	
	$sql = mysql_query("SELECT * FROM korisnik WHERE username='$kor'");
	$korisnik = mysql_fetch_array($sql);
	
	$xmlStr='<?xml version="1.0" encoding="UTF-8"?><korisnik><postoji>'.count($korisnik['username']).'</postoji></korisnik>';
	echo $xmlStr;  
	
	bazaDisconnect();
?>