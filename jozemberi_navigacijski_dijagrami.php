<?php
	session_start();
	require_once('_jozemberi_smarty.php');
	$smarty->assign('naslov', 'Navigacijski dijagrami');
	$smarty->assign('div_id', 'content');
	
	$smarty->display('jozemberi_navigacijski_dijagrami.tpl');

	include 'templates/jozemberi_footer.tpl';
?>