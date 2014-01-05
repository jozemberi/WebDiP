<?php
	session_start();
	require_once('_jozemberi_smarty.php');
	require_once('_recaptchalib.php');
	require_once('_simpleImage.php');
	require_once('_jozemberi_baza.php');
	bazaConnect();
	
	$smarty->assign('naslov', 'Kreiranje ponude - Motor');
	$smarty->assign('div_id', 'content_v530px');
	
	$sqlTipMotora = "SELECT id_tipa, tip FROM tip_motora";
			
			$rsTipMotora = mysql_query($sqlTipMotora) or die(mysql_error());						
			$tip=array();
			while($row=mysql_fetch_array($rsTipMotora)){
				$tip[]=$row;
			}
	$smarty->assign('tip', $tip);
	
	if (isset($_POST['kreiraj_motor'])) {
		$greske=array();
	
		$snaga = mysql_real_escape_string($_POST['snaga']);
		$radni_obujam = mysql_real_escape_string($_POST['radni_obujam']);
		$tip = mysql_real_escape_string($_POST['tip']);
		
		if(empty ($snaga)) $greske['snaga'] = "Snaga motora nije unesena";
		
		if (empty ($radni_obujam)) $greske['radni_obujam'] = "Radni obujam motora nije unesen";
	
		$smarty->assign('greske', $greske);
		
		if (empty($greske)) {
			$upis_podataka = mysql_query ("INSERT INTO motor VALUES
						(default, $tip, '$snaga', '$radni_obujam')") or die(mysql_error());
			
			bazaDisconnect();
			$smarty->display('jozemberi_kreiranje_ponude_motor.tpl');
			
		}
		else {
			bazaDisconnect();
			$smarty->display('jozemberi_kreiranje_ponude_motor.tpl');
		}
	}
	else $smarty->display('jozemberi_kreiranje_ponude_motor.tpl');
	
	include 'templates/jozemberi_footer.tpl';
?>
