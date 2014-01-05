<?php
	session_start();
	require_once('_jozemberi_smarty.php');
	$smarty->assign('naslov', 'Dijagrami sekvence');
	$smarty->assign('div_id', 'content');
	
	$smarty->display('jozemberi_dijagrami_sekvence.tpl');

	include 'templates/jozemberi_footer.tpl';
?>