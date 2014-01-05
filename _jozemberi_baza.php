<?php
	$dbc = null;
	
	function bazaConnect(){
		$bp_server = '-';
		$bp_korisnik = '-';
		$bp_lozinka = '-';
		$bp_baza = '-';
		GLOBAL $dbc;
		$dbc = null;
		$db = null;
		
		$dbc= mysql_connect($bp_server, $bp_korisnik, $bp_lozinka);
		if(!$dbc) trigger_error('Problem kod povezivanja na bazu podataka!', E_USER_ERROR);
		
		$db = mysql_select_db($bp_baza, $dbc);
		if(!$db) trigger_error('Problem kod selektiranja baze podataka!', E_USER_ERROR);
		
		mysql_query('set names utf8');
	}
	
	function bazaDisconnect(){
		//GLOBAL $dbc;
		//mysql_close($dbc);
	}
	
?>