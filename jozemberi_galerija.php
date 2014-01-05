<?php
	session_start();

	require_once '_jozemberi_baza.php';
	bazaConnect();
	require_once('_jozemberi_smarty.php');
	
	$notLoggedIn = false;
	
	$upozorenje = 'Za pauziranje slideshow-a postavite kursor na sliku. Za pokretanje ga pomaknite sa slike.';
	$notLoggedIn = true;
	$smarty->assign("upozorenje", $upozorenje);

	$sql = "SELECT osnovne_konfiguracije.id_osnovne_konfiguracije, osnovne_konfiguracije.model AS model, 
			osnovne_konfiguracije.tip AS tip_automobila, osnovne_konfiguracije.slika, osnovne_konfiguracije.cijena,
			marka_automobila.marka AS marka
			FROM osnovne_konfiguracije
			INNER JOIN marka_automobila ON osnovne_konfiguracije.marka=marka_automobila.id_marke";	
		
	$rs = mysql_query($sql) or die(mysql_error());						
		
	$modeli_automobila=array();
		
	while($row=mysql_fetch_array($rs)){
		$modeli_automobila[]=$row;
	}
	
	$smarty->assign("naslov", "Galerija modela automobila");
	$smarty->assign("div_id", "content");
	
	$smarty->assign("modeli_automobila",$modeli_automobila);
	
	$smarty->display("jozemberi_galerija.tpl");
	include 'templates/jozemberi_footer.tpl';
	
	bazaDisconnect();
?>