<?php
	session_start();
	require_once('_jozemberi_smarty.php');
	$smarty->assign('naslov', 'Dokumentacija');
	$smarty->assign('div_id', 'content_v530px');
	
	$smarty->display('jozemberi_dokumentacija.tpl');

	include 'templates/jozemberi_footer.tpl';
?>