<?php
	session_start();
	require_once('_jozemberi_smarty.php');
	require_once('_recaptchalib.php');
	require_once('_simpleImage.php');
	require_once('_jozemberi_baza.php');
	bazaConnect();
	
	$smarty->assign('naslov', 'Kreiranje - Predefinirane linije');
	$smarty->assign('div_id', 'content_v530px');
	
	if (isset($_POST['kreiraj_liniju'])) {
		$greske=array();
	
		$naziv = mysql_real_escape_string($_POST['naziv']);
		
		if(empty ($naziv)) $greske['naziv'] = "Naziv linije nije unesen";
	
		$smarty->assign('greske', $greske);
		
		if (empty($greske)) {
			$upis_podataka = mysql_query ("INSERT INTO predefinirane_linije VALUES
						(default, '$naziv')") or die(mysql_error());
			
			bazaDisconnect();
			$smarty->display('jozemberi_kreiranje_predefiniranih_linija.tpl');
			
		}
		else {
			bazaDisconnect();
			$smarty->display('jozemberi_kreiranje_predefiniranih_linija.tpl');
		}
	}
	else $smarty->display('jozemberi_kreiranje_predefiniranih_linija.tpl');
	
	include 'templates/jozemberi_footer.tpl';
?>
