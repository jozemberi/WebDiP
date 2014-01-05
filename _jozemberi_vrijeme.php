<?php
	require_once('_jozemberi_baza.php');
	
	function virtualnoVrijeme(){
		bazaConnect();
	
		$rs= mysql_query ("SELECT pomak FROM sustav WHERE id='1'") or die(mysql_error());
		$rez=mysql_fetch_array($rs);
		$virtualno_vrijeme = time() + (intval($rez['pomak']) * 60 * 60);
		
		bazaDisconnect();
		return $virtualno_vrijeme;
	}
	
	
?>