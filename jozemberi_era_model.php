<?php
	session_start();
	require_once('_jozemberi_smarty.php');
	$smarty->assign('naslov', 'ERA model');
	$smarty->assign('div_id', 'content');
	
	$smarty->display('jozemberi_era_model.tpl');

	include 'templates/jozemberi_footer.tpl';
?>