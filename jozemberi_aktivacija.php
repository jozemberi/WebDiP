<?php
	require_once('_jozemberi_baza.php');
	require_once('_jozemberi_vrijeme.php');
	require_once('_jozemberi_smarty.php');
	
	$smarty->assign('naslov', 'Aktivacija korisničkog računa');
	$smarty->assign('div_id', 'content_v530px');
	
	if(isset($_GET['a'], $_GET['b'])){
		$pristigli_kod = $_GET['a'];
		$pristiglo_korIme = $_GET['b'];
		
		$uspjesna_aktivacija;
		$link_istekao;
		bazaConnect();
		$korisnik = mysql_query("SELECT username, dat_i_vrij_registracije, aktivacijski_kod, status_korisnika FROM korisnik
		WHERE username = '$pristiglo_korIme' and aktivacijski_kod = '$pristigli_kod' and status_korisnika = '5'") or die(mysql_error());
		
		if (isset($korisnik)){
			$row = mysql_fetch_array($korisnik); 
			$date1 = strtotime ($row['dat_i_vrij_registracije']);
			
			$date2 = virtualnoVrijeme();
			
			if(($date2 - $date1) > 86400){ // 24 sata
				$link_istekao = 'Aktivacijski link je istekao';
				$smarty->assign('link_istekao', $link_istekao);
			}
				
			else{
				bazaConnect();
				$rsUpdate = mysql_query("UPDATE korisnik SET status_korisnika = '1', aktivacijski_kod = 'NULL' WHERE username = '$pristiglo_korIme' ") or die(mysql_error());
				$uspjesna_aktivacija = 'Uspješno ste potvrdili registraciju!';
				$smarty->assign('uspjesna_aktivacija', $uspjesna_aktivacija);
				bazaDisconnect();
			}
			
			$smarty->display('jozemberi_aktivacija.tpl');		
		}
	}		
	include 'templates/jozemberi_footer.tpl';
?>
