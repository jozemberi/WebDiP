<?php
	session_start();
	require_once('_jozemberi_smarty.php');
	
	$smarty->assign("naslov", "Početna stranica");
	$smarty->assign("div_id", "content");
	$smarty->display("jozemberi_home.tpl");
	
	include 'templates/jozemberi_footer.tpl';
?>