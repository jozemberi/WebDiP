<?php
	session_start();
	require_once('_jozemberi_smarty.php');
	$smarty->assign('naslov', 'Detaljnije informacije o projektu');
	$smarty->assign('div_id', 'content');
	
	$smarty->display('jozemberi_detaljnije_o_projektu.tpl');

	include 'templates/jozemberi_footer.tpl';
?>