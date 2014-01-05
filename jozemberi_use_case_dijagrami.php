<?php
	session_start();
	require_once('_jozemberi_smarty.php');
	$smarty->assign('naslov', 'Use case dijagrami');
	$smarty->assign('div_id', 'content');
	$smarty->display('jozemberi_use_case_dijagrami.tpl');
	include 'templates/jozemberi_footer.tpl';
?>