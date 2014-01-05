<?php
	session_start();
	require_once('_jozemberi_smarty.php');
	require_once('_recaptchalib.php');
	require_once('_simpleImage.php');
	require_once('_jozemberi_baza.php');
	bazaConnect();
	
	$smarty->assign('naslov', 'Kreiranje akcije');
	$smarty->assign('div_id', 'content_v530px');
	
	if (isset($_POST['kreiraj_akciju'])) {
		$greske=array();
	
		$naziv = mysql_real_escape_string($_POST['naziv']);
		$cijena = mysql_real_escape_string($_POST['cijena']);
		$satPoc = mysql_real_escape_string($_POST['satPoc']);
		$danPoc = mysql_real_escape_string($_POST['danPoc']);
		$mjesecPoc = mysql_real_escape_string($_POST['mjesecPoc']);
		$godinaPoc = mysql_real_escape_string($_POST['godinaPoc']);
		
		$satZav = mysql_real_escape_string($_POST['satZav']);
		$danZav = mysql_real_escape_string($_POST['danZav']);
		$mjesecZav = mysql_real_escape_string($_POST['mjesecZav']);
		$godinaZav = mysql_real_escape_string($_POST['godinaZav']);
		
		
		if(empty ($naziv)) $greske['naziv'] = "Naziv akcije nije unesen";
		if(empty ($cijena)) $greske['cijena'] = "Akcijska cijena nije unesena";
		
		
		$smarty->assign('greske', $greske);
		
		$pocetak_akcije = $godinaPoc . "-" . $mjesecPoc . "-" . $danPoc . " " . $satPoc . ":00:00"; 
		$zavrsetak_akcije = $godinaZav . "-" . $mjesecZav . "-" . $danZav . " " . $satZav . ":00:00"; 
		
		if (empty($greske)) {
			
			$upis_podataka = mysql_query ("INSERT INTO akcija VALUES
						(default, '$naziv', $cijena, default, '$pocetak_akcije', '$zavrsetak_akcije')") or die(mysql_error());
			
			
			bazaDisconnect();
			$smarty->display('jozemberi_kreiranje_akcije.tpl');
			
		}
		else {
			bazaDisconnect();
			$smarty->display('jozemberi_kreiranje_akcije.tpl');
		}
	}
	else $smarty->display('jozemberi_kreiranje_akcije.tpl');
	
	include 'templates/jozemberi_footer.tpl';
?>
