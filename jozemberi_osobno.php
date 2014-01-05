<?php
	session_start();
	require_once('_jozemberi_smarty.php');
	$smarty->assign('naslov', 'Osobni podaci');
	$smarty->assign('div_id', 'content');
	
	$smarty->display('jozemberi_osobno.tpl');

	include 'templates/jozemberi_footer.tpl';
?>